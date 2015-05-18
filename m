From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v8 3/5] generate-cmdlist: parse common group commands
Date: Mon, 18 May 2015 21:18:15 +0200
Message-ID: <1431976697-26288-4-git-send-email-sebastien.guimmara@gmail.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 21:18:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQYg-0000zF-Q5
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbbERTSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 15:18:30 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34093 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754714AbbERTS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:18:26 -0400
Received: by wguv19 with SMTP id v19so138722015wgu.1
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/Lo+89JuwSXJzKbfnFGJfykJSYIEyOeSgPvKn/49tqI=;
        b=MuwvluWlm+k3Y42E0BZpQob/ppqNhVtVIPI3tSvpVc86t58YByGTmzuEJO66LEIB5K
         yM6tYn/cXy7UdzzkSxQGu77mwVxXPSAvpqTD/psS3BhOgPwMIzi5xM9Zt4CxdMbO/en4
         oXVI+zRC1UTQV2QvhSbKb14jf1YTcD3ieaKxT1V2oM2L/p9Z379fDFiHhhhsOFxBYDYX
         PQa/gpDv8cNdjGs14GMyHTOvKPPV4d6VXYrLLoovJTncwrWVm8ouSjb3nmLq23jm4JOu
         EUczoEprU4KL0j5nB/B/gZAlBt1sof2kKm595G7/qRg2tj2yfZp8bo8FGifvKHKqNvMB
         kIcQ==
X-Received: by 10.180.104.197 with SMTP id gg5mr25006500wib.27.1431976705189;
        Mon, 18 May 2015 12:18:25 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id z12sm18259450wjq.12.2015.05.18.12.18.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 12:18:24 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269307>

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
 Makefile             |  4 ++--
 generate-cmdlist.awk | 39 +++++++++++++++++++++++++++++++++++++++
 generate-cmdlist.sh  | 23 -----------------------
 3 files changed, 41 insertions(+), 25 deletions(-)
 create mode 100644 generate-cmdlist.awk
 delete mode 100755 generate-cmdlist.sh

diff --git a/Makefile b/Makefile
index 5ed0acf..9da8687 100644
--- a/Makefile
+++ b/Makefile
@@ -1693,10 +1693,10 @@ $(BUILT_INS): git$X
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
index 0000000..dbf1e6b
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
+/### common groups/ {
+	state =3D 1
+}
+/### command list/ {
+	print "};\n\nstatic struct cmdname_help common_cmds[] =3D {"
+	state =3D 2
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
+state =3D=3D 1 {
+	grp[$1] =3D ++n
+	sub($1"[ 	][ 	]*", "")
+	printf "\tN_(\"%s\"),\n", $0
+}
+
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
2.4.0.GIT
