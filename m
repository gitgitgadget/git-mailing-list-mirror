From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Improve the naming of guessed target repository for git clone
Date: Wed, 13 May 2009 17:41:02 -0700
Message-ID: <7vfxf81ppd.fsf@alter.siamese.dyndns.org>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	<200905121557.18542.Hugo.Mildenberger@namir.de>
	<81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	<200905121900.00625.Hugo.Mildenberger@namir.de>
	<81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	<20090512172452.GA32594@blimp.localdomain>
	<20090513180853.GB26288@blimp.localdomain>
	<20090513205333.GA21631@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 02:41:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4P0d-0005J2-6f
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 02:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760124AbZENAlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 20:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753885AbZENAlF
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 20:41:05 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:36557 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912AbZENAlD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 20:41:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090514004101.EIFG25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 May 2009 20:41:01 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id rCh21b00K4aMwMQ03Ch35o; Wed, 13 May 2009 20:41:03 -0400
X-Authority-Analysis: v=1.0 c=1 a=aZmvEVOQGsQA:10 a=csnF2-1mRMQA:10
 a=pGLkceISAAAA:8 a=Y7NETM-SUb63C11j5PYA:9 a=6X9YstZ-aHj79NqdJjoA:7
 a=yonHt9_mUoCYNtW0ZErdblrjSd4A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090513205333.GA21631@blimp.localdomain> (Alex Riesen's message of "Wed\, 13 May 2009 22\:53\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119121>

Alex Riesen <raa.lkml@gmail.com> writes:

> Strip trailing spaces off guessed target directory in builtin clone,
> and replace 'control' characters with an ASCII space.
>
> User still can have any name by specifying it explicitely after url.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> This should take care of accidental pastings inside shell quotes.
> At least for the local part of the operation.
> Now I'm looking at the code and think I should have stripped the
> heading whitespace as well. It is much less likely to happen, though.

> @@ -140,10 +141,21 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>  	if (is_bare) {
>  		struct strbuf result = STRBUF_INIT;
>  		strbuf_addf(&result, "%.*s.git", (int)(end - start), start);
> +		dir = strbuf_detach(&result, 0);
> +	} else
> +		dir = xstrndup(start, end - start);
> +	/* replace all 'control' characters with ascii space */
> +	for (start = dir; *start; ++start)
> +		if (*(const unsigned char *)start < 32u)
> +			dir[start - dir] = '\x20';

What's this strange mixture of 32u and '\x20'?

> +	/* remove trailing spaces */
> +	if (dir < start)
> +		for (end = start; dir < --end; )
> +			if (!isspace(*end))
> +				break;
> +			else
> +				dir[end - dir] = '\0';
> +	return dir;
>  }

Honestly, I regret having asked if there was a 2/2 ;-)

What's the point of this change, now that you have a fix in 1/2?  Who are
you helping with this patch?
