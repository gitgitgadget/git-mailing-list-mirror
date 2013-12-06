From: Tomo Krajina <tkrajina@gmail.com>
Subject: [PATCH] push: Allow @ shortcut with git-push
Date: Fri,  6 Dec 2013 07:13:12 +0100
Message-ID: <1386310392-26882-1-git-send-email-tkrajina@gmail.com>
Cc: felipe.contreras@gmail.com, Tomo Krajina <tkrajina@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 07:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voog1-0006vj-PR
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 07:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab3LFGOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 01:14:10 -0500
Received: from mail-ee0-f44.google.com ([74.125.83.44]:55608 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750752Ab3LFGOI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 01:14:08 -0500
Received: by mail-ee0-f44.google.com with SMTP id b57so78267eek.17
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 22:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=jqD9jBapwXK9UWjbygXAg4AYgJf4OjKwNYx7o+EY2rI=;
        b=W976LUWK0RLp6DgLSsrjbYvUF8gD/DVbQn2blp+zHysSKaYFm85fCAv2gIc6nXKkMK
         PCwDFJIswA0OF+lOIVtmpxB1fOFP0QrPlPQQVqKJAcKGtVJJ7eF9wsm/6w8Now5n97yW
         MEB13fpODU+XFFQXTj9vaxugKkIEfSN5KGp1ww1QTfJl9TjtJcZ1QVdfYYUzd9fkdFD6
         U7Tws4xa1KrK6KBgybK7JshYRh5R9NWWwqKNV3Wzy1zoSNClwJf+am3hFkcmowj6QXlm
         mkOcvyZ8V2by09V8svbT4hnYBnxiCVLcgcLSnET22aR0+Ee7CHvp8nCMfjIE+i8Wl8Bo
         nBXg==
X-Received: by 10.14.179.130 with SMTP id h2mr1189572eem.34.1386310446861;
        Thu, 05 Dec 2013 22:14:06 -0800 (PST)
Received: from puzz.lan (93-140-233-26.adsl.net.t-com.hr. [93.140.233.26])
        by mx.google.com with ESMTPSA id g7sm65151022eet.12.2013.12.05.22.14.05
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 22:14:06 -0800 (PST)
X-Mailer: git-send-email 1.8.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238923>

Until now, HEAD could be used with git-push to push the current
branch. Now @ is a shortcut to HEAD, but it didn't work when
pushing branches. It fails with:

  fatal: remote part of refspec is not a valid name in @

Reinterpret all branch names from argv in order for @ to be used
when pushing branches.

Signed-off-by: Tomo Krajina <tkrajina@gmail.com>
---
 builtin/push.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..51c0200 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -494,7 +494,20 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	if (argc > 0) {
 		repo = argv[0];
-		set_refspecs(argv + 1, argc - 1);
+
+		char *refs[argc - 1];
+		int i;
+		for(i = 1; i < argc; i++) {
+			refs[i - 1] = argv[i];
+
+			struct strbuf buf = STRBUF_INIT;
+			interpret_branch_name(argv[i], strlen(argv[i]), &buf);
+
+			if(buf.buf && strlen(buf.buf) > 0)
+				refs[i - 1] = buf.buf;
+		}
+
+		set_refspecs(refs, argc - 1);
 	}
 
 	rc = do_push(repo, flags);
-- 
1.8.5
