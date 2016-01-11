From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Mon, 11 Jan 2016 16:33:51 -0500
Message-ID: <20160111213351.GA21131@sigill.intra.peff.net>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <xmqqr3ht41w8.fsf@gitster.mtv.corp.google.com>
 <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:34:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIk6U-0000pj-5G
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760021AbcAKVeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:34:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:51635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933722AbcAKVdy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:33:54 -0500
Received: (qmail 15124 invoked by uid 102); 11 Jan 2016 21:33:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:33:54 -0500
Received: (qmail 5967 invoked by uid 107); 11 Jan 2016 21:34:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:34:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 16:33:51 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtwmp2e6d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283725>

On Thu, Jan 07, 2016 at 02:54:50PM -0800, Junio C Hamano wrote:

>  This is not even compile tested; I just wanted to prevent people
>  from adding two unnecessary checks to this function following my
>  analysis in the previous message.  I think returning bogus value
>  stored in a crafted .idx file from this function is OK, as the
>  offset will be first used by use_pack() and the sanity of the
>  offset, relative to the packfile size, is checked there, and an
>  offset that points to a random point in the packfile will be caught
>  by the pack reading code, either by unpack_compressed_entry() or by
>  patch_delta(), so that is also safe.
> 
>  We do need to check the unprotected access here.  Nobody else in
>  the current codepath protects us from this access attempting to
>  read an unmapped memory and segfault.

I think this is the right track, and it does indeed catch the bogus .idx
that started this thread. I agree that we should be OK to hand back a
bogus offset to the pack code, which already handles bounds-checking due
to the sliding window code.

> diff --git a/sha1_file.c b/sha1_file.c
> index 73ccd49..8aca1f6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2458,6 +2458,13 @@ off_t nth_packed_object_offset(const struct packed_git *p, uint32_t n)
>  		off = ntohl(*((uint32_t *)(index + 4 * n)));
>  		if (!(off & 0x80000000))
>  			return off;
> +
> +		/* 8-byte offset table */
> +		if ((p->index_size - (8 + 256 * 4 + 28 * p->num_objects + 40))
> +		    <
> +		    (off & 0x7fffffff) * 8)
> +			die("offset beyond end of .idx file");
> +
>  		index += p->num_objects * 4 + (off & 0x7fffffff) * 8;
>  		return (((uint64_t)ntohl(*((uint32_t *)(index + 0)))) << 32) |
>  				   ntohl(*((uint32_t *)(index + 4)));

It's hard to verify that this is right due to all the magic numbers. :)

This function advances the "index" pointer to access the data, and it
has already handled the initial header, v2 object names, etc. I think it
might be simpler to compute:

  const unsigned char *end = p->index_data + p->index_size;

and compare the computed "index" against that. I suspect the earlier
accesses of "index" can also be fooled using integer overflows (e.g.,
claim that we have a huge number of objects, and (20 * p->num_objects)
may overflow to arbitrary memory, especially on 32-bit systems where
it's easy to wrap).

-Peff
