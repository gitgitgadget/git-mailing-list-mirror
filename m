From: Jeff King <peff@peff.net>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Mon, 25 Feb 2013 13:30:09 -0500
Message-ID: <20130225183009.GB13912@sigill.intra.peff.net>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222224655.GB21579@sigill.intra.peff.net>
 <7vy5egark3.fsf@alter.siamese.dyndns.org>
 <20130222230418.GC21579@sigill.intra.peff.net>
 <7vppzsaqc5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:30:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2oy-00005x-Iy
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181Ab3BYSaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:30:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60076 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759120Ab3BYSaM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:30:12 -0500
Received: (qmail 25461 invoked by uid 107); 25 Feb 2013 18:31:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Feb 2013 13:31:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Feb 2013 13:30:09 -0500
Content-Disposition: inline
In-Reply-To: <7vppzsaqc5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217074>

On Fri, Feb 22, 2013 at 03:20:10PM -0800, Junio C Hamano wrote:

> As pp_user_info() is called from very few places, I do not think it
> is unreasonable to add an output parameter (i.e. "unsigned *") to
> let the caller know that we made a best guess given malformed input
> and handle the error in the caller.  The make_cover_letter() caller
> may look like:
> 
> 	pp_user_info(&pp, NULL, &sb, committer, encoding, &errors);
>         if (errors & PP_CORRUPT_DATE)
> 		warning("unparsable datestamp in '%s'", committer);
> 
> although it is unlikely to see this error in practice, given that
> committer is coming from git_committer_info(0) and would have the
> current timestamp.

Sadly that is not quite enough for the object-parsing cases (which are
the ones we _really_ want to add context to, because they are buried
inside other pp_* calls. Probably adding an object context field (or an
error return) to the pretty-print context would make sense. But I don't
relish the thought of annotating each pretty-print caller.

I think we're OK to be silent and just react in an appropriate way;
having looked over the other callers of split_ident_line, we already do
so in some places. See my patch 1 below for details.

Once fsck is taught to note this, then the warning is a lot less
important (my patch 3 below).

> The whole "cat-file -p" is a historical wart, aka poor-man's
> "show".  I do not even consider it a part of the plumbing.  It is a
> fair game for Porcelainisque improvement ;-)

Good, that's how I feel, too. See my patch 4. :)

Here are the patches I'd like to do:

  [1/4]: handle malformed dates in ident lines
  [2/4]: skip_prefix: return a non-const pointer
  [3/4]: fsck: check "tagger" lines
  [4/4]: cat-file: print tags raw for "cat-file -p"

The first one is solid, and should probably go to maint and/or the -rc
track, as it fixes a segfault on bogus input. It's hopefully a
no-brainer, as the existing behavior is obviously unacceptable. We may
change our mind later about exactly what to print for such bogus input,
but whatever we print in such a case is just trying to be nice to the
user, and anybody who depends on our particular handling of malformed
objects is crazy.

The rest can wait, as they are about improving output when fed bogus
input, or tightening fsck. Moreover, they have some problems which make
them not suitable for applying yet. I'll give details in each patch.

-Peff
