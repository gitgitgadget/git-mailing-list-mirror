From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/20] untracked cache: invalidate dirs recursively if .gitignore changes
Date: Wed,  7 May 2014 21:51:47 +0700
Message-ID: <1399474320-6840-8-git-send-email-pclouds@gmail.com>
References: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 16:52:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi3DB-0005nX-Us
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 16:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbaEGOwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 10:52:41 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51803 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756127AbaEGOwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 10:52:40 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so1275126pab.22
        for <git@vger.kernel.org>; Wed, 07 May 2014 07:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eNAOA//r7tXwiXLPZflTwcYq2QPMkbKgsd1VAPdOh5k=;
        b=XoELb4nDaOswhoOSz/OhDEtMQPAQvYGfiZRX1ns6vJjtc2yQtrwVYnA6uSVMZZfmwm
         bEnu7BJEQtpOt7TCM2+K/A3UVtce0NvTg4DIk9QKk9JnRdTmJnF7SLpjP8k1wUPzhmTO
         sgcKo/aNGsv9lpbMEeTHt9yphyTJaczSi8uaTGn/UGtZxeiiDp7QIAv4jWZcJgVlzbfl
         n5OeLTo77N0weooJtNx5ixdTTxZIt1YkdMASFZcxL0MsBiD+PnKjFSRb1PVaxYQJSeKB
         0Gfa6MHD0r8MnTX49QD/FliUIYDKIlPqscysmEqGEe8rQIPvS+0ZrY1WfAwmtanqI09j
         K2JA==
X-Received: by 10.66.141.109 with SMTP id rn13mr20004317pab.117.1399474360008;
        Wed, 07 May 2014 07:52:40 -0700 (PDT)
Received: from lanh ([115.73.204.3])
        by mx.google.com with ESMTPSA id op3sm3650038pbc.40.2014.05.07.07.52.36
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 07 May 2014 07:52:38 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 07 May 2014 21:52:39 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399474320-6840-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248313>

It's easy to see that if an existing .gitignore changes, its SHA-1
would be different and invalidate_gitignore() is called.

If .gitignore is removed, add_excludes() will treat it like an empty
.gitignore, which again should invalidate the cached directory data.

if .gitignore is added, lookup_untracked() already fills initial
.gitignore SHA-1 as "empty file", so again invalidate_gitignore() is
called.
---
 dir.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/dir.c b/dir.c
index a198aa8..6370f6e 100644
--- a/dir.c
+++ b/dir.c
@@ -1007,7 +1007,26 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			add_excludes(el->src, el->src, stk->baselen, el, 1,
 				     untracked ? sha1 : NULL, NULL, NULL);
 		}
+		/*
+		 * NEEDSWORK: when untracked cache is enabled,
+		 * prep_exclude() will first be called in
+		 * valid_cached_dir() then maybe many times more in
+		 * last_exclude_matching(). When the cache is used,
+		 * last_exclude_matching() will not be called and
+		 * reading .gitignore content will be a waste.
+		 *
+		 * So when it's called by valid_cached_dir() and we
+		 * can get .gitignore SHA-1 from the index
+		 * (i.e. .gitignore is not modified on work tree), we
+		 * could delay reading the .gitignore content until we
+		 * absolutely need it in last_exclude_matching(). Be
+		 * careful about ignore rule order, though, if you do
+		 * that.
+		 */
 		if (untracked) {
+			if (hashcmp(sha1, untracked->exclude_sha1))
+				invalidate_gitignore(dir->untracked,
+						     untracked);
 			hashcpy(untracked->exclude_sha1, sha1);
 		}
 		dir->exclude_stack = stk;
-- 
1.9.1.346.ga2b5940
