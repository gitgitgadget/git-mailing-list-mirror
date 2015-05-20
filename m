From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v9 3/5] generate-cmdlist: parse common group commands
Date: Wed, 20 May 2015 21:22:59 +0200
Message-ID: <1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 21:23:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9aU-0002WQ-PY
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbbETTX2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:23:28 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36495 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbbETTXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:23:25 -0400
Received: by wizk4 with SMTP id k4so166474554wiz.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vlwRwwxKlxplzam5VhN7qbZtK4TgNIOFWOlKmPN8WCQ=;
        b=ZUwgY9FDmQ34APqWCzqGarU2q4qDQMlibMO6exVVsmuU7jU5p+MVhN7fv1/Edkmpac
         k4WDsn4Vi4wnbuVrqybGETABd0gRuBYlaTJIC88fxNQrwX8fgu3YPWID/mebqFiq8eru
         VN/PFJu15l6U2U50C9+fjvjupsO1f8rxBzRWRsv+F8GYNQLmfabUAJn+Cz6FAfEsoPIC
         p/jqC58YJj+Kyywwm+Zkbj7BclgSgoEWSdxJV4gaIWXIQiGKvBtoNcFK1ZCceL94UWXj
         vxaCSXzMcPkyHVVFMcU/BAzO94m3brE1O1Bdsx6txsig14oDqGnLElKA4uu50vmDiT3A
         DTsQ==
X-Received: by 10.180.76.231 with SMTP id n7mr43801046wiw.44.1432149804330;
        Wed, 20 May 2015 12:23:24 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id bm9sm28320276wjc.21.2015.05.20.12.23.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 12:23:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269499>

=46rom: Eric Sunshine <sunshine@sunshineco.com>

Parse the group block to create the array of group descriptions:

static char *common_cmd_groups[] =3D {
    N_("starting a working area"),
    N_("working on the current change"),
    N_("working with others"),
    N_("examining the history and state"),
    N_("growing, marking and tweaking your history"),
};

then map each element of common_cmds[] to a group via its index:

static struct cmdname_help common_cmds[] =3D {
    {"add", N_("Add file contents to the index"), 1},
    {"branch", N_("List, create, or delete branches"), 4},
    {"checkout", N_("Checkout a branch or paths to the ..."), 4},
    {"clone", N_("Clone a repository into a new directory"), 0},
    {"commit", N_("Record changes to the repository"), 4},
    ...
};

so that 'git help' can print those commands grouped by theme.

Only commands tagged with an attribute from the group block are emitted=
 to
common_cmds[].

[commit message by S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Makefile              |  4 ++--
 generate-cmdlist.perl | 50 +++++++++++++++++++++++++++++++++++++++++++=
+++++++
 generate-cmdlist.sh   | 23 -----------------------
 3 files changed, 52 insertions(+), 25 deletions(-)
 create mode 100755 generate-cmdlist.perl
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 655740d..54ec511 100644
--- a/Makefile
+++ b/Makefile
@@ -1694,10 +1694,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.perl command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)$(PERL_PATH) generate-cmdlist.perl command-list.txt > $@+=
 && mv $@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
diff --git a/generate-cmdlist.perl b/generate-cmdlist.perl
new file mode 100755
index 0000000..31516e3
--- /dev/null
+++ b/generate-cmdlist.perl
@@ -0,0 +1,50 @@
+#!/usr/bin/perl
+use strict;
+use warnings;
+
+print <<"EOT";
+/* Automatically generated by $0 */
+
+struct cmdname_help {
+	char name[16];
+	char help[80];
+	unsigned char group;
+};
+
+static char *common_cmd_groups[] =3D {
+EOT
+
+my $n =3D 0;
+my %grp;
+while (<>) {
+	last if /^### command list/;
+	next if (1../^### common groups/) || /^#/ || /^\s*$/;
+	chop;
+	my ($k, $v) =3D split ' ', $_, 2;
+	$grp{$k} =3D $n++;
+	print "\tN_(\"$v\"),\n";
+}
+
+print "};\n\nstatic struct cmdname_help common_cmds[] =3D {\n";
+
+while (<>) {
+	next if /^#/ || /^\s*$/;
+	my @tags =3D split;
+	my $cmd =3D shift @tags;
+	for my $t (@tags) {
+		if (exists $grp{$t}) {
+			my $s;
+			open my $f, '<', "Documentation/$cmd.txt" or die;
+			while (<$f>) {
+				($s) =3D /^$cmd - (.+)$/;
+				last if $s;
+			}
+			close $f;
+			$cmd =3D~ s/^git-//;
+			print "\t{\"$cmd\", N_(\"$s\"), $grp{$t}},\n";
+			last;
+		}
+	}
+}
+
+print "};\n";
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
deleted file mode 100755
index 9a4c9b9..0000000
--- a/generate-cmdlist.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-
-echo "/* Automatically generated by $0 */
-struct cmdname_help {
-    char name[16];
-    char help[80];
-};
-
-static struct cmdname_help common_cmds[] =3D {"
-
-sed -n -e 's/^git-\([^ 	]*\)[ 	].* common.*/\1/p' command-list.txt |
-sort |
-while read cmd
-do
-     sed -n '
-     /^NAME/,/git-'"$cmd"'/H
-     ${
-	    x
-	    s/.*git-'"$cmd"' - \(.*\)/  {"'"$cmd"'", N_("\1")},/
-	    p
-     }' "Documentation/git-$cmd.txt"
-done
-echo "};"
--=20
2.4.0.GIT
