From: Avishay Lavie <avishay.lavie@gmail.com>
Subject: RE: [PATCH] git-svn: support rebase --preserve-merges
Date: Tue, 15 May 2012 15:09:18 +0300
Message-ID: <CAHkK2boS2ffnz+vz1jRqKHy1vQcrcd6FHEdWgY-btHZaCapdkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Eric Wong <normalperson@yhbt.net>, avarab@gmail.com,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 15 14:09:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUGZV-00045c-BL
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 14:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab2EOMJl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 May 2012 08:09:41 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:53432 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074Ab2EOMJk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 May 2012 08:09:40 -0400
Received: by weyu7 with SMTP id u7so2429027wey.19
        for <git@vger.kernel.org>; Tue, 15 May 2012 05:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        bh=zs6AxxPfLntchYFteCOMgjNbSluPQuFRnzlBaNzuq6w=;
        b=DKYZQBnP5OkRQYs270PagIpjFE/GIqUsZylEjn+MUsnsYyxFNOv6lhbqWavD02ZnHf
         0qSkhfm1JMiYuSelKxwJg80ASGEblfH1M1aQhVo1P8HuyD8mwSpia05fZtr4GRacPeAJ
         oHWcUI9M2gk/o3UbbEdcmo88sPmWXbV/MdqALtjji2vRB/DVDwgunISVM+FUynvtha37
         sXWsDoAEtECogyJDJPYvHRu33T0LcEAY9Z2C85XiLCPaMTm3NG1aZev7qZXJWnMIrYRM
         UNA+KwFBygKZ2s5NnSOoVsAsje0/5jVr8rXcC4TyIx/nZTG6AXay7EIvUocZ54AQQ8+Q
         JEUQ==
Received: by 10.216.133.139 with SMTP id q11mr7606445wei.44.1337083779033;
 Tue, 15 May 2012 05:09:39 -0700 (PDT)
Received: by 10.216.187.204 with HTTP; Tue, 15 May 2012 05:09:18 -0700 (PDT)
X-Google-Sender-Auth: x9lHRGWf6daPcussxk5oE0nxsKM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197829>

(Adding previous authors of git-svn.perl)

---------- Forwarded message ----------
=46rom: Avishay Lavie <avishay.lavie@gmail.com>
Date: Tue, May 15, 2012 at 12:09 PM
Subject: PATCH: git-svn: support rebase --preserve-merges
To: git@vger.kernel.org


=46rom: Avishay Lavie <avishay.lavie@gmail.com>
Date: Tue, 15 May 2012 11:45:50 +0300
Subject: [PATCH] git-svn: support rebase --preserve-merges

When git svn rebase is performed after an unpushed merge, the
rebase operation follows both parents and replays both the user's
local commits and those from the merged branch. This is usually
not the intended behavior.
This patch adds support for the --preserve-merges/-p flag which
allows for a better workflow by re-applying merge commits as merges.

Signed-off-by: Avishay Lavie <avishay.lavie@gmail.com>
---
=C2=A0Documentation/git-svn.txt | =C2=A0 =C2=A02 ++
=C2=A0git-svn.perl =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=
=A0 =C2=A04 +++-
=C2=A02 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..0d52997 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -572,6 +572,8 @@ config key: svn.repackflags
=C2=A0--merge::
=C2=A0-s<strategy>::
=C2=A0--strategy=3D<strategy>::
+-p::
+--preserve-merges::
=C2=A0 =C2=A0 =C2=A0 =C2=A0These are only used with the 'dcommit' and '=
rebase' commands.
=C2=A0+
=C2=A0Passed directly to 'git rebase' when using 'dcommit' if a
diff --git a/git-svn.perl b/git-svn.perl
index ca038ec..e86d60b 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -84,7 +84,7 @@ my ($_stdin, $_help, $_edit,
=C2=A0 =C2=A0 =C2=A0 =C2=A0$_message, $_file, $_branch_dest,
=C2=A0 =C2=A0 =C2=A0 =C2=A0$_template, $_shared,
=C2=A0 =C2=A0 =C2=A0 =C2=A0$_version, $_fetch_all, $_no_rebase, $_fetch=
_parent,
- =C2=A0 =C2=A0 =C2=A0 $_merge, $_strategy, $_dry_run, $_local,
+ =C2=A0 =C2=A0 =C2=A0 $_merge, $_strategy, $_preserve_merges, $_dry_ru=
n, $_local,
=C2=A0 =C2=A0 =C2=A0 =C2=A0$_prefix, $_no_checkout, $_url, $_verbose,
=C2=A0 =C2=A0 =C2=A0 =C2=A0$_git_format, $_commit_url, $_tag, $_merge_i=
nfo, $_interactive);
=C2=A0$Git::SVN::_follow_parent =3D 1;
@@ -233,6 +233,7 @@ my %cmd =3D (
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0'local|l' =3D> \$_local,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0'fetch-all|all' =3D> \$_fetch_all,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0'dry-run|n' =3D> \$_dry_run,
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 'preserve-merges|p' =3D> \$_preserve_merges
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0%fc_opts } ],
=C2=A0 =C2=A0 =C2=A0 =C2=A0'commit-diff' =3D> [ \&cmd_commit_diff,
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 'Commit a diff between two trees',
@@ -1570,6 +1571,7 @@ sub rebase_cmd {
=C2=A0 =C2=A0 =C2=A0 =C2=A0push @cmd, '-v' if $_verbose;
=C2=A0 =C2=A0 =C2=A0 =C2=A0push @cmd, qw/--merge/ if $_merge;
=C2=A0 =C2=A0 =C2=A0 =C2=A0push @cmd, "--strategy=3D$_strategy" if $_st=
rategy;
+ =C2=A0 =C2=A0 =C2=A0 push @cmd, "--preserve-merges" if $_preserve_mer=
ges;
=C2=A0 =C2=A0 =C2=A0 =C2=A0@cmd;
=C2=A0}

--
1.7.9.msysgit.0
