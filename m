From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] diffcore-pickaxe: remove unnecessary call to
 get_textconv()
Date: Thu, 4 Apr 2013 17:11:10 -0400
Message-ID: <20130404211110.GB25811@sigill.intra.peff.net>
References: <7vr4iqi2uw.fsf@alter.siamese.dyndns.org>
 <ed31727421dc3000e943e62a8d82ac1af6589733.1365105971.git.simon@ruderich.org>
 <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Simon Ruderich <simon@ruderich.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 23:11:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNrRh-0006Si-SM
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 23:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763122Ab3DDVLR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 17:11:17 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56384 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761171Ab3DDVLQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 17:11:16 -0400
Received: (qmail 7181 invoked by uid 107); 4 Apr 2013 21:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 04 Apr 2013 17:13:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2013 17:11:10 -0400
Content-Disposition: inline
In-Reply-To: <7vvc82ggy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220105>

On Thu, Apr 04, 2013 at 01:48:52PM -0700, Junio C Hamano wrote:

> If I am reading the code correctly, it is has_changes(), which is
> used for "log -S" (not "log -G" that uses diff_grep()), that does
> the unnecessary get_textconv() unconditionally.  The way diff_grep() 
> divides the work to make fill_one() responsible for filling the
> textconv as necessary is internally consistent, and there is no
> unnecessary call.
> 
> Perhaps...
> 
> 	The fill_one() function is responsible for finding and
> 	filling the textconv filter as necessary, and is called by
> 	diff_grep() function that implements "git log -G<pattern>".
> 
> 	The has_changes() function calls get_textconv() for two
> 	sides being compared, before it checks to see if it was
> 	asked to perform the pickaxe limiting with the -S option.
> 	Move the code around to avoid this wastage.  After that,
> 	fill_one() is called to use the textconv.
> 
> 	By adding get_textconv() to diff_grep() and relieving
> 	fill_one() of responsibility to find the textconv filter, we
> 	can avoid calling get_textconv() twice.
> 
> Explained that way, it makes me wonder why we cannot fix it the
> other way around, that is, not fetching textconv in has_changes()
> and instead letting fill_one() to find textconv as needed.
> 
> The answer is because has_changes() itself looks at the textconv.
> 
> But we have to wonder why it is so.  diff_grep() short-circuits when
> the two sides are identical and has_changes() has a similar but
> different logic to check if the identical two sides are processed
> with the same textconv filter before saying this filepair is
> uninteresting.
> 
> Shouldn't that logic be unified as well?

I think it would be OK to perform the same optimization in diff_grep; I
do not recall offhand why I didn't do so when touching this code last
time, so it may have just been because I didn't think of it.

But I do not think fill_one is the right interface for it. The reason
has_changes calls get_textconv separately is that we do not want to fill
the buffer (which may be expensive) if we can avoid it. So the correct
sequence is:

  1. Find out textconv_one.

  2. Find out textconv_two.

  3. Check "!hashcmp(one->sha1, two->sha1) && textconv_one == textconv_two";
     if true, then we know the content we are about to compare will be
     identical, and we can return early.

  4. Otherwise, retrieve the content for one (respecting textconv_one).

  5. Retrieve the content for two (respecting textconv_two).

You cannot implement the optimization looking only at one side
(obviously), but you also need to split the textconv lookup from the
"fill" procedure if you want the optimization to come at the right
place.

If you turned fill_one into "fill_both_sides" then you could share
the code between diff_grep/pickaxe and do it in the right order in the
helper.

-Peff
