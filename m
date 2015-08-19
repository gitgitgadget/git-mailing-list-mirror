From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] generate-cmdlist: re-implement as shell script
Date: Wed, 19 Aug 2015 16:18:48 -0400
Message-ID: <1440015528-7791-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Renato Botelho <garga@freebsd.org>,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 19 22:19:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS9pV-0007QO-OE
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 22:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbHSUTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 16:19:21 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33476 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbbHSUTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 16:19:20 -0400
Received: by iods203 with SMTP id s203so22815760iod.0
        for <git@vger.kernel.org>; Wed, 19 Aug 2015 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CCu4c0v6B7030/RMrFiYaoCX/X8Qo/griVV5jtAW5qk=;
        b=mJYdWP634m/pKlYR+ai945l6p3HEfXyuAcTedW/oJ3hbCDmHgCshCaA3bPJDkTMrBK
         WwCxG7c0UU/GGXeEl6Hqr8vMuOQ4/9WFqEhc75njpldJYvytKjPGGrBYJp00mtvrWvZH
         epA4TsuvCApJ9c7yLHbP5EYwM5z1ZEpSLc2C362YMjmGk9YLMf1paBc8LN9zjcLyTVao
         WFb9C2WBc1JO8RuUsa5brRjYXvqVxJCAwoyB8ayhoxftAz7OwXzFRNMnIhUDqA3HdBev
         ZbNBiYYc8+KGoO1gSUO7aOhjmVNotMHung2nrGy6QAbSiqft5bIbGqgA1PM0GnJwtqfj
         tpOQ==
X-Received: by 10.107.9.150 with SMTP id 22mr14309160ioj.27.1440015559985;
        Wed, 19 Aug 2015 13:19:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id v1sm1483198igk.3.2015.08.19.13.19.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 19 Aug 2015 13:19:19 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.457.gab17608
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276226>

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

In addition to reviving 527ec39^:generate-cmdlist.sh and extending it, I
also re-indented it with tabs instead of spaces, so it's helpful to
ignore whitespace changes when comparing the old and new versions of the
shell script.

Makefile              |  4 ++--
 generate-cmdlist.perl | 50 --------------------------------------------------
 generate-cmdlist.sh   | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 52 deletions(-)
 delete mode 100755 generate-cmdlist.perl
 create mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index e39ca6c..ddfe7a1 100644
--- a/Makefile
+++ b/Makefile
@@ -1697,10 +1697,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
 
-common-cmds.h: generate-cmdlist.perl command-list.txt
+common-cmds.h: generate-cmdlist.sh command-list.txt
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)$(PERL_PATH) generate-cmdlist.perl command-list.txt > $@+ && mv $@+ $@
+	$(QUIET_GEN)./generate-cmdlist.sh <command-list.txt >$@+ && mv $@+ $@
 
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
index 0000000..1ac329d
--- /dev/null
+++ b/generate-cmdlist.sh
@@ -0,0 +1,50 @@
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
+tmp=cmdgrps$$.tmp
+trap "rm -fr $tmp" 0 1 2 3 15
+
+sed -n '
+	1,/^### common groups/b
+	/^### command list/q
+	/^#/d; /^[ 	]*$/b
+	h;s/^[^ 	][^ 	]*[ 	][ 	]*\(.*\)/	N_("\1"),/p
+	g;s/^\([^ 	][^ 	]*\)[ 	].*/\1/w '$tmp'
+	'
+printf '};\n\n'
+
+n=0
+matchgrp=
+substnum=
+while read grp
+do
+	matchgrp="$matchgrp${matchgrp:+
+}^git-..*[ 	]$grp"
+	substnum="$substnum${substnum:+;}s/[ 	]$grp/$n/"
+	n=$(($n+1))
+done <$tmp
+
+printf 'static struct cmdname_help common_cmds[] = {\n'
+grep "$matchgrp" |
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
2.5.0.457.gab17608
