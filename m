From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 13:24:46 -0800
Message-ID: <1359321886-80523-5-git-send-email-davvid@gmail.com>
References: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZjA-0004mz-SP
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab3A0VZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:25:01 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:43701 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756408Ab3A0VY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:24:58 -0500
Received: by mail-ie0-f171.google.com with SMTP id 9so662918iec.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=C+Z4JNQ5/IPpYqslnkAoKUYMDw9z2TIvg814j8UMJoI=;
        b=yBm9kMHif676NtLgkzbK68FLc23eG5VhlKXGj7/hh0hu+yyK3iR3SBg7DpyGfkeMx8
         xJLmCFHIjn2GbiI4/tPxKuJOpMl4ABq3YUFGwzICX3QMLH62PrTApJ2D7vY80qUhIwYj
         Ox+xigUy0kbMLgWB0+jCImN20fCIvbYyYXLeHXNMnzzHrkgm3pAmVfAnnE4GQiuCxGfK
         26FUyVw0pfWYJaOrnhf5W1e0HeGlEW+deejLeBC9/0yi7KOB30IPtZMESQr4UPFIwVt4
         o5843ASCcx8Qu4YsEy5ZhMh6SkjEMJzkd5921P0/dWVlsExQxQxP3e9Cix+q7QUsgjSA
         QYuA==
X-Received: by 10.50.154.229 with SMTP id vr5mr3630485igb.49.1359321898234;
        Sun, 27 Jan 2013 13:24:58 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id mj6sm4503782igc.9.2013.01.27.13.24.56
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 13:24:57 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.gf25ae33
In-Reply-To: <1359321886-80523-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214736>

Use the new filter_tools() function to build lists of all
the built-in tools supported by difftool and mergetool.
This frees us from needing to update the documentation
whenever a new tool is added.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 Documentation/.gitignore       |  1 +
 Documentation/Makefile         | 16 +++++++++++++++-
 Documentation/diff-config.txt  | 13 +++++++------
 Documentation/merge-config.txt | 12 ++++++------
 git-mergetool--lib.sh          |  1 +
 5 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/Documentation/.gitignore b/Documentation/.gitignore
index d62aebd..2c8b2d6 100644
--- a/Documentation/.gitignore
+++ b/Documentation/.gitignore
@@ -9,4 +9,5 @@ gitman.info
 howto-index.txt
 doc.dep
 cmds-*.txt
+mergetools-*.txt
 manpage-base-url.xsl
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 267dfe1..f595d26 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -226,13 +226,27 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
 	$(PERL_PATH) ./cmd-list.perl ../command-list.txt $(QUIET_STDERR) && \
 	date >$@
 
+mergetools_txt = mergetools-diff.txt mergetools-merge.txt
+
+$(mergetools_txt): mergetools-list.made
+
+mergetools-list.made: ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
+	$(QUIET_GEN)$(RM) $@ && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		. ../git-mergetool--lib.sh && \
+		filter_tools can_diff "* "' > mergetools-diff.txt && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		. ../git-mergetool--lib.sh && \
+		filter_tools can_merge "* "' > mergetools-merge.txt && \
+	date > $@
+
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
 	$(RM) *.pdf
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
-	$(RM) $(cmds_txt) *.made
+	$(RM) $(cmds_txt) $(mergetools_txt) *.made
 	$(RM) manpage-base-url.xsl
 
 $(MAN_HTML): %.html : %.txt
diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
index 67a90a8..7c968d1 100644
--- a/Documentation/diff-config.txt
+++ b/Documentation/diff-config.txt
@@ -132,9 +132,10 @@ diff.<driver>.cachetextconv::
 	conversion outputs.  See linkgit:gitattributes[5] for details.
 
 diff.tool::
-	The diff tool to be used by linkgit:git-difftool[1].  This
-	option overrides `merge.tool`, and has the same valid built-in
-	values as `merge.tool` minus "tortoisemerge" and plus
-	"kompare".  Any other value is treated as a custom diff tool,
-	and there must be a corresponding `difftool.<tool>.cmd`
-	option.
+	Controls which diff tool is used by linkgit:git-difftool[1].
+	This variable overrides the value configured in `merge.tool`.
+	The list below shows the valid built-in values.
+	Any other value is treated as a custom diff tool and requires
+	that a corresponding difftool.<tool>.cmd variable is defined.
+
+include::mergetools-diff.txt[]
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 861bd6f..5f40e71 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -52,12 +52,12 @@ merge.stat::
 	at the end of the merge.  True by default.
 
 merge.tool::
-	Controls which merge resolution program is used by
-	linkgit:git-mergetool[1].  Valid built-in values are: "araxis",
-	"bc3", "diffuse", "ecmerge", "emerge", "gvimdiff", "kdiff3", "meld",
-	"opendiff", "p4merge", "tkdiff", "tortoisemerge", "vimdiff"
-	and "xxdiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	Controls which merge tool is used by linkgit:git-mergetool[1].
+	The list below shows the valid built-in values.
+	Any other value is treated as a custom merge tool and requires
+	that a corresponding mergetool.<tool>.cmd variable is defined.
+
+include::mergetools-merge.txt[]
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 894b849..59e1650 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,5 +1,6 @@
 #!/bin/sh
 # git-mergetool--lib is a library for common merge tool functions
+test -z "$MERGE_TOOLS_DIR" &&
 MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
 
 mode_ok () {
-- 
1.8.0.13.gf25ae33
