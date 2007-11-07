From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH PARSEOPT 3/4] Use OPT_BIT in builtin-for-each-ref
Date: Wed,  7 Nov 2007 11:20:29 +0100
Message-ID: <1194430832-6224-5-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
 <1194430832-6224-3-git-send-email-madcoder@debian.org>
 <1194430832-6224-4-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:20:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi1n-00018B-00
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:20:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbXKGKUm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXKGKUk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:40 -0500
Received: from pan.madism.org ([88.191.52.104]:35295 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828AbXKGKUf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:35 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1497B28E24;
	Wed,  7 Nov 2007 11:20:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 23B9A1CA9F; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-4-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63795>

---
 builtin-for-each-ref.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index da8c794..1a23ea6 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -833,16 +833,19 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	int i, num_refs;
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
-	int maxcount = 0, quote_style;
-	int quote_shell = 0, quote_perl = 0, quote_python = 0, quote_tcl = 0;
+	int maxcount = 0, quote_style = 0;
 	struct refinfo **refs;
 	struct grab_ref_cbdata cbdata;
 
 	struct option opts[] = {
-		OPT_BOOLEAN('s', "shell", &quote_shell, "quote placeholders suitably for shells"),
-		OPT_BOOLEAN('p', "perl",  &quote_perl, "quote placeholders suitably for perl"),
-		OPT_BOOLEAN( 0 , "python", &quote_python, "quote placeholders suitably for python"),
-		OPT_BOOLEAN( 0 , "tcl",  &quote_tcl, "quote placeholders suitably for tcl"),
+		OPT_BIT('s', "shell", &quote_style,
+		        "quote placeholders suitably for shells", QUOTE_SHELL),
+		OPT_BIT('p', "perl",  &quote_style,
+		        "quote placeholders suitably for perl", QUOTE_PERL),
+		OPT_BIT(0 , "python", &quote_style,
+		        "quote placeholders suitably for python", QUOTE_PYTHON),
+		OPT_BIT(0 , "tcl",  &quote_style,
+		        "quote placeholders suitably for tcl", QUOTE_TCL),
 
 		OPT_GROUP(""),
 		OPT_INTEGER( 0 , "count", &maxcount, "show only <n> matched refs"),
@@ -857,15 +860,13 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 		error("invalid --count argument: `%d'", maxcount);
 		usage_with_options(for_each_ref_usage, opts);
 	}
-	if (quote_shell + quote_perl + quote_python + quote_tcl > 1) {
+	if (HAS_MULTI_BITS(quote_style)) {
 		error("more than one quoting style ?");
 		usage_with_options(for_each_ref_usage, opts);
 	}
 	if (verify_format(format))
 		usage_with_options(for_each_ref_usage, opts);
 
-	quote_style = QUOTE_SHELL * quote_shell + QUOTE_PERL * quote_perl +
-		QUOTE_PYTHON * quote_python + QUOTE_TCL * quote_tcl;
 	if (!sort)
 		sort = default_sort();
 	sort_atom_limit = used_atom_cnt;
-- 
1.5.3.5.1598.gdef4e
