From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v8 5/5] help: respect new common command grouping
Date: Mon, 18 May 2015 21:18:17 +0200
Message-ID: <1431976697-26288-6-git-send-email-sebastien.guimmara@gmail.com>
References: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sunshine@sunshineco.com,
	=?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 18 21:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuQYh-0000zF-Fr
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbbERTSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2015 15:18:34 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37651 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbbERTS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 15:18:29 -0400
Received: by wibt6 with SMTP id t6so80474649wib.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 12:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=aj9k8yldrIL1/ABHjFt6svo1cSzFCc0jeU7Aak2xnO8=;
        b=b17l0ZmoqaSden6tFqN2GNQrLqMLtggi/9aH0BOCbDzvMNco4BOv8Sb1FWsjFeeX6b
         WEI/lOY3P8Dj3CoLKItNoIEjfEveqli1L1j0UWaanMT2qJ47ZyzCUQjdIFsxWvjHMKjl
         zYXKvNHuG37lyyauJV0ETiNtxhdvm6Szv7ONIXBj3RbEPlGFX0mxHmpxWdTOeCcKmMn/
         33Virzraac/7vms7amLLDMW5HM+cRp7dKxGcy8v6F1CS7gxF7hiWQt+DsXsZg+4EOd2V
         VxI6dHgpWD6ZmRjzqRwuDurtm0jqr8cRz56LtHDI6Q5RBJpYB2ycli8TyTwzBm7UqG6I
         UkbQ==
X-Received: by 10.194.249.40 with SMTP id yr8mr34005714wjc.21.1431976708480;
        Mon, 18 May 2015 12:18:28 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id z12sm18259450wjq.12.2015.05.18.12.18.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 May 2015 12:18:27 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1431976697-26288-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269308>

'git help' shows common commands in alphabetical order:

The most commonly used git commands are:
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   [...]

without any indication of how commands relate to high-level
concepts or each other. Revise the output to explain their relationship
with the typical Git workflow:

The typical Git workflow includes:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize [...]

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   log        Show commit logs
   status     Show the working tree status

   [...]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 2072a87..71027b7 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+	const struct cmdname_help *e1 =3D elem1;
+	const struct cmdname_help *e2 =3D elem2;
+
+	if (e1->group < e2->group)
+		return -1;
+	if (e1->group > e2->group)
+		return 1;
+	return strcmp(e1->name, e2->name);
+}
+
 void list_common_cmds_help(void)
 {
 	int i, longest =3D 0;
+	int current_grp =3D -1;
=20
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
 		if (longest < strlen(common_cmds[i].name))
 			longest =3D strlen(common_cmds[i].name);
 	}
=20
-	puts(_("The most commonly used git commands are:"));
+	qsort(common_cmds, ARRAY_SIZE(common_cmds),
+		sizeof(common_cmds[0]), cmd_group_cmp);
+
+	puts(_("The typical Git workflow includes:"));
+
 	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+		if (common_cmds[i].group !=3D current_grp) {
+			printf("\n%s\n", _(common_cmd_groups[common_cmds[i].group]));
+			current_grp =3D common_cmds[i].group;
+		}
+
 		printf("   %s   ", common_cmds[i].name);
 		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(_(common_cmds[i].help));
--=20
2.4.0.GIT
