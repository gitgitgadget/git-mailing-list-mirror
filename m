From: Jeff King <peff@peff.net>
Subject: Re: auto merge bug
Date: Tue, 5 Mar 2013 12:59:04 -0500
Message-ID: <20130305175904.GC9379@sigill.intra.peff.net>
References: <CAOFaZ+5F1BcWNU=AkcnS53bQt1VfAfsFjp9EvRCL=7kYiU1ejg@mail.gmail.com>
 <20130305090326.GC13552@sigill.intra.peff.net>
 <7vtxopvoky.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Krmpotic <david.krmpotic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 18:59:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCw9F-0002Se-Uo
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 18:59:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756610Ab3CER7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 12:59:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35457 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755694Ab3CER7G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 12:59:06 -0500
Received: (qmail 16556 invoked by uid 107); 5 Mar 2013 18:00:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 13:00:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 12:59:04 -0500
Content-Disposition: inline
In-Reply-To: <7vtxopvoky.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217469>

On Tue, Mar 05, 2013 at 07:44:13AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the merge will produce the results you are looking for. This
> > would have to be configurable, though, as it is a regression for
> > existing users of "union", which would want the duplicate-line
> > suppression (or maybe not; it will only catch such duplicates at the
> > beginning and end of the conflict hunk, so maybe it is sane to always
> > ask "union" to keep all lines).
> 
> The original use-case example of "union" was to merge two shopping
> lists (e.g. I add "bread" and "orange juice" to remind me that we
> need to buy these things, while my wife adds "bread" and "butter").
> 
> We do not necessarily want to end up with a shopping list to buy two
> loaves of bread.  When the user verifies and fixes up the result, we
> can keep the current behaviour and those who want to re-dup can add
> one back, or we can change the behaviour to leave the duplicates and
> those who do not want to see duplicates can remove them manually.
> 
> Given that the caveat you quoted already tells the user to verify
> the result and not to use it without understanding its implications,
> I think it technically is fine either way (read: keeping duplicates
> is not a clearly superiour solution). So let's leave it as-is.

My problem with the current behavior is that it is not predictable
whether it will de-dup or not. If your shopping lists are:

  bread
  orange juice

  bread
  butter

it works; you get only one bread. If they are:

  milk
  bread
  orange juice

  beer
  bread
  butter

you get two. It depends on the exact behavior of the XDL_MERGE_ZEALOUS
flag. What I'd propose is two different drivers:

  1. Find conflicts via 3-way merge, and include both sides of the
     conflict verbatim. Do not use XDL_MERGE_ZEALOUS, as it is more
     important to retain items from both sides (in their original order)
     than it is to remove duplicates.

  2. A true line-based union, which should act like "cat $ours $theirs |
     sort | uniq". That is what you want for the shopping list example,
     I think (you could also preserve existing ordering with a lookup
     table, though I prefer clobbering the ordering; the ordering of
     resolved conflicts will be arbitrary anyway, so it makes it clear
     from the outset that you should not use this driver if your content
     is not really a set (in the mathematical sense) of lines).

     You could also have sets of other objects (e.g., blank-line
     delimited paragraphs, changelog entries, etc). But you would need
     some way to specify the parsing then[1].

I'm not sure which should be called "union". The first one would still
need careful examination of the result. The second one should always be
correct, but only because it is limited to a much more constrained
problem.

I'm also not sure how useful those really are in practice. I have not
used "union" myself ever. And in the example that started this thread, I
find the use of "union" slightly dubious. I do not even know how it
would react to a line _changing_, or other complicated edit. Short of a
specialized XML-aware merge driver, using XDL_MERGE_ZEALOUS and kicking
the result out to the user (i.e., what the default merge driver does)
seems like the only sane thing, even if it is more work at merge time.

-Peff

[1] Some of this is fairly easy to do with perl one-liners (e.g., "perl
   -00 -ne 'print unless $h{$_}++" for paragraph mode), so maybe it is
   just an education/documentation issue. I dunno. I have always been
   happy enough with the stock merge.
