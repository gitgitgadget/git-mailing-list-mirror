From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 07/19] for-each-ref: add '--merged' and '--no-merged' options
Date: Mon, 22 Jun 2015 02:18:21 +0530
Message-ID: <1434919705-4884-7-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:49:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mAy-0005ZE-Lt
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776AbbFUUtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:49:08 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:32991 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbFUUtF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:49:05 -0400
Received: by pdjn11 with SMTP id n11so124855388pdj.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DiaMXdBaYyb7sMj7ka3/AP18ZXPCLPjJO+E2t6QWnAI=;
        b=KEk9iM/m/ZLi0V/sxcQZjy3OAzr+hTL//lu+IPiEXPBEFW+g46MW9ZR08+3PnxcA3+
         8ysgpYb8LGsh43Q1OT2sSgWSqUgpRwhp5lvWHFlN9LGYdMG6bJN3/DJRszyi2c3d3vP3
         uwI1up9I4COWs7vm/jbcL0B+AatDupg4/PmrjsmFaup36yCvfi1ifRo1Z3UQfw2yBIsP
         3B0fxCwokxce7izecOwo1qLS6tewi6k1w1p8RmzO1s4jxTw6+M9mQnC91dI3SYXG8/sU
         7vHoX5HJmyvDOau3rpKMfjkE9+cdU56TFQMLeHTLgUDnd3BWqGFNNchLsDoev7h1+AZy
         dqSQ==
X-Received: by 10.68.221.70 with SMTP id qc6mr52242298pbc.76.1434919744590;
        Sun, 21 Jun 2015 13:49:04 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.49.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:49:03 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272293>

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
 t/t6301-for-each-ref-filter.sh     | 22 +++++++++++++++++-----
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 0ede41d..c6dcd99 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
-		   [--points-at <object>]
+		   [--points-at <object>] [(--merged | --no-merged) <object>]
 
 DESCRIPTION
 -----------
@@ -66,6 +66,14 @@ OPTIONS
 --points-at <object>::
 	Only list refs pointing to the given object.
 
+--merged [<commit>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged [<commit>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
 FIELD NAMES
 -----------
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 46f9b05..09d48da 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,6 +8,7 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
+	N_("git for-each-ref [(--merged | --no-merged) <object>]"),
 	NULL
 };
 
@@ -38,6 +39,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK(0, "points-at", &filter.points_at,
 			     N_("object"), N_("print only refs pointing to the given object"),
 			     parse_opt_object_name),
+		OPT_MERGED(&filter, N_("print only refs that are merged")),
+		OPT_NO_MERGED(&filter, N_("print only refs that are not merged")),
 		OPT_END(),
 	};
 
diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
index 67de3a7..5b5cf04 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -26,13 +26,25 @@ test_expect_success 'filtering with --points-at' '
 	test_cmp expect actual
 '
 
-test_expect_success 'check signed tags with --points-at' '
+test_expect_success 'filtering with --merged' '
 	cat >expect <<-\EOF &&
-	refs/heads/side 
-	refs/tags/four 
-	refs/tags/signed-tag four
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
+	refs/tags/four
+	refs/tags/signed-tag
 	EOF
-	git for-each-ref  --format="%(refname) %(*subject)" --points-at=side >actual &&
+	git for-each-ref --format="%(refname)" --no-merged=master >actual &&
 	test_cmp expect actual
 '
 
-- 
2.4.3.439.gfea0c2a.dirty
