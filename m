From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v4 5/6] for-each-ref: introduce %(color:...) for color
Date: Mon, 18 Nov 2013 23:09:12 +0530
Message-ID: <1384796353-18701-6-git-send-email-artagnon@gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 18 18:48:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViSwO-0004Az-Oc
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 18:48:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab3KRRsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 12:48:47 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:45876 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751727Ab3KRRsn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 12:48:43 -0500
Received: by mail-pa0-f49.google.com with SMTP id kx10so662575pab.22
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 09:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=st0sUp4XlRyEVxYiVZA0coqqvdbnfYFkGmQDxYKp2f0=;
        b=dlF3BU5wSgIq3Wk6fp/iAMEjCeD1WVc34CdrjeNd91odEPdcLcaA9YwK9wdQhVJpGx
         Rvg+ErxpPMFs7RAQ0tKjwfRGfK1MrKpm/SykJ/uKG30W+FB1+iHZAvgG569rIp12iAjE
         l43zICW1g+uCcavnAWZUGqZE2GNqopEUx+uBfcm/6JzYxJfuttOhn0hvxs74Xmx7XDAB
         bQtUIZR0IVtHxF5i6+UBX6YdZet0RAvHzE/GXExSG31TwpxYkGV++D5yNcdLR7w4x93S
         pBBL2JMIxYhspuZwiQh5SYvoBpmPDrjoMEwLe3I3D8gE5VgR/M2+Ws9jPh/KVOzgXCtT
         lOjw==
X-Received: by 10.69.12.36 with SMTP id en4mr21985756pbd.54.1384796922635;
        Mon, 18 Nov 2013 09:48:42 -0800 (PST)
Received: from localhost.localdomain ([122.164.173.226])
        by mx.google.com with ESMTPSA id hu10sm24836183pbc.11.2013.11.18.09.48.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2013 09:48:42 -0800 (PST)
X-Mailer: git-send-email 1.8.5.rc0.5.g70ebc73.dirty
In-Reply-To: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238000>

Enhance 'git for-each-ref' with color formatting options.  You can now
use the following format in for-each-ref:

  %(color:green)%(refname:short)%(color:reset)

where color names are described in color.branch.*.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  4 ++++
 builtin/for-each-ref.c             | 11 +++++++++--
 t/t6300-for-each-ref.sh            | 17 +++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 92e82fd..94f5c46 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -101,6 +101,10 @@ HEAD::
 	'*' if HEAD matches current ref (the checked out branch), ' '
 	otherwise.
 
+color::
+	Change output color.  Followed by `:<colorname>`, where names
+	are described in `color.branch.*`.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index ed81407..2ff4e54 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -9,6 +9,7 @@
 #include "quote.h"
 #include "parse-options.h"
 #include "remote.h"
+#include "color.h"
 
 /* Quoting styles */
 #define QUOTE_NONE 0
@@ -76,6 +77,7 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
+	{ "color" },
 };
 
 /*
@@ -662,8 +664,13 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
-		}
-		else if (!strcmp(name, "flag")) {
+		} else if (!prefixcmp(name, "color:")) {
+			char color[COLOR_MAXLEN] = "";
+
+			color_parse(name + 6, "--format", color);
+			v->s = xstrdup(color);
+			continue;
+		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index d88d7ac..69e3155 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -343,6 +343,23 @@ test_expect_success 'Check for invalid refname format' '
 	test_must_fail git for-each-ref --format="%(refname:INVALID)"
 '
 
+get_color ()
+{
+	git config --get-color no.such.slot "$1"
+}
+
+cat >expected <<EOF
+$(git rev-parse --short refs/heads/master) $(get_color green)master$(get_color reset)
+$(git rev-parse --short refs/remotes/origin/master) $(get_color green)origin/master$(get_color reset)
+$(git rev-parse --short refs/tags/testtag) $(get_color green)testtag$(get_color reset)
+$(git rev-parse --short refs/tags/two) $(get_color green)two$(get_color reset)
+EOF
+
+test_expect_success 'Check %(color:...) ' '
+	git for-each-ref --format="%(objectname:short) %(color:green)%(refname:short)%(color:reset)" >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 heads/master
 tags/master
-- 
1.8.5.rc0.5.g70ebc73.dirty
