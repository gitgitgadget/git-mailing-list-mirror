From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 15/15] for-each-ref: use get_pretty_userformat in --pretty
Date: Tue,  4 Jun 2013 18:05:37 +0530
Message-ID: <1370349337-20938-16-git-send-email-artagnon@gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 04 14:34:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjqRv-0007Oz-Pj
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 14:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754347Ab3FDMen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 08:34:43 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:62375 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab3FDMee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 08:34:34 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so178110pde.4
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 05:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YGJQHXpTMXtMByvY8A2ass6pysZGstGT1BsnVz7XeaA=;
        b=PJ8twLx4ooT6MZBrh/UAHr0jEXuu/757zyfG5QbIqMx6q7Txs5PfFyhkQL4U4qath8
         hd+wqMSyK4quwJ0S8zJp73WIh8JBmRsKhW/ro7cbPvL4O73qpvjCevLM6p8rw1jXtNuB
         8nPfyje0Kf5c0HGf6UIz45gabaA7qczuOI4PjnyJYYiXnVp6B6ds5ZzBC/b8XDhVLk6l
         BDf4aVginLZdm+TGoJ9AO/aBQPApsQkgP8nFcAKy0zEwSAqWV65COYejDNbTzLQxl7fs
         j5rKYaWP5zFih3kxh5WURW19ASdsuH7cuqPtp5Cj0xK8/ZLKmLh0OUu5LpIinBbmnbgG
         /GgQ==
X-Received: by 10.68.76.67 with SMTP id i3mr3457054pbw.20.1370349273400;
        Tue, 04 Jun 2013 05:34:33 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id vz8sm67423587pac.20.2013.06.04.05.34.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 04 Jun 2013 05:34:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226358>

Use get_pretty_userformat() to interpret the --pretty string.  This
means that leading you can now reference a format specified in a pretty.*
configuration variable as an argument to 'git for-each-ref --pretty='.
There are two caveats:

1. A leading "format:" or "tformat:" is automatically stripped and
   ignored.  Separator semantics are not configurable (yet).

2. No built-in formats are available.  The ones specified in
   pretty-formats (oneline, short etc) don't make sense when displaying
   refs anyway.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 builtin/for-each-ref.c             | 16 +++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 05ff7ba..7f3cba5 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -60,6 +60,9 @@ calculated.
 +
 Caveats:
 
+0. No built-in formats from PRETTY FORMATS (like oneline, short) are
+   available.
+
 1. Many of the placeholders in "PRETTY FORMATS" are designed to work
    specifically on commit objects: when non-commit objects are
    supplied, those placeholders won't work.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index edaa6b2..c00ab05 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1146,7 +1146,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int num_refs;
 	const char *default_format = "%(objectname) %(objecttype)\t%(refname)";
 	const char *format = default_format;
-	const char *pretty = NULL;
+	const char *pretty_raw = NULL, *pretty_userformat = NULL;
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
 	struct refinfo **refs;
@@ -1165,13 +1165,15 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, N_("show only <n> matched refs")),
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
-		OPT_STRING(  0 , "pretty", &pretty, N_("format"), N_("alternative format to use for the output")),
+		OPT_STRING(  0 , "pretty", &pretty_raw, N_("format"), N_("alternative format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sort_tail, N_("key"),
 			    N_("field name to sort on"), &opt_parse_sort),
 		OPT_END(),
 	};
 
 	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	if (pretty_raw)
+		pretty_userformat = get_pretty_userformat(pretty_raw);
 	if (maxcount < 0) {
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
@@ -1180,10 +1182,10 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("more than one quoting style?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (format != default_format && pretty)
+	if (format != default_format && pretty_userformat)
 		die("--format and --pretty cannot be used together");
-	if ((pretty && verify_format(pretty, 1)) ||
-	    (!pretty && verify_format(format, 0)))
+	if ((pretty_userformat && verify_format(pretty_userformat, 1)) ||
+	    (!pretty_userformat && verify_format(format, 0)))
 		usage_with_options(for_each_ref_usage, opts);
 
 	if (!sort)
@@ -1204,8 +1206,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	if (!maxcount || num_refs < maxcount)
 		maxcount = num_refs;
 
-	if (pretty)
-		show_pretty_refs(refs, maxcount, pretty, quote_style);
+	if (pretty_userformat)
+		show_pretty_refs(refs, maxcount, pretty_userformat, quote_style);
 	else
 		show_refs(refs, maxcount, format, quote_style);
 	return 0;
-- 
1.8.3.GIT
