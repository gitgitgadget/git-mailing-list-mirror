From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 02:33:59 -0400
Message-ID: <20090814063359.GA6898@coredump.intra.peff.net>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <20090814052153.GA2881@coredump.intra.peff.net>
 <fabb9a1e0908132324td6869aydc752f67b95546f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 08:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbqMy-0002Aw-6e
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 08:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbZHNGd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 02:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753511AbZHNGd7
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 02:33:59 -0400
Received: from peff.net ([208.65.91.99]:44902 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217AbZHNGd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 02:33:59 -0400
Received: (qmail 15165 invoked by uid 107); 14 Aug 2009 06:34:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 14 Aug 2009 02:34:02 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Aug 2009 02:33:59 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908132324td6869aydc752f67b95546f1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125903>

On Thu, Aug 13, 2009 at 11:24:05PM -0700, Sverre Rabbelier wrote:

> > It seems like it would be simple enough to just check whether the
> > refspec contains a colon; if so, silently leave it alone. That could
> > also protect configured refspecs, as mentioned above, but I wouldn't
> > rule out somebody have a single-name refspec in their config (in fact, I
> > think "remote.$X.push = HEAD" is reasonable -- should that delete the
> > HEAD on "git push --delete"?).
> 
> I don't think we should touch any configured refspecs, think about how
> often one would use that vs. the inconvenience of doing so
> unintentionally.

I think you are right. My previous message was sort of thinking out
loud, but I think on the whole, the annoyance caused by accidental
deletion is not worth it. :)

> > So maybe it would make more sense for it to be "--delete <ref>" and
> > impact only a single ref. The simple case of "git push --delete foo"
> > would remain unchanged.
> 
> I thought about that, but I decided that it was both intuitive and
> convenient to be able to delete multiple refs this way.
> [...]
> I do, it's easy to make mistakes when it's more powerful, and I think
> less intuitive. I think we want this to be as intuitive as possible.

I guess I find what you are doing _more_ complex, because you are really
introducing a whole new mode to push, which is "I am deleting some
stuff". As opposed to some syntactic sugar to replace the confusing
":ref" syntax, which is what I thought the goal was.

On the other hand, "--delete <ref>" introduces its own syntactic
problems. Is it an option, in which case you end up doing:

  git push --delete master origin

which is a bit backwards from the usual syntax. Or is it part of the
refspec list, in which case:

  1. We have just disallowed a refspec called "--delete" (though to be
     fair, you have to be a little insane to use that anyway, and you
     can always call it refs/heads/--delete)).

  2. Now we don't simply have a list, one refspec per element, which
     makes things syntactically a little more complex.

Perhaps saying that "--delete=<ref>" is equivalent to ":<ref>" would be
a reasonable way of adding just the syntactic sugar. I.e.:

  git push origin --delete=master

Of course, maybe the goal of a "delete mode" is useful to people. I
can't think of a time when I would have used it, but then I also tend to
think ":<ref>" is elegant and obvious. ;)

I dunno. I don't feel too strongly about it; mainly I was just surprised
because I would have done it the other way. :)

-Peff
