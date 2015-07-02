From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 07/11] for-each-ref: add '--merged' and '--no-merged' options
Date: Thu,  2 Jul 2015 20:51:06 +0530
Message-ID: <1435850470-5175-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJm-0000Vk-PC
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbbGBPWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:19 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33493 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbbGBPWD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:22:03 -0400
Received: by pdjd13 with SMTP id d13so46896676pdj.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kiSSsvAiwhEbA5DzRwuiUrWaja8BjXrexaw3MYak5LM=;
        b=jjxod6AC/lSmpVD+/8/Ue6xv7Yx5/vtzDyfhbiKeG5ALEfR+uxVseWvQMtl2CQTm8L
         EyWxa201jWbJopuHTLdgI3/0lNo6Hlb3QJ++y5SUEIsTSQVOM1KhLxOYc0D4uX0yI23M
         i/8RFNnmmuzaXzCKFHUDwn/Aj0wykjLjLC6gAz02InQN93pLCH8H9249DKIYgQdHIELn
         pbuYrFlJvU2blrSAfIYFCokS3PzNC/srGT6lcduqqAiyoPvVVjvtAC8/I3YUTgyPlIQN
         yn2SuAiXDpX1XR1mY1r7Yt98jZFOQJ36zdS0Gf6sdjC9WVxFdx0bit1mlt6km0tG9CcB
         P0wQ==
X-Received: by 10.70.33.67 with SMTP id p3mr67150943pdi.126.1435850523064;
        Thu, 02 Jul 2015 08:22:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.22.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:22:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273242>

Add the '--merged' and '--no-merged' options provided by 'ref-filter'.
The '--merged' option lets the user to only list refs merged into the
named commit. The '--no-merged' option lets the user to only list refs
not merged into the named commit.

Add documentation and tests for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 10 +++++++++-
 builtin/for-each-ref.c             |  3 +++
 t/t6302-for-each-ref-filter.sh     | 23 +++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index f115335..bf8b24a 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>]
+		   [--points-at <object>] [(--merged | --no-merged) [<object>]]
 
 DESCRIPTION
 -----------
@@ -66,6 +66,14 @@ OPTIONS
 --points-at <object>::
 	Only list refs pertaining to the given object.
 
+--merged [<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 5b6f93a..120b753 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,6 +8,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
+	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs pertaining to the given object"),
 			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_END(),
 	};
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 457991f..73dbf53 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -37,4 +37,27 @@ test_expect_success 'check signed tags with --points-at' '
 	test_cmp expect actual
 '
 
+test_expect_success 'filtering with --merged' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/odd/spot
+	refs/tags/one
+	refs/tags/three
+	refs/tags/two
+	EOF
+	git for-each-ref --format="%(refname)" --merged=master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'filtering with --no-merged' '
+	cat >expect <<-\EOF &&
+	refs/heads/side
+	refs/tags/double-tag
+	refs/tags/four
+	refs/tags/signed-tag
+	EOF
+	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.4
