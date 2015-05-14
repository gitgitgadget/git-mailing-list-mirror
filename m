From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH 3/5] generate-cmdlist: parse common group commands
Date: Thu, 14 May 2015 14:59:08 +0200
Message-ID: <1431608351-9413-4-git-send-email-sebastien.guimmara@gmail.com>
References: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org, sunshine@sunshineco.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 14 15:00:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsskX-0007Na-VW
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbbENNAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2015 09:00:11 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33117 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964808AbbENNAH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:00:07 -0400
Received: by wgin8 with SMTP id n8so74753151wgi.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SuW3O9JevVIyrb8vpO3DF1wajKun84ugaA5juCOpPKc=;
        b=UQV6K0pdAjEb1ZdooLrbKzb8meI1prW8MeNm1M+uMdViR9RIO0tiTX3Mb2QTKti8Wt
         CiCC506mF+4sk1DXqHZdBqzJQcnVT4Ku89rEQSO+2O07p0WjzrqixMZO9dVrjCy/8v+G
         N+hbdYmgE5Fj/ODSawOFbTNBZySxPuQBNetuh2vLKcTsXOHqGMla6xIU3TXnWMF5RdP6
         FKvbRJqzIPGZ+sOmDU7i92JzjFtZf/+QXqvJ0B0B1kFqGl6WfcJSCQp7hqlbGkYkAB65
         RgR7/9RC5dIGZ/EbDZHMFO725L3WmVsQL8eTFvpqRjyPAy1NEm4c53wIBW+hA4EhsRq0
         tVtQ==
X-Received: by 10.180.83.6 with SMTP id m6mr48873732wiy.72.1431608405388;
        Thu, 14 May 2015 06:00:05 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id pj5sm32671676wjb.40.2015.05.14.06.00.03
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 06:00:04 -0700 (PDT)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1431608351-9413-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269033>

=46rom: Eric Sunshine <sunshine@sunshineco.com>

Parse the [common] block to create the array of group descriptions:

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

Only commands tagged with an attribute from [common] are emitted to
common_cmds[].

[commit message by S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.co=
m>]

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 Makefile             |  4 ++--
 generate-cmdlist.awk | 39 +++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh  | 23 -----------------------
 3 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 generate-cmdlist.awk
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 7c57369..286a68f 100644
--- a/Makefile
+++ b/Makefile
@@ -1687,10 +1687,10 @@ $(BUILT_INS): git$X
 	ln -s $< $@ 2>/dev/null || \
 	cp $< $@
=20
-common-cmds.h: ./generate-cmdlist.sh command-list.txt
+common-cmds.h: generate-cmdlist.awk command-list.txt
=20
 common-cmds.h: $(wildcard Documentation/git-*.txt)
-	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
+	$(QUIET_GEN)awk -f generate-cmdlist.awk command-list.txt > $@+ && mv =
$@+ $@
=20
 SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
 	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ)=
:\
diff --git a/generate-cmdlist.awk b/generate-cmdlist.awk
new file mode 100644
index 0000000..b5cc789
--- /dev/null
+++ b/generate-cmdlist.awk
@@ -0,0 +1,39 @@
+BEGIN {
+	print "/* Automatically generated by generate-cmdlist.awk */\n"
+	print "struct cmdname_help {"
+	print "\tchar name[16];"
+	print "\tchar help[80];"
+	print "\tunsigned char group;"
+	print "};\n"
+	print "static char *common_cmd_groups[] =3D {"
+}
+/^#/ || /^[ 	]*$/ { next }
+state =3D=3D 2 {
+	for (i =3D 2; i <=3D NF; i++)
+		if (grp[$i]) {
+			f =3D "Documentation/"$1".txt"
+			while (getline s <f > 0)
+				if (match(s, $1" - ")) {
+					t =3D substr(s, length($1" - ") + 1)
+					break
+				}
+			close(f)
+			printf "\t{\"%s\", N_(\"%s\"), %s},\n",
+				substr($1, length("git-") + 1), t, grp[$i] - 1
+			break
+		}
+}
+/\[commands\]/ {
+	print "};\n\nstatic struct cmdname_help common_cmds[] =3D {"
+	state =3D 2
+}
+state =3D=3D 1 {
+	grp[$1] =3D ++n
+	sub($1"[ 	][ 	]*", "")
+	printf "\tN_(\"%s\"),\n", $0
+	next
+}
+/\[common\]/ {
+	state =3D 1
+}
+END { print "};" }
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
2.4.0
