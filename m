From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] Integrate wildmatch to git
Date: Mon, 17 Sep 2012 19:40:20 +0700
Message-ID: <20120917124020.GA21798@lanh>
References: <1347710524-15404-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-1-git-send-email-pclouds@gmail.com>
 <1347809265-2457-5-git-send-email-pclouds@gmail.com>
 <7vpq5lw6z8.fsf@alter.siamese.dyndns.org>
 <7vd31lw5vy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 14:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDacr-0007eK-De
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 14:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958Ab2IQMkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 08:40:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62639 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab2IQMkS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 08:40:18 -0400
Received: by obbuo13 with SMTP id uo13so8842554obb.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 05:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=//D8TTQw49NLW0puItGELyxo0D4du+cMDpgEZyJKtp8=;
        b=KqrlG3/Btsk5MkNIk8TA7s7PzYQcQe8DGB7CNoouct1NhKiry1WBBPf12lnLqnX9bQ
         6JnRjt0W5YISch152xfEFjMOyWG+2eXMuwXFY/LozesdfeXljsjgSQmps4+gUDkOFPQV
         Qr8O/29MmrQUT08JdIaDdedJt9UK4hqsovgqyXz98qdcVIP3O+SgCgH+UD4odI1lfwoL
         RBd9QsQynn5Bqk1BJ5ymT5wTgxCwrzqcG2gMNO+M98HLHN4lZEd5hzcfDosa6rgBuMCS
         Cxxf+QlPZHMaovhbH5bBSBKEIB2yRML3YggX+FVGo5X98VoPWqGEgmI5452UD10h8EZY
         2D0w==
Received: by 10.60.10.225 with SMTP id l1mr11637540oeb.28.1347885617496;
        Mon, 17 Sep 2012 05:40:17 -0700 (PDT)
Received: from lanh ([115.74.50.93])
        by mx.google.com with ESMTPS id ac10sm10589055obc.7.2012.09.17.05.40.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 05:40:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 17 Sep 2012 19:40:20 +0700
Content-Disposition: inline
In-Reply-To: <7vd31lw5vy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205682>

On Sun, Sep 16, 2012 at 10:54:57PM -0700, Junio C Hamano wrote:
> Yeah, popt.h it is.  It is a bit distasteful that we have a build
> dependency only to build test-* helper on something that we do not
> even have runtime dependency on.

Perhaps this squash-in? It kills libpopt and removes the "#include
"wildmatch.c"". Now we really do test what libgit.a carries.

-- 8< --
diff --git a/Makefile b/Makefile
index 745e88c..093ab9c 100644
--- a/Makefile
+++ b/Makefile
@@ -2589,9 +2589,6 @@ test-svn-fe$X: vcs-svn/lib.a
 test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
-test-wildmatch$X: test-wildmatch.o GIT-LDFLAGS
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) -lpopt
-
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
diff --git a/test-wildmatch.c b/test-wildmatch.c
index 828188a..b94921b 100644
--- a/test-wildmatch.c
+++ b/test-wildmatch.c
@@ -19,17 +19,18 @@
 
 /*#define COMPARE_WITH_FNMATCH*/
 
-#define WILD_TEST_ITERATIONS
-#include "wildmatch.c"
+#include "cache.h"
+#include "parse-options.h"
+#include "wildmatch.h"
 
+#ifndef MAXPATHLEN
 #define MAXPATHLEN 1024
+#endif
 #ifdef NO_STRLCPY
 #include "compat/strlcpy.c"
 #define strlcpy gitstrlcpy
 #endif
 
-#include <popt.h>
-
 #ifdef COMPARE_WITH_FNMATCH
 #include <fnmatch.h>
 
@@ -41,18 +42,16 @@ char number_separator = ',';
 
 typedef char bool;
 
-int output_iterations = 0;
 int explode_mod = 0;
 int empties_mod = 0;
 int empty_at_start = 0;
 int empty_at_end = 0;
+char *empties;
 
-static struct poptOption long_options[] = {
-  /* longName, shortName, argInfo, argPtr, value, descrip, argDesc */
-  {"iterations",     'i', POPT_ARG_NONE,   &output_iterations, 0, 0, 0},
-  {"empties",        'e', POPT_ARG_STRING, 0, 'e', 0, 0},
-  {"explode",        'x', POPT_ARG_INT,    &explode_mod, 0, 0, 0},
-  {0,0,0,0, 0, 0, 0}
+static struct option options[] = {
+  OPT_STRING('e', "empties", &empties, "", ""),
+  OPT_INTEGER('x', "explode", &explode_mod, ""),
+  OPT_END(),
 };
 
 /* match just at the start of string (anchored tests) */
@@ -106,51 +105,33 @@ run_test(int line, bool matches,
 	fnmatch_errors++;
     }
 #endif
-    if (output_iterations) {
-	printf("%d: \"%s\" iterations = %d\n", line, pattern,
-	       wildmatch_iteration_count);
-    }
 }
 
 int
 main(int argc, char **argv)
 {
     char buf[2048], *s, *string[2], *end[2];
-    const char *arg;
     FILE *fp;
-    int opt, line, i, flag[2];
-    poptContext pc = poptGetContext("wildtest", argc, (const char**)argv,
-				    long_options, 0);
-
-    while ((opt = poptGetNextOpt(pc)) != -1) {
-	switch (opt) {
-	  case 'e':
-	    arg = poptGetOptArg(pc);
-	    empties_mod = atoi(arg);
-	    if (strchr(arg, 's'))
-		empty_at_start = 1;
-	    if (strchr(arg, 'e'))
-		empty_at_end = 1;
-	    if (!explode_mod)
-		explode_mod = 1024;
-	    break;
-	  default:
-	    fprintf(stderr, "%s: %s\n",
-		    poptBadOption(pc, POPT_BADOPTION_NOALIAS),
-		    poptStrerror(opt));
-	    exit(1);
-	}
+    int line, i, flag[2];
+    const char *help[] = { NULL };
+
+    argc = parse_options(argc, (const char **)argv, "", options, help, 0);
+    if (argc != 1)
+	    die("redundant options");
+    if (empties) {
+	const char *arg = empties;
+	empties_mod = atoi(arg);
+	if (strchr(empties, 's'))
+	    empty_at_start = 1;
+	if (strchr(arg, 'e'))
+	    empty_at_end = 1;
+	if (!explode_mod)
+	    explode_mod = 1024;
     }
 
     if (explode_mod && !empties_mod)
 	empties_mod = 1024;
 
-    argv = (char**)poptGetArgs(pc);
-    if (!argv || argv[1]) {
-	fprintf(stderr, "Usage: wildtest [OPTIONS] TESTFILE\n");
-	exit(1);
-    }
-
     if ((fp = fopen(*argv, "r")) == NULL) {
 	fprintf(stderr, "Unable to open %s\n", *argv);
 	exit(1);
diff --git a/wildmatch.c b/wildmatch.c
index 625cb0c..f153f8a 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -59,10 +59,6 @@ typedef unsigned char uchar;
 #define ISUPPER(c) (ISASCII(c) && isupper(c))
 #define ISXDIGIT(c) (ISASCII(c) && isxdigit(c))
 
-#ifdef WILD_TEST_ITERATIONS
-int wildmatch_iteration_count;
-#endif
-
 /* Match pattern "p" against the a virtually-joined string consisting
  * of "text" and any strings in array "a". */
 static int dowild(const uchar *p, const uchar *text,
@@ -70,10 +66,6 @@ static int dowild(const uchar *p, const uchar *text,
 {
     uchar p_ch;
 
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count++;
-#endif
-
     for ( ; (p_ch = *p) != '\0'; text++, p++) {
 	int matched, special;
 	uchar t_ch, prev_ch;
@@ -295,9 +287,6 @@ static const uchar *trailing_N_elements(const uchar*const **a_ptr, int count)
 int wildmatch(const char *pattern, const char *text)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count = 0;
-#endif
     return dowild((const uchar*)pattern, (const uchar*)text, nomore, 0) == TRUE;
 }
 
@@ -306,9 +295,6 @@ int iwildmatch(const char *pattern, const char *text)
 {
     static const uchar *nomore[1]; /* A NULL pointer. */
     int ret;
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count = 0;
-#endif
     ret = dowild((const uchar*)pattern, (const uchar*)text, nomore, 1) == TRUE;
     return ret;
 }
@@ -325,10 +311,6 @@ int wildmatch_array(const char *pattern, const char*const *texts, int where)
     const uchar *text;
     int matched;
 
-#ifdef WILD_TEST_ITERATIONS
-    wildmatch_iteration_count = 0;
-#endif
-
     if (where > 0)
 	text = trailing_N_elements(&a, where);
     else
-- 8< --
