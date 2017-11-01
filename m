Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1B93202A0
	for <e@80x24.org>; Wed,  1 Nov 2017 19:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932209AbdKAT64 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 15:58:56 -0400
Received: from cloud.peff.net ([104.130.231.41]:43084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755208AbdKAT6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 15:58:55 -0400
Received: (qmail 24928 invoked by uid 109); 1 Nov 2017 19:58:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 19:58:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14850 invoked by uid 111); 1 Nov 2017 19:59:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Nov 2017 15:59:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Nov 2017 15:58:53 -0400
Date:   Wed, 1 Nov 2017 15:58:53 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/3] sha1_file: use hex_to_bytes()
Message-ID: <20171101195853.tu7wfpzo5cqoqwbo@sigill.intra.peff.net>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
 <d8f73744-b3f5-0fca-d58c-1f60e79214e0@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8f73744-b3f5-0fca-d58c-1f60e79214e0@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 02:50:06PM +0100, René Scharfe wrote:

> The path of a loose object contains its hash value encoded into two
> substrings of 2 and 38 hexadecimal digits separated by a slash.  The
> first part is handed to for_each_file_in_obj_subdir() in decoded form as
> subdir_nr.  The current code builds a full hexadecimal representation of
> the hash in a temporary buffer, then uses get_oid_hex() to decode it.
> 
> Avoid the intermediate step by taking subdir_nr as-is and using
> hex_to_bytes() directly on the second substring.  That's shorter and
> easier.

This raises some of the same questions as the previous one on whether
hex_to_bytes() is the ideal abstraction. But as before, I'm on the
fence.

> @@ -1908,20 +1911,15 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
>  		strbuf_setlen(path, baselen);
>  		strbuf_addf(path, "/%s", de->d_name);
>  
> -		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2)  {
> -			char hex[GIT_MAX_HEXSZ+1];
> -			struct object_id oid;
> -
> -			xsnprintf(hex, sizeof(hex), "%02x%s",
> -				  subdir_nr, de->d_name);
> -			if (!get_oid_hex(hex, &oid)) {
> -				if (obj_cb) {
> -					r = obj_cb(&oid, path->buf, data);
> -					if (r)
> -						break;
> -				}
> -				continue;
> +		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
> +		    !hex_to_bytes(oid.hash + 1, de->d_name,
> +				  GIT_SHA1_RAWSZ - 1)) {
> +			if (obj_cb) {
> +				r = obj_cb(&oid, path->buf, data);
> +				if (r)
> +					break;
>  			}
> +			continue;
>  		}
>  
>  		if (cruft_cb) {

Now that this is one big conditional for "is this a valid object
filename", I think we could get rid of the "continue" in favor of:

  if (...looks like an object...)
          ...call obj_cb...
  else if (cruft_cb)
          ...call cruft_cb...

Not a big deal, but it may make the flow more clear (the original had to
use a continue because there were multiple independent steps to
determining it was an object file, so we had to "break out" from the
inner conditional).

-Peff
