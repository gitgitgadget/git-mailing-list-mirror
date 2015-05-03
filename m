From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: [PATCH v3 3/4] help.c - group common commands by theme
Date: Sun, 03 May 2015 02:23:45 +0200
Message-ID: <55456A91.3040408@gmail.com>
References: <554405D5.9080702@gmail.com> <55456990.6000509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 03 02:23:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YohhJ-0000oX-Nk
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 02:23:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbbECAXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 May 2015 20:23:50 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38227 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbbECAXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 20:23:49 -0400
Received: by wiun10 with SMTP id n10so78462176wiu.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 17:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=jwi1K+AiRl1DOHW20L5wl9dfFyz1igtdSNo5Hz33zKs=;
        b=Y0X/QXc1AK4bOpZaBD8OXFsbd/7Q6sDUE+awSIl9h358x1lurLYw0nm94ngQkzWiBq
         gFyDZeR61zZZztLtatYbQVS2rKOYhE4vzT6aB//+u1aB4Gpy0K0PZpyglrJAjWuJ3y43
         lWvERwYi8kCHE/xNioy4ZqdiqHi+ZATuAEzkVs7+IQI2tg1EnYDi6K4UM+IXlHCV+14p
         Z/Wj7xcNSn+bBw05TOZfZrbYgtEvfpVFluL3Id3luLaIbuTvcPLoshJTCmP3xY9LT9Ti
         +Va6VHjFGIXWwedufRHtwN0MutMTtwEXns1sy9pEhA1sBEOu57fkjQIuBbpy+8CrK8Kl
         hwTA==
X-Received: by 10.194.7.97 with SMTP id i1mr30026599wja.107.1430612627849;
        Sat, 02 May 2015 17:23:47 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id ex5sm4416715wib.2.2015.05.02.17.23.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 May 2015 17:23:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <55456990.6000509@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268244>

When 'git help' is called, a list of common commands are printed:

The most commonly used git commands are:
    add        Add file contents to the index
    bisect     Find by binary search the change that introduced a bug
    branch     List, create, or delete branches
    checkout   Checkout a branch or paths to the working tree
    clone      Clone a repository into a new directory
    commit     Record changes to the repository
    [...]

Instead of a less than optimal alphabetical order, print those
commands in theme-related groups:

The most commonly used git commands are:
    clone      Clone a repository into a new directory
    init       Create an empty Git repository or reinitialize an existi=
ng one

    log        Show commit logs
    show       Show various types of objects
    status     Show the working tree status

    add        Add file contents to the index
    mv         Move or rename a file, a directory, or a symlink
    reset      Reset current HEAD to the specified state
    rm         Remove files from the working tree and from the index
    [...]

To achieve this, qsort the common_cmds array by group name,
then print those common commands, skipping a line between each group.

Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
---
  help.c | 21 +++++++++++++++++++++
  1 file changed, 21 insertions(+)

diff --git a/help.c b/help.c
index 2072a87..2169a59 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,38 @@ void list_commands(unsigned int colopts,
  	}
  }
 =20
+/* sort the command name struct by group name */
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+	struct cmdname_help *cmd1 =3D (struct cmdname_help*) elem1;
+	struct cmdname_help *cmd2 =3D (struct cmdname_help*) elem2;
+
+	return strcmp(cmd1->group, cmd2->group);
+}
+
  void list_common_cmds_help(void)
  {
  	int i, longest =3D 0;
+	char *current_grp =3D NULL;
 =20
  	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
  		if (longest < strlen(common_cmds[i].name))
  			longest =3D strlen(common_cmds[i].name);
  	}
 =20
+	/* sort common commands by group (i.e, beginner's relevance) */
+	qsort(common_cmds, ARRAY_SIZE(common_cmds),
+		sizeof(struct cmdname_help), cmd_group_cmp);
+
  	puts(_("The most commonly used git commands are:"));
  	for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+
+		/* skip a line each time we encounter a new command group */
+		if (current_grp !=3D NULL && strcmp(common_cmds[i].group, current_gr=
p))
+			printf("\n");
+
+		current_grp =3D common_cmds[i].group;
+
  		printf("   %s   ", common_cmds[i].name);
  		mput_char(' ', longest - strlen(common_cmds[i].name));
  		puts(_(common_cmds[i].help));
--=20
2.4.0
