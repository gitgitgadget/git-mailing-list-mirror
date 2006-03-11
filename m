From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 4/4] Add quick reference
Date: Sat, 11 Mar 2006 14:12:40 +0100
Message-ID: <20060311131240.GA26418@diku.dk>
References: <20060310144106.GA7920@diku.dk> <20060310144835.GE7920@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 11 14:13:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FI3tw-0008NH-1e
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 14:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWCKNMp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Mar 2006 08:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWCKNMp
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Mar 2006 08:12:45 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:18607 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750800AbWCKNMo (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Mar 2006 08:12:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 834FB52C688;
	Sat, 11 Mar 2006 14:12:43 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12080-09; Sat, 11 Mar 2006 14:12:41 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 62A7677000A;
	Sat, 11 Mar 2006 14:12:41 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id D691A6DF8B9; Sat, 11 Mar 2006 14:11:15 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 228DF61DD9; Sat, 11 Mar 2006 14:12:41 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20060310144835.GE7920@diku.dk>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17500>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 This renames quick-reference.txt to cg-ref.txt to address the
 cg-ref.pdf issue, makes the script more robust by using printf for
 alignment, and improves the reference itself a bit.

 Documentation/Makefile             |    9 ++-
 Documentation/asciidoc.conf        |    4 +
 Documentation/cg-ref.txt           |  116 ++++++++++++++++++++++++++++++++++++
 Documentation/make-cg-ref-asciidoc |   70 ++++++++++++++++++++++
 4 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index d316a14..b38fc4d 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -4,14 +4,14 @@ CG_SRC=$(filter-out $(CG_IGNORE), $(wild
 PACKAGE=cogito
 
 MAN1_TXT=$(patsubst ../cg%,cg%.1.txt,$(CG_SRC))
-MAN7_TXT=$(PACKAGE).7.txt
+MAN7_TXT=$(PACKAGE).7.txt cg-ref.7.txt
 
-DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) introduction.html
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT)) cg-ref.html introduction.html
 
 DOC_MAN1=$(patsubst %.txt,%,$(MAN1_TXT))
 DOC_MAN7=$(patsubst %.txt,%,$(MAN7_TXT))
 
-DOC_PDF=$(patsubst %.txt,%.pdf,$(MAN1_TXT) $(MAN7_TXT)) introduction.pdf
+DOC_PDF=$(patsubst %.txt,%.pdf,$(MAN1_TXT) $(MAN7_TXT)) cg-ref.pdf introduction.pdf
 
 prefix=$(HOME)
 bin=$(prefix)/bin
@@ -100,6 +100,9 @@ introduction.xml: ../README
 $(PACKAGE).7.txt : make-$(PACKAGE)-asciidoc
 	./make-$(PACKAGE)-asciidoc > $@
 
+cg-ref.7.txt : cg-ref.txt make-cg-ref-asciidoc
+	CGPACKAGE=$(PACKAGE) ./make-cg-ref-asciidoc $< > $@
+
 # It seems that cg%.txt won't match this so use an explicit rule
 cg.1.txt : ../cg make-cg-asciidoc
 	CGPACKAGE=$(PACKAGE) ./make-cg-asciidoc $< > $@
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index baefb2f..69f1646 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -19,3 +19,7 @@ ifdef::backend-xhtml11[]
 [gitlink-inlinemacro]
 <a href="{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
+
+[attributes]
+# Five non breaking spaces used for option indentation in the quick reference
+cg-refopt=&#160;&#160;&#160;&#160;&#160;
diff --git a/Documentation/cg-ref.txt b/Documentation/cg-ref.txt
new file mode 100644
index 0000000..ab2321b
--- /dev/null
+++ b/Documentation/cg-ref.txt
@@ -0,0 +1,116 @@
+Cogito Quick Reference
+======================
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Getting help:
+------------------------------------------------------------------------------
+*cg help* 'command'		Show help for a command
+*cg* 'command' -h		Show usage summary for a command
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Repository creation:
+------------------------------------------------------------------------------
+*cg init*			Create a repository in the current directory
+*cg clone* 'url'		Clone a remote repository into a subdirectory
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+File operations:
+------------------------------------------------------------------------------
+*cg add* 'file'			Add file to the working tree
+*cg add* -r 'directory'		Recursively add files in directory
+*cg rm* 'file'			Remove file or directory from the working tree
+*cg rm* -r 'directory'		Recursively remove files in directory
+{cg-refopt} -f			Delete file from disk
+*cg mv* 'file' 'destination'	Move file or directory to new location
+{cg-refopt} -f			Overwrite existing destination files
+*cg restore* 'file'		Restore file
+{cg-refopt} -r 'revision'	Bring back file from revision (and add it)
+{cg-refopt} -f			Overwrite uncommitted changes
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Working tree:
+------------------------------------------------------------------------------
+*cg status* '[file]'		Show branches and status of the working tree
+*cg reset*			Reset the working tree
+*cg clean*			Clean unknown files from the working tree
+*cg commit* '[file]'		Commit the working tree
+{cg-refopt} -m 'message'	Append message to commit log
+*cg admin-uncommit*		Undo commit
+*cg seek* 'revision'		Temporarily switch the working tree
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Examining History:
+------------------------------------------------------------------------------
+*cg log* '[file]'		View commit log
+{cg-refopt} -r 'revision'	Limit to revision range
+{cg-refopt} -f			List affected files
+{cg-refopt} -s			Summarize commits to one line
+*cg diff* '[file]'		Show diff of changes
+{cg-refopt} -r 'revision'	Diff revision instead of working tree
+{cg-refopt} -p			Diff against parent
+{cg-refopt} -s			Show diff stat
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Remote branches:
+------------------------------------------------------------------------------
+*cg fetch* '[branch]'		Fetch changes from a remote branch
+*cg update* '[branch]'		Fetch and merge changes from a remote branch
+*cg push* '[branch]'		Push changes to a remote branch
+*cg branch-ls*			List remote branches
+*cg branch-add* 'branch' 'url'	Add remote branch
+*cg branch-chg* 'branch' 'url'	Change URL of existing branch
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Local branches:
+------------------------------------------------------------------------------
+*cg merge* 'branch'		Merge changes from branch
+*cg switch* 'branch'		Switch the working tree to branch
+{cg-refopt} -r 'revision'	Create branch from revision
+{cg-refopt} -f			Overwrite existing branch
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Exporting and importing:
+------------------------------------------------------------------------------
+*cg patch* < 'file'		Apply patch from stdin
+*cg mkpatch*			Format a patch with log message and diffstat
+{cg-refopt} -r 'revision'	Limit to revision range
+*cg export* 'directory'		Export snapshot to directory
+*cg export* 'file.tar.gz'	Export snapshot to tar file
+{cg-refopt} -r 'revision'	Base snapshot on revision	
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+Tags:
+------------------------------------------------------------------------------
+*cg tag* 'name' 'revision'	Create tag for a given revision
+{cg-refopt} -s			Sign tag with your private key using GPG
+*cg tag-ls*			Show name and revision for all tags
+------------------------------------------------------------------------------
+
+[frame="none"]
+`-------------------------------`---------------------------------------------
+File status flags:
+------------------------------------------------------------------------------
+`?` unknown			File is not under revision control
+`A` added			File has been added
+`D` deleted			File has been deleted
+`!` disappeared			File is not in the working tree
+`M` modified			File has been touched or modified
+`m` modified (while merging)	File was modified prior to the merge
+------------------------------------------------------------------------------
diff --git a/Documentation/make-cg-ref-asciidoc b/Documentation/make-cg-ref-asciidoc
new file mode 100755
index 0000000..960e711
--- /dev/null
+++ b/Documentation/make-cg-ref-asciidoc
@@ -0,0 +1,70 @@
+#!/usr/bin/env bash
+#
+# Generate asciidoc manpage markup from Cogito quick reference file.
+# Copyright (c) Jonas Fonseca, 2006
+#
+# Takes the path to the reference file. Prints the manpage to stdout.
+
+PACKAGE=${CGPACKAGE:-cogito}
+
+ref=$1
+
+cat <<__END__
+cg-ref(7)
+=========
+
+NAME
+----
+cg-ref - Cogito quick reference
+
+SYNOPSIS
+--------
+A list of frequently used commands grouped with related commands.
+
+DESCRIPTION
+-----------
+
+__END__
+
+sed '
+	0,/^$/d
+	/^`---/d
+	/frame="none"/,1d
+	s/\\$//
+	s/[*]\([^*]*\)[*]/\1/g
+	s/[`]\([^`]*\)[`]/\1/g
+	s/['\'']\([^'\'']*\)['\'']/\1/g
+' < "$ref" | \
+while read line; do
+	col1=$(echo "$line" | cut -f 1)
+	case "$line" in
+	*":")
+		echo "$line"
+		echo "$line" | sed "s/[^~]/~/g"
+		echo
+		echo "[verse]"
+		continue
+		;;
+	"-----"*|"")
+		echo "$line" | sed 's/-/./g'
+		continue
+		;;
+	"{cg-refopt}"*)
+		col1=$(echo "$col1" | sed 's/.*cg-refopt}/   /')
+		;;
+	esac
+	col2=$(echo "$line" | sed 's/.*[	]\+//')
+	printf "%-30s  %s\n" "$col1" "$col2"
+done
+
+cat << __END__
+
+COPYRIGHT
+---------
+Copyright (C) Jonas Fonseca, 2006.
+
+SEE ALSO
+--------
+gitlink:cg-ref[7] is part of gitlink:${PACKAGE}[7],
+a toolkit for managing gitlink:git[7] trees.
+__END__

-- 
Jonas Fonseca
