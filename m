From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/11] for-each-ref: add '--points-at' option
Date: Sun, 14 Jun 2015 01:48:19 +0530
Message-ID: <1434226706-3764-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 22:18:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rtB-0003KI-Em
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:18:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbFMUSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:18:47 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35191 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751166AbbFMUSo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:18:44 -0400
Received: by pacyx8 with SMTP id yx8so41102661pac.2
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=78pwJr5mscvwIjxK3luYlnrVGRzSXXMFmhOb8YX9fJg=;
        b=FbBZm/fN38LLHjJHW4SmDsUcS4yNIYdzTNl4oq9RDJFTm+gkslicSQ2pYuFjmX92O8
         zy0WuWGubJGoFpKwVlxB3UDTP+C8mQ0NXX4j7In9ZtwhqLSpMPEdvJJ/qoXeNOhypq4Z
         W9X6vxv6CHDOkQZ1HIWe2XJvICPqnFcUc2Vyt5XPyWFesN6fu4pgDSjZsrdzDcG33Swc
         m69Epto4a1ouvWBBfcvgkmMgVTBDaVdjsDbhjnBsjrTdF7cJfIspu3BoEzCPCBoqT/hb
         mKyi1nbSgCQnB/L8bG/1D+sxDwTY3Tgf63FhaDllR7KskisftjflHFBG91p7Jvlb+DDT
         42ZA==
X-Received: by 10.70.22.235 with SMTP id h11mr34425688pdf.135.1434226724128;
        Sat, 13 Jun 2015 13:18:44 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nw8sm7471590pdb.30.2015.06.13.13.18.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 13:18:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434226706-3764-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271579>

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
 t/t6301-for-each-ref-filter.sh     | 10 ++++++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f8d9a5..0524ac4 100644
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
+	Only list refs of the given object.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7919206..2dee149 100644
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
+			     N_("object"), N_("print only refs of the object"),
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
index 5bd49b3..3a1c3f6 100644
--- a/t/t6301-for-each-ref-filter.sh
+++ b/t/t6301-for-each-ref-filter.sh
@@ -32,4 +32,14 @@ test_expect_success 'filtering with fnmatch' '
 	test_cmp expect actual
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
 test_done
-- 
2.4.3.435.g2403634.dirty
