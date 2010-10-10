From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: Support the DWIM mode for git checkout
Date: Sun, 10 Oct 2010 23:16:34 +0200
Message-ID: <20101010211634.GA4730@neumann>
References: <1286496492-65221-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun Oct 10 23:16:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P53G8-0001C0-LF
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751595Ab0JJVQi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Oct 2010 17:16:38 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55990 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab0JJVQh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 17:16:37 -0400
Received: from [127.0.1.1] (p5B130D54.dip0.t-ipconnect.de [91.19.13.84])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MAihL-1Oy8Qi38TT-00BNHV; Sun, 10 Oct 2010 23:16:36 +0200
Content-Disposition: inline
In-Reply-To: <1286496492-65221-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V02:K0:EPelXtWu328mZIGhnnbPUA8i7qdm4twKR1xxX57OnQS
 pvo53hWurq77noJmtlx6Jn6jgwHcha9jWcmAZDBOYOM4LXGQLL
 Akp3V65O8gOAVVJP6BxbISx8stfsjW+yxWbauNBD9brKdDDVhF
 t03/4GNydwpo+f9dLDPBzKpLGiYDyXu6PxuVgO2uA4p7DYeBID
 8KrWhIRBa81rMG5esfqHQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158708>

Hi,


On Thu, Oct 07, 2010 at 05:08:12PM -0700, Kevin Ballard wrote:
> Signed-off-by: Kevin Ballard <kevin@sb.org>
> ---

I think the commit message should add some details about how the patch
changes the completion script's behavior.  At least I didn't know
offhand what "DWIM mode for git checkout" is, and once I found it
(70c9ac2 (DWIM "git checkout frotz" to "git checkout -b frotz
origin/frotz", 2009-10-18), right?), I didn't know how the completion
script is supposed to support that, and once I applied the patch and
played around a bit, I was surprised that only 'git checkout h<tab>'
includes the 'html' branch but 'git checkout <tab>' don't.


>  contrib/completion/git-completion.bash |   35 ++++++++++++++++++++++=
+++++++--
>  1 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/contrib/completion/git-completion.bash b/contrib/complet=
ion/git-completion.bash
> index f83f019..be0498c 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash


> @@ -988,7 +1007,17 @@ _git_checkout ()
>  			"
>  		;;
>  	*)
> -		__gitcomp "$(__git_refs)"
> +		# check if --track, --no-track, or --no-guess was specified
> +		# if so, disable DWIM mode
> +		local i c=3D1 track=3D1
> +		while [ $c -lt $COMP_CWORD ]; do
> +			i=3D"${COMP_WORDS[c]}"
> +			case "$i" in
> +			--track|--no-track|--no-guess) track=3D''; break ;;
> +			esac
> +			c=3D$((++c))
> +		done
> +		__gitcomp "$(__git_refs '' $track)"

You could use the __git_find_on_cmdline() helper function instead.


Best,
G=E1bor
