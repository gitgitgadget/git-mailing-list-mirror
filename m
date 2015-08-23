From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] generate-cmdlist: re-implement as shell script
Date: Sun, 23 Aug 2015 17:31:09 -0400
Message-ID: <1440365469-9928-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Renato Botelho <garga@freebsd.org>,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 23:31:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTcrq-00030m-MR
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 23:31:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbbHWVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 17:31:48 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35828 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbbHWVbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 17:31:47 -0400
Received: by iodt126 with SMTP id t126so129897066iod.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 14:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=MaG6cjhoAo+JDqymOvJS2e9anJ3IZjeqYRfcee18LKA=;
        b=LiA5wxVTO5GqNizegLOmrTiqcHiKGk8xckFaccW79mGDHeiQF/GZuPOi5BlJs0ibj1
         WAW3EbF095IDohBelusMg+nw/aub/mxl65Yc2/PGw7p29Wsktqz3nkZpcFOhNOHI3I8y
         ms2F5vMAFP1Gq04fXL7burKXF5w8owPx+PMQ34ifg7diLiy7G/bS53aucb9jD6xCv0I0
         UC8bWXxcgFtbSvWKQwHSGjY1h5xbbTJlenNaLMM30NoRV6mmwHBmPArdqvzCKm5Jgguk
         AXNXLpLOCSeNVmyR0C7TLklBFLFWf5nRUVfCoLFUoH3HcDqgloFFx/RytAhOo7UwDh/T
         yH0g==
X-Received: by 10.107.6.148 with SMTP id f20mr20062184ioi.167.1440365506552;
        Sun, 23 Aug 2015 14:31:46 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id n5sm7573442iga.0.2015.08.23.14.31.45
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Aug 2015 14:31:46 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.495.g1755c2e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276427>

527ec39 (generate-cmdlist: parse common group commands, 2015-05-21)
replaced generate-cmdlist.sh with a more functional Perl version,
generate-cmdlist.perl. The Perl version gleans named tags from a new
"common groups" section in command-list.txt and recognizes those tags in
"command list" section entries in place of the old 'common' tag. This
allows git-help to, not only recognize, but also group common commands.

Although the tests require Perl, 527ec39 creates an unconditional
dependence upon Perl in the build system itself, which can not be
overridden with NO_PERL. Such a dependency may be undesirable; for
instance, the 'git-lite' package in the FreeBSD ports tree is intended
as a minimal Git installation (which may, for example, be useful on
servers needing only local clone and update capability), which,
historically, has not depended upon Perl[1].

Therefore, revive generate-cmdlist.sh and extend it to recognize "common
groups" and its named tags. Retire generate-cmdlist.perl.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/275905/focus=276132

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Changes since v1 [2]:

* Avoid literal newline inside ${var:+val} when composing grep match
  patterns, lest some shells might trip over it. Instead, pass match
  patterns to grep via -f temporary file.

* Don't assume it's portable to feed commands-list.txt to script as
  stdin and expect one command (sed) to consume only part of it, leaving
  the rest for consumption by a subsequent command (grep). While this
  works on some platforms, in practice, the first command (sed) may
  buffer and eat more of the input than expected. Instead, pass
  commands-list.txt as argument and have each command independently open
  and consume it.

* Replace errant 'd' sed command with 'b' to skip comment lines. The end
  result is the same, but the other "skipping" actions use 'b', and 'b'
  was intended all along.

v2 is still a single patch since I couldn't quite figure out[3] whether
Junio was asking for the patch to be submitted as a reversion plus a
cleanup plus an enhancement or not.

[2]: http://thread.gmane.org/gmane.comp.version-control.git/276226
[3]: http://thread.gmane.org/gmane.comp.version-control.git/276226/focus=276256

 Makefile              |  4 ++--
 generate-cmdlist.perl | 50 --------------------------------------------------
 generate-cmdlist.sh   | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 52 deletions(-)
 delete mode 100755 generate-cmdlist.perl
 create mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index e39ca6c..5d3e3b9 100644
--- a/Makefile
+++ b/Makefile
@@ -1697,10 +1697,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-common-cmds.h: generate-cmdlist.perl command-list.txt
+common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)$(PERL_PATH) generate-cmdlist.perl command-list.txt > $@+ && mv $@+ $@
+	$(QUIET_GEN)./generate-cmdlist.sh command-list.txt >$@+ && mv $@+ $@
 
 SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
diff --git a/generate-cmdlist.perl b/generate-cmdlist.perl
deleted file mode 100755
index 31516e3..0000000
--- a/generate-cmdlist.perl
+++ /dev/null
@@ -1,50 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use warnings;
-
-print <<"EOT";
-/* Automatically generated by $0 */
-
-struct cmdname_help {
-	char name[16];
-	char help[80];
-	unsigned char group;
-};
-
-static char *common_cmd_groups[] = {
-EOT
-
-my $n = 0;
-my %grp;
-while (<>) {
-	last if /^### command list/;
-	next if (1../^### common groups/) || /^#/ || /^\s*$/;
-	chop;
-	my ($k, $v) = split ' ', $_, 2;
-	$grp{$k} = $n++;
-	print "\tN_(\"$v\"),\n";
-}
-
-print "};\n\nstatic struct cmdname_help common_cmds[] = {\n";
-
-while (<>) {
-	next if /^#/ || /^\s*$/;
-	my @tags = split;
-	my $cmd = shift @tags;
-	for my $t (@tags) {
-		if (exists $grp{$t}) {
-			my $s;
-			open my $f, '<', "Documentation/$cmd.txt" or die;
-			while (<$f>) {
-				($s) = /^$cmd - (.+)$/;
-				last if $s;
-			}
-			close $f;
-			$cmd =~ s/^git-//;
-			print "\t{\"$cmd\", N_(\"$s\"), $grp{$t}},\n";
-			last;
-		}
-	}
-}
-
-print "};\n";
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
new file mode 100755
index 0000000..6b39c62
--- /dev/null
+++ b/generate-cmdlist.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+echo "/* Automatically generated by $0 */
+struct cmdname_help {
+	char name[16];
+	char help[80];
+	unsigned char group;
+};
+
+static const char *common_cmd_groups[] = {"
+
+grps=grps$$.tmp
+match=match$$.tmp
+trap "rm -f $grps $match" 0 1 2 3 15
+
+sed -n '
+	1,/^### common groups/b
+	/^### command list/q
+	/^#/b
+	/^[ 	]*$/b
+	h;s/^[^ 	][^ 	]*[ 	][ 	]*\(.*\)/	N_("\1"),/p
+	g;s/^\([^ 	][^ 	]*\)[ 	].*/\1/w '$grps'
+	' $1
+printf '};\n\n'
+
+n=0
+>$match
+substnum=
+while read grp
+do
+	echo "^git-..*[ 	]$grp" >>$match
+	substnum="$substnum${substnum:+;}s/[ 	]$grp/$n/"
+	n=$(($n+1))
+done <$grps
+
+printf 'static struct cmdname_help common_cmds[] = {\n'
+grep -f $match $1 |
+sed 's/^git-//' |
+sort |
+while read cmd tags
+do
+	tag=$(echo $tags | sed "$substnum; s/[^0-9]//g")
+	sed -n '
+		/^NAME/,/git-'"$cmd"'/H
+		${
+			x
+			s/.*git-'"$cmd"' - \(.*\)/	{"'"$cmd"'", N_("\1"), '$tag'},/
+			p
+		}' "Documentation/git-$cmd.txt"
+done
+echo "};"
-- 
2.5.0.495.g1755c2e
