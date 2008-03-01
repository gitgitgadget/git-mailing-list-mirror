From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] git-submodule: New subcommand 'summary' (2) -
 hard work
Date: Fri, 29 Feb 2008 23:29:20 -0800
Message-ID: <7vabli7vhr.fsf@gitster.siamese.dyndns.org>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
 <d6e82710452985611fb75c9d32a1b772bf0cb529.1204306070.git.pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 08:30:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVMAd-0002nV-EJ
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 08:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbYCAH33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 02:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753075AbYCAH33
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 02:29:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40049 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752785AbYCAH33 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 02:29:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C0A362256;
	Sat,  1 Mar 2008 02:29:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 0BDF12254; Sat,  1 Mar 2008 02:29:22 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75628>

Ping Yin <pkufranky@gmail.com> writes:

> This patch does the hard work of submodule summary and finally gives
> output shown in last patch.
>
> Signed-off-by: Ping Yin <pkufranky@gmail.com>
> ---
>  git-submodule.sh |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 69 insertions(+), 1 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index 8009a8d..8322771 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -380,7 +380,75 @@ cmd_summary()
>  	# TODO: quote module names containing space or tab
>  	test -n "$modules" &&
>  	echo "# Submodules modified: "$modules &&
> -	echo "#"
> +	echo "#" &&
> +	git diff $cache_option --raw $head -- $modules |
> +	grep '^:160000\|:[0-9]\+ 160000' |
> +	cut -c2- |

Same issues as before.  It might be worthwhile to write this part all in
Perl, I suspect...

> +	while read mod_src mod_dst sha1_src sha1_dst status name
> +	do
> +		sha1_src=$(echo $sha1_src | sed -e 's/\.\.\.//')
> +		sha1_dst=$(echo $sha1_dst | sed -e 's/\.\.\.//')

This is unneeded if you used the right tool, i.e. diff-index.

> +		check_src=$(echo $mod_src | grep 160000)
> +		check_dst=$(echo $mod_dst | grep 160000)

Huh?  Do you mean "test $mod_src = ':160000'" and such?

> +		errmsg=
> +		unfound_src=
> +		unfound_dst=

Perhaps "missing" is a better word.

> +		test -z "$check_src" ||
> +		GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 ||
> +		unfound_src=t

You do not want to do ^0; you will not be bind a non-commit in gitlink
entry anyway.
