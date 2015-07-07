From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 04/11] for-each-ref: add '--points-at' option
Date: Tue,  7 Jul 2015 21:36:10 +0530
Message-ID: <1436285177-12279-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZTP+=aQL_JW4+O7jUh5jTD1bWpk7xbguYUsW1DkotAafA@mail.gmail.com>
 <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 07 18:07:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCVOp-0001NM-CK
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 18:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757812AbbGGQHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 12:07:07 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35756 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757758AbbGGQHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 12:07:04 -0400
Received: by pdbci14 with SMTP id ci14so128169998pdb.2
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9xmTNVCr42ReVba6BvMNGhLv1lF+i+O/HQPzVQPnw4k=;
        b=hw6yjGGeGP+1otwlLMpxwvpzFpGEq8+abPNLxdKTR90eUoaIz1vs/SpBe369o4Z2/i
         YtxOcWzODcINmzwWFDRG+nZFrxvjJR90JjmIU1Tnmt5rEIKvp6QpDkZm4m3aTLDEjhiQ
         aGG4ARELIfZfvgv3T2r3H/iZ1IKChl4tuw+6wJQulpxCQ21iscLN8gTqm4JEqOWfqH4d
         CMqjGoWHo24fVB9jCPZR5UFueN8d7VKFzmADg0m7jn5KWBg68oZKtYlLs85L7erbEp5N
         sep8l8w5ZUmWkmVjVhAOlK37MoVvD4zkwQ9ZQCyoiGQuvh2cqMNITPtFPBSF0+JcPt5G
         Doyg==
X-Received: by 10.68.109.37 with SMTP id hp5mr10474793pbb.63.1436285223762;
        Tue, 07 Jul 2015 09:07:03 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nt6sm22295515pbc.18.2015.07.07.09.07.00
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Jul 2015 09:07:02 -0700 (PDT)
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1436285177-12279-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273574>

Add the '--points-at' option provided by 'ref-filter'. The
option lets the user to list only refs which points at the
given object.

Add documentation and tests for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 builtin/for-each-ref.c             |  9 +++++++--
 t/t6302-for-each-ref-filter.sh     | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f8d9a5..ff0283b 100644
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
+	Only list refs which points at the given object.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7919206..ae5419e 100644
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
+			     N_("object"), N_("print only refs which points at the given object"),
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
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 44d2f24..457991f 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -17,4 +17,24 @@ test_expect_success 'setup some history and refs' '
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
+	sed -e "s/Z$//" >expect <<-\EOF &&
+	refs/heads/side Z
+	refs/tags/four Z
+	refs/tags/signed-tag four
+	EOF
+	git for-each-ref --format="%(refname) %(*subject)" --points-at=side >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.4.5
