From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 16:49:13 -0500
Message-ID: <1367358554-4257-6-git-send-email-felipe.contreras@gmail.com>
References: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 23:50:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXIRt-0003XS-HJ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 23:50:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933855Ab3D3Vuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 17:50:51 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:37270 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839Ab3D3Vut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Apr 2013 17:50:49 -0400
Received: by mail-yh0-f43.google.com with SMTP id a41so174590yho.30
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0QTS52q91e74wEmIvzJNrS6MtzErJPRmDx90L9r10Ng=;
        b=zscVJkIhlICWUYA7cC9gOwLOEAvE3VozhZtkMU2v8TZeAw9D+DsBo2C31AqeNxR1gv
         nW/WBNS66ssh9bwxIo7PkeghQf4LmtYBAfhVk157Wd/qlQM+XwnEY5+L6aYe4yPF0NHc
         aKKoT+n4/xWKCbP/ohywik/VFI3E9a775eEgapYuhIZnWwIyATBbgfZlJdlrI5suLfS4
         lBIZ1ZYBFriOjzfFcwEBnEr0/9Gsa+0rVk6j03AeF0hvNj+J7mBcOOdTHWMEC4VKs7zN
         cdD5BJ4V6OCW06YFa6xVGUPz89pWQgycFQCRihoQ5x1TwnRDJUGsTvKU0G3KEusaVL51
         9wpA==
X-Received: by 10.236.106.70 with SMTP id l46mr124018yhg.134.1367358648813;
        Tue, 30 Apr 2013 14:50:48 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id t27sm316848yhm.20.2013.04.30.14.50.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 14:50:48 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.395.gfe9a10d
In-Reply-To: <1367358554-4257-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223017>

So HEAD@{0}~0^0 is too much to type, but we can remove '^0', and we can
remove '~0', and we can remove 'HEAD', which leaves us with @{0}, but we
can't remove '{0}'?

This patch allows '@' to be the same as 'HEAD'.

So now we can use 'git show @~1', and all that goody goodness.

Until now '@' was a valid name, but it conflicts with this idea, so lets
make it invalid. Very few people if any probably used this name, if they
did, they can rename it by using the full-path (e.g. refs/heads/@).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-check-ref-format.txt | 2 ++
 Documentation/revisions.txt            | 3 +++
 refs.c                                 | 4 ++++
 sha1_name.c                            | 6 +++++-
 t/t1508-at-combinations.sh             | 3 +++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index ec1739a..e8035ec 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -54,6 +54,8 @@ Git imposes the following rules on how references are named:
 
 . They cannot contain a sequence `@{`.
 
+. They cannot be the single character `@`.
+
 . They cannot contain a `\`.
 
 These rules make it easy for shell script based tools to parse
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index d477b3f..09896a3 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -58,6 +58,9 @@ the '$GIT_DIR/refs' directory or from the '$GIT_DIR/packed-refs' file.
 While the ref name encoding is unspecified, UTF-8 is preferred as
 some output processing may assume ref names in UTF-8.
 
+'@'::
+  '@' alone is a shortcut for 'HEAD'.
+
 '<refname>@\{<date>\}', e.g. 'master@\{yesterday\}', 'HEAD@\{5 minutes ago\}'::
   A ref followed by the suffix '@' with a date specification
   enclosed in a brace
diff --git a/refs.c b/refs.c
index de2d8eb..4e70b3e 100644
--- a/refs.c
+++ b/refs.c
@@ -72,6 +72,10 @@ int check_refname_format(const char *refname, int flags)
 {
 	int component_len, component_count = 0;
 
+	if (!strcmp(refname, "@"))
+		/* Refname is a single character '@'. */
+		return -1;
+
 	while (1) {
 		/* We are at the start of a path component. */
 		component_len = check_refname_component(refname, flags);
diff --git a/sha1_name.c b/sha1_name.c
index 76e3219..887de6c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -437,11 +437,13 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 	static const char *warn_msg = "refname '%.*s' is ambiguous.";
 	char *real_ref = NULL;
 	int refs_found = 0;
-	int at, reflog_len;
+	int at, reflog_len, only_at;
 
 	if (len == 40 && !get_sha1_hex(str, sha1))
 		return 0;
 
+	only_at = len == 1 && str[0] == '@';
+
 	/* basic@{time or number or -number} format to query ref-log */
 	reflog_len = at = 0;
 	if (len && str[len-1] == '}') {
@@ -474,6 +476,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
 		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	} else if (reflog_len)
 		refs_found = dwim_log(str, len, sha1, &real_ref);
+	else if (only_at)
+		refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
 	else
 		refs_found = dwim_ref(str, len, sha1, &real_ref);
 
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index d5d6244..50035cd 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -45,6 +45,9 @@ check "@{u}" upstream-two
 check "@{u}@{1}" upstream-one
 check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
+check "@" new-two
+check "HEAD@{u}" upstream-two
+check "@@{u}" upstream-two failure
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.395.gfe9a10d
