From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add a Documentation directory inspired by the git one.
Date: Sun, 25 Feb 2007 01:05:25 +0100
Message-ID: <20070225000313.22850.50329.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 25 01:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HL6td-0004Md-RT
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 01:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbXBYAFd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Feb 2007 19:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933602AbXBYAFd
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Feb 2007 19:05:33 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:53942 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933601AbXBYAFb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Feb 2007 19:05:31 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 940DE49F76;
	Sun, 25 Feb 2007 01:05:29 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 51E501F084;
	Sun, 25 Feb 2007 01:05:25 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40526>


The html and manpages are generated from asciidoc source.  Short
description strings are extracted from the python modules.

Only the stg(7) frontpage and the stg-new(1) command page are already
written.  A template is provided for new command pages.

This also reworks a couple of help strings and command classification.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

Here is a more complete starting point for writing StGIT
documentation.  Looks like I hit an asciidoc bug (look at generated
NAME sections), but appart from that I'm quite pleased with the
result.  But any constructive criticism is still happily accepted ;)

 Documentation/COMMAND-TEMPLATE.txt |   41 +++++++
 Documentation/Makefile             |   62 +++++++++++
 Documentation/asciidoc.conf        |   59 ++++++++++
 Documentation/build-docdep.perl    |   50 +++++++++
 Documentation/callouts.xsl         |   30 +++++
 Documentation/stg-new.txt          |  115 ++++++++++++++++++++
 Documentation/stg.txt              |  210 ++++++++++++++++++++++++++++++++++++
 stgit/commands/branch.py           |    2 
 stgit/commands/clone.py            |    2 
 stgit/commands/export.py           |    2 
 stgit/commands/id.py               |    2 
 stgit/commands/patches.py          |    2 
 stgit/main.py                      |   12 +-
 13 files changed, 578 insertions(+), 11 deletions(-)

diff --git a/Documentation/COMMAND-TEMPLATE.txt b/Documentation/COMMAND-TEMPLATE.txt
new file mode 100644
index 0000000..5d8a1a9
--- /dev/null
+++ b/Documentation/COMMAND-TEMPLATE.txt
@@ -0,0 +1,41 @@
+stg-NAME(1)
+==========
+XXX <xxx@xxx.xx>
+v0.12.1, Xxxx 2007
+
+NAME
+----
+stg-NAME - stgdesc:NAME[]
+
+SYNOPSIS
+--------
+stg NAME [OPTIONS] XXX
+
+DESCRIPTION
+-----------
+
+XXX
+
+OPTIONS
+-------
+
+XXX
+
+FILES
+-----
+
+	<templates>/XXX
+
+ENVIRONMENT VARIABLES
+---------------------
+
+	XXX
+
+GIT CONFIGURATION VARIABLES
+---------------------------
+
+	stgit.XXX
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[7].
diff --git a/Documentation/Makefile b/Documentation/Makefile
new file mode 100644
index 0000000..7f5520c
--- /dev/null
+++ b/Documentation/Makefile
@@ -0,0 +1,62 @@
+MAN1_TXT=$(wildcard stg-*.txt)
+MAN7_TXT=stg.txt
+
+DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN7_TXT))
+
+DOC_MAN1=$(patsubst %.txt,%.1,$(MAN1_TXT))
+DOC_MAN7=$(patsubst %.txt,%.7,$(MAN7_TXT))
+
+prefix?=$(HOME)
+mandir?=$(prefix)/man
+man1dir=$(mandir)/man1
+man7dir=$(mandir)/man7
+# DESTDIR=
+
+ASCIIDOC=asciidoc --unsafe
+ASCIIDOC_EXTRA =
+INSTALL?=install
+
+#
+# Please note that there is a minor bug in asciidoc.
+# The version after 6.0.3 _will_ include the patch found here:
+#   http://marc.theaimsgroup.com/?l=git&m=111558757202243&w=2
+#
+# Until that version is released you may have to apply the patch
+# yourself - yes, all 6 characters of it!
+#
+
+all: html man
+
+html: $(DOC_HTML)
+
+$(DOC_HTML) $(DOC_MAN1) $(DOC_MAN7): asciidoc.conf
+
+man: man1 man7
+man1: $(DOC_MAN1)
+man7: $(DOC_MAN7)
+
+install: man
+	$(INSTALL) -d -m755 $(DESTDIR)$(man1dir) $(DESTDIR)$(man7dir)
+	$(INSTALL) -m644 $(DOC_MAN1) $(DESTDIR)$(man1dir)
+	$(INSTALL) -m644 $(DOC_MAN7) $(DESTDIR)$(man7dir)
+#
+# Determine "include::" file references in asciidoc files.
+#
+doc.dep : $(wildcard *.txt) build-docdep.perl
+	rm -f $@+ $@
+	perl ./build-docdep.perl >$@+
+	mv $@+ $@
+
+-include doc.dep
+
+clean:
+	rm -f *.xml *.html *.1 *.7 doc.dep
+
+%.html : %.txt
+	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
+
+%.1 %.7 : %.xml
+	xmlto -m callouts.xsl man $<
+
+%.xml : %.txt
+	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf $<
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
new file mode 100644
index 0000000..3df8814
--- /dev/null
+++ b/Documentation/asciidoc.conf
@@ -0,0 +1,59 @@
+## gitlink: macro
+#
+# Usage: gitlink:command[manpage-section]
+#
+# Note, {0} is the manpage section, while {target} is the command.
+#
+# Show GIT link as: <command>(<section>); if section is defined, else just show
+# the command.
+
+[attributes]
+caret=^
+startsb=&#91;
+endsb=&#93;
+tilde=&#126;
+
+ifdef::backend-docbook[]
+[gitlink-inlinemacro]
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
+endif::backend-docbook[]
+
+ifdef::backend-docbook[]
+# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+|
+</literallayout>
+{title#}</example>
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[gitlink-inlinemacro]
+<a href="{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
+
+# stglink
+
+ifdef::backend-docbook[]
+[stglink-inlinemacro]
+<citerefentry>
+<refentrytitle>stg {target}</refentrytitle><manvolnum>1</manvolnum>
+</citerefentry>
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[stglink-inlinemacro]
+<a href="stg-{target}.html">stg {target}(1)</a>
+endif::backend-xhtml11[]
+
+# stgdesc
+[stgdesc-inlinemacro]
+{sys:../stg help|grep "  {target}" | tr -s ' '| cut -d' ' -f3-}
+
+[stgdesc-blockmacro]
+stglink:{target}[]::
+	stgdesc:{target}[]
diff --git a/Documentation/build-docdep.perl b/Documentation/build-docdep.perl
new file mode 100755
index 0000000..489389c
--- /dev/null
+++ b/Documentation/build-docdep.perl
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+
+my %include = ();
+my %included = ();
+
+for my $text (<*.txt>) {
+    open I, '<', $text || die "cannot read: $text";
+    while (<I>) {
+	if (/^include::/) {
+	    chomp;
+	    s/^include::\s*//;
+	    s/\[\]//;
+	    $include{$text}{$_} = 1;
+	    $included{$_} = 1;
+	}
+    }
+    close I;
+}
+
+# Do we care about chained includes???
+my $changed = 1;
+while ($changed) {
+    $changed = 0;
+    while (my ($text, $included) = each %include) {
+	for my $i (keys %$included) {
+	    # $text has include::$i; if $i includes $j
+	    # $text indirectly includes $j.
+	    if (exists $include{$i}) {
+		for my $j (keys %{$include{$i}}) {
+		    if (!exists $include{$text}{$j}) {
+			$include{$text}{$j} = 1;
+			$included{$j} = 1;
+			$changed = 1;
+		    }
+		}
+	    }
+	}
+    }
+}
+
+while (my ($text, $included) = each %include) {
+    if (! exists $included{$text} &&
+	(my $base = $text) =~ s/\.txt$//) {
+	my ($suffix) = '1';
+	if ($base eq 'git') {
+	    $suffix = '7'; # yuck...
+	}
+	print "$base.html $base.$suffix : ", join(" ", keys %$included), "\n";
+    }
+}
diff --git a/Documentation/callouts.xsl b/Documentation/callouts.xsl
new file mode 100644
index 0000000..6a361a2
--- /dev/null
+++ b/Documentation/callouts.xsl
@@ -0,0 +1,30 @@
+<!-- callout.xsl: converts asciidoc callouts to man page format -->
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
+<xsl:template match="co">
+	<xsl:value-of select="concat('\fB(',substring-after(@id,'-'),')\fR')"/>
+</xsl:template>
+<xsl:template match="calloutlist">
+	<xsl:text>.sp&#10;</xsl:text>
+	<xsl:apply-templates/>
+	<xsl:text>&#10;</xsl:text>
+</xsl:template>
+<xsl:template match="callout">
+	<xsl:value-of select="concat('\fB',substring-after(@arearefs,'-'),'. \fR')"/>
+	<xsl:apply-templates/>
+	<xsl:text>.br&#10;</xsl:text>
+</xsl:template>
+
+<!-- sorry, this is not about callouts, but attempts to work around
+ spurious .sp at the tail of the line docbook stylesheets seem to add -->
+<xsl:template match="simpara">
+  <xsl:variable name="content">
+    <xsl:apply-templates/>
+  </xsl:variable>
+  <xsl:value-of select="normalize-space($content)"/>
+  <xsl:if test="not(ancestor::authorblurb) and
+                not(ancestor::personblurb)">
+    <xsl:text>&#10;&#10;</xsl:text>
+  </xsl:if>
+</xsl:template>
+
+</xsl:stylesheet>
diff --git a/Documentation/stg-new.txt b/Documentation/stg-new.txt
new file mode 100644
index 0000000..698816b
--- /dev/null
+++ b/Documentation/stg-new.txt
@@ -0,0 +1,115 @@
+stg-new(1)
+==========
+Yann Dirson <ydirson@altern.org>
+v0.12.1, February 2007
+
+NAME
+----
+stg-new - stgdesc:new[]
+
+SYNOPSIS
+--------
+stg new [OPTIONS] <name>
+
+DESCRIPTION
+-----------
+
+Create a new, empty patch with the given <name> on the current stack.
+The new patch is created on top of the currently applied patches, and
+is made the new top of the stack.  The local changes in the working
+tree are not included in the patch. A stglink:refresh[] command is
+needed for this.
+
+An editor will be launched to edit the commit message to be used for
+the patch, unless the '--message' flag already specified one.  The
+'patchdescr.tmpl' template file is used if available to pre-fill the
+editor.  The editor to use is taken from the first of the following
+sources of information, and defaults to 'vi':
+
+. the 'stgit.editor' GIT configuration variable
+. the 'EDITOR' environment variable
+
+The message and other GIT commit attributes can be modified later
+using stglink:refresh[].
+
+AUTHOR AND COMMITTER INFORMATION
+--------------------------------
+
+The author name (resp. email) to record in the StGIT patch is taken
+from the first of the following sources for the information:
+
+. the '--authname' (resp. '--authemail') or '--author' flag on command-line
+. the 'GIT_AUTHOR_NAME' (resp. 'GIT_AUTHOR_EMAIL') environment variable
+. the 'user.name' (resp. 'user.email') GIT configuration variable
+
+Similarly, the committer name (resp. email) is taken from the first of
+the following sources:
+
+. the '--commname' (resp. '--commemail') flag on command-line
+. the 'GIT_COMMITTER_NAME' (resp. 'GIT_COMMITTER_EMAIL') environment variable
+. the 'user.name' (resp. 'user.email') GIT configuration variable
+
+The GIT commit generated by stglink:refresh[] will use these
+informations when available.  If one of them is not available, GIT
+will pick the value from your machine's configuration at that time, as
+described in gitlink:git-commit-tree[1].
+
+OPTIONS
+-------
+
+<name>::
+	The short name that will be used as to identify the patch in
+	other StGIT commands.  Must be unique in the stack.  May only
+	contain alphanumeric characters, dashes and underscores.
+
+--message=<message>::
+-m <message>::
+	Use <message> as the patch description.
+
+--showpatch::
+-s::
+	Show the patch content in the editor buffer.  This flag does
+	nothing if '-m' is also specified.
+
+--author="Name <email@company>"::
+-a "Name <email@company>"::
+	Use "Name <email@company>" as the author details.  This form
+	sets both 'authname' and 'authemail'.
+
+--authname=<name>::
+	Use <name> as the author name
+--authemail=<email>::
+	Use <email> as the author e-mail
+--authdate=<date>::
+	Use <date> as the author date
+
+--commname=<name>::
+	Use <name> as the committer name
+--commemail=<email>::
+	Use <email> as the committer e-mail
+
+FILES
+-----
+
+	<templates>/patchdescr.tmpl
+
+ENVIRONMENT VARIABLES
+---------------------
+
+	GIT_AUTHOR_NAME
+	GIT_AUTHOR_EMAIL
+	GIT_AUTHOR_DATE
+	GIT_COMMITTER_NAME
+	GIT_COMMITTER_EMAIL
+	EDITOR
+
+GIT CONFIGURATION VARIABLES
+---------------------------
+
+	user.name
+	user.email
+	stgit.editor
+
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[7].
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
new file mode 100644
index 0000000..571e53a
--- /dev/null
+++ b/Documentation/stg.txt
@@ -0,0 +1,210 @@
+stg(7)
+======
+Yann Dirson <ydirson@altern.org>
+v0.12.1, February 2007
+
+NAME
+----
+stg - manage stacks of patches using the GIT content tracker
+
+SYNOPSIS
+--------
+[verse]
+'stg' [--version] [--help] <command> [OPTIONS] [ARGS]
+
+DESCRIPTION
+-----------
+
+StGIT (Stacked GIT) is an application providing similar functionality
+to Quilt (i.e. pushing/popping patches to/from a stack), on top of
+GIT. These operations are performed using GIT commands and the patches
+are stored as GIT commit objects, allowing easy merging of the StGIT
+patches into other repositories using standard GIT functionality.
+
+Typical uses of StGIT include:
+
+Tracking branch::
+	Maintaining modifications against a remote branch, possibly
+	with the intent of sending some patches upstream.  StGIT
+	assists in preparing and cleaning up patches until they are
+	acceptable upstream, as well as maintaining local patches not
+	meant to be sent upstream.
+
+Development branch::
+	Preparing and testing your commits before publishing them,
+	separating your features from unrelated bugfixes collected
+	while developping.
+
+OPTIONS
+-------
+
+--version::
+	Prints the StGIT suite version that the 'stg' program came
+	from, as well as version of other components used, such as GIT
+	and Python.
+
+--help::
+	Prints the synopsis and a list of all commands.  If a git
+	command is given this option will display the specific help
+	for that command.
+
+STGIT COMMANDS
+--------------
+
+We divide StGIT commands in thematic groups, according to the primary
+type of object they create or change.
+
+ifdef::backend-docbook[]
+Here is a short description of each command. A more detailed
+description is available in individual command manpages.  Those
+manpages are named 'stg-<command>(1)'.
+endif::backend-docbook[]
+
+Generic commands
+~~~~~~~~~~~~~~~~
+
+User-support commands not touching the repository.
+
+stglink:help[]::
+	stgdesc:help[]
+stglink:version[]::
+	stgdesc:version[]
+stglink:copyright[]::
+	stgdesc:copyright[]
+
+Repository commands
+~~~~~~~~~~~~~~~~~~~
+
+stglink:clone[]::
+	stgdesc:clone[]
+stglink:id[]::
+	stgdesc:id[]
+
+Stack commands
+~~~~~~~~~~~~~~
+
+Stack management
+^^^^^^^^^^^^^^^^
+
+stglink:branch[]::
+	stgdesc:branch[]
+stglink:init[]::
+	stgdesc:init[]
+stglink:clean[]::
+	stgdesc:clean[]
+stglink:pull[]::
+	stgdesc:pull[]
+stglink:rebase[]::
+	stgdesc:rebase[]
+
+stglink:commit[]::
+	stgdesc:commit[]
+stglink:uncommit[]::
+	stgdesc:uncommit[]
+stglink:assimilate[]::
+	stgdesc:assimilate[]
+
+Controlling what patches are applied
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+stglink:series[]::
+	stgdesc:series[]
+stglink:push[]::
+	stgdesc:push[]
+stglink:pop[]::
+	stgdesc:pop[]
+stglink:goto[]::
+	stgdesc:goto[]
+stglink:float[]::
+	stgdesc:float[]
+stglink:applied[]::
+	stgdesc:applied[]
+stglink:unapplied[]::
+	stgdesc:unapplied[]
+stglink:top[]::
+	stgdesc:top[]
+
+stglink:hide[]::
+	stgdesc:hide[]
+stglink:unhide[]::
+	stgdesc:unhide[]
+
+Miscellaneous stack commands
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+stglink:patches[]::
+	stgdesc:patches[]
+
+
+Patch commands
+~~~~~~~~~~~~~~
+
+Patch management
+^^^^^^^^^^^^^^^^
+
+stglink:new[]::
+	stgdesc:new[]
+stglink:delete[]::
+	stgdesc:delete[]
+stglink:rename[]::
+	stgdesc:rename[]
+stglink:log[]::
+	stgdesc:log[]
+
+Controlling patch contents
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+stglink:files[]::
+	stgdesc:files[]
+stglink:show[]::
+	stgdesc:show[]
+stglink:refresh[]::
+	stgdesc:refresh[]
+stglink:fold[]::
+	stgdesc:fold[]
+stglink:pick[]::
+	stgdesc:pick[]
+stglink:sync[]::
+	stgdesc:sync[]
+
+Interaction with the rest of the world
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+stglink:export[]::
+	stgdesc:export[]
+stglink:import[]::
+	stgdesc:import[]
+stglink:mail[]::
+	stgdesc:mail[]
+
+
+Working-copy commands
+~~~~~~~~~~~~~~~~~~~~~
+
+stglink:add[]::
+	stgdesc:add[]
+stglink:rm[]::
+	stgdesc:rm[]
+stglink:status[]::
+	stgdesc:status[]
+stglink:diff[]::
+	stgdesc:diff[]
+stglink:resolved[]::
+	stgdesc:resolved[]
+
+CONFIGURATION MECHANISM
+-----------------------
+
+Starting with 0.12, StGIT uses the same configuration mechanism as
+GIT.  See gitlink:git[7] for more details.
+
+TEMPLATES
+---------
+
+A number of StGIT commands make use of template files to provide
+useful default texts to be edited by the user.  These '<name>.tmpl'
+template files are searched in the following directories:
+
+	$GITDIR/
+	$HOME/.stgit/templates/
+	/usr/share/stgit/templates/
diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 032218a..eff0121 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -26,7 +26,7 @@ from stgit.utils import *
 from stgit import stack, git, basedir
 
 
-help = 'manage development branches'
+help = 'manage patch stacks'
 usage = """%prog [options] branch-name [commit-id]
 
 Create, clone, switch between, rename, or delete development branches
diff --git a/stgit/commands/clone.py b/stgit/commands/clone.py
index 455dd6e..15139c8 100644
--- a/stgit/commands/clone.py
+++ b/stgit/commands/clone.py
@@ -23,7 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
 
 
-help = 'clone a remote repository into local storage'
+help = 'make a local clone of a remote repository'
 usage = """%prog [options] <repository> <dir>
 
 Clone a GIT <repository> into the local <dir> and initialise the
diff --git a/stgit/commands/export.py b/stgit/commands/export.py
index 35a25ba..79b8630 100644
--- a/stgit/commands/export.py
+++ b/stgit/commands/export.py
@@ -26,7 +26,7 @@ from stgit.utils import *
 from stgit import stack, git, templates
 
 
-help = 'exports a series of patches to <dir> (or patches)'
+help = 'exports patches to a directory'
 usage = """%prog [options] [<patch1>] [<patch2>] [<patch3>..<patch4>]
 
 Export a range of applied patches to a given directory (defaults to
diff --git a/stgit/commands/id.py b/stgit/commands/id.py
index 284589a..4226adf 100644
--- a/stgit/commands/id.py
+++ b/stgit/commands/id.py
@@ -23,7 +23,7 @@ from stgit.utils import *
 from stgit import stack, git
 
 
-help = 'print the hash value of a GIT id'
+help = 'print the GIT hash value of a StGIT reference'
 usage = """%prog [options] [id]
 
 Print the hash value of a GIT id (defaulting to HEAD). In addition to
diff --git a/stgit/commands/patches.py b/stgit/commands/patches.py
index 7da74ba..01708b0 100644
--- a/stgit/commands/patches.py
+++ b/stgit/commands/patches.py
@@ -24,7 +24,7 @@ from stgit.utils import *
 from stgit import stack, git
 
 
-help = 'show the patches modifying a file'
+help = 'show the applied patches modifying a file'
 usage = """%prog [options] <file> [<file>...]
 
 Show the applied patches modifying the given files. The '--diff'
diff --git a/stgit/main.py b/stgit/main.py
index 933f127..f77fba8 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -102,28 +102,29 @@ commands = Commands({
 
 # classification: repository, stack, patch, working copy
 repocommands = (
-    'branch',
     'clone',
     'id',
-    'pull'
     )
 stackcommands = (
     'applied',
     'assimilate',
+    'branch',
     'clean',
     'commit',
     'float',
     'goto',
     'hide',
     'init',
+    'patches',
     'pop',
+    'pull',
     'push',
     'rebase',
     'series',
     'top',
     'unapplied',
     'uncommit',
-    'unhide'
+    'unhide',
     )
 patchcommands = (
     'delete',
@@ -138,15 +139,14 @@ patchcommands = (
     'refresh',
     'rename',
     'show',
-    'sync'
+    'sync',
     )
 wccommands = (
     'add',
     'diff',
-    'patches',
     'resolved',
     'rm',
-    'status'
+    'status',
     )
 
 def _print_helpstring(cmd):
