From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCH] mergetool--lib: add support for beyond compare
Date: Fri, 18 Feb 2011 21:09:13 +1300
Message-ID: <1298016553-2308-1-git-send-email-judge.packham@gmail.com>
Cc: Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 18 09:09:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqLPK-000546-3P
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 09:09:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756142Ab1BRIJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Feb 2011 03:09:24 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:49224 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756132Ab1BRIJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Feb 2011 03:09:21 -0500
Received: by pxi15 with SMTP id 15so500047pxi.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 00:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=/lmIuD3/QgHCw8RzThvz9yLKGlynKsPHNhC6gMlZnDU=;
        b=v/hO+kHh58V0Y6e56GhQFj3+VMaRxfEHdWVze2VaE/nMd3Lwm8AhDguU+fFC0J77Ug
         pkw0wx5Ryh/9rDVK2Ej/g/UTb6t903KzeN8DoCnr3K1z4zzZf3DsLQAFZy6mXBM6b4mU
         jdJYR573xTmTwz8i4K8OENwvnMuO7YQDJG5Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Jt1wefz217GNWyW/sQA6r3OF5OC4PNkHpjU+y138urc5eXjsShJUdk2uu92zKLGtAo
         q8JJ04l0Z9E5G/tqbDPfAXG4RjmdBpMyZaz4WXHDPGUr5UvQdDBXVlqR9nj0IyqJ3qJM
         NRvHloYXGkVrJR7TiXEVzBfeWr4vDHyHgLcUo=
Received: by 10.142.203.18 with SMTP id a18mr326711wfg.328.1298016559224;
        Fri, 18 Feb 2011 00:09:19 -0800 (PST)
Received: from localhost.localdomain (222-153-44-114.jetstream.xtra.co.nz [222.153.44.114])
        by mx.google.com with ESMTPS id w42sm2426586wfh.15.2011.02.18.00.09.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 00:09:17 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1.48.g5673d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167184>

Add support for Beyond Compare as a diff/merge tool.

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
Beyond compare is a non-free file comparison tool for Linux and Windows. A
trial version is available here [1]. People at $dayjob had used beyond compare
v2.0 for Windows a while ago but we hadn't paid attention since the change to
Linux. We noticed the other day that with v3.0 a native Linux version was now
available.

I wasn't sure about whether git should have support for non-free external
tools.  Then I saw that support for Araxis had been added in b6f0621a, which
I've used as a guide for this patch.

The actual problem I was trying to solve was that if I configure an external
merge tool beyond compare gets confused when $BASE does not exist (I think this
might be a problem for other tools too). I could work around the problem with
the following messy config

[mergetool "bcompare"]
        cmd = test -e \"$BASE\" && bcompare \"$BASE\" \"$LOCAL\" \"$REMOTE\" -mergeoutput=\"$MERGED\" || bcompare \"$LOCAL\" \"$REMOTE\" -mergeoutput=\"$MERGED\"

I've tested this with the Linux version and it works well, it'd be nice to hear
from some windows folks. In particular I think the option flags might change to
use '/' instead of '-' 

[1] http://www.scootersoftware.com/download.php

 Documentation/git-difftool.txt         |    2 +-
 Documentation/git-mergetool.txt        |    2 +-
 Documentation/merge-config.txt         |    6 +++---
 contrib/completion/git-completion.bash |    2 +-
 git-mergetool--lib.sh                  |   18 ++++++++++++++++--
 5 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index db87f1d..35ec927 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -32,7 +32,7 @@ OPTIONS
 	Use the diff tool specified by <tool>.
 	Valid merge tools are:
 	kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff,
-	ecmerge, diffuse, opendiff, p4merge and araxis.
+	ecmerge, diffuse, opendiff, p4merge, araxis and bcompare.
 +
 If a diff tool is not specified, 'git difftool'
 will use the configuration variable `diff.tool`.  If the
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 1f75a84..0239929 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -27,7 +27,7 @@ OPTIONS
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
 	kdiff3, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge,
-	diffuse, tortoisemerge, opendiff, p4merge and araxis.
+	diffuse, tortoisemerge, opendiff, p4merge, araxis and bcompare.
 +
 If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable `merge.tool`.  If the
diff --git a/Documentation/merge-config.txt b/Documentation/merge-config.txt
index 1e5c22c..87c76e5 100644
--- a/Documentation/merge-config.txt
+++ b/Documentation/merge-config.txt
@@ -35,9 +35,9 @@ merge.tool::
 	Controls which merge resolution program is used by
 	linkgit:git-mergetool[1].  Valid built-in values are: "kdiff3",
 	"tkdiff", "meld", "xxdiff", "emerge", "vimdiff", "gvimdiff",
-	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis" and
-	"opendiff".  Any other value is treated is custom merge tool
-	and there must be a corresponding mergetool.<tool>.cmd option.
+	"diffuse", "ecmerge", "tortoisemerge", "p4merge", "araxis",
+	"opendiff" and "bcompare".  Any other value is treated is custom merge
+	tool and there must be a corresponding mergetool.<tool>.cmd option.
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 893b771..59ae12e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1358,7 +1358,7 @@ _git_diff ()
 }
 
 __git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
-			tkdiff vimdiff gvimdiff xxdiff araxis p4merge
+			tkdiff vimdiff gvimdiff xxdiff araxis p4merge bcompare
 "
 
 _git_difftool ()
diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 77d4aee..c77ac7f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -48,7 +48,7 @@ valid_tool () {
 	case "$1" in
 	kdiff3 | tkdiff | xxdiff | meld | opendiff | \
 	vimdiff | gvimdiff | vimdiff2 | gvimdiff2 | \
-	emerge | ecmerge | diffuse | araxis | p4merge)
+	emerge | ecmerge | diffuse | araxis | p4merge | bcompare)
 		;; # happy
 	tortoisemerge)
 		if ! merge_mode; then
@@ -304,6 +304,20 @@ run_merge_tool () {
 				>/dev/null 2>&1
 		fi
 		;;
+	bcompare)
+		if merge_mode; then
+			if $base_present; then
+				"$merge_tool_path" \
+					"$BASE" "$LOCAL" "$REMOTE" -mergeoutput="$MERGED"
+			else
+				"$merge_tool_path" \
+					"$LOCAL" "$REMOTE" -mergeoutput="$MERGED"
+			fi
+			check_unchanged
+		else
+			"$merge_tool_path" "$LOCAL" "$REMOTE"
+		fi
+		;;
 	*)
 		merge_tool_cmd="$(get_merge_tool_cmd "$1")"
 		if test -z "$merge_tool_cmd"; then
@@ -343,7 +357,7 @@ guess_merge_tool () {
 		else
 			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
 		fi
-		tools="$tools gvimdiff diffuse ecmerge p4merge araxis"
+		tools="$tools gvimdiff diffuse ecmerge p4merge araxis bcompare"
 	fi
 	case "${VISUAL:-$EDITOR}" in
 	*vim*)
-- 
1.7.4.1.48.g5673d.dirty
