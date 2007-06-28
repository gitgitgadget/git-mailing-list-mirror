From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule: Try harder to describe the status of a submodule
Date: Wed, 27 Jun 2007 21:24:53 -0700
Message-ID: <7v1wfwpuy2.fsf@assigned-by-dhcp.pobox.com>
References: <118297160163-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Emil Medve <Emilian.Medve@Freescale.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 06:24:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3lYu-0001wN-Cq
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 06:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbXF1EYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 00:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXF1EYz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 00:24:55 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42245 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbXF1EYy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 00:24:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070628042454.GZKV1204.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Jun 2007 00:24:54 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id GsQt1X00L1kojtg0000000; Thu, 28 Jun 2007 00:24:54 -0400
In-Reply-To: <118297160163-git-send-email-Emilian.Medve@Freescale.com> (Emil
	Medve's message of "Wed, 27 Jun 2007 14:13:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51078>

Emil Medve <Emilian.Medve@Freescale.com> writes:

> Some repositories might not use/have annotated tags (for example repositories created with
> git-cvsimport) or might not have tags at all and could cause git-submodule status to fail because
> git-describe might fail.
>
> This change makes git-submodule status try harder in displaying the status of a module by
> considering lightweight tags, subsequent tags and branches.

Why are we suddenly seeing these loooooooong lines...

> +get_revname()
> +{
> +	_revname=$(git-describe --tags "$1" 2>/dev/null || git-describe --contains "$1" 2>/dev/null)
> +	if test -z "$_revname" -o "$_revname" = "undefined"
> +	then
> +		_revname=$(git-describe --all "$1" 2>/dev/null | cut -d / -f2-)
> +		test -z "$_revname" && _revname=undefined
> +	fi

I really do not think using --all is useful.  If you do not have
a tag and the rev cannot be described, what damage does it incur?

We still say "$sha1 $path" in the output anyway, and ($revname)
is only "it makes it nicer" appendix.

> @@ -155,7 +174,7 @@ modules_list()
>  			say "-$sha1 $path"
>  			continue;
>  		fi
> -		revname=$(unset GIT_DIR && cd "$path" && git-describe $sha1)
> +		revname=$(unset GIT_DIR && cd "$path" && get_revname $sha1)
>  		if git diff-files --quiet -- "$path"
>  		then
>  			say " $sha1 $path ($revname)"

In that sense, I would prefer mine much better. If a rev is
indescribable, your version would say:

	" dddddddddddddddddddddddddddddddddddddddd subdir (undefined)"

while mine would have said:

	" dddddddddddddddddddddddddddddddddddddddd subdir"
