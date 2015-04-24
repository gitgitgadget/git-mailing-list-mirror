From: Quentin Neill <quentin.neill@gmail.com>
Subject: [PATCH] blame: add blame.showemail config option
Date: Thu, 23 Apr 2015 21:13:32 -0500
Message-ID: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
Cc: Quentin Neill <quentin.neill@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 04:12:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlT6S-0001QJ-1v
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 04:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbbDXCMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 22:12:23 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:36483 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751217AbbDXCMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 22:12:22 -0400
Received: by pdea3 with SMTP id a3so34752225pde.3
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2BzTvtgITvTQJmoFij3V+WajJpKbE/GK90iAHPXgFHM=;
        b=KjC190otMWbBwcf3cOybeteKooXgxE4xx5e45U3EXSBn6p+fk7GE8B2ZOU/NQpZ4Ap
         BUaYD4WS9PbD+oufGURKVYV4BmhwtQf4EHfSOGa8+Q0jbHaXmAX4XSxbLPOwA9YjExma
         cUfLjaDaS6YfUq09yYkh43xFRfQtuFbpa4lBMnL93MlnSKBsKpQEyLXfOljC6qa3mnGn
         C4fUTybWwZwLlj5QTZRRjh3UvE7htv0ejcFXaSUZpxmvtBWux7PgCeQIkq3BXhSHwGU9
         G8B3jlNG1ZL7Z6qXA4hw/CClOb4zILQmke722DF/Jr0CARcmjBzdNQJHy8lVN5aNbnVq
         /zQQ==
X-Received: by 10.70.133.170 with SMTP id pd10mr1676405pdb.127.1429841542092;
        Thu, 23 Apr 2015 19:12:22 -0700 (PDT)
Received: from dig.qualcomm.com (cpe-70-114-250-106.austin.res.rr.com. [70.114.250.106])
        by mx.google.com with ESMTPSA id nh9sm9299194pbc.63.2015.04.23.19.12.20
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Apr 2015 19:12:21 -0700 (PDT)
X-Google-Original-From: Quentin Neill <qneill@quicinc.com>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267720>

From: Quentin Neill <quentin.neill@gmail.com>

	If you prefer seeing emails in your git blame output, rather
	than sprinkling '-e' options everywhere you can just set
	the new config blame.showemail to true.
---
 Documentation/blame-options.txt |  5 +++++
 Documentation/git-blame.txt     |  4 ----
 builtin/blame.c                 | 11 ++++++++---
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index b299b59..9326115 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -1,6 +1,11 @@
 -b::
 	Show blank SHA-1 for boundary commits.  This can also
 	be controlled via the `blame.blankboundary` config option.
+-e::
+--show-email::
+	Show the author email instead of author name (Default: off).
+	This can also be controlled via the `blame.showemail` config
+	option.
 
 --root::
 	Do not treat root commits as boundaries.  This can also be
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 9f23a86..50a9030 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -73,10 +73,6 @@ include::blame-options.txt[]
 -s::
 	Suppress the author name and timestamp from the output.
 
--e::
---show-email::
-	Show the author email instead of author name (Default: off).
-
 -w::
 	Ignore whitespace when comparing the parent's version and
 	the child's to find where the lines came from.
diff --git a/builtin/blame.c b/builtin/blame.c
index 06484c2..70bfd0a 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -44,6 +44,7 @@ static int max_score_digits;
 static int show_root;
 static int reverse;
 static int blank_boundary;
+static int show_email;
 static int incremental;
 static int xdl_opts;
 static int abbrev = -1;
@@ -1926,7 +1927,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		printf("%.*s", length, hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
-			if (opt & OUTPUT_SHOW_EMAIL)
+			if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
 				name = ci.author_mail.buf;
 			else
 				name = ci.author.buf;
@@ -1949,7 +1950,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
-				if (opt & OUTPUT_SHOW_EMAIL)
+				if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
 					name = ci.author_mail.buf;
 				else
 					name = ci.author.buf;
@@ -2098,7 +2099,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 			struct commit_info ci;
 			suspect->commit->object.flags |= METAINFO_SHOWN;
 			get_commit_info(suspect->commit, &ci, 1);
-			if (*option & OUTPUT_SHOW_EMAIL)
+			if ((*option & OUTPUT_SHOW_EMAIL) || show_email)
 				num = utf8_strwidth(ci.author_mail.buf);
 			else
 				num = utf8_strwidth(ci.author.buf);
@@ -2185,6 +2186,10 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 		blank_boundary = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "blame.showemail")) {
+		show_email = git_config_bool(var, value);
+		return 0;
+	}
 	if (!strcmp(var, "blame.date")) {
 		if (!value)
 			return config_error_nonbool(var);
-- 
1.9.1
