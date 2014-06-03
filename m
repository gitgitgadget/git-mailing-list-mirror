From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-objects: use free()+xcalloc() instead of
 xrealloc()+memset()
Date: Tue, 3 Jun 2014 02:29:51 -0400
Message-ID: <20140603062951.GA26150@sigill.intra.peff.net>
References: <538B0969.9080409@web.de>
 <20140602194246.GD2510@sigill.intra.peff.net>
 <878upf9h9v.fsf@fencepost.gnu.org>
 <20140602215911.GA4612@sigill.intra.peff.net>
 <xmqqbnua3o4n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Kastrup <dak@gnu.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <tanoku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:29:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WriEQ-0002C4-S0
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 08:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbaFCG3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 02:29:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:36408 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932190AbaFCG3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 02:29:54 -0400
Received: (qmail 5547 invoked by uid 102); 3 Jun 2014 06:29:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jun 2014 01:29:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jun 2014 02:29:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnua3o4n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250614>

On Mon, Jun 02, 2014 at 04:09:12PM -0700, Junio C Hamano wrote:

> > I tried "git blame -M -C -C -C pack-objects.c" but couldn't get anything
> > but the whole thing blamed to 2834bc2.
> 
> Are you two being a bit too unreasonable, or trying to be fanciful
> and funny and I am not getting the humor?

We are being too unreasonable.

> Here is the relevant part of what 2834bc27 (pack-objects: refactor
> the packing list, 2013-10-24) removes from builtin/pack-objects.c:
> 
> -	object_ix = xrealloc(object_ix, sizeof(int) * object_ix_hashsz);
> -	memset(object_ix, 0, sizeof(int) * object_ix_hashsz);
> 
> And here is how the same rehash is done in pack-objects.c at the
> toplevel in the new code:
> 
> +	pdata->index = xrealloc(pdata->index, sizeof(uint32_t) * pdata->index_size);
> +	memset(pdata->index, 0, sizeof(int) * pdata->index_size);
> 
> Surely, the code structure may be similar, but the similarity ends
> there.  These lines are not equivalent even under the "-w" option.

Yes, I did not expect these particular lines to get blamed, but I
thought some of the surrounding function would (which could lead to a
parent-blame to find the true origin). Skimming the diff, it looked like
some of them made it through unscathed. But they didn't.

Running:

  git show 2834bc2 |
  perl -lne '
    /^-(.*)/ and $del{$1}++;
    print "$.: $_" if /^\+(.*)/ && $del{$1};
  '

shows that there are only a handful of interesting lines that survived
completely intact, and typically not more than one line in a row.  The
big exceptions are the bits that made it into pack-objects.h, and a "git
blame" there does find the code movement.

So I think everything is operating as expected.

-Peff
