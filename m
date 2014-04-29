From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 28 Apr 2014 23:15:23 -0400
Message-ID: <20140429031523.GA11979@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
 <20140428193502.GD25993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 05:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeyW5-0002TR-66
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 05:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752868AbaD2DP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 23:15:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:40925 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbaD2DPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 23:15:25 -0400
Received: (qmail 8197 invoked by uid 102); 29 Apr 2014 03:15:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 22:15:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 23:15:23 -0400
Content-Disposition: inline
In-Reply-To: <20140428193502.GD25993@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247514>

On Mon, Apr 28, 2014 at 03:35:02PM -0400, Jeff King wrote:

> Since such entries are in the minority, and because cache_entry is
> already a variable-length struct, I think you could get away with
> sticking it after the "name" field, and then comparing like:
> 
>   const char *ce_normalized_name(struct cache_entry *ce, size_t *len)
>   {
> 	const char *ret;
> 
> 	/* Normal, fast path */
> 	if (!(ce->ce_flags & CE_NORMALIZED_NAME)) {
> 		len = ce_namelen(ce);
> 		return ce->name;
> 	}
> 
> 	/* Slow path for normalized names */
> 	ret = ce->name + ce->namelen + 1;
> 	*len = strlen(name);
> 	return ret;
>   }

That's the reading half. We would also need to create the normalized
names for each cache_entry. I took a look at that this afternoon. It
turns out we make cache_entry structs in quite a few places.  So I
thought I'd start with converting them all to a function like:

  struct cache_entry *cache_entry_alloc(const char *name, size_t len);

And then once converted, we could teach it to normalize the name as
appropriate. That interface does improve many of the callers, but there
are a few tricky ones.

For example, in checkout.c:update_some (and one or two other spots), we
actually have the path broken into two parts, and we combine them while
writing into the cache_entry. We could obviously combine them into a
single buffer beforehand, but that means extra copying in reasonably hot
code paths. It would be slightly ugly but perhaps reasonable to have:

  cache_entry_alloc_two(const char *one, size_t one_len,
                        const char *two, size_t two_len);

But then I got to unpack-trees. It has the whole path broken down across
a linked list.  I'm not sure what would be least terrible interface
here. Again, we could format to a buffer and copy, but I'm hesitant to
do it on this code path.

I'm not sure if I'm just being paranoid about the extra memcpys (it's
not _that_ tight a loop, since after all, we are generally zlib
inflating to get the tree data, and the filenames are not all _that_
long).

I dunno. I just hate the idea of tradeoffs for this OS-X-only fix
permeating the rest of the code on other platforms. But maybe Knuth
should be hitting me with his premature optimization clue-stick.

-Peff
