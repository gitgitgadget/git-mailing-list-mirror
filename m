From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix for a merge where a branch has an F->D transition
Date: Tue, 12 May 2009 23:19:47 -0700
Message-ID: <7v63g57ce4.fsf@alter.siamese.dyndns.org>
References: <81b0412b0905110242u3624f0eeyc0dc9b2b987bfa2b@mail.gmail.com>
	<20090511192536.GA1485@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 08:19:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M47oq-000260-Dw
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752128AbZEMGTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 02:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbZEMGTs
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:19:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:34326 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbZEMGTr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 02:19:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090513061947.ECLE20430.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 13 May 2009 02:19:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id quKn1b0094aMwMQ04uKn82; Wed, 13 May 2009 02:19:47 -0400
X-Authority-Analysis: v=1.0 c=1 a=odGI_XOhU64A:10 a=Z7b2yMBJ4bQA:10
 a=pGLkceISAAAA:8 a=FSXoXewp_f9eTXnJgV8A:9 a=SVzXLaTKmoMDx0Lt0cYA:7
 a=Ew6r0fExDW_4mIUwHCpp1NM23wUA:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090511192536.GA1485@blimp.localdomain> (Alex Riesen's message of "Mon\, 11 May 2009 21\:25\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118986>

Alex Riesen <raa.lkml@gmail.com> writes:

> Frankly, I'm not really sure. The solution came largely ... empirical
> way. IOW, I tried more or less random things which looked like they
> should fix the problem. So a review is very much appreciated. Please.

I've always thought that D/F conflict logic in merge-recursive is placed
at the wrong processing phase.  IIRC, it enumerates potential D/F
conflicting paths before even attempting to process renames, and it is
easy to miss a path that was previously file going away as the result of a
clean merge (in which case it is ok to have a directory there as the
result of a merge for other paths).  This breakage could be a small
example of it.

Regardless, I think your patch is a reasonable fix to go to the
maintenance track.  Thanks for looking into it.

>  merge-recursive.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index a3721ef..3c5420b 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -980,14 +980,15 @@ static int process_renames(struct merge_options *o,
>  
>  				if (mfi.clean &&
>  				    sha_eq(mfi.sha, ren1->pair->two->sha1) &&
> -				    mfi.mode == ren1->pair->two->mode)
> +				    mfi.mode == ren1->pair->two->mode) {
>  					/*
>  					 * This messaged is part of
>  					 * t6022 test. If you change
>  					 * it update the test too.
>  					 */
>  					output(o, 3, "Skipped %s (merged same as existing)", ren1_dst);
> -				else {
> +					ren1->dst_entry->processed = 0;
> +				} else {
>  					if (mfi.merge || !mfi.clean)
>  						output(o, 1, "Renaming %s => %s", ren1_src, ren1_dst);
>  					if (mfi.merge)
> -- 
> 1.6.3.28.ga852b
