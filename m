From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Make list of features auto-managed.
Date: Thu, 21 Jun 2007 02:00:39 -0700
Message-ID: <7vhcp1y954.fsf_-_@assigned-by-dhcp.pobox.com>
References: <20070621045903.GA14047@spearce.org>
	<7v1wg55065.fsf@assigned-by-dhcp.pobox.com>
	<20070621061045.GG8477@spearce.org>
	<7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 21 11:01:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1IXO-0001yI-TB
	for gcvg-git@gmane.org; Thu, 21 Jun 2007 11:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbXFUJAm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 05:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbXFUJAm
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 05:00:42 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36041 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbXFUJAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 05:00:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070621090040.BQPF3993.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Jun 2007 05:00:40 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id E90f1X00E1kojtg0000000; Thu, 21 Jun 2007 05:00:40 -0400
In-Reply-To: <7vr6o5zt76.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's
	message of "Thu, 21 Jun 2007 00:02:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50608>

This updates the build procedure so that a mark-up in the form
of:

	SP "FEATURE<" feature-name ">" SP

is picked up from the sources, in order to help keeping
supported_features[] array automatically in sync.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

  Junio C Hamano <gitster@pobox.com> writes:

  > So, first of all, I would want the list of features in
  > supported_features[] to come from a separate file, whose sole
  > purpose is to have that list.  I would even suggest making it an
  > generated file, which depends on the source files (not
  > necessarily limited to C files), and built from within the build
  > procedure.
  > ...
  > Assuming if this --list-features is a viable approach in the
  > long run, my gut feeling of relative order of things is:
  >
  >  (1) We prepare rock-solid runtime with an _EMPTY_ feature array
  >      in 'master'.
  >
  >  (2) We add automated feature array management in 'master', as
  >      outlined above.
  >
  >  (3) Merge the above two to 'next'.
  >
  >  (4) Update all existing topics, including the ones that are
  >      already in 'next', with the feature mark-up in comment
  >      (i.e. "FEATURE[[[feature-name]]]").
  >
  > After (3) happens, any new topics that introduce a new feature
  > should be accompanied with the feature mark-up.

  So here is a PoC for step (2).  It loses more lines than it
  adds, primarily because we can lose is_feature_name_sane(); it
  is done at the build time now.

 .gitignore           |    1 +
 Makefile             |   12 +++++++++++-
 builtin-blame.c      |    1 +
 generate-features.sh |    9 +++++++++
 help.c               |   48 +++++++++++++-----------------------------------
 5 files changed, 35 insertions(+), 36 deletions(-)
 create mode 100755 generate-features.sh

diff --git a/.gitignore b/.gitignore
index e8b060c..64ee08b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -169,3 +169,4 @@ config.status
 config.mak.autogen
 config.mak.append
 configure
+features.h
diff --git a/Makefile b/Makefile
index c09dfaf..d8d1ddc 100644
--- a/Makefile
+++ b/Makefile
@@ -262,6 +262,13 @@ BUILT_INS = \
 	git-fsck-objects$X git-cherry-pick$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
+# what are the source files
+SOURCE_FILES = $(sort \
+	$(SCRIPT_SH) $(SCRIPT_PERL) $(SCRIPT_PYTHON) \
+	$(patsubst git-%$X,%.c,$(PROGRAMS)) \
+	$(LIB_H) \
+	$(patsubst %.o,%.c,$(LIB_OBJS) $(BUILTIN_OBJS)))
+
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 
@@ -755,7 +762,10 @@ git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 		$(ALL_CFLAGS) -o $@ $(filter %.c,$^) git.o \
 		$(BUILTIN_OBJS) $(ALL_LDFLAGS) $(LIBS)
 
-help.o: common-cmds.h
+features.h: $(SOURCE_FILES) generate-features.sh
+	$(QUIET_GEN)./generate-features.sh $(SOURCE_FILES) > $@+ && mv $@+ $@
+
+help.o: common-cmds.h features.h
 
 git-merge-subtree$X: git-merge-recursive$X
 	$(QUIET_BUILT_IN)rm -f $@ && ln git-merge-recursive$X $@
diff --git a/builtin-blame.c b/builtin-blame.c
index f7e2c13..c84d96a 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2162,6 +2162,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		else if (!strcmp("-s", arg))
 			output_option |= OUTPUT_NO_AUTHOR;
 		else if (!strcmp("-w", arg))
+			/* FEATURE<blame-ignore-whitespace> */
 			xdl_opts |= XDF_IGNORE_WHITESPACE;
 		else if (!strcmp("-S", arg) && ++i < argc)
 			revs_file = argv[i];
diff --git a/generate-features.sh b/generate-features.sh
new file mode 100755
index 0000000..674c5fe
--- /dev/null
+++ b/generate-features.sh
@@ -0,0 +1,9 @@
+#!/bin/sh
+#
+# New features that Porcelains may care about can be marked in the
+# source code with FEATURE<feature name>.  This script is driven
+# by Makefile to pick them out and sort them to prepare features.h
+# file, which is included by help.c.
+
+sed -n -e 's|.* FEATURE<\([a-z0-9][-a-z0-9]*[a-z0-9]\)> .*/|  "\1",|p' "$@" |
+sort -u
diff --git a/help.c b/help.c
index d050cbf..b0887ea 100644
--- a/help.c
+++ b/help.c
@@ -9,9 +9,10 @@
 #include "common-cmds.h"
 #include <sys/ioctl.h>
 
+/* FEATURE<list-features> */
+
 static const char *supported_features[] = {
-	"blame-ignore-whitespace",
-	"list-features",
+#include "features.h"
 };
 
 /* most GUI terminals set COLUMNS (although some don't export it) */
@@ -195,51 +196,28 @@ void help_unknown_cmd(const char *cmd)
 	exit(1);
 }
 
-static int is_feature_name_sane(const char *a)
+static void list_features(void)
 {
-	if (!*a || *a == '-')
-		return 0;
-	for (; *a; a++) {
-		if (! ((*a >= 'a' && *a <= 'z')
-		    || (*a >= '0' && *a <= '9')
-		    || *a == '-'))
-			return 0;
-	}
-	return 1;
+	unsigned cnt = ARRAY_SIZE(supported_features);
+	unsigned i;
+
+	for (i = 0; i < cnt; i++)
+		printf("%s\n", supported_features[i]);
 }
 
 static int cmp_feature(const void *a_, const void *b_)
 {
 	const char *a = *((const char **)a_);
 	const char *b = *((const char **)b_);
-	return strcmp(a, b);
-}
 
-static void list_features()
-{
-	unsigned cnt = ARRAY_SIZE(supported_features);
-	unsigned i;
-
-	qsort(supported_features, cnt,
-		sizeof(supported_features[0]), cmp_feature);
-	for (i = 0; i < cnt; i++) {
-		const char *f = supported_features[i];
-		if (!is_feature_name_sane(f))
-			die("feature name \"%s\" is bogus", f);
-		printf("%s\n", f);
-	}
+	return strcmp(a, b);
 }
 
 static int supports_feature(const char *the_feature)
 {
-	unsigned cnt = ARRAY_SIZE(supported_features);
-	unsigned i;
-
-	for (i = 0; i < cnt; i++) {
-		if (!strcmp(supported_features[i], the_feature))
-			return 0;
-	}
-	return 1;
+	return !bsearch(&the_feature, supported_features,
+			(size_t) ARRAY_SIZE(supported_features),
+			sizeof(const char *), cmp_feature);
 }
 
 static const char version_usage[] =
-- 
1.5.2.2.1050.g51a8b
