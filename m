From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2 5/6] pack-bitmap: fix a memleak
Date: Mon, 30 Mar 2015 23:29:53 -0400
Message-ID: <20150331032953.GA842@peff.net>
References: <1427495569-10863-1-git-send-email-sbeller@google.com>
 <1427495569-10863-6-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, tanoku@gmail.com,
	blees@dcon.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 05:30:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcmsL-00043t-OF
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 05:30:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753966AbbCaD35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 23:29:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:40143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752974AbbCaD34 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 23:29:56 -0400
Received: (qmail 1662 invoked by uid 102); 31 Mar 2015 03:29:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 22:29:56 -0500
Received: (qmail 20117 invoked by uid 107); 31 Mar 2015 03:30:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 30 Mar 2015 23:30:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Mar 2015 23:29:53 -0400
Content-Disposition: inline
In-Reply-To: <1427495569-10863-6-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266508>

On Fri, Mar 27, 2015 at 03:32:48PM -0700, Stefan Beller wrote:

> `recent_bitmaps` is allocated in the function load_bitmap_entries_v1
> and it is not passed into any function, so it's safe to free it before
> leaving that function.

I think this is OK, though it might be easier still to just turn the
array into a stack variable. It's only 160 * sizeof(ptr), or about 1280
bytes on a 64-bit system. Note that the xcalloc there looks wrong (it is
way over-allocating by using the sizeof the struct, not a pointer to the
struct).

> Notes:
>     I wonder however if we need to free the actual bitmaps
>     stored in the recent_bitmaps as well.

No, those are just weak pointers. The memory is owned by the hash that
store_bitmap puts the bitmaps into.

>  		bitmap = read_bitmap_1(index);

This line allocates, too. So if we get down to...

> -		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i)
> -			return error("Corrupted bitmap pack index");
> +		if (xor_offset > MAX_XOR_OFFSET || xor_offset > i) {
> +			ret = error("Corrupted bitmap pack index");
> +			goto out;
> +		}

...here, for example, where we have not yet called store_bitmap, then
it's a leak, too.

-Peff
