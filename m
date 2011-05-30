From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/5] combine-diff: handle binary files as binary
Date: Mon, 30 May 2011 10:36:27 -0400
Message-ID: <20110530143627.GC31490@sigill.intra.peff.net>
References: <20110523201529.GA6281@sigill.intra.peff.net>
 <20110523202734.GC6298@sigill.intra.peff.net>
 <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 16:36:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR3a7-00065S-AW
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 16:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755062Ab1E3Oga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 10:36:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42827
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751629Ab1E3Og3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 10:36:29 -0400
Received: (qmail 15239 invoked by uid 107); 30 May 2011 14:36:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 10:36:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 10:36:27 -0400
Content-Disposition: inline
In-Reply-To: <7vpqn0ofy5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174748>

On Sun, May 29, 2011 at 11:33:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > @@ -852,6 +862,29 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
> >  		}
> >  	}
> >  
> > +	if (userdiff->binary != -1)
> > +		is_binary = userdiff->binary;
> > +	else {
> > +		is_binary = buffer_is_binary(result, result_size);
> > +		for (i = 0; !is_binary && i < num_parent; i++) {
> > +			char *buf;
> > +			unsigned long size;
> > +			buf = grab_blob(elem->parent[i].sha1,
> > +					elem->parent[i].mode,
> > +					&size);
> > +			if (buffer_is_binary(buf, size))
> > +				is_binary = 1;
> > +			free(buf);
> > +		}
> > +	}
> 
> Two comments.
> 
>  - This loop will grab the blob from all parents just to peek and discard
>    for most of commits. It feels somewhat wasteful, especially because
>    "binary" that is not marked as binary is a rare minor case (most of the
>    paths are text). Stopping immediately at the first binary blob does not
>    optimize the loop even though it is better than not having one.

Yeah, I am not too happy with that bit. Our choices are:

  1. Grab each blob, check binary-ness, and free. This double-loads in
     the common, non-binary case.

  2. Grab each blob, check binary-ness, and keep it in memory. This
     means using N times as much memory, where N is the number of
     parents. In practice, N generally equals 2, and the file sizes
     aren't gigantic, so it's not that bad. But there are some corner
     cases.

  3. Choose (1) or (2) based on file size, or based on the number of
     parents. The problem cases for (2) are going to be big files
     (bigger than bigFileThreshold?), and gigantic numbers of parents.

I'd also eventually like to do a "peek" binary-ness check on top of your
streaming work, as I showed for the non-combined diff case (speaking of
which, I need to polish that now that the streaming series seems to have
settled). And we would probably want to peek only in the big file case.

I'll try to take a look at it this week and get some measurements on (1)
versus (2) for both speed and peak memory usage. And then see if I can
do better with (3), and implement the "peek" solution both here and in
regular diff.

>  - It may make sense to compare [i].sha1 with earlier [j].sha1 (j < i) and
>    avoid grab_blob() altogether?  Cf. 3c39e9b (combine-diff: reuse diff
>    from the same blob., 2006-02-01).

Yeah, that is probably worth doing, as it collapses the "N" above into
"how many parents all modified the same file". I'll add it to my list to
measure.

-Peff
