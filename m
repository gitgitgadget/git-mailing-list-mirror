From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git name-rev writes beyond the end of malloc() with large generations
Date: Tue, 15 May 2007 12:09:08 -0700
Message-ID: <7vps51j44r.fsf@assigned-by-dhcp.cox.net>
References: <2be2ad34be511217dc735a15490f4536@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Whitcroft <apw@shadowen.org>
X-From: git-owner@vger.kernel.org Tue May 15 21:09:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho2Oc-0008PN-Nu
	for gcvg-git@gmane.org; Tue, 15 May 2007 21:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988AbXEOTJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 15:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756499AbXEOTJL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 15:09:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:46423 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755383AbXEOTJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 15:09:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070515190909.RYGL1318.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 15:09:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zX981W00L1kojtg0000000; Tue, 15 May 2007 15:09:09 -0400
In-Reply-To: <2be2ad34be511217dc735a15490f4536@pinky> (Andy Whitcroft's
	message of "Tue, 15 May 2007 17:33:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47368>

Andy Whitcroft <apw@shadowen.org> writes:

> When using git name-rev on my kernel tree I triggered a malloc()
> corruption warning from glibc.
>
> apw@pinky$ git log --pretty=one $N/base.. | git name-rev --stdin
> *** glibc detected *** malloc(): memory corruption: 0x0bff8950 ***
> Aborted
>
> This comes from name_rev() which is building the name of the revision
> in a malloc'd string, which it sprintf's into:
>
> 	char *new_name = xmalloc(len + 8);
> 	[...]
> 		sprintf(new_name, "%.*s~%d^%d", len, tip_name,
> 				generation, parent_number);
>
> This allocation is only sufficient if the generation number is
> less than 5 digits, in my case generation was 13432.  In reality
> parent_number can be up to 16 so that also can require two digits,
> reducing us to 3 digits before we are at risk of blowing this
> allocation.
>
> This patch introduces a decimal_length() which approximates the
> number of digits a type may hold, it produces the following:
> ...

Does this attempt to cramp down to what's only necessary really
matter in practice in the light of malloc overhead?

It does futureproof against an insanely long "long long" on
future architectures, but I am not sure if we care either.  Why
not just raise 8 to 25 or something and be done with it?

> diff --git a/git-compat-util.h b/git-compat-util.h
> index c08688c..25b8274 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -19,6 +19,9 @@
>  #define TYPEOF(x)
>  #endif
>  
> +/* Approximation of the length of the decimal representation of this type. */
> +#define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> +
>  #define MSB(x, bits) ((x) & TYPEOF(x)(~0ULL << (sizeof(x) * 8 - (bits))))
>  
>  #if !defined(__APPLE__) && !defined(__FreeBSD__)

Having said that, clever and clean math and use of compiler's
ability always attracts me, so maybe I would end up applying
this as is.
