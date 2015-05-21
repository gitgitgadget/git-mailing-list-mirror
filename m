From: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v10 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 15:13:09 +0200
Message-ID: <1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?S=C3=A9bastien=20Guimmara?= 
	<sebastien.guimmara@gmail.com>, gitster@pobox.com,
	sunshine@sunshineco.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 15:13:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvQI1-0001fi-PI
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 15:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbbEUNNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 May 2015 09:13:31 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:38222 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755892AbbEUNNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 09:13:25 -0400
Received: by wichy4 with SMTP id hy4so13452739wic.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 06:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nItNCoVF/lT71vJShqSMOC0MSOz1qE+sBZSgfLlTPGA=;
        b=V9t6lE68y6v9VRXx3jEeW4sU06r9ihYhOuv6jZLlOL3KBESXcTHAWbykWSda4q7qFr
         T2p6ZSTq4Up9aR6czRNapJgY7E3lzcR4JA0ojSV1TGQR7R1mN+26WrbfmbvcBXJ6tamZ
         oumGMpBv+Z93l1dhiKEl5KOmKDArkNHFtzV2KfDe1Mzv0MYOzvmEsyF0umMGL4YWpuJZ
         NDQq8m28Mvws1B2Wf6/5uXvDiOa1x7wJQvViy8LowK59Wq5cXHKOxSW3Lbc4Lu3Qd0P5
         iGM6+YmVzEjYmAzaP52tL7JRQtmHnRKuW8B3ccO67ZhW1yQ3QjdktPCQbBdyIHL4tJgN
         yI1A==
X-Received: by 10.194.242.195 with SMTP id ws3mr5304548wjc.155.1432214004701;
        Thu, 21 May 2015 06:13:24 -0700 (PDT)
Received: from localhost.localdomain (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id fb3sm2816361wib.21.2015.05.21.06.13.22
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 May 2015 06:13:23 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.GIT
In-Reply-To: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269589>

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

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize [...]

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   reset      Reset current HEAD to the specified state

examine the history and state (see also: git help revisions)
   log        Show commit logs
   status     Show the working tree status

   [...]

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
 help.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 2072a87..8f72051 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,39 @@ void list_commands(unsigned int colopts,
 	}
 }
=20
+static int cmd_group_cmp(const void *elem1, const void *elem2)
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
+	puts(_("These are common Git commands used in various situations:"));
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
