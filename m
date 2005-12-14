From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-am --one
Date: Tue, 13 Dec 2005 17:30:59 -0800
Message-ID: <7vy82o5uss.fsf@assigned-by-dhcp.cox.net>
References: <439F7105.9050302@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 14 02:33:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EmLU1-0004Os-T5
	for gcvg-git@gmane.org; Wed, 14 Dec 2005 02:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030347AbVLNBbC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Dec 2005 20:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVLNBbC
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Dec 2005 20:31:02 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:35018 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030347AbVLNBbA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2005 20:31:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051214012936.YMP17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 13 Dec 2005 20:29:36 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <439F7105.9050302@zytor.com> (H. Peter Anvin's message of "Tue,
	13 Dec 2005 17:10:29 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13610>

"H. Peter Anvin" <hpa@zytor.com> writes:

> This patch adds the --one (-o) option to git-am, to apply a single 
> message in RFC 2822 format, as opposed to an mbox.  With some MUAs it's 
> a lot easier to save individual messages than with mboxes, and either 
> way the user may want to control the ordering if there are known 
> interdependencies.

> +	# standard input.  To prepend the header, we thus want a
> +	# second cat, sigh...
> +	if test "$one" = t
> +	then
> +		LANG=C date +'From - %a %b %d %T %Y' > "$dotest"/fakefrom
> +		fakefrom="$dotest"/fakefrom
> +	else
> +		fakefrom=/dev/null
> +	fi
> +	cat "$@" | cat "$fakefrom" - |
>  	git-mailsplit -d$prec "$dotest/" >"$dotest/last" || {
>  		rm -fr "$dotest"
>  		exit 1

I understand the motivation, but I suspect skipping mailsplit
might be simpler, like this untested code perhaps?

	case "$one" in
        '')
        	... original code ...
		;;
        *)
		one=`printf "%${prec}d" 1`
        	cat "$@" >"$dotest/$one"
                echo "$one" >"$dotest/last"
                ;;
	esac
