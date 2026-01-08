Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01AA2ED164
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767895158; cv=none; b=KaWDWqYErL/ilX0BaEpOLcFhO0aeNMQn4mgqJKZWccMbjAYo/PicvliVTrZBy17i62/n/cfv9OrcJvDc0N58yTiMeR+XRwjuIUDZ6umeVDgubcb3dz15rbUGHJTlPYX9VitOKiqBPaOGAL2+bNKFqMoViTtMDRoECYgy6jJ4pt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767895158; c=relaxed/simple;
	bh=EpjHCEZ7nouCLTp+r7c9xKqqokiMkgPLQ+6fITDYHz0=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=SrHdpW84Vf0/pSNIoPHaK8YnDmz2+z6PEVzXedGq0BZud8kLnDBjxbGHk/mOBQavvwvaI7vCV9Y2/MGRRbNZBYN1lDN/j1GusXWlN5wpm74axm/KXt3LsuuCKDxt/qfJZdmvPMIbDRsXWhU/6+JCLIUQwyxXuc/dqsYMfj/9Ny4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=q4Nk5ZpN; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="q4Nk5ZpN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1767895130; x=1768154330;
	bh=maaaHek2KKdRmSzIIQxQp38FunF3y7uNSkiuY8UTn4E=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=q4Nk5ZpNNsZyojkfS1lF4EMMGIXn6ksP+CylmStnR8geBT7PpN8GzljhJbf7Uzu6L
	 Gx6ru3Jhz5jMquRfg3K+y0bLWY/i9HQpnLBO0QO2gTbISxWTqSpF3uiHg1eboMoTFt
	 WI1uFsael4slq9Swbv3+YScezdbzhCeE91m69jFc5E7AOqpqUwmlcm8LqTBlnM34a/
	 13cpQRCEo+LD/H9xlj5Lw3FLRvOxIxgTXi/UMOaOc90KYWRUBG68x6lGCXbu2f7IPh
	 KcnDZKqGQvVbhbUz4ogVen+5Oi7Uw9DL9e19616xrg8Jd+GrhuT8kQ9VB4Fe3SdCYs
	 WFv9X9h6J8bWg==
Date: Thu, 08 Jan 2026 17:58:47 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: Tsahi Elkayam <Tsahi.Elkayam@protonmail.com>
Subject: [RFC] reftable: indexed_table_ref_iter inefficiency
Message-ID: <RoV3JLYR-DPkt0_9M-1fsR7tvqQOElF032Z_KOgiKKwksx2K-MBL1N7KsXUZXHBXKybxvpdBsGYEMux-xSCU-EhvhusqsbvhK8K6pMr-tFM=@protonmail.com>
Feedback-ID: 35521663:user:proton
X-Pm-Message-ID: 9f9907247d9b1696755bd3d82fad1b52d394c70a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Following Patrick's review of my recent patch fixing undefined behavior
in indexed_table_ref_iter_next(), I noticed the TODO comment points to
a larger issue with the obj table implementation.

If I understand the current workflow correctly:

  reftable_table_refs_for_indexed()
    -> seeks to obj record matching OID prefix
    -> reads one obj record
    -> passes offsets to indexed_table_ref_iter_new()

  indexed_table_ref_iter_next()
    -> for each offset, reads entire ref block
    -> iterates all records in block
    -> manually filters by OID comparison

It seems like the code reads only one obj record, iterates through all
ref records in each block, and relies on manual filtering instead of
using the index properly.

I think the correct approach would be:

  1. Seek to first obj record with desired OID prefix
  2. For each obj record starting with that prefix:
     a. For each offset in the obj record:
        - Read the ref block at that offset
        - Yield refs whose value/target_value matches the OID
     b. Move to next obj record
  3. Stop when obj record no longer matches prefix

This would require indexed_table_ref_iter to hold a reference to the
obj iterator instead of just the offsets array, and advance through
obj records as offsets are exhausted.

Is this the right approach? I would like to help fix this, but I'm not
very familiar with the reftable internals yet.

Thanks,
Tsahi
