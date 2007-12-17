From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 5/7] parse-options: Add a gitcli(5) man page.
Date: Mon, 17 Dec 2007 19:23:15 +0100
Message-ID: <1197915797-30679-6-git-send-email-madcoder@debian.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
 <1197915797-30679-2-git-send-email-madcoder@debian.org>
 <1197915797-30679-3-git-send-email-madcoder@debian.org>
 <1197915797-30679-4-git-send-email-madcoder@debian.org>
 <1197915797-30679-5-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Dec 17 19:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4KdU-0003yo-BN
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 19:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783AbXLQSXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 13:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756633AbXLQSXc
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 13:23:32 -0500
Received: from pan.madism.org ([88.191.52.104]:54946 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbXLQSXU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 13:23:20 -0500
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 055903095A;
	Mon, 17 Dec 2007 19:23:19 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3170D4BF5B7; Mon, 17 Dec 2007 19:23:17 +0100 (CET)
X-Mailer: git-send-email 1.5.4.rc0.1148.ga3ab1-dirty
In-Reply-To: <1197915797-30679-5-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68593>

This page should hold every information about the git ways to parse command
lines, and best practices to be used for scripting.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Documentation/Makefile   |    2 +-
 Documentation/gitcli.txt |  113 ++++++++++++++++++++++++++++++++++++++++++++++
 Makefile                 |    1 +
 3 files changed, 115 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitcli.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 76df06c..c4486d3 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitcli.txt gitmodules.txt
 MAN7_TXT=git.txt
 
 MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
new file mode 100644
index 0000000..b7dcf9c
--- /dev/null
+++ b/Documentation/gitcli.txt
@@ -0,0 +1,113 @@
+gitcli(5)
+=========
+
+NAME
+----
+gitcli - git command line interface and conventions
+
+SYNOPSIS
+--------
+gitcli
+
+
+DESCRIPTION
+-----------
+
+This manual describes best practice in how to use git CLI.  Here are
+the rules that you should follow when you are scripting git:
+
+ * it's preferred to use the non dashed form of git commands, which means that
+   you should prefer `"git foo"` to `"git-foo"`.
+
+ * splitting short options to separate words (prefer `"git foo -a -b"`
+   to `"git foo -ab"`, the latter may not even work).
+
+ * when a command line option takes an argument, use the 'sticked' form.  In
+   other words, write `"git foo -oArg"` instead of `"git foo -o Arg"` for short
+   options, and `"git foo --long-opt=Arg"` instead of `"git foo --long-opt Arg"`
+   for long options.  An option that takes optional option-argument must be
+   written in the 'sticked' form.
+
+ * when you give a revision parameter to a command, make sure the parameter is
+   not ambiguous with a name of a file in the work tree.  E.g. do not write
+   `"git log -1 HEAD"` but write `"git log -1 HEAD --"`; the former will not work
+   if you happen to have a file called `HEAD` in the work tree.
+
+
+ENHANCED CLI
+------------
+From the git 1.5.4 series and further, many git commands (not all of them at the
+time of the writing though) come with an enhanced option parser.
+
+Here is an exhaustive list of the facilities provided by this option parser.
+
+
+Magic Options
+~~~~~~~~~~~~~
+Commands which have the enhanced option parser activated all understand a
+couple of magic command line options:
+
+-h::
+	gives a pretty printed usage of the command.
++
+---------------------------------------------
+$ git describe -h
+usage: git-describe [options] <committish>*
+
+    --contains            find the tag that comes after the commit
+    --debug               debug search strategy on stderr
+    --all                 use any ref in .git/refs
+    --tags                use any tag in .git/refs/tags
+    --abbrev [<n>]        use <n> digits to display SHA-1s
+    --candidates <n>      consider <n> most recent tags (default: 10)
+---------------------------------------------
+
+--help-all::
+	Some git commands take options that are only used for plumbing or that
+	are deprecated, and such options are hidden from the default usage. This
+	option gives the full list of options.
+
+
+Negating options
+~~~~~~~~~~~~~~~~
+Options with long option names can be negated by prefixing `"--no-"`. For
+example, `"git branch"` has the option `"--track"` which is 'on' by default. You
+can use `"--no-track"` to override that behaviour. The same goes for `"--color"`
+and `"--no-color"`.
+
+
+Aggregating short options
+~~~~~~~~~~~~~~~~~~~~~~~~~
+Commands that support the enhanced option parser allow you to aggregate short
+options. This means that you can for example use `"git rm -rf"` or
+`"git clean -fdx"`.
+
+
+Separating argument from the option
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+You can write the mandatory option parameter to an option as a separate
+word on the command line.  That means that all the following uses work:
+
+----------------------------
+$ git foo --long-opt=Arg
+$ git foo --long-opt Arg
+$ git foo -oArg
+$ git foo -o Arg
+----------------------------
+
+However, this is *NOT* allowed for switches with an optionnal value, where the
+'sticked' form must be used:
+----------------------------
+$ git describe --abbrev HEAD     # correct
+$ git describe --abbrev=10 HEAD  # correct
+$ git describe --abbrev 10 HEAD  # NOT WHAT YOU MEANT
+----------------------------
+
+
+Documentation
+-------------
+Documentation by Pierre Habouzit.
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index 7776077..eda7b1a 100644
--- a/Makefile
+++ b/Makefile
@@ -1172,6 +1172,7 @@ check-docs::
 		documented,gitattributes | \
 		documented,gitignore | \
 		documented,gitmodules | \
+		documented,gitcli | \
 		documented,git-tools | \
 		sentinel,not,matching,is,ok ) continue ;; \
 		esac; \
-- 
1.5.4.rc0.1148.ga3ab1-dirty
