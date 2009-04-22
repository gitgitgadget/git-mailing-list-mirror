From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] bisect: remove Perl use by implementing "git bisect--helper
	--sq-quote"
Date: Wed, 22 Apr 2009 06:55:23 +0200
Message-ID: <20090422045524.3606.81842.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 06:58:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUXS-00057m-RU
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 06:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbZDVE4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 00:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbZDVE4x
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 00:56:53 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:38188 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750821AbZDVE4w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 00:56:52 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 53433E0803A;
	Wed, 22 Apr 2009 06:56:45 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id 4107FE08053;
	Wed, 22 Apr 2009 06:56:43 +0200 (CEST)
X-git-sha1: b87aee8d73a2316de49a0152b09ceb1abfcae236 
X-Mailer: git-mail-commits v0.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117171>

The sq() function in "git-bisect.sh" was the only place where Perl
was needed. This patch remove this use of Perl by implementing
a new "--sq-quote" option in "builtin-bisect--helper.c".

While at it we remove the line in the Makefile that replaced @@PERL@@
by the shell quoted perl path in the shell scripts, because no more
shell script needs that. ("git-instaweb.sh" is dealt with separetely
in the Makefile.)

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile                 |    1 -
 builtin-bisect--helper.c |   25 ++++++++++++++++++++++---
 git-bisect.sh            |    8 +-------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/Makefile b/Makefile
index b630408..329b0a4 100644
--- a/Makefile
+++ b/Makefile
@@ -1238,7 +1238,6 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
-	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
 	    $@.sh >$@+ && \
diff --git a/builtin-bisect--helper.c b/builtin-bisect--helper.c
index aca7018..098ac84 100644
--- a/builtin-bisect--helper.c
+++ b/builtin-bisect--helper.c
@@ -1,27 +1,46 @@
 #include "builtin.h"
 #include "cache.h"
 #include "parse-options.h"
+#include "quote.h"
 #include "bisect.h"
 
 static const char * const git_bisect_helper_usage[] = {
 	"git bisect--helper --next-exit",
+	"git bisect--helper --sq-quote ARG1...",
 	NULL
 };
 
+static int print_sq_quote_argv(int argc, const char **argv)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	if (argc)
+		sq_quote_argv(&buf, argv, 0);
+	printf("%s\n", buf.buf);
+	strbuf_release(&buf);
+
+	return 0;
+}
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	int next_exit = 0;
+	int sq_quote = 0;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "next-exit", &next_exit,
 			    "output bisect result and exit instuctions"),
+		OPT_BOOLEAN(0, "sq-quote", &sq_quote,
+			    "output shell quoted arguments"),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, options, git_bisect_helper_usage, 0);
 
-	if (!next_exit)
+	if ((next_exit && sq_quote) || (!next_exit && !sq_quote))
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-exit */
-	return bisect_next_exit(prefix);
+	if (sq_quote)
+		return print_sq_quote_argv(argc, argv);
+	else /* next-exit */
+		return bisect_next_exit(prefix);
 }
diff --git a/git-bisect.sh b/git-bisect.sh
index e1f300b..93ecfeb 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -34,13 +34,7 @@ _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
 
 sq() {
-	@@PERL@@ -e '
-		for (@ARGV) {
-			s/'\''/'\'\\\\\'\''/g;
-			print " '\''$_'\''";
-		}
-		print "\n";
-	' "$@"
+	git bisect--helper --sq-quote "$@"
 }
 
 bisect_autostart() {
-- 
1.6.2.2.537.g3b83b
