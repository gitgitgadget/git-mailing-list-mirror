From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/5] combine-diff: respect textconv attributes
Date: Mon, 23 May 2011 19:39:16 -0400
Message-ID: <20110523233916.GA10488@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523203105.GE6298@sigill.intra.peff.net>
 <7vwrhht4oj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 01:39:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOeiZ-0002GY-SB
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 01:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757713Ab1EWXjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 19:39:19 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54907
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753700Ab1EWXjT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 19:39:19 -0400
Received: (qmail 24946 invoked by uid 107); 23 May 2011 23:41:23 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 23 May 2011 19:41:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 May 2011 19:39:16 -0400
Content-Disposition: inline
In-Reply-To: <7vwrhht4oj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174292>

On Mon, May 23, 2011 at 03:47:40PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +	} else if (textconv) {
> > +		/* yuck, the textconv code is linked heavily with
> > +		 * filespecs */
> > +		struct diff_filespec *df = alloc_filespec("");
> > +		fill_filespec(df, sha1, mode);
> > +		*size = fill_textconv(textconv, df, &blob);
> 
> I thought your 4/5 talked something about not requiring filespec for
> textconv handling...?  Is it still yuck?

Yeah, I removed the requirement for get_textconv to need a filespec.
Which is nice, because it means the non-textconv codepath doesn't deal
with this at all.

But removing the filespec from fill_textconv is much nastier, because it
relies on diff.c's prepare_temp_file, which also uses the filespec.

So it's still yuck, but limited to this little conditional. It would be
nice if we used filespecs all the way through the combine-diff code
path, but that was a bit more refactoring than I was up for today.

-Peff
