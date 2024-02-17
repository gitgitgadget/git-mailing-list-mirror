Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCA1CF83
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708202319; cv=none; b=sovg5Eu6CRx7maRujgmaUVQFkK1oixJEjMtTMpbmHT3GG0eGQgRKHKTADulT9ciqAVA0datahXXi3lilUfDPAf/3mWJe9j4s8grP/HA2iQZbuB+a2VLzcYNmW7UXwNxpYi7utYb1BJnvbdWTdO1DmLC9Z2Ee4uv0f1+PGStGls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708202319; c=relaxed/simple;
	bh=ebCTKSmM5VeZtKT8Lwd4W03HtxV+mm2ucD8K8fZQEKY=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=qzrbV+S1M84J7AabEJVo7WW5zZd1j6upMHcV8e7Kz8WiSxEcrnGqe7zRHEEyDOt3DSs6C5njsnudX+HjWa0HbKOrbckC1N153YGNxo/0KVvUW3DhkuwPbx0e9gm8fUFSGKoaBVKjywcBzzRJoLDZZkuv+XzFgO2OVUhsGhNbBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iypbBz/U; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iypbBz/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1708202300; x=1708461500;
	bh=ebCTKSmM5VeZtKT8Lwd4W03HtxV+mm2ucD8K8fZQEKY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=iypbBz/UpszKGLL9DuctBNqcuSlJezR/DBFiTc0NSaiclGja5FYE/2Zcp3rRyTmSn
	 nFpfhsWCx7GS59bXzs4K2TNcNQ3aWbu9pjMAh9vzZTlwu+ejCAhZZVPmIUC7+qTb5D
	 TAiWPOWm8eA6iF/+dNniCBRRrOoRz8gOKT5wc6U0O+E3pr7P259VlUNJbAnaWBMQ5M
	 pwzuxgz7iuVKiom83+NsA4O4yb1TOaWhvy8rWe+MdN7buEgeJpG8I/EOTmzNnSK5ek
	 29ghqlAEi1+RJX8DoniqMwwam1432sWEUhXzjg3Vp/pXMm2Ldhvn8yTwJEOqF0N9Zh
	 Qp7B/zLp1YqBA==
Date: Sat, 17 Feb 2024 20:38:08 +0000
To: "git@vger.kernel.org" <git@vger.kernel.org>
From: charmocc <charmocc@proton.me>
Subject: Git commit causes data download in partial clone
Message-ID: <OK9E_kNDYqB1tDn6YJhtTgkdDDrcr2LhZEGRdmqismu6KyTki-M22CpCAxXHZCn45SZICjnPNYxvw02BnWeJic3mx47-zeI0HDhzdgoJpG0=@proton.me>
Feedback-ID: 101377472:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

I was recently exploring git partial clone feature because I wanted to
contribute to repository which has a lot of binary files. My intent was to =
only
add new files without modifying any existing ones and to download as few da=
ta
as possible in the process. Here are the steps I followed:

$ git clone --no-checkout --filter=3Dblob:none https://github.com/libretro-=
thumbnails/Nintendo_-_Nintendo_Entertainment_System.git nes
$ cd nes
$ echo foo > bar
$ git add bar
$ git commit bar # causes git fetch behind the scene and download of a lot =
of objects!

Now for reasons I don't understand the last command cause download of a lot=
 of
objects from remote (blobs) which is what I was trying to avoid. By enablin=
g
tracing options I can see that it runs fetch operation in the background:

git -c fetch.negotiationAlgorithm=3Dnoop fetch origin --no-tags --no-write-=
fetch-head --recurse-submodules=3Dno --filter=3Dblob:none --stdin

Unfortunately trace doesn't show what refspec is being used for the fetch=
=20
operation. The regular "git fetch" doesn't cause any additional object=20
downloads.

Is there something I'm doing wrong here or maybe what I'm trying to achieve=
=20
(contribute to repository without downloading all of its files) is simply=
=20
not possible?

git version 2.34.1 (Ubuntu 22.04)

Thanks for your time
charmocc
