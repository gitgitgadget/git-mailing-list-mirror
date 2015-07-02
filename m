From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 04/11] for-each-ref: add '--points-at' option
Date: Thu,  2 Jul 2015 20:51:03 +0530
Message-ID: <1435850470-5175-4-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZSJLsxfTGQjhsemL3r-z1e6i4DVT14NJUDYY719mzzTAg@mail.gmail.com>
 <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 17:22:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAgJU-0000I8-Ls
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 17:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbbGBPWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 11:22:00 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35394 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753856AbbGBPVw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 11:21:52 -0400
Received: by pactm7 with SMTP id tm7so42016672pac.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 08:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EcLpwYQGX5QUT2+XKsq36LMQrh9S2dHtyak+5mOLlfQ=;
        b=sN1wu8dhQ99wJBjcDModnhzIxxGhUuEJNXvq8pnXr9K0Fuv1/1HvDBbxGkfgRXwlM+
         23WbjUazF2z4Rmuh29VS+IF6kHyL+bjdiu6O+4h4Hl4DesZUtW8pw5R6v0AtXtGfA4Xu
         FdPDz0TLwG8fK2g1UkK4zD3ThHr9c2a6+RzBo2rZVythN+wvWNyXeGU23A8IK7Rf68jS
         qsxpuhOePLz30x2lJrQHbI/WQa0yL9ZXMjJTVlm2JJvOyEZY2n9YlyFMOSwXkqec7rfa
         XyFNnChSspuuvVIjYtgeseKQi1yaFz6+cdvh9JZZGD9ZkxV9CC9YvjPh+6rWMpGefQE6
         wSIQ==
X-Received: by 10.68.182.68 with SMTP id ec4mr66828359pbc.88.1435850511517;
        Thu, 02 Jul 2015 08:21:51 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id fu2sm635208pdb.32.2015.07.02.08.21.49
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 08:21:50 -0700 (PDT)
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1435850470-5175-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273236>

Add the '--points-at' option provided by 'ref-filter'. The
option lets the user to list only refs which pertain to the
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
index 7f8d9a5..f115335 100644
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
+	Only list refs pertaining to the given object.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 7919206..5b6f93a 100644
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
+			     N_("object"), N_("print only refs pertaining to the given object"),
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
2.4.4
