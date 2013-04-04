From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] diffcore-pickaxe: respect --no-textconv
Date: Thu, 4 Apr 2013 13:43:01 -0400
Message-ID: <20130404174301.GA13005@sigill.intra.peff.net>
References: <vpqd2uay9rq.fsf@grenoble-inp.fr>
 <20130404160359.GA25232@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Simon Ruderich <simon@ruderich.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 19:43:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNoCJ-0008Gc-7D
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 19:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763707Ab3DDRnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 13:43:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56096 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763588Ab3DDRnI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 13:43:08 -0400
Received: (qmail 3259 invoked by uid 107); 4 Apr 2013 17:44:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 13:44:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 13:43:01 -0400
Content-Disposition: inline
In-Reply-To: <20130404160359.GA25232@ruderich.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220039>

On Thu, Apr 04, 2013 at 06:03:59PM +0200, Simon Ruderich wrote:

> git log -S doesn't respect --no-textconv:
> 
>     $ echo '*.txt diff=wrong' > .gitattributes
>     $ git -c diff.wrong.textconv='xxx' log --no-textconv -Sfoo
>     error: cannot run xxx: No such file or directory
>     fatal: unable to read files to diff
> 
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> Reported-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>

Usually these pseudo-headers are meant to be chronological, so you would
swap the order.

> > It seems the command "git log --no-textconv -Sfoo" still runs the
> > textconv filter (noticed because I have a broken textconv filter that
> > lets "git log -S" error out).
> >
> > [snip]
> 
> Hello Matthieu,
> 
> This patch should fix it. All tests pass.

Thanks, the patch looks correct to me, although...

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index b097fa7..f814a52 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -78,7 +78,6 @@ static void fill_one(struct diff_filespec *one,
>  		     mmfile_t *mf, struct userdiff_driver **textconv)
>  {
>  	if (DIFF_FILE_VALID(one)) {
> -		*textconv = get_textconv(one);
>  		mf->size = fill_textconv(*textconv, one, &mf->ptr);

Dropping this is the right thing to do with the rest of your patch, but
like Matthieu, it took me a second to see why. Something like this
should probably go into the commit message:

  We need to check that the ALLOW_TEXTCONV diff option is set before
  loading the textconv drivers. Rather than pass the diff options
  structure into the fill_one helper, let's just determine the textconv
  driver outside of that function and pass that in.

Though I really think that justification would make more sense if your
second cleanup patch came first, pulling the get_textconv calls back out
to the callers (which is easy to justify, since one of the callers
already has to load them itself _anyway_, which is just ugly).

-Peff
