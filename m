From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: git cherry unkillable
Date: Sun, 22 Jan 2006 18:21:53 +0300
Message-ID: <200601221821.54461.arvidjaar@mail.ru>
References: <200601221323.33377.arvidjaar@mail.ru> <BAYC1-PASMTP10435A067270A659801A48AE110@CEZ.ICE> <BAYC1-PASMTP123903F6C83FFE0EDA6284AE110@CEZ.ICE>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, zsh-workers@sunsite.dk
X-From: git-owner@vger.kernel.org Sun Jan 22 16:22:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0h2g-0007qJ-F9
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 16:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAVPV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 10:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWAVPV6
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 10:21:58 -0500
Received: from mx3.mail.ru ([194.67.23.149]:9798 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S932197AbWAVPV5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 10:21:57 -0500
Received: from [83.237.106.88] (port=55289 helo=cooker.home.net)
	by mx3.mail.ru with asmtp 
	id 1F0h2R-000Kz3-00; Sun, 22 Jan 2006 18:21:56 +0300
To: sean <seanlkml@sympatico.ca>
User-Agent: KMail/1.9.1
In-Reply-To: <BAYC1-PASMTP123903F6C83FFE0EDA6284AE110@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15052>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 22 January 2006 17:51, sean wrote:
> On Sun, 22 Jan 2006 06:39:04 -0500
>
> sean <seanlkml@sympatico.ca> wrote:
> > The attached patch works for me but i'm concerned about it a bit.
>
> Below is a better version that doesn't obscure the proper exit value in the
> normal case and exits with 1 if interrupted by the user.   It also ensures
> that the cleanup isn't executed twice when the script is interrupted.
>
> However, for Bash (at least) none of this is necessary; all the traps could
> just be changed to only trap 0 and the cleanup will be executed for all
> cases.   However, I don't know how compatible that is with other shells.  
> If other shells behave the same, the best fix is just to strip the 1,2,3
> and 15 from each of the existing trap lines and not bother with the patch
> given below.
>

this patch fails on zsh; trap 0 never executed after signal (SIGINT to be 
sure) is caught:

#!/bin/zsh

trap "exit 0" 1 2 3 15
trap "echo  exiting" 0

sleep 100000000

{pts/0}% /tmp/timout.zsh ^C
{pts/0}% 

- -andrey

> Sean
>
>
> diff --git a/git-cherry.sh b/git-cherry.sh
> index 1a62320..0b2ef1f 100755
> --- a/git-cherry.sh
> +++ b/git-cherry.sh
> @@ -49,7 +49,8 @@ ours=`git-rev-list $ours ^$limit` || exi
>  tmp=.cherry-tmp$$
>  patch=$tmp-patch
>  mkdir $patch
> -trap "rm -rf $tmp-*" 0 1 2 3 15
> +trap "rm -rf $tmp-*" 0
> +trap "exit 1" 1 2 3 15
>
>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> diff --git a/git-format-patch.sh b/git-format-patch.sh
> index 7e67c4e..6ba6339 100755
> --- a/git-format-patch.sh
> +++ b/git-format-patch.sh
> @@ -77,7 +77,8 @@ tt)
>  esac
>
>  tmp=.tmp-series$$
> -trap 'rm -f $tmp-*' 0 1 2 3 15
> +trap "rm -f $tmp-*" 0
> +trap "exit 1" 1 2 3 15
>
>  series=$tmp-series
>  commsg=$tmp-commsg
> diff --git a/git-ls-remote.sh b/git-ls-remote.sh
> index f699268..7dc224b 100755
> --- a/git-ls-remote.sh
> +++ b/git-ls-remote.sh
> @@ -38,7 +38,8 @@ peek_repo="$(get_remote_url "$@")"
>  shift
>
>  tmp=.ls-remote-$$
> -trap "rm -fr $tmp-*" 0 1 2 3 15
> +trap "rm -rf $tmp-*" 0
> +trap "exit 1" 1 2 3 15
>  tmpdir=$tmp-d
>
>  case "$peek_repo" in
> diff --git a/git-reset.sh b/git-reset.sh
> index 6c9e58a..166b635 100755
> --- a/git-reset.sh
> +++ b/git-reset.sh
> @@ -4,7 +4,8 @@ USAGE='[--mixed | --soft | --hard]  [<co
>  . git-sh-setup
>
>  tmp=${GIT_DIR}/reset.$$
> -trap 'rm -f $tmp-*' 0 1 2 3 15
> +trap "rm -f $tmp-*" 0
> +trap "exit 1" 1 2 3 15
>
>  reset_type=--mixed
>  case "$1" in
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD06MSR6LMutpd94wRApgAAJ0e0AUIS83XTa4BA1rEY1XriHKZmQCgnXZd
1sElZOLAgyuxgi3EHiaMGFc=
=xwjP
-----END PGP SIGNATURE-----
