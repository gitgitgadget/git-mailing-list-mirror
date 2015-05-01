From: =?UTF-8?B?U8OpYmFzdGllbiBHdWltbWFyYQ==?= 
	<sebastien.guimmara@gmail.com>
Subject: Re: [PATCH 2/2] git help: group common commands by theme
Date: Fri, 01 May 2015 17:12:24 +0200
Message-ID: <554397D8.7020803@gmail.com>
References: <554392E2.8000206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 01 17:12:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoCcG-0000Ki-Vs
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 17:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753795AbbEAPMc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 11:12:32 -0400
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35363 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbbEAPMb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 11:12:31 -0400
Received: by wgyo15 with SMTP id o15so93275119wgy.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 08:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=1e1Mbsz0PGh7/AWG16+rnA04nEK7BQS6FtZxPIDBAr8=;
        b=K0wAkUj+dTjwMJkxYMKcspTMSEIRQb3zoniWwBmWSZMQTKEhxT9T5ARSnY+9SRszgG
         lxbAx5bhCxvVlnPpQ5Q7zyHaosKOAPti1aMI+T82N1s7txn2N+4FW1NIRpsL36kVWssH
         MsxD0gCFyhOLUVBPFxfjHkhR1NvU5umBQxWzyx3QbXY8TlkN37UzwIjkMRzIaaFYlQW8
         /+5wHJgTiwSf+Kgl0JJkFcs9xgkZ7G5ilU/uca9RzXdAupsw7pfjO2hmxyOIZH71tBnm
         cIwX4vPea5hdkLp4z42xCDtZCFoIC7v02MMqaVzqHyHKMJgK0t7w8TW0dIoxcGyb99CT
         qSPg==
X-Received: by 10.180.20.14 with SMTP id j14mr15224170wie.45.1430493149216;
        Fri, 01 May 2015 08:12:29 -0700 (PDT)
Received: from [192.168.0.10] (bd231-1-88-176-208-17.fbx.proxad.net. [88.176.208.17])
        by mx.google.com with ESMTPSA id v3sm7094444wix.8.2015.05.01.08.12.25
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2015 08:12:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <554392E2.8000206@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268144>

Author: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
Date:   Fri May 1 16:35:41 2015 +0200

     help.c - teach list_common_cmds_help() to group common commands by=
=20
theme

     Until now, the output of list_common_cmds_help() was in=20
alphabetical order:

     [...]

     The most commonly used git commands are:
        add        Add file contents to the index
        bisect     Find by binary search the change that introduced a b=
ug
        branch     List, create, or delete branches
        checkout   Checkout a branch or paths to the working tree
        clone      Clone a repository into a new directory
        commit     Record changes to the repository

     [...]

     This is a bit confusing for a beginner.
     This patch changes the output this way:

     [...]

     The most commonly used git commands are:
        clone      Clone a repository into a new directory
        init       Create an empty Git repository or reinitialize an=20
existing one

        log        Show commit logs
        show       Show various types of objects
        status     Show the working tree status

        add        Add file contents to the index
        mv         Move or rename a file, a directory, or a symlink
        reset      Reset current HEAD to the specified state
        rm         Remove files from the working tree and from the inde=
x

     [...]

diff --git a/help.c b/help.c
index 2072a87..2169a59 100644
--- a/help.c
+++ b/help.c
@@ -218,17 +218,38 @@ void list_commands(unsigned int colopts,
      }
  }

+/* sort the command name struct by group name */
+int cmd_group_cmp(const void *elem1, const void *elem2)
+{
+    struct cmdname_help *cmd1 =3D (struct cmdname_help*) elem1;
+    struct cmdname_help *cmd2 =3D (struct cmdname_help*) elem2;
+
+    return strcmp(cmd1->group, cmd2->group);
+}
+
  void list_common_cmds_help(void)
  {
      int i, longest =3D 0;
+    char *current_grp =3D NULL;

      for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
          if (longest < strlen(common_cmds[i].name))
              longest =3D strlen(common_cmds[i].name);
      }

+    /* sort common commands by group (i.e, beginner's relevance) */
+    qsort(common_cmds, ARRAY_SIZE(common_cmds),
+        sizeof(struct cmdname_help), cmd_group_cmp);
+
      puts(_("The most commonly used git commands are:"));
      for (i =3D 0; i < ARRAY_SIZE(common_cmds); i++) {
+
+        /* skip a line each time we encounter a new command group */
+        if (current_grp !=3D NULL && strcmp(common_cmds[i].group,=20
current_grp))
+            printf("\n");
+
+        current_grp =3D common_cmds[i].group;
+
          printf("   %s   ", common_cmds[i].name);
          mput_char(' ', longest - strlen(common_cmds[i].name));
          puts(_(common_cmds[i].help));

S=C3=A9bastien


On 05/01/2015 04:51 PM, S=C3=A9bastien Guimmara wrote:
> Hello everyone,
>
> This is my first contribution to an open source project.
>
> I tackled the issue found here:
> https://git.wiki.kernel.org/index.php/SmallProjectsIdeas#improve_.22g=
it_help.22=20
>
>
> Namely, format the output of 'git help' so that
> the commands are grouped by theme.
>
> Author: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> Date:   Fri May 1 15:48:57 2015 +0200
>
>     command-list.txt - added command groups to common commands
>
>     groups are in the form: 'x_group',
>     where x is a number used to order (ascending)
>     commands in the displayed help.
>
>     example:  git-add        mainporcelain common-2_worktree
>
> diff --git a/command-list.txt b/command-list.txt
> index f1eae08..b0730a2 100644
> --- a/command-list.txt
> +++ b/command-list.txt
> @@ -1,29 +1,29 @@
>  # List of known git commands.
>  # command name                category [deprecated] [common]
> -git-add                                 mainporcelain common
> +git-add                                 mainporcelain common-3_workt=
ree
>  git-am                                  mainporcelain
>  git-annotate                            ancillaryinterrogators
>  git-apply                               plumbingmanipulators
>  git-archimport                          foreignscminterface
>  git-archive                             mainporcelain
> -git-bisect                              mainporcelain common
> +git-bisect                              mainporcelain common-7_searc=
h
>  git-blame                               ancillaryinterrogators
> -git-branch                              mainporcelain common
> +git-branch                              mainporcelain common-6_branc=
hing
>  git-bundle                              mainporcelain
>  git-cat-file                            plumbinginterrogators
>  git-check-attr                          purehelpers
>  git-check-ignore                        purehelpers
>  git-check-mailmap                       purehelpers
> -git-checkout                            mainporcelain common
> +git-checkout                            mainporcelain common-6_branc=
hing
>  git-checkout-index                      plumbingmanipulators
>  git-check-ref-format                    purehelpers
>  git-cherry                              ancillaryinterrogators
>  git-cherry-pick                         mainporcelain
>  git-citool                              mainporcelain
>  git-clean                               mainporcelain
> -git-clone                               mainporcelain common
> +git-clone                               mainporcelain common-1_init
>  git-column                              purehelpers
> -git-commit                              mainporcelain common
> +git-commit                              mainporcelain common-5_histo=
ry
>  git-commit-tree                         plumbingmanipulators
>  git-config                              ancillarymanipulators
>  git-count-objects                       ancillaryinterrogators
> @@ -35,14 +35,14 @@ git-cvsimport foreignscminterface
>  git-cvsserver                           foreignscminterface
>  git-daemon                              synchingrepositories
>  git-describe                            mainporcelain
> -git-diff                                mainporcelain common
> +git-diff                                mainporcelain common-5_histo=
ry
>  git-diff-files                          plumbinginterrogators
>  git-diff-index                          plumbinginterrogators
>  git-diff-tree                           plumbinginterrogators
>  git-difftool                            ancillaryinterrogators
>  git-fast-export                ancillarymanipulators
>  git-fast-import                ancillarymanipulators
> -git-fetch                               mainporcelain common
> +git-fetch                               mainporcelain common-4_remot=
e
>  git-fetch-pack                          synchingrepositories
>  git-filter-branch                       ancillarymanipulators
>  git-fmt-merge-msg                       purehelpers
> @@ -51,7 +51,7 @@ git-format-patch mainporcelain
>  git-fsck                            ancillaryinterrogators
>  git-gc                                  mainporcelain
>  git-get-tar-commit-id                   ancillaryinterrogators
> -git-grep                                mainporcelain common
> +git-grep                                mainporcelain common-7_searc=
h
>  git-gui                                 mainporcelain
>  git-hash-object                         plumbingmanipulators
>  git-help                ancillaryinterrogators
> @@ -60,17 +60,17 @@ git-http-fetch synchelpers
>  git-http-push                           synchelpers
>  git-imap-send                           foreignscminterface
>  git-index-pack                          plumbingmanipulators
> -git-init                                mainporcelain common
> +git-init                                mainporcelain common-1_init
>  git-instaweb                            ancillaryinterrogators
>  git-interpret-trailers                  purehelpers
>  gitk                                    mainporcelain
> -git-log                                 mainporcelain common
> +git-log                                 mainporcelain common-2_info
>  git-ls-files                            plumbinginterrogators
>  git-ls-remote                           plumbinginterrogators
>  git-ls-tree                             plumbinginterrogators
>  git-mailinfo                            purehelpers
>  git-mailsplit                           purehelpers
> -git-merge                               mainporcelain common
> +git-merge                               mainporcelain common-6_branc=
hing
>  git-merge-base                          plumbinginterrogators
>  git-merge-file                          plumbingmanipulators
>  git-merge-index                         plumbingmanipulators
> @@ -79,7 +79,7 @@ git-mergetool ancillarymanipulators
>  git-merge-tree                          ancillaryinterrogators
>  git-mktag                               plumbingmanipulators
>  git-mktree                              plumbingmanipulators
> -git-mv                                  mainporcelain common
> +git-mv                                  mainporcelain common-3_workt=
ree
>  git-name-rev                            plumbinginterrogators
>  git-notes                               mainporcelain
>  git-p4                                  foreignscminterface
> @@ -90,11 +90,11 @@ git-parse-remote synchelpers
>  git-patch-id                            purehelpers
>  git-prune                               ancillarymanipulators
>  git-prune-packed                        plumbingmanipulators
> -git-pull                                mainporcelain common
> -git-push                                mainporcelain common
> +git-pull                                mainporcelain common-4_remot=
e
> +git-push                                mainporcelain common-4_remot=
e
>  git-quiltimport                         foreignscminterface
>  git-read-tree                           plumbingmanipulators
> -git-rebase                              mainporcelain common
> +git-rebase                              mainporcelain common-5_histo=
ry
>  git-receive-pack                        synchelpers
>  git-reflog                              ancillarymanipulators
>  git-relink                              ancillarymanipulators
> @@ -103,28 +103,28 @@ git-repack ancillarymanipulators
>  git-replace                             ancillarymanipulators
>  git-request-pull                        foreignscminterface
>  git-rerere                              ancillaryinterrogators
> -git-reset                               mainporcelain common
> +git-reset                               mainporcelain common-3_workt=
ree
>  git-revert                              mainporcelain
>  git-rev-list                            plumbinginterrogators
>  git-rev-parse                           ancillaryinterrogators
> -git-rm                                  mainporcelain common
> +git-rm                                  mainporcelain common-3_workt=
ree
>  git-send-email                          foreignscminterface
>  git-send-pack                           synchingrepositories
>  git-shell                               synchelpers
>  git-shortlog                            mainporcelain
> -git-show                                mainporcelain common
> +git-show                                mainporcelain common-2_info
>  git-show-branch                         ancillaryinterrogators
>  git-show-index                          plumbinginterrogators
>  git-show-ref                            plumbinginterrogators
>  git-sh-i18n                             purehelpers
>  git-sh-setup                            purehelpers
>  git-stash                               mainporcelain
> -git-status                              mainporcelain common
> +git-status                              mainporcelain common-2_info
>  git-stripspace                          purehelpers
>  git-submodule                           mainporcelain
>  git-svn                                 foreignscminterface
>  git-symbolic-ref                        plumbingmanipulators
> -git-tag                                 mainporcelain common
> +git-tag                                 mainporcelain common-5_histo=
ry
>  git-unpack-file                         plumbinginterrogators
>  git-unpack-objects                      plumbingmanipulators
>  git-update-index                        plumbingmanipulators
>
