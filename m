From: Yann Dirson <ydirson@altern.org>
Subject: [RFC PATCH] Add a stgit Documentation directory inspired by the git
	one.
Date: Wed, 21 Feb 2007 23:53:01 +0100
Message-ID: <20070221224531.7956.4335.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 21 23:53:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HK0Kn-0007BG-Tz
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 23:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423241AbXBUWxJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 17:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423254AbXBUWxI
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 17:53:08 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:46795 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423241AbXBUWxG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 17:53:06 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3416F4A0E7;
	Wed, 21 Feb 2007 23:53:03 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id DAD6C1F084;
	Wed, 21 Feb 2007 23:53:01 +0100 (CET)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40329>

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

[Please don't apply yet - this is a proof of concept to gather
feedback before I invest more time in this]

This is an early sketch of a Documentation directory for StGIT.  I
mostly took the Documentation directory from Git and adapted it
slightly.

It is not 100% suited to stgit yet, because 1) unlike git, the StGIT
main command is named "stg" and not "stgit", and 2) the various
commands are not available individually as stg-<name>.

Because of manpage namespace consideration, the manpages will still
have to be named stg-*.1 of something similar, so the issue left is
how to handle the presentation, in docbook/man and in html.  I had a
try at a simple adaptation of the gitlink macro (as stglink), but it
will surely need tuning (eg. we'll probably want to avoid passing the
man section as argument, it will be a constant).


 Documentation/Makefile          |   62 ++++++++++++++++++++++++++++++++
 Documentation/asciidoc.conf     |   52 +++++++++++++++++++++++++++
 Documentation/build-docdep.perl |   50 ++++++++++++++++++++++++++
 Documentation/callouts.xsl      |   30 ++++++++++++++++
 Documentation/stg-new.txt       |   43 ++++++++++++++++++++++
 Documentation/stg.txt           |   75 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 312 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
new file mode 100644
index 0000000..670bfd3
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
+ASCIIDOC=asciidoc
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
index 0000000..e019a0e
--- /dev/null
+++ b/Documentation/asciidoc.conf
@@ -0,0 +1,52 @@
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
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>stg-{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
+endif::backend-docbook[]
+
+ifdef::backend-xhtml11[]
+[stglink-inlinemacro]
+<a href="stg-{target}.html">{target}{0?({0})}</a>
+endif::backend-xhtml11[]
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
index 0000000..225ce3d
--- /dev/null
+++ b/Documentation/stg-new.txt
@@ -0,0 +1,43 @@
+stg-new(1)
+==========
+
+NAME
+----
+stg-new - create a new patch
+
+SYNOPSIS
+--------
+stg new [OPTIONS] <name>
+
+DESCRIPTION
+-----------
+
+'stg new' creates a new patch with the given <name> on the current
+stack.  The new patch is created on top of the currently applied
+patches, and is made the new top of the stack.
+
+An editor will be launched to edit the commit message to be used for
+the patch, unless the '-m' flag already specified one.
+
+The message and other GIT commit attributes can be modified later
+using stglink:refresh[1].
+
+OPTIONS
+-------
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
+StGIT
+-----
+Part of the StGIT suite - see gitlink:stg[7]
diff --git a/Documentation/stg.txt b/Documentation/stg.txt
new file mode 100644
index 0000000..d5a61b2
--- /dev/null
+++ b/Documentation/stg.txt
@@ -0,0 +1,75 @@
+stg(7)
+======
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
+StGIT (Stacked GIT) is a Python application providing similar
+functionality to Quilt (i.e. pushing/popping patches to/from a stack)
+on top of GIT. These operations are performed using GIT commands and
+the patches are stored as GIT commit objects, allowing easy merging of
+the StGIT patches into other repositories using standard GIT
+functionality.
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
+Generic commands
+----------------
+
+Informational commands not touching the repository.
+
+Repository commands
+-------------------
+
+stglink:clone[1]::
+	clone a remote repository into local storage
+
+Stack commands
+--------------
+
+stglink:branch[1]::
+	manage patch series
+
+Patch commands
+--------------
+
+stglink:new[1]::
+	create a new patch and make it the topmost one
+
+Working-copy commands
+---------------------
+
+stglink:status[1]::
+	show the tree status
+
+CONFIGURATION MECHANISM
+-----------------------
+
+Starting with 0.12, StGIT uses the same configuration mechanism as
+GIT.  See gitlink:git[7] for more details.
