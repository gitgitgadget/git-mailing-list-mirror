From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 2/24] Documentation: Add variable-substitution script
Date: Mon, 26 Jul 2010 20:48:54 +0200
Message-ID: <049043aa444288fd9409a3706fe3190fd679cb7d.1280169048.git.trast@student.ethz.ch>
References: <cover.1280169048.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:49:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSjh-0005Le-GP
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:49:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab0GZStE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 14:49:04 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:14250 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754743Ab0GZStD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:49:03 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Mon, 26 Jul
 2010 20:48:56 +0200
Received: from localhost.localdomain (84.74.100.241) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.0.702.0; Mon, 26 Jul
 2010 20:48:56 +0200
X-Mailer: git-send-email 1.7.2.349.gd5452
In-Reply-To: <cover.1280169048.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151881>

The new subst-config.perl is run by the Makefile as

  ./subst-config.perl <vars> <in> <out>

It first reads <vars> for variable-documenting blocks.  A line
consisting of '<name>::' starts the block for <name>, except inside a
'--' delimited block (which is used to generate sub-lists).  A block
extends until the first blank line, which is what asciidoc also looks
for.

Then it copies from <in> to <out>, substituting lines of the form

  @@CONFIG(<name>)@@

with the documentation block for <name>.

=C3=86var kindly implemented the following, squashed into this patch:

 - Print a usage message when argument prerequisites aren't met
 - Use Getopt::Long instead of manually looking at @ARGV
 - use warnings, not -w
 - Split the parsing & substituting functionality into subroutines

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/Makefile          |   14 +++++---
 Documentation/config-vars.txt   |    1 +
 Documentation/subst-config.perl |   74 +++++++++++++++++++++++++++++++=
++++++++
 3 files changed, 84 insertions(+), 5 deletions(-)
 create mode 100755 Documentation/subst-config.perl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a4c4063..c20d580 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -239,12 +239,16 @@ cmd-list.made: cmd-list.perl ../command-list.txt =
$(MAN1_TXT)
 clean:
 	$(RM) *.xml *.xml+ *.html *.html+ *.1 *.5 *.7
 	$(RM) *.texi *.texi+ *.texi++ git.info gitman.info
+	$(RM) *.txt.cv
 	$(RM) howto-index.txt howto/*.html doc.dep
 	$(RM) technical/api-*.html technical/api-index.txt
 	$(RM) $(cmds_txt) *.made
 	$(RM) manpage-base-url.xsl
=20
-$(MAN_HTML): %.html : %.txt
+%.txt.cv : %.txt subst-config.perl config-vars.txt
+	$(QUIET_GEN) ./subst-config.perl --varlist=3Dconfig-vars.txt --input=3D=
$< --output=3D$@
+
+$(patsubst %.txt,%.txt.cv,$(MAN_HTML)): %.html : %.txt.cv
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=3D$(GIT_VERSION) -o $@+ $< && \
@@ -257,13 +261,13 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_XMLTO)$(RM) $@ && \
 	xmlto -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
=20
-%.xml : %.txt
+%.xml : %.txt.cv
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) -b docbook -d manpage -f asciidoc.conf \
 		$(ASCIIDOC_EXTRA) -agit_version=3D$(GIT_VERSION) -o $@+ $< && \
 	mv $@+ $@
=20
-user-manual.xml: user-manual.txt user-manual.conf
+user-manual.xml: user-manual.txt.cv user-manual.conf
 	$(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
 	$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b docbook -d book -o $@+ $< && \
 	mv $@+ $@
@@ -320,8 +324,8 @@ howto-index.txt: howto-index.sh $(wildcard howto/*.=
txt)
 	'$(SHELL_PATH_SQ)' ./howto-index.sh $(wildcard howto/*.txt) >$@+ && \
 	mv $@+ $@
=20
-$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt
-	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt
+$(patsubst %,%.html,$(ARTICLES)) : %.html : %.txt.cv
+	$(QUIET_ASCIIDOC)$(ASCIIDOC) $(ASCIIDOC_EXTRA) -b xhtml11 $*.txt.cv
=20
 WEBDOC_DEST =3D /pub/software/scm/git/docs
=20
diff --git a/Documentation/config-vars.txt b/Documentation/config-vars.=
txt
index b82fada..3fcefe9 100644
--- a/Documentation/config-vars.txt
+++ b/Documentation/config-vars.txt
@@ -689,6 +689,7 @@ diff.mnemonicprefix::
 	standard "a/" and "b/" depending on what is being compared.  When
 	this configuration is in effect, reverse diff output also swaps
 	the order of the prefixes:
+
 diff.noprefix::
 	If set, 'git diff' does not show any source or destination prefix.
 `git diff`;;
diff --git a/Documentation/subst-config.perl b/Documentation/subst-conf=
ig.perl
new file mode 100755
index 0000000..a981670
--- /dev/null
+++ b/Documentation/subst-config.perl
@@ -0,0 +1,74 @@
+#!/usr/bin/perl
+use 5.006002;
+use strict;
+use warnings;
+use Getopt::Long;
+
+Getopt::Long::Configure qw/ pass_through /;
+
+my $rc =3D GetOptions(
+    "varlist=3Ds" =3D> \my $varlist,
+    "input=3Ds"   =3D> \my $input,
+    "output=3Ds"  =3D> \my $output,
+);
+
+if (!$rc or (!-r $varlist or !-r $input)) {
+    print "$0 --varlist=3D<varlist> --input=3D<in> --output=3D<out>\n"=
;
+    exit 1;
+}
+
+my $vars =3D read_varlist($varlist);
+substitute_variables($vars, $input, $output);
+exit 0;
+
+sub read_varlist {
+    my ($file) =3D @_;
+
+    open my $fh, "<", $varlist or die "cannot open $varlist: $!";
+    my %vars;
+
+    my ($v, $last_v);
+    my $in_block =3D 0;
+    while (<$fh>) {
+        if (/^(\S+)::/) {
+            $v =3D lc $1;
+            $in_block =3D 0;
+            push @{$vars{$v}}, $_;
+        } elsif (/^$/ && !$in_block) {
+            if (defined $last_v && !$#{$vars{$last_v}}) {
+                $vars{$last_v} =3D $vars{$v};
+            }
+            $last_v =3D $v;
+        } elsif (defined $v) {
+            push @{$vars{$v}}, $_;
+            $in_block =3D !$in_block if /^--$/;
+        }
+    }
+
+    close $fh or die "eh? close failed: $!";
+
+    return \%vars
+}
+
+sub substitute_variables {
+    my ($varlist, $in, $out) =3D @_;
+
+    open my $infh, "<", $input or die "Can't open $in for reading: $!"=
;
+    open my $outfh, ">", $output or die "Can't open $out for reading: =
$!";
+
+    while (<$infh>) {
+        if (/^\@\@CONFIG\((\S+)\)\@\@$/) {
+            my $v =3D lc $1;
+            die "Key $v not documented" unless exists $varlist->{$v};
+            print $outfh @{$varlist->{$v}};
+            print $outfh "\n";
+        } else {
+            print $outfh $_;
+        }
+    }
+
+    close $infh or die "closing input failed: $!";
+    close $outfh or die "closing output failed: $!";
+
+    return;
+}
--=20
1.7.2.349.gd5452
