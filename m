From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Wed, 30 Dec 2009 21:11:44 +0700
Message-ID: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 30 15:15:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPzKO-0002TG-67
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 15:15:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbZL3OMf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Dec 2009 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752794AbZL3OMf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 09:12:35 -0500
Received: from mail-px0-f189.google.com ([209.85.216.189]:40958 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbZL3OMe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 09:12:34 -0500
Received: by pxi27 with SMTP id 27so6865311pxi.4
        for <git@vger.kernel.org>; Wed, 30 Dec 2009 06:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=syEW1iL1/xVz00L9ZU3oMLcWFZxrrZqLDHX7WcZZK0Y=;
        b=WOQWeRx6Ohn2+eAtn80GqLInIoe14D2agtGcI7E2dNsHZn7/garhVg3bGvQkz6P7se
         ENFJ+wzLd7ckiwGeMuEK8JJfDyBGMSp5EGVQqGU9F9p1qFc8hdMyG9FHs+ZCJP9Ft/xp
         cPkjyqD61XJf9VnC1F2frRDb8AXKMqpMcidIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=HopIOIN4kR39bHLUw0/F2OIIZDEN0bTd2IwHM7hGiyWo2uGYSOX7j2q/FbmFPJT/wu
         x5YHgxIQAuLdIUDku4mECYQ/rGlY7/d7RJtvapWHwnHYXeVgJtQlei0g+3gC0f8qgHNP
         7daKsyBp9j7MNOAva/1IkNwKcQo8YZil41g90=
Received: by 10.142.2.24 with SMTP id 24mr12195262wfb.139.1262182354263;
        Wed, 30 Dec 2009 06:12:34 -0800 (PST)
Received: from pclouds@gmail.com ([115.73.227.183])
        by mx.google.com with ESMTPS id 21sm13547991pzk.15.2009.12.30.06.12.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Dec 2009 06:12:33 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 30 Dec 2009 21:11:49 +0700
X-Mailer: git-send-email 1.6.6.315.g1a406
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135900>

Skip-worktree entries are not on disk. There is no reason to call
external grep in such cases.

A trace message is also added to aid debugging external grep cases.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-grep.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index d582232..d49c637 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -488,17 +488,34 @@ static int grep_cache(struct grep_opt *opt, const=
 char **paths, int cached,
 	read_cache();
=20
 #if !NO_EXTERNAL_GREP
+	if (cached)
+		external_grep_allowed =3D 0;
+	if (external_grep_allowed) {
+		for (nr =3D 0; nr < active_nr; nr++) {
+			struct cache_entry *ce =3D active_cache[nr];
+			if (!S_ISREG(ce->ce_mode))
+				continue;
+			if (!pathspec_matches(paths, ce->name, opt->max_depth))
+				continue;
+			if (ce_skip_worktree(ce)) {
+				external_grep_allowed =3D 0;
+				break;
+			}
+		}
+	}
 	/*
 	 * Use the external "grep" command for the case where
 	 * we grep through the checked-out files. It tends to
 	 * be a lot more optimized
 	 */
-	if (!cached && external_grep_allowed) {
+	if (external_grep_allowed) {
 		hit =3D external_grep(opt, paths, cached);
 		if (hit >=3D 0)
 			return hit;
 		hit =3D 0;
 	}
+	else
+		trace_printf("grep: external grep not used\n");
 #endif
=20
 	for (nr =3D 0; nr < active_nr; nr++) {
--=20
1.6.6.315.g1a406
