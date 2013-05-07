From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 2/2] Add new @ shortcut for HEAD
Date: Tue,  7 May 2013 17:04:31 -0500
Message-ID: <1367964271-11422-3-git-send-email-felipe.contreras@gmail.com>
References: <1367964271-11422-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, "Duy Nguyen\"" <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 08 00:06:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq1V-0007zo-N1
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab3EGWGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:06:05 -0400
Received: from mail-gg0-f170.google.com ([209.85.161.170]:44201 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab3EGWGE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:06:04 -0400
Received: by mail-gg0-f170.google.com with SMTP id e5so250875ggh.15
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=1cFveljkQB61iBZunbXmkWwQAwcxlZxl05e6YtNg3dw=;
        b=HR5Lff/nCe4a9lfJOSfVTZTkh9ykou4DPnm9bSwB0s+mS+NAg3UXUbjSGJfvh7h2E2
         74c7L/YmXKcjWgURNJLef1ScvlATOrTJvAuSLSdDr5sFIgQbFgq/cYLZIh/bXFmi9G5R
         MmE+RX45y/0ZDF7nIWIK062TF9Db0CwkIjxjKu24KjYp5CTS+oGMkoV5CTZ8p8p9NqeM
         +MsoaHvHe5515WfbYZYCSatYPC8moL74tCIOqtvROMPi7SK40N+WCmlzSvmV+v1wi9nV
         /Afve8n4soUrg9Sv8Umi1lBb1NLGjVf0eGeeqJ3bbi7brVL8nBl2h3K0UwHbWcR239ax
         ek/A==
X-Received: by 10.236.148.162 with SMTP id v22mr3817831yhj.131.1367964364200;
        Tue, 07 May 2013 15:06:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b70sm7107531yhm.3.2013.05.07.15.06.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 15:06:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367964271-11422-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223620>

Typing 'HEAD' is tedious, especially when we can use '@' instead.

The reason for choosing '@' is that it follows naturally from the
ref@op syntax (e.g. HEAD@{u}), except we have no ref, and no
operation, and when we don't have those, it makes sens to assume
'HEAD'.

So now we can use 'git show @~1', and all that goody goodness.

Until now '@' was a valid name, but it conflicts with this idea, so
let's make it invalid. Probably very few people, if any, used this name.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-check-ref-format.txt |  2 ++
 Documentation/revisions.txt            |  3 +++
 refs.c                                 |  4 ++++
 sha1_name.c                            | 17 +++++++++++++++++
 t/t1508-at-combinations.sh             |  2 ++
 5 files changed, 28 insertions(+)

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
index fd2a95a..dd30c7c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -966,6 +966,17 @@ int get_sha1_mb(const char *name, unsigned char *sha1)
 	return st;
 }
 
+/* parse @something syntax, when 'something' is not {.*} */
+static int interpret_empty_at(const char *name, int namelen, int len, struct strbuf *buf)
+{
+	if (len || name[1] == '{')
+		return -1;
+
+	strbuf_reset(buf);
+	strbuf_add(buf, "HEAD", 4);
+	return 1;
+}
+
 static int reinterpret(const char *name, int namelen, int len, struct strbuf *buf)
 {
 	/* we have extra data, which might need further processing */
@@ -1026,9 +1037,15 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
 	cp = strchr(name, '@');
 	if (!cp)
 		return -1;
+
+	len = interpret_empty_at(name, namelen, cp - name, buf);
+	if (len > 0)
+		return reinterpret(name, namelen, len, buf);
+
 	tmp_len = upstream_mark(cp, namelen - (cp - name));
 	if (!tmp_len)
 		return -1;
+
 	len = cp + tmp_len - name;
 	cp = xstrndup(name, cp - name);
 	upstream = branch_get(*cp ? cp : NULL);
diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
index d5d6244..277a1a2 100755
--- a/t/t1508-at-combinations.sh
+++ b/t/t1508-at-combinations.sh
@@ -45,6 +45,8 @@ check "@{u}" upstream-two
 check "@{u}@{1}" upstream-one
 check "@{-1}@{u}" master-two
 check "@{-1}@{u}@{1}" master-one
+check "@" new-two
+check "@@{u}" upstream-two
 nonsense "@{u}@{-1}"
 nonsense "@{1}@{u}"
 
-- 
1.8.3.rc0.401.g45bba44
