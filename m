Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7218A950
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718754283; cv=none; b=TYXrp0dZfhy8zMosntMzafYKZXHcD498BtxUnmHfiWuVvU++U4QPx1QxatoUTfHua9ILcF+Q4Z8Pu8OAfCPzkWU0wcORnZQUkO1VJvl82INTjac+lLQ2XoEvjeSikQs4z1FHP9aoVYRSl1xWC6+KBKrWZaH37ZnmsTYunBjEAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718754283; c=relaxed/simple;
	bh=jJ+hTzl2gudEsSZ3cOCZya01oVWu5MhMA9/toYOwkq4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8jhSiqU1uEGWCeVZWezm1rUEbkl+PUBOOZs07SI5orpzQ9CTEvKPmcSp7AWrejy3LDvh3jF/C4Ioxs/KzVheJ69v07j1joQejNvdz4+DKCGhwi0Kzv5MdmDEjh3y1w4L3xwLL4j8v4pMukmi0cy/Qgr8Th3F/owPRUFQiTtnDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kg+YSOD9; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kg+YSOD9"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9AC522C5ED;
	Tue, 18 Jun 2024 19:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=jJ+hTzl2gudEsSZ3cOCZya01o
	VWu5MhMA9/toYOwkq4=; b=kg+YSOD9kuc8td7FPi6yFPoXCbFfaJN2Frm2IQeCx
	dcAd6IK94opZ3j3B9DgTfIVU6II8/wclftr/pZVWDWeRD5dfc6iSMFRTPtZDSiNk
	kN5JUk7HPVMAr3KQ5sMkKeldoKO6VYwNttJn9BqL+ONDd6yHmvVXW4IpGVDRh2+/
	Rg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87E892C5EC;
	Tue, 18 Jun 2024 19:44:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD0552C5EB;
	Tue, 18 Jun 2024 19:44:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 0/4] .git{ignore,attributes} directories?
Date: Tue, 18 Jun 2024 16:44:31 -0700
Message-ID: <20240618234436.4107855-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-711-gd2c001ca14
In-Reply-To: <20240618233303.GA188880@coredump.intra.peff.net>
References: <20240618233303.GA188880@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B94DEB2C-2DCC-11EF-84F3-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

We seem to blindly open .gitignore that is a directory and rely on
subsequent read() to be more-or-less silent to implement a "non-file
.gitignore is silently ignored" behaviour.

Let's be a bit more strict in detecting and reporting I/O errors,
and also stop reading from directories.

I think the first three are reasonable changes, but the last one is
of dubious value.

Junio C Hamano (4):
  .gitignore: introduce GITIGNORE_FILE CPP macro
  attr: notice and report read failure
  exclude: notice and report read failure of .gitignore files
  submodule: ignore .gitmodules that is not a regular file

 attr.c                | 10 +++++++++-
 builtin/read-tree.c   |  3 ++-
 dir.c                 | 16 ++++++++++++++--
 dir.h                 |  1 +
 environment.h         |  1 +
 submodule-config.c    |  2 +-
 t/t0003-attributes.sh |  9 +++++++++
 t/t0008-ignores.sh    | 18 ++++++++++++++++++
 8 files changed, 55 insertions(+), 5 deletions(-)

--=20
2.45.2-711-gd2c001ca14

