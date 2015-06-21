From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 04/19] for-each-ref: add '--points-at' option
Date: Mon, 22 Jun 2015 02:18:18 +0530
Message-ID: <1434919705-4884-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZS_vn8ZNrb7mtqZKU4Y3RCZojcbeMYfbx=3X-aVjhdpSA@mail.gmail.com>
 <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 21 22:48:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6mAe-0005Nd-Q5
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 22:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754176AbbFUUst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 16:48:49 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:33839 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446AbbFUUsr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 16:48:47 -0400
Received: by pdbki1 with SMTP id ki1so124839353pdb.1
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 13:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nOrNVVQEqicvGfy4YmM42i0q1nJLa5Wekt5XK0phuoo=;
        b=bUqDBONGwb34AA7Mq0O6zUNt7tMUI8hRq0zuhA89gqzz5p/0nYx5jWo8duS5Bx9hSq
         2kSwCFBzi+nUNFk3vn0qRKoffm11os4p9tarzqO2yLnsyxmMn/0K5BLLP/Omws1ll48w
         44OT05UaVkRZgO6DkrPefPKEfjWuPbnQI7nfRxXwTfuaBbDx3ctYXUsMz2aNWhnnIEBQ
         URh+LxsHCm/AifJjOIiwpfoiROSam6ug6AIi66Kj/9lw9PboM7n9MdEb0jt+SZ0IVA/i
         2LtLs4pKF+KqPE+HNv0/UbWBNLnGoro1xUio7zd3vsmsKJxt2ITtXIEal0jnHnEsRolY
         hzvw==
X-Received: by 10.68.102.228 with SMTP id fr4mr51941179pbb.110.1434919726838;
        Sun, 21 Jun 2015 13:48:46 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id s1sm17519488pda.54.2015.06.21.13.48.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jun 2015 13:48:46 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1434919705-4884-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272291>

Add the '--points-at' option provided by 'ref-filter'. The
option lets the user to pick only refs which point to a particular
commit.

Add documentation and tests for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 builtin/for-each-ref.c             |  9 +++++++--
 t/t6301-for-each-ref-filter.sh     | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f8d9a5..0ede41d 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
+		   [--points-at <object>]
 
 DESCRIPTION
 -----------
@@ -62,6 +63,8 @@ OPTIONS
 	the specified host language.  This is meant to produce
 	a scriptlet that can directly be `eval`ed.
 
+--points-at <object>::
+	Only list refs pointing to the given object.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7919206..46f9b05 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -7,6 +7,7 @@
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
+	N_("git for-each-ref [--points-at <object>]"),
 	NULL
 };
 
@@ -34,9 +35,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_CALLBACK(0, "points-at", &filter.points_at,
+			     N_("object"), N_("print only refs pointing to the given object"),
+			     parse_opt_object_name),
 		OPT_END(),
 	};
 
+	memset(&array, 0, sizeof(array));
+	memset(&filter, 0, sizeof(filter));
+
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
@@ -55,8 +62,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&array, 0, sizeof(array));
-	memset(&filter, 0, sizeof(filter));
 	filter.name_patterns = argv;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
 	ref_array_sort(sorting, &array);
diff --git a/t/t6301-for-each-ref-filter.sh b/t/t6301-for-each-ref-filter.sh
index b1fa8d4..67de3a7 100755
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -16,4 +16,24 @@ test_expect_success 'setup some history and refs' '
 	git update-ref refs/odd/spot master
 '
 
+test_expect_success 'filtering with --points-at' '
+	cat >expect <<-\EOF &&
+	refs/heads/master
+	refs/odd/spot
+	refs/tags/three
+	EOF
+	git for-each-ref --format="%(refname)" --points-at=master >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check signed tags with --points-at' '
+	cat >expect <<-\EOF &&
+	refs/heads/side 
+	refs/tags/four 
+	refs/tags/signed-tag four
+	EOF
+	git for-each-ref  --format="%(refname) %(*subject)" --points-at=side >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.3.439.gfea0c2a.dirty
