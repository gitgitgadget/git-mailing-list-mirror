From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCHv2 3/3] completion: match ctags symbol names in grep
	patterns
Date: Sun, 23 Oct 2011 23:29:28 +0200
Message-ID: <20111023212928.GG22551@goldbirke>
References: <20111021172239.GA22289@sigill.intra.peff.net>
	<20111021173021.GC24417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 23 23:29:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RI5bm-00081u-A6
	for gcvg-git-2@lo.gmane.org; Sun, 23 Oct 2011 23:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab1JWV3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Oct 2011 17:29:25 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51458 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab1JWV3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Oct 2011 17:29:24 -0400
Received: from localhost6.localdomain6 (p5B13006F.dip0.t-ipconnect.de [91.19.0.111])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0MY20C-1RVPPu2qRc-00V6zD; Sun, 23 Oct 2011 23:29:23 +0200
Content-Disposition: inline
In-Reply-To: <20111021173021.GC24417@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Provags-ID: V02:K0:tTwske51XjZ2VeF4XC5mMVVhzK0Hh7F6rU+B1prT1/i
 7mT6V1lyQmu+ETjsU2TbGnSeqOUyV07uceLttIPifdGcGzmBym
 ZmpR80bWXdVTRebPbos33CrOvoRZRwpWw/AGr2HKHgRIU3xKT5
 FZc6xbwCbFDoyEnxPlUGSdf+rmi95taLzikLS2XzM6DoFMGPZ1
 qiIMhjmGuR6pfTYxMy5dxYgbtvaT+Am7Q/d8RNPP83L5N2q6sj
 7YhLdmSTmSzYDHzPPv9My3RERVFDwFq3XLTtkSsloEWkj1alLo
 pHbHW4yBGuZjaSiULLLBq2OZOx8YC+gyUQsfTolHlYwZQThicP
 3f/NFdF2sQ7qXnyveJGo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184147>

Hi,

On Fri, Oct 21, 2011 at 01:30:21PM -0400, Jeff King wrote:
> This incorporates the suggestions from G=E1bor's review, with one
> exception: it still looks only in the current directory for the "tags=
"
> files. I think that might have some performance implications, so I'd
> rather add it separately, if at all.

I agree that scanning through a whole working tree for tags files
would cost too much.  But I think that a tags file at the top of the
working tree is common enough to be supported, and checking its
existence is fairly cheap.

> +	case "$cword,$prev" in
> +	2,*|*,-*)
> +		if test -r tags; then
> +			__gitcomp "$(__git_match_ctag "$cur" tags)"
> +			return
> +		fi
> +		;;

So how about something like this for the case arm? (I didn't actually
tested it.)

		local tagsfile
		if test -r tags; then
			tagsfile=3Dtags
		else
			local dir=3D"$(__gitdir)"
			if test -r "$dir"/tags; then
				tagsfile=3D"$dir"/tags
			fi
		fi
		if [ -n "tagsfile" ]; then
			__gitcomp "$(__git_match_ctag "$cur" "$tagsfile")"
			return
		fi


Btw, there is a bug in the case statement: 'git --no-pager grep <TAB>'
offers refs instead of symbols, because $cword is not 2 and $prev
doesn't start with a dash.  But it's not worse than the current
behavior, so I don't think this bug is a show-stopper for the patch.


Best,
G=E1bor
