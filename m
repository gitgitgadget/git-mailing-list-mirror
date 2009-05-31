From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http*: cleanup slot->local after fclose
Date: Sat, 30 May 2009 23:17:19 -0700
Message-ID: <7vy6sdssnk.fsf@alter.siamese.dyndns.org>
References: <49F1EA6D.8080406@gmail.com> <20090530091755.GA13578@localhost>
	<be6fef0d0905300231k5167f3efle9a450419bdfa1cb@mail.gmail.com>
	<20090530093717.GA22129@localhost>
	<be6fef0d0905300352o33694420m9c988daa554420a3@mail.gmail.com>
	<20090530230153.527532b0.rctay89@gmail.com>
	<20090531000955.953725d9.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 08:17:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAeMK-0001PR-Un
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 08:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZEaGRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbZEaGRS
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 02:17:18 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:59801 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbZEaGRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 02:17:18 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090531061719.NMFS17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 31 May 2009 02:17:19 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id y6HK1b0014aMwMQ046HK1B; Sun, 31 May 2009 02:17:19 -0400
X-Authority-Analysis: v=1.0 c=1 a=HW4xNc0D6V0A:10 a=C1YqLowQeloA:10
 a=pGLkceISAAAA:8 a=OLL_FvSJAAAA:8 a=vMqirlFpfZrUu_yjjAMA:9
 a=MzdZRcYL1b8zAZMp-zZqDRZhiQ8A:4 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090531000955.953725d9.rctay89@gmail.com> (Tay Ray Chuan's message of "Sun\, 31 May 2009 00\:09\:55 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120382>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Set slot->local to NULL after doing a fclose on the FILE* pointer it
> points to.
>
> Move NULL assignment to request->slot from
> http-push.c::finish_request() to http-push.c::release_request(). This
> is safe, since the functions finish_request() invoke will overwrite
> request->slot anyway.
>
> Refactor http-push.c::fetch_index(), http-walker.c::fetch_index() and
> http-walker.c::fetch_pack() to use labels while cleaning up.
>
> This fixes the issue raised by Clemens Buchacher on 30th May:
>
>   http://www.spinics.net/lists/git/msg104623.html
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---
>
>  This applies on master, and is a resend, this time with the subject.

Shouldn't a fix instead be queued for 'maint', without "refactoring"?

Is there a reproducible repipe you can add to the test script?

>  http-push.c   |   23 ++++++++++++++---------
>  http-walker.c |   36 +++++++++++++++++++++++-------------
>  2 files changed, 37 insertions(+), 22 deletions(-)
>
> diff --git a/http-push.c b/http-push.c
> index dac2c6e..816824a 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -715,6 +715,8 @@ static void release_request(struct transfer_request *request)
>  		close(request->local_fileno);
>  	if (request->local_stream)
>  		fclose(request->local_stream);
> +	if (request->slot)
> +		request->slot = NULL;
>  	free(request->url);
>  	free(request);

Hmm, what's the point of setting NULL to request->slot if you are already
freeing "request" that contains the field?
