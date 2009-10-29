From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH 1/2] Provide a build time default-pager setting
Date: Thu, 29 Oct 2009 12:42:44 -0400
Message-ID: <1256834565-19443-2-git-send-email-bwalton@artsci.utoronto.ca>
References: <20091029073224.GA15403@progeny.tock>
 <1256834565-19443-1-git-send-email-bwalton@artsci.utoronto.ca>
Cc: Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 17:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Y5x-0006un-2w
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 17:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755573AbZJ2QnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 12:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755479AbZJ2QnT
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 12:43:19 -0400
Received: from www.cquest.utoronto.ca ([192.82.128.5]:60989 "EHLO
	www.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409AbZJ2QnS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 12:43:18 -0400
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253]:50923 ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1N3Y5q-0004Gt-WE; Thu, 29 Oct 2009 12:43:23 -0400
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1N3Y5q-00054Z-Tf; Thu, 29 Oct 2009 12:43:22 -0400
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n9TGhMt9019499;
	Thu, 29 Oct 2009 12:43:22 -0400
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1256834565-19443-1-git-send-email-bwalton@artsci.utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131612>

From: Junio C Hamano <gitster@pobox.com>

On (old) solaris systems, /usr/bin/less (typically the first less
found) doesn't understand the default arguments (FXRS), which
forces users to alter their environment (PATH, GIT_PAGER, LESS,
etc) or have a local or global gitconfig before paging works as
expected.

On Debian systems, by policy packages must fall back to the
'pager' command, so that changing the target of the
/usr/bin/pager symlink changes the default pager for all packages
at once.

Provide a DEFAULT_PAGER knob so packagers can set the fallback
pager to something appropriate during the build.

This puts the "less" default in the Makefile instead of pager.c, since
it is needed for git-svn and git-am, too.  This means that the
DEFAULT_PAGER preprocessor token _has_ to be defined on the command
line for git to build.  I was worried about this for a moment, but
GIT_VERSION already works this way without trouble.

Probably the DEFAULT_PAGER setting should be added to something
like TRACK_CFLAGS as well.  Actually, some other settings that
can change without forcing files to be rebuilt (e.g. SHELL_PATH),
too.  This should be probably be addressed separately.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Makefile     |    9 +++++++++
 git-am.sh    |    2 +-
 git-svn.perl |    5 +++--
 pager.c      |    2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 42b7d60..1d26800 100644
--- a/Makefile
+++ b/Makefile
@@ -200,6 +200,9 @@ all::
 # memory allocators with the nedmalloc allocator written by Niall Douglas.
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
+#
+# Define DEFAULT_PAGER to the path of a sensible pager (defaults to "less") if
+# you want to use something different.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -1294,6 +1297,10 @@ ifdef NO_REGEX
 	COMPAT_CFLAGS += -Icompat/regex
 	COMPAT_OBJS += compat/regex/regex.o
 endif
+ifndef DEFAULT_PAGER
+	DEFAULT_PAGER = less
+endif
+BASIC_CFLAGS += -DDEFAULT_PAGER='"$(DEFAULT_PAGER)"'
 
 ifdef USE_NED_ALLOCATOR
        COMPAT_CFLAGS += -DUSE_NED_ALLOCATOR -DOVERRIDE_STRDUP -DNDEBUG -DREPLACE_SYSTEM_ALLOCATOR -Icompat/nedmalloc
@@ -1428,6 +1435,7 @@ $(patsubst %.sh,%,$(SCRIPT_SH)) : % : %.sh
 	    -e 's|@SHELL_PATH@|$(SHELL_PATH_SQ)|' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
 	    -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
+	    -e 's|@@DEFAULT_PAGER@@|$(DEFAULT_PAGER)|g' \
 	    -e $(BROKEN_PATH_FIX) \
 	    $@.sh >$@+ && \
 	chmod +x $@+ && \
@@ -1451,6 +1459,7 @@ $(patsubst %.perl,%,$(SCRIPT_PERL)): % : %.perl
 	    -e '}' \
 	    -e 's|@@INSTLIBDIR@@|'"$$INSTLIBDIR"'|g' \
 	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
+	    -e 's|@@DEFAULT_PAGER@@|$(DEFAULT_PAGER)|g' \
 	    $@.perl >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-am.sh b/git-am.sh
index c132f50..a194a4e 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -649,7 +649,7 @@ do
 		[eE]*) git_editor "$dotest/final-commit"
 		       action=again ;;
 		[vV]*) action=again
-		       LESS=-S ${PAGER:-less} "$dotest/patch" ;;
+		       LESS=-S ${PAGER:-@@DEFAULT_PAGER@@} "$dotest/patch" ;;
 		*)     action=again ;;
 		esac
 	    done
diff --git a/git-svn.perl b/git-svn.perl
index eb4b75a..a61ec55 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -3,11 +3,12 @@
 # License: GPL v2 or later
 use warnings;
 use strict;
-use vars qw/	$AUTHOR $VERSION
+use vars qw/	$AUTHOR $VERSION $DEFAULT_PAGER
 		$sha1 $sha1_short $_revision $_repository
 		$_q $_authors $_authors_prog %users/;
 $AUTHOR = 'Eric Wong <normalperson@yhbt.net>';
 $VERSION = '@@GIT_VERSION@@';
+$DEFAULT_PAGER = '@@DEFAULT_PAGER@@';
 
 # From which subdir have we been invoked?
 my $cmd_dir_prefix = eval {
@@ -5031,7 +5032,7 @@ sub git_svn_log_cmd {
 sub config_pager {
 	$pager ||= $ENV{GIT_PAGER} || $ENV{PAGER};
 	if (!defined $pager) {
-		$pager = 'less';
+		$pager = $DEFAULT_PAGER;
 	} elsif (length $pager == 0 || $pager eq 'cat') {
 		$pager = undef;
 	}
diff --git a/pager.c b/pager.c
index 86facec..416a796 100644
--- a/pager.c
+++ b/pager.c
@@ -58,7 +58,7 @@ void setup_pager(void)
 	if (!pager)
 		pager = getenv("PAGER");
 	if (!pager)
-		pager = "less";
+		pager = DEFAULT_PAGER;
 	else if (!*pager || !strcmp(pager, "cat"))
 		return;
 
-- 
1.6.5
