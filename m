Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD2210EC
	for <git@vger.kernel.org>; Wed, 22 May 2024 18:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716403483; cv=none; b=rhoqo9sspKU6a+gMkxfTW+c+kVAU3WNO0/eaKSklqC0F0ZZ6KjKGyh9CCa7ZIsYahECwzLr0n1OnFhc5TdSQGLdviWoo6cha1kIVPK1lRNC0VHnX5LU0Gq1VZ1farNVdx4dvUD2fsIZI4mnaBI5v2IAGlgz8re8wNtv8Btm1bT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716403483; c=relaxed/simple;
	bh=1NgUqdTvnyXbFSBsi12OOD63VqsE72Gc1ePBR5foYB4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=co8OP8AWtFPUxKaaTrG50vfCz5MiCb7J21PXhA32PWXbTi39K81A6eXlI09p/2z7CgTYvXQQwW3c80b9YLO2hbwBoPKntRXiFw5+G/x5RUZjhfcaB3/7RZcVhkeoJzkSG8XYC5d/z+YuuPMZ3ThAbuDchpY89uZsMk+aFce124s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gTYqo/F3; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gTYqo/F3"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C695C1919E;
	Wed, 22 May 2024 14:44:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=1
	NgUqdTvnyXbFSBsi12OOD63VqsE72Gc1ePBR5foYB4=; b=gTYqo/F3RoFmfrolN
	/qtCO/s7H44ik4EUOrNzAyuCmGjjjmgJzy84qDggjyODyRi6r2OACvB1da6Xq3H3
	H4HaJQM433e4Hk/Qn+MKBNLMRktUGD8WKM/sgAQmybH2VH0H7Zj5MAdX5bAQeBTH
	IBxhqaeSAYKvpJghILssVEELeE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BED101919D;
	Wed, 22 May 2024 14:44:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CDF4019144;
	Wed, 22 May 2024 14:44:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] blame: do not mention obvious default configuration values
Date: Wed, 22 May 2024 11:44:37 -0700
Message-ID: <xmqqpltd4rfu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57FDAAD6-186B-11EF-845E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

While it helps to mention what the default behaviour is when a
variable is unconfigured, when there are more than true or false
choices for the variable (e.g. "defaults to never, among possible
choices never/local/remote/always"), or if the default behaviour is
as if the unconfigured variable were set to true the knob is purely
to opt out of it ("Porcelain 'git diff' refreshes the index, but
diff.autoRefreshIndex can be set to false to opt out of it"), it
feels like it adds unnecesary noise to say "defaults to off" for a
configuration variable that is clearly a Boolean.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am somewhat hesitant to use a phrase that implies that there is
   some "default value" for any configuration variable.  Saying "The
   default value for the configuration variable X is Y" misleads
   readers to expect that "git config -l" would show X=Y when the
   user hasn't configured X at all.

   It is just the feature controlled by the configuration variable
   works exactly as if the configuration variable is set to that
   "default value", instead of left unconfigured.

   But that is a separate issue, and is totally outside the scope of
   this change.

 Documentation/config/blame.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4d047c1790..36f965484c 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -1,6 +1,6 @@
 blame.blankBoundary::
 	Show blank commit object name for boundary commits in
-	linkgit:git-blame[1]. This option defaults to false.
+	linkgit:git-blame[1].
 
 blame.coloring::
 	This determines the coloring scheme to be applied to blame
@@ -14,11 +14,9 @@ blame.date::
 
 blame.showEmail::
 	Show the author email instead of author name in linkgit:git-blame[1].
-	This option defaults to false.
 
 blame.showRoot::
 	Do not treat root commits as boundaries in linkgit:git-blame[1].
-	This option defaults to false.
 
 blame.ignoreRevsFile::
 	Ignore revisions listed in the file, one unabbreviated object name per
-- 
2.45.1-216-g4365c6fcf9

