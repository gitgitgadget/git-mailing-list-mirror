From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Documentation: Add asciidoc.conf file and gitlink: macro
Date: Sat, 30 Jul 2005 15:33:46 +0200
Message-ID: <20050730133346.GA23664@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 15:34:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyrTP-00085y-Ms
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 15:33:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262949AbVG3Nds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 09:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262954AbVG3Nds
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 09:33:48 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:65224 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S262949AbVG3Ndr (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 09:33:47 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 034826E2261; Sat, 30 Jul 2005 15:33:30 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A00B26E225A; Sat, 30 Jul 2005 15:33:29 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 3B10F61E6C; Sat, 30 Jul 2005 15:33:46 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.8 required=5.0 tests=BAYES_00,HTML_MESSAGE 
	autolearn=ham version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Introduce an asciidoc.conf file with the purpose of adding a gitlink: macro
which will improve the manpage output. Most notably this changes the following
in cogito.7

   ...
       cg-add: cg-add.html [-N] FILE...
              Add files to the GIT repository.

       cg-branch-add: cg-branch-add.html BRANCH_NAME LOCATION
              Add new branch to the GIT repository.
   ...

to

   ...
       cg-add [-N] FILE...
              Add files to the GIT repository.

       cg-branch-add BRANCH_NAME LOCATION
              Add new branch to the GIT repository.
   ...

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

I only did the Cogito part, since it was a lot easier. If this is
desirable for the GIT core manpages I'd be happy to provide a similar
patch to remove the confusing .html links from GIT manpages.

 Documentation/Makefile             |    4 ++--
 Documentation/asciidoc.conf        |   18 ++++++++++++++++++
 Documentation/make-cg-asciidoc     |    6 +++---
 Documentation/make-cogito-asciidoc |   19 ++++++++++---------
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -48,13 +48,13 @@ clean:
 	rm -f *.xml *.html *.1 *.7 cg-*.txt cogito.txt
 
 %.html : %.txt
-	asciidoc -b xhtml11 -d manpage $<
+	asciidoc -b xhtml11 -d manpage -f asciidoc.conf $<
 
 %.1 %.7 : %.xml
 	xmlto man $<
 
 %.xml : %.txt
-	asciidoc -b docbook -d manpage $<
+	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
 cogito.txt : make-cogito-asciidoc
 	./make-cogito-asciidoc > $@
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
new file mode 100644
--- /dev/null
+++ b/Documentation/asciidoc.conf
@@ -0,0 +1,18 @@
+## gitlink: macro
+#
+# Usage: gitlink:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show GIT link as: <command>(<section>); if section is defined, else just show
+# the command.
+
+ifdef::backend-docbook[]
+[gitlink-inlinemacro]
+{target}{0?({0})}
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[gitlink-inlinemacro]
+<a href="{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
diff --git a/Documentation/make-cg-asciidoc b/Documentation/make-cg-asciidoc
--- a/Documentation/make-cg-asciidoc
+++ b/Documentation/make-cg-asciidoc
@@ -40,7 +40,7 @@ CAPTION=$(echo "$HEADER" | head -n 1 | t
 # were referenced as "`cg-command`". This way references from cg-* combos in
 # code listings will be ignored.
 BODY=$(echo "$HEADER" | sed '0,/^$/d' \
-		      | sed 's/`\(cg-[a-z-]\+\)`/link:\1.html[\1]/')
+		      | sed 's/`\(cg-[a-z-]\+\)`/gitlink:\1[1]/')
 
 DESCRIPTION=
 OPTIONS=
@@ -108,6 +108,6 @@ $COPYRIGHT
 
 SEE ALSO
 --------
-$COMMAND command is part of link:cogito.html[cogito(7)],
-a toolkit for managing link:git.html[git(1)] trees.
+$COMMAND command is part of gitlink:cogito[7],
+a toolkit for managing gitlink:git[7] trees.
 __END__
diff --git a/Documentation/make-cogito-asciidoc b/Documentation/make-cogito-asciidoc
--- a/Documentation/make-cogito-asciidoc
+++ b/Documentation/make-cogito-asciidoc
@@ -8,10 +8,11 @@ ADVANCED_COMMANDS="$(ls ../cg-admin-*)"
 HELPER_COMMANDS="$(ls ../cg-X*) $(ls ../*-id | grep -v git-)"
 
 # Shorthand for the link markup.
-link()
+man()
 {
-	command="$1"
-	echo "link:$command.html['$command']"
+	section="$1"
+	command="$2"
+	echo "gitlink:$command[$section]"
 }
 
 # Print description list entry.
@@ -28,7 +29,7 @@ print_command_info()
 		;;
 	cg-*)
 		usage=$(sed -n '/^USAGE=/,0s/.*cg-[^ ]*\(.*\)"/\1/p' < $command)
-		echo "link:$cmdname.html[$cmdname] $usage::"
+		echo "gitlink:$cmdname[] $usage::"
 		;;
 	esac
 	echo "	$caption"
@@ -62,7 +63,7 @@ storage system. Amongst some of the note
 for branching, tagging and multiple backends for distributing repositories
 (local files, rsync, HTTP, ssh).
 
-'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(link git)
+'Cogito' is implemented as a series of 'bash(1)' scripts on top of $(man 7 git)
 (a content-tracking filesystem) with the goal of providing an interface for
 working with the 'GIT' database in a manner similar to other SCM tools (like
 'CVS', 'BitKeeper' or 'Monotone').
@@ -107,21 +108,21 @@ $(print_command_listing $HELPER_COMMANDS
 Command Identifiers
 -------------------
 BRANCH_NAME::
-	Indicates a branch name added with the $(link cg-branch-add) command.
+	Indicates a branch name added with the $(man 1 cg-branch-add) command.
 
 COMMAND::
 	Indicates a 'Cogito' command. The \`cg-\` prefix is optional.
 
 LOCATION::
-	Indicates a local file path or a URI. See $(link cg-branch-add) for a
+	Indicates a local file path or a URI. See $(man 1 cg-branch-add) for a
 	list of supported URI schemes.
 
 COMMIT_ID, FROM_ID, TO_ID, BASE_COMMIT::
 	Indicates an ID resolving to a commit. The following expressions can
 	be used interchangably as IDs:
 	- empty string, 'this' or 'HEAD' (current HEAD)
-	- branch name (as registered with $(link cg-branch-add))
-	- tag name (as registered with $(link cg-tag))
+	- branch name (as registered with $(man 1 cg-branch-add))
+	- tag name (as registered with $(man 1 cg-tag))
 	- date string (as recognized by the 'date' tool)
 	- shortcut object hash (shorted unambiguous hash lead)
 	- commit object hash (as returned by 'commit-id')

-- 
Jonas Fonseca
