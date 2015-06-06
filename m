From: Karthik Nayak <karthik.188@gmail.com>
Subject: [RFC/PATCH 3/9] for-each-ref: add '--points-at' option
Date: Sun,  7 Jun 2015 01:34:06 +0530
Message-ID: <1433621052-5588-3-git-send-email-karthik.188@gmail.com>
References: <5573520A.90603@gmail.com>
 <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 06 22:04:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1KKb-0002Lu-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 22:04:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbbFFUE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 16:04:28 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33357 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbbFFUE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 16:04:26 -0400
Received: by padev16 with SMTP id ev16so12000741pad.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 13:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y4Pm7zJQzJV+tsIuIs16KGbZCH68vDjiPPm7hlh5Cnw=;
        b=s1UrDbOPGfYAKd1DOk9heHnoBAnuan8OrM3fKgJmOz+sAsLj0XhfhxqhyuEGElP6Py
         oqO2/CIBPJi0ucz/SDDIj19mXTxBkzVW4HcFycp7FJ3V+VKP1++Aei8ytmQ0QYnZ8F5L
         AKQ0u8Nvn3YPJ6oz1ING+xpq3BafOWnbP5z+RswOAra1NZW1Kdl/f3YCTFyVQGoVB/9P
         wemhOhmnHJKgWij2Wq7rE2zka84I9aFs4Rt5pPrHZiM4zr5HDVx7uj5KYtBN6pu/8qM5
         SwCCF2PbUvQo4kk2a+rPxZK/MKPzDraHnOw0mk5jwnt5sk9ohNUH+zGWc0rrVwm38IsZ
         P7Rw==
X-Received: by 10.69.31.106 with SMTP id kl10mr16122297pbd.155.1433621065085;
        Sat, 06 Jun 2015 13:04:25 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id q5sm10333703pde.56.2015.06.06.13.04.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Jun 2015 13:04:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <1433621052-5588-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270944>

Add the '--points-at' option provided by 'ref-filter'. The
option lets the user to pick only refs which point to a particular
commit.

Add Documentation for the same.

Based-on-patch-by: Jeff King <peff@peff.net>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 +++
 builtin/for-each-ref.c             | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 7f8d9a5..e9f6a8a 100644
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
+	Only list tags of the given object.
 
 FIELD NAMES
 -----------
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 4d2d024..b9d180a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -7,6 +7,7 @@
 
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
+	N_("git for-each-ref [--points-at <object>]"),
 	NULL
 };
 
@@ -17,6 +18,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	struct ref_sorting *sorting = NULL, **sorting_tail = &sorting;
 	int maxcount = 0, quote_style = 0;
 	struct ref_filter_cbdata ref_cbdata;
+	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 
 	struct option opts[] = {
 		OPT_BIT('s', "shell", &quote_style,
@@ -33,6 +35,9 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		OPT_STRING(  0 , "format", &format, N_("format"), N_("format to use for the output")),
 		OPT_CALLBACK(0 , "sort", sorting_tail, N_("key"),
 			    N_("field name to sort on"), &parse_opt_ref_sorting),
+		OPT_CALLBACK(0, "points-at", &ref_cbdata.filter.points_at,
+			     N_("object"), N_("print only tags of the object"),
+			     parse_opt_points_at),
 		OPT_END(),
 	};
 
@@ -54,7 +59,6 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	/* for warn_ambiguous_refs */
 	git_config(git_default_config, NULL);
 
-	memset(&ref_cbdata, 0, sizeof(ref_cbdata));
 	ref_cbdata.filter.name_patterns = argv;
 	filter_refs(for_each_rawref, &ref_cbdata);
 
-- 
2.4.2
