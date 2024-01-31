Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7912CDB3
	for <git@vger.kernel.org>; Wed, 31 Jan 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722950; cv=none; b=jxR1N5vs95vuKH4cPU9gUMdUj9weGTt8UZzKsCTc0Y9sl7twdneTL4fb3f4SKxv44O6QVmj91E4d4R70VgmZ5uym1N4bk/UCuqcQ72TW1u7tGb4u0KmA8mxQ1zVUc6sFEbXqEHy/HBrqUCpsdD9wLV8bylNEA4BVRWFYhZsJPiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722950; c=relaxed/simple;
	bh=sraBt3NvopvDsGgpZz3x40gjxkWKMb0vS18GC+R53uc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ev8LBI1j8kD9Yhd1JelGm/n8FCelSOozcb6RcHU5zbf6qQ4jzEZRMQJlRY3rlgEABmjXVmJ/LaOR4XRRrx4/YZ1qKoWg6MXMP4P4qWnlbrJTwLt+MHzoRbHhapAG2F3Gee6fY+ZsX3NvRi8I0J/rpqEIgbe5WcINMEJX/L/Ec5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QGz6959i; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGz6959i"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A710E1D6FA9;
	Wed, 31 Jan 2024 12:42:22 -0500 (EST)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-transfer-encoding;
	 s=sasl; bh=sraBt3NvopvDsGgpZz3x40gjxkWKMb0vS18GC+R53uc=; b=QGz6
	959iApnP//mkV5/Shi9BqBEg5LHXspU0oqvPcu/VCHGJBRt0uZC+tLBvniuJxdid
	WHCu0yzZuucsSfUM2EUlrryKCdMzDCO4pIjogaQxflbtsQvnPglbhn/6vQoiGHnY
	PeNZsDttWuDPWpbHUBj5lSItwuVQdszy++x8gFs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9DF3B1D6FA8;
	Wed, 31 Jan 2024 12:42:22 -0500 (EST)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D8751D6FA7;
	Wed, 31 Jan 2024 12:42:21 -0500 (EST)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Haritha D <harithamma.d@ibm.com>
Subject: [PATCH 0/2] CC_LD_DYNPATH improvements
Date: Wed, 31 Jan 2024 09:42:18 -0800
Message-ID: <20240131174220.4160560-1-gitster@pobox.com>
X-Mailer: git-send-email 2.43.0-493-gbc7ee2e5e1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 166CF9D6-C060-11EE-80C0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

We seem to repeat ourselves many times in Makefile with lines like
this:

  EXTLIBS +=3D -L$(LIBPCREDIR)/$(lib) $(CC_LD_DYNPATH)$(LIBPCREDIR)/$(lib=
)

but we should be able to express ourselves without repeating the
same long string twice, perhaps like so:

  EXTLIBS +=3D $(call libpath_template,$(LIBPCREDIR)/$(lib))

I originally wrote this as a practice to use the $(call template)
pattern in Makefile, but it may make porting to a platform without
dynamic library path support simpler.


Junio C Hamano (2):
  Makefile: reduce repetitive library paths
  Makefile: simplify output of the libpath_template

 Makefile   | 12 ++++++------
 shared.mak |  6 ++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

--=20
2.43.0-493-gbc7ee2e5e1

