Received: from joooj.vinc17.net (joooj.vinc17.net [155.133.131.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA7817A31E
	for <git@vger.kernel.org>; Wed,  6 May 2026 01:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=155.133.131.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778029921; cv=none; b=Dz2080KwVw95plwmks9tMVoPNu96DQjnTAQkfOKkl1wAO5Bjp0t8dhslhDm+IBDHC2NbzBBOZ2mkAjOW8ItKYkSF1pvuecvkT5dvmCRgT4VrSb7w3+u7p7gbAYPqgh050I1SYAZdS51oEPpobVskYGmqJZPNvpHM0Q5/85koz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778029921; c=relaxed/simple;
	bh=Sqga0uqGhtD8rz24tU5dG8CyOmRCFPQOEtJ2mZfytuQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bKgRbobwCIURgOXnLbFu6zWyJNfIoU27zQsSts/vDyr45HRMwZPDMOhk29hepI++iR+XygWKvJqaJwg04x8zfGxTPtLdWS9/CK03+6YMdihw42xDHZ9F/7kIfuC46Rfxj6FcoaVDOsgbrS+EKCfqy/EUoaMBKJl60A2Ya6sYkkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net; spf=pass smtp.mailfrom=vinc17.net; arc=none smtp.client-ip=155.133.131.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vinc17.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinc17.net
Received: from smtp-qaa.vinc17.net (135.197.67.86.rev.sfr.net [86.67.197.135])
	by joooj.vinc17.net (Postfix) with ESMTPSA id A9D264F5;
	Wed,  6 May 2026 03:09:27 +0200 (CEST)
Received: by qaa.vinc17.org (Postfix, from userid 1000)
	id 35DE0CA3963; Wed, 06 May 2026 03:09:27 +0200 (CEST)
Date: Wed, 6 May 2026 03:09:27 +0200
From: Vincent Lefevre <vincent@vinc17.net>
To: git@vger.kernel.org
Subject: [BUG] "git diff --word-diff" gives a diff while they are only space
 changes
Message-ID: <20260506010927.GE5260@qaa.vinc17.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer-Info: https://www.vinc17.net/mutt/
User-Agent: Mutt/2.3+4 (71f3e314) vl-169878 (2026-01-27)

Consider the following two 5-line files:

file1:

1
2
3
 2
4

file2:

1
 2
 3
 2
 4

On these files, "git diff --word-diff file1 file2" gives

--- a/file1
+++ b/file2
@@ -1,5 +1,5 @@
1
[-2-]
[-3-]
 2
 {+3+}
{+ 2+}
 4

instead of

--- a/file1
+++ b/file2
@@ -1,5 +1,5 @@
1
 2
 3
 2
 4

(e.g. as output by GNU wdiff 1.2.2).

Equivalently, the following command can be used under bash or zsh:

  git diff --word-diff <(printf "1\n2\n3\n 2\n4\n") \
                       <(printf "1\n 2\n 3\n 2\n 4\n")

Tested with git 2.39.5 (Debian 12), 2.53.0 (Debian unstable) and
2.54.0 (Termux/Android).

Issue initially found with

  git show --word-diff 1bf0b214deff2d0ccdcef3b2a4723369e014de3d

and more precisely

  git show --word-diff 1bf0b214deff2d0ccdcef3b2a4723369e014de3d attach.c

in the Mutt Git repository.

-- 
Vincent Lefèvre <vincent@vinc17.net> - Web: <https://www.vinc17.net/>
100% accessible validated (X)HTML - Blog: <https://www.vinc17.net/blog/>
Work: CR INRIA - computer arithmetic / Pascaline project (LIP, ENS-Lyon)
