From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 4/4] doc: Generate a list of valid merge tools
Date: Sun, 27 Jan 2013 16:52:26 -0800
Message-ID: <1359334346-5879-5-git-send-email-davvid@gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
 <1359334346-5879-2-git-send-email-davvid@gmail.com>
 <1359334346-5879-3-git-send-email-davvid@gmail.com>
 <1359334346-5879-4-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 01:53:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzcyG-00013K-BZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 01:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756849Ab3A1Awp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 19:52:45 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49113 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963Ab3A1Awj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 19:52:39 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so386698ieb.37
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 16:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=ow30pWLhfvAq1qRQDELwzJhG3vqJ0jGd4cX5O+O2IKU=;
        b=RpWCohB7hM/qkzJetbjal9UIQfLlkJvYqdYPyqka26Fp5sTgF3HF0PaYPhQch50VTx
         C3dkcqWGaI/Iy4XREGFJakSKRiiXyxHOGx7fS79nZot4TE6Yd/KbV2LiNNefdzQCyyHA
         jjpJfHemBIwht0auz7mRiutb6or02CkhANjjPOzK7ajZXB9APEfxjbYDDliUQSOjF7sK
         0HKl7NP1Vt/uITo8wjrnFlxOoBv6VBg3BXNIt5cSI/9KbTqjRtGzmkhCb2tnNWWVSVCm
         hjYxJdX/zPI6/4mmZMZ82zlg/GbKYXoKM/mXpNumr/RTW3Bwq5eXtJCWw5ur7WXSdpe+
         CSmA==
X-Received: by 10.50.196.162 with SMTP id in2mr3843190igc.76.1359334358217;
        Sun, 27 Jan 2013 16:52:38 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id ke8sm1868421igc.17.2013.01.27.16.52.36
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 16:52:37 -0800 (PST)
X-Mailer: git-send-email 1.8.0.13.g3ff16bb
In-Reply-To: <1359334346-5879-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214762>

Use the show_tool_names() function to build lists of all
the built-in tools supported by difftool and mergetool.
This frees us from needing to update the documentation
whenever a new tool is added.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Adjusted to use show_tool_names() and reworked the makefile dependencies.
I could use another set of eyes on the Makefile..

 Documentation/.gitignore       |  1 +
 Documentation/Makefile         | 22 ++++++++++++++++++++--
 Documentation/diff-config.txt  | 13 +++++++------
 Documentation/merge-config.txt | 12 ++++++------
 git-mergetool--lib.sh          |  3 ++-
 5 files changed, 36 insertions(+), 15 deletions(-)

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
index 267dfe1..834ec25 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -202,7 +202,11 @@ install-html: html
 #
 # Determine "include::" file references in asciidoc files.
 #
-doc.dep : $(wildcard *.txt) build-docdep.perl
+docdep_prereqs = \
+	mergetools-list.made $(mergetools_txt) \
+	cmd-list.made $(cmds_txt)
+
+doc.dep : $(docdep_prereqs) $(wildcard *.txt) build-docdep.perl
 	$(QUIET_GEN)$(RM) $@+ $@ && \
 	$(PERL_PATH) ./build-docdep.perl >$@+ $(QUIET_STDERR) && \
 	mv $@+ $@
@@ -226,13 +230,27 @@ cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
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
+		show_tool_names can_diff "* "' > mergetools-diff.txt && \
+	$(SHELL_PATH) -c 'MERGE_TOOLS_DIR=../mergetools && \
+		. ../git-mergetool--lib.sh && \
+		show_tool_names can_merge "* "' > mergetools-merge.txt && \
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
index fe068f6..f665bee 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -1,6 +1,7 @@
 #!/bin/sh
 # git-mergetool--lib is a library for common merge tool functions
-MERGE_TOOLS_DIR=$(git --exec-path)/mergetools
+
+: ${MERGE_TOOLS_DIR=$(git --exec-path)/mergetools}
 
 mode_ok () {
 	diff_mode && can_diff ||
-- 
1.8.0.13.g3ff16bb
