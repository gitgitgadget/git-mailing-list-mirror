From: Jeff King <peff@peff.net>
Subject: Re: [BUG] rebase -p loses commits
Date: Tue, 17 May 2011 01:39:34 -0400
Message-ID: <20110517053934.GB10048@sigill.intra.peff.net>
References: <20110516103354.GA23564@sigill.intra.peff.net>
 <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:39:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMD0U-0003b5-Dn
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 07:39:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972Ab1EQFjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 01:39:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39110
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751736Ab1EQFjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 01:39:36 -0400
Received: (qmail 21557 invoked by uid 107); 17 May 2011 05:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 17 May 2011 01:41:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2011 01:39:34 -0400
Content-Disposition: inline
In-Reply-To: <7vfwoel6vw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173786>

On Mon, May 16, 2011 at 01:36:51PM -0700, Junio C Hamano wrote:

> Hmm, I am confused.  You have this:
> 
>    F---*  feature
>   /   /
>  B---M    master
> 
> and you are at "*".  If it were to rebase to linearize,
> 
>     B---M---F' 
> 
> with F' that has the same the contents as '*', possibly autoresolved by
> "am -3" and/or "rerere", should be what you would get.
> 
> But what does it mean to rebase that on top of master, preserving merges
> in the first place? You are already on top of 'master' and '*' itself
> should be what you should get, no?  IOW, shouldn't you already be
> up-to-date?

To be honest, I am not sure what should happen. How this example came
about was that somebody had the same graph, except that a third branch,
"origin", also pointed at "B". They were confused why "git rebase
--pull" made them re-resolve the same conflict that they had
already handled during the merge.

The answer, of course, is that rebase is linearizing the commits instead
of trying to preserve the shape of history, and that they really wanted
"rebase -p".

I constructed the simplified example to show that the issue didn't have
to do with origin, but rather with linearizing.

So it's not a real-world example, in that sense. If it had done one of:

  1. Said "you are up to date" and one nothing.

  2. Put F' on top of M.

  3. Bailed and said "what you're doing is silly".

I would probably have shrugged and left it alone. But claiming success
and losing F entirely is pretty bad.

> I don't use preserve-merge rebase either, but at least when you are
> strictly ahead of the target, nothing should happen, I think.
> 
> Perhaps this should be a good start?

Aside from how unreadable that shell conditional is getting, I think
it's an improvement.

-Peff
