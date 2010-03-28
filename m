From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 18:09:35 +0200
Message-ID: <4BAF7F3F.5020604@drmicha.warpmail.net>
References: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:09:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvv3L-00016a-Ou
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab0C1QJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:09:17 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:54988 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754726Ab0C1QJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Mar 2010 12:09:16 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C6553EA44F;
	Sun, 28 Mar 2010 12:09:15 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sun, 28 Mar 2010 12:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5Mv9V0E8/v5gXLEzq0kZyByRrm4=; b=lbq/X71bp+yeP57CARNDJYkblfvqA76l+l6vBqs7cXGYv8ItK1ja8wFR4yvphaNNZ3vjArsOkQigERvYEHYoAOuDqAdM/dZkIHy4DmoyqTHFXwglcsFlRrplGNijWImktwgtLpPH44p+4bk6kOSWgG93UjIUgp00lD2zvORlFsI=
X-Sasl-enc: spl/n/Y/ypMkHuzUce7mvk1aK+pnzmqBL7ZcLLsDXzSa 1269792555
Received: from localhost.localdomain (p3EE29099.dip0.t-ipconnect.de [62.226.144.153])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C7B4649F5D6;
	Sun, 28 Mar 2010 12:09:14 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <20100328145301.GA26213@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143393>

Jeff King venit, vidit, dixit 28.03.2010 16:53:
> The normal textconv procedure is to dump the binary file to a tempfile
> (optionally using a working tree file if available), then run the
> textconv helper to produce a textual version on stdout. This is a very
> convenient interface, as helpers don't need to be aware of git at all
> and many standard commands can be used without wrappers.
> 
> Unfortunately, it can be slow for large binary files. We spool the file
> to disk before invoking the textconv helper, so the helper has no way to
> do any optimizations. For example, the helper may need only part of the
> file (e.g., when showing metadata at the beginning of a media file), or
> it may implement a caching scheme to avoid repeating expensive
> conversions.
> 
> This series introduces a "fast textconv", which does not automatically
> spool a tempfile, but instead gives the helper program the sha1 of the
> blob to be converted.
> 
> Here are some timings from my photo repository, on a commit with 37
> JPEGs and 8 AVIs. Each file had two lines added to its exif metadata.
> My textconv helper is a perl script that dumps the exif tags, and
> implements its own caching scheme.
> 
>   $ time git show >/dev/null ;# before patch
>   real    0m13.818s
>   user    0m12.137s
>   sys     0m1.552s
> 
>   $ time git show >/dev/null ;# after patch, first run
>   real    0m15.076s
>   user    0m13.321s
>   sys     0m1.772s
> 
>   $ time git show >/dev/null ;# after patch, subsequent runs
>   real    0m2.502s
>   user    0m1.820s
>   sys     0m0.592s
> 
> So you can see a 5.5x speedup. The first run is a little bit slower,
> presumably due to the extra git-cat-file calls by the helper.
> 
> The speedup is purely from caching; I am not using the "we only need to
> read the first part of the file" optimization. My files are only a few
> megabytes. Probably that would be more useful for people storing files
> in the hundreds of megabytes, where a full cat-file will cause a lot of
> unwanted I/O.
> 
> There are two things I'm still not 100% happy with:
> 
>  1. 2.5 seconds is still a little slower than I would like. The slowness
>     comes from the fact that my helper is written in perl, and therefore
>     perl gets invoked for each diff. I could try collecting all of the
>     to-be-textconv'd files at the beginning of the diff process and just
>     invoking the helper once. But that means we need to store the
>     results in core, and they could potentially be long (in my case,
>     they are only a few hundred bytes, but somebody could potentially be
>     textconv'ing a large documents).
> 
>  2. It is up to the helper to implement a caching layer. This offers a
>     lot of flexibility, but it means each helper must implement its own.
>     It also means we have to run the helper even for a cache hit, which
>     causes slowness.
> 
>     An alternative would be for git to support textconv caching
>     natively, probably by using the notes mechanism to map blob sha1's
>     to their textconv'd contents. But that opens a whole can of worms
>     with how the cache is managed. If I change my textconv helper to
>     produce different results, how do I invalidate the cache? Should it
>     happen automatically if I change the contents of
>     diff.$method.textconv? Or do I need to do it manually (you will
>     still need to do it manually if, e.g., you upgrade your textconv
>     helper. Git can't know about that). How do I evict entries if the
>     cache gets too large when notes are stored as a history?

Really, "Notes!" was my first thought even before reading 2. Happy to
have found a like mind :)

This would still need a mechanism where the conv helper gets the blob's
SHA1 - hey, it's there in your patch...

How about:

Set fasttextconv=notestextconv

notestextconv does the following:

- If $sha1 has a note in refs/notes/bikeshed display it.
- If not create one and then display it.

In fact, the creation could be done using the textconv setting!

Pruning the cache is done be deleting the refs/notes/bikeshed ref,
truncating it by truncating it's DAG (filter-branch...).

Cheers,
Michael
