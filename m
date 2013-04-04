From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 4 Apr 2013 16:33:44 -0400
Message-ID: <20130404203344.GA25330@sigill.intra.peff.net>
References: <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
 <20130307180157.GA6604@sigill.intra.peff.net>
 <7vfw07m4sx.fsf@alter.siamese.dyndns.org>
 <20130307185046.GA11622@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 22:34:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqrW-0007Iu-3U
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 22:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764812Ab3DDUdv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 16:33:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56325 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764263Ab3DDUdv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 16:33:51 -0400
Received: (qmail 6646 invoked by uid 107); 4 Apr 2013 20:35:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 16:35:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 16:33:44 -0400
Content-Disposition: inline
In-Reply-To: <20130307185046.GA11622@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220093>

On Thu, Mar 07, 2013 at 01:50:46PM -0500, Jeff King wrote:

> On Thu, Mar 07, 2013 at 10:40:46AM -0800, Junio C Hamano wrote:
> 
> > Where we differ is if such information loss is a good thing to have.
> >
> > We could say "both sides added, identically" is auto-resolved when
> > you use the zealous option, and do so regardless of how the merge
> > conflicts are presented.  Then it becomes perfectly fine to eject
> > "A" and "E" out of the conflicted block and merge them to be part of
> > pre/post contexts.  The same goes for reducing "<C|=C>" to "C".  As
> > long as we clearly present the users what the option does and what
> > its implications are, it is not bad to have such an option, I think.
> 
> Exactly. I do think it has real-world uses (see the example script I
> posted yesterday), but it would never replace diff3. I'm going to try it
> out for a bit. As I mentioned yesterday, I see those sorts of
> cherry-pick-with-something-on-top conflicts when I am rebasing onto or
> merging my topics into what you have picked up from the same topic on
> the list.

I wanted to give an update on how this has been going. I've been running
with zdiff3 for almost a month. I keep my merge.conflictstyle set to
diff3, and when I see something that I think might benefit from the
"both sides added" zealousness, I do a "git checkout --conflict=zdiff3"
and examine the result.

I have seen it help, and always when rebasing patches that were accepted
upstream. For example, imagine I added a big block of text in one patch
(e.g., an entire test script). Then I added more tests in a follow-on
patch. Or I change some of the lines from expect_failure to
expect_success. You can see this in t1060 of the
jk/check-corrupt-objects-carefully topic (I didn't try, but you could
probably reproduce by just rebasing it on top of the current master).

When I rebase my version of the patches on your master with the new
content, the conflict for the first patch is useless in diff3. I see
that the base had nothing, upstream added a hundred lines, and my patch
added ninety lines. But it's hard to see which lines are missing or
modified because of the size of the conflict. It looks like:

       <<<<<<< ours
       #!/bin/sh
       test_description=whatever
       ...
          end of some test
       '
       test_done
       ||||||| base
       =======
       #!/bin/sh
       test_description=whatever
       ...
          end of another test
       '
       test_done
       >>>>>>> theirs

The interesting part is in the "...", which contains different lines in
each version, but it may be hundreds of lines long. Using zdiff3, I get:

       #!/bin/sh
       test_description=whatever
       ...
       <<<<<<< ours
       test_expect_success 'some_new_test' '
       ...
       ||||||| base
       =======
       >>>>>>> theirs
       '
       test_done

I can see that nothing was tweaked; I just didn't add any content there,
and upstream did. Contrast this with zealous "merge" conflicts, which
would look like:

      #!/bin/sh
      test_description=whatever
      ...
      <<<<<<< ours
      test_expect_success 'some_new_test' '
      ...
      =======
      >>>>>>> theirs
      '
      test_done

which similarly condenses, but is missing a piece of information: that
there was nothing in the base. I don't know whether the conflict is
there because my patch removed some content that got changed upstream,
or whether upstream added some content that I did not have in my patch.

So I think it is useful when rebasing on top of what upstream took,
specifically when:

  1. You have a series that updates the same hunk repeatedly (because
     from your perspective, you see only the tip of what upstream took).

  2. Upstream takes your patch but tweaks it (either as a fixup, to deal
     with a merge conflict, or whatever). You get to see the minimal
     tweak, not the fact that you have a giant hunk which differs from
     the upstream only by a few characters or a few lines.

So I do think zdiff3 is useful, and I plan to continue using it.

-Peff
