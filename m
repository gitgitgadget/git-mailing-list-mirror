From: Jeff King <peff@peff.net>
Subject: Re: Crashes while trying to show tag objects with bad timestamps
Date: Fri, 22 Feb 2013 18:04:18 -0500
Message-ID: <20130222230418.GC21579@sigill.intra.peff.net>
References: <kg8ri2$vjb$1@ger.gmane.org>
 <20130222224655.GB21579@sigill.intra.peff.net>
 <7vy5egark3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:04:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91fa-0006eO-CU
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840Ab3BVXEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 18:04:21 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57596 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753416Ab3BVXEV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:04:21 -0500
Received: (qmail 9442 invoked by uid 107); 22 Feb 2013 23:05:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 18:05:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 18:04:18 -0500
Content-Disposition: inline
In-Reply-To: <7vy5egark3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216876>

On Fri, Feb 22, 2013 at 02:53:48PM -0800, Junio C Hamano wrote:

> > I guess we should probably issue a warning, too. Also disappointingly,
> > git-fsck does not seem to detect this breakage at all.
> 
> Yes for the warning, 

Unfortunately, a good warning is harder than I had hoped. At the point
where we notice the problem, pp_user_info, we have very little context.
We can say only something like:

  warning: malformed date in ident 'Jeff King <peff@peff.net> BOGUS'

but we cannot say in which object, or even that it was a "tagger" line
(and in some cases we do not even have an object, as in
make_cover_letter).

> and no for disappointing.  IIRC, in the very early implementations
> allowed tag object without dates.
> 
> I _think_ we can start tightening fsck, though.

Then I think it would make sense to allow the very specific no-date tag,
but not allow arbitrary crud. I wonder if there's an example in the
kernel or in git.git.

I also took a look at parsing routine of "cat-file -p". It's totally
hand-rolled, separate from what "git show" does, and is not build on the
pretty-print code at all. I wonder, though, if it actually makes sense
to munge the date there. The commit-object pretty-printer for cat-file
just shows the object intact. It seems weirdly inconsistent that we
would munge tags just to rewrite the date. If you want a real
pretty-printer, you should be using porcelain like "show".

It would be a regression, of course, for people relying on "cat-file -p"
to have consistent output. But I am very tempted to call it a bug, and
tempted to call "cat-file -p" inside a script a bad thing (you cannot,
after all, tell what object type you have; you should figure out the
type you expect and then use "cat-file <type> <obj>" to make sure you
get the right one).

-Peff
