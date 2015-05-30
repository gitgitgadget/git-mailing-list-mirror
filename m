From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/2] completion: Add sequencer function
Date: Sat, 30 May 2015 21:01:03 +0200
Message-ID: <20150530210103.Horde.YoJthfdQJy5oq9wT_oOl3Q1@webmail.informatik.kit.edu>
References: <CALkWK0m9Fj_3AnJcENL-kAFSbYjW4fKpN76Tftrt672hQj4qww@mail.gmail.com>
 <1433001710.5113.8.camel@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Sat May 30 21:01:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yym0v-0007Pv-GI
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 21:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045AbbE3TBc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 May 2015 15:01:32 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:58440 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755620AbbE3TBb convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 15:01:31 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1Yym0d-000746-8u; Sat, 30 May 2015 21:01:27 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1Yym0F-0004ZE-2E; Sat, 30 May 2015 21:01:03 +0200
Received: from x590d914b.dyn.telefonica.de (x590d914b.dyn.telefonica.de
 [89.13.145.75]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 30 May 2015 21:01:03 +0200
In-Reply-To: <1433001710.5113.8.camel@virtuell-zuhause.de>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1433012487.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270302>


Quoting Thomas Braun <thomas.braun@virtuell-zuhause.de>:

> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  contrib/completion/git-completion.bash | 48 =20
> +++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 15 deletions(-)

I don't see the benefits of this change.  This patch adds more than =20
twice as many lines as it removes, and patch 2/2 adds 8 new lines =20
although it could get away with only 5 without this function.  To =20
offer sequencer options we currently go through a single if statement, =
=20
with this patch we'd go through a case statement, an if statement and =20
finally an &&.

G=C3=A1bor


> diff --git a/contrib/completion/git-completion.bash =20
> b/contrib/completion/git-completion.bash
> index bfc74e9..f6e5bf6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -851,15 +851,40 @@ __git_count_arguments ()
>  	printf "%d" $c
>  }
>
> +__git_complete_sequencer ()
> +{
> +	local dir=3D"$(__gitdir)"
> +
> +	case "$1" in
> +	am)
> +		if [ -d "$dir"/rebase-apply ]; then
> +			__gitcomp "--skip --continue --resolved --abort"
> +			return 0
> +		fi
> +		;;
> +	cherry-pick)
> +		if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
> +			__gitcomp "--continue --quit --abort"
> +			return 0
> +		fi
> +		;;
> +	rebase)
> +		if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
> +			__gitcomp "--continue --skip --abort"
> +			return 0
> +		fi
> +		;;
> +	esac
> +
> +	return 1
> +}
> +
>  __git_whitespacelist=3D"nowarn warn error error-all fix"
>
>  _git_am ()
>  {
> -	local dir=3D"$(__gitdir)"
> -	if [ -d "$dir"/rebase-apply ]; then
> -		__gitcomp "--skip --continue --resolved --abort"
> -		return
> -	fi
> +	__git_complete_sequencer "am" && return
> +
>  	case "$cur" in
>  	--whitespace=3D*)
>  		__gitcomp "$__git_whitespacelist" "" "${cur##--whitespace=3D}"
> @@ -1044,11 +1069,8 @@ _git_cherry ()
>
>  _git_cherry_pick ()
>  {
> -	local dir=3D"$(__gitdir)"
> -	if [ -f "$dir"/CHERRY_PICK_HEAD ]; then
> -		__gitcomp "--continue --quit --abort"
> -		return
> -	fi
> +	__git_complete_sequencer "cherry-pick" && return
> +
>  	case "$cur" in
>  	--*)
>  		__gitcomp "--edit --no-commit --signoff --strategy=3D --mainline"
> @@ -1666,11 +1688,7 @@ _git_push ()
>
>  _git_rebase ()
>  {
> -	local dir=3D"$(__gitdir)"
> -	if [ -d "$dir"/rebase-apply ] || [ -d "$dir"/rebase-merge ]; then
> -		__gitcomp "--continue --skip --abort"
> -		return
> -	fi
> +	__git_complete_sequencer "rebase" && return
>  	__git_complete_strategy && return
>  	case "$cur" in
>  	--whitespace=3D*)
