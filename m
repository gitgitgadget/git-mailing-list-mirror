Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BEF93
	for <git@vger.kernel.org>; Mon, 11 Dec 2023 23:05:00 -0800 (PST)
Received: (qmail 9235 invoked by uid 109); 12 Dec 2023 07:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Dec 2023 07:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11930 invoked by uid 111); 12 Dec 2023 07:04:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Dec 2023 02:04:59 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Dec 2023 02:04:58 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/24] pack-bitmap: plug leak in find_objects()
Message-ID: <20231212070458.GB1117953@coredump.intra.peff.net>
References: <cover.1701198172.git.me@ttaylorr.com>
 <bc38fba65547f5716a2ff9904dd615e755ea84bb.1701198172.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc38fba65547f5716a2ff9904dd615e755ea84bb.1701198172.git.me@ttaylorr.com>

On Tue, Nov 28, 2023 at 02:08:02PM -0500, Taylor Blau wrote:

> The `find_objects()` function creates an object_list for any tips of the
> reachability query which do not have corresponding bitmaps.
> 
> The object_list is not used outside of `find_objects()`, but we never
> free it with `object_list_free()`, resulting in a leak. Let's plug that
> leak by calling `object_list_free()`, which results in t6113 becoming
> leak-free.

Makes sense.

> @@ -1280,6 +1280,8 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		base = fill_in_bitmap(bitmap_git, revs, base, seen);
>  	}
>  
> +	object_list_free(&not_mapped);
> +
>  	return base;
>  }

There's an extra return earlier in the function, but it triggers only
when not_mapped is NULL. So this covers all cases. Good.

> +++ b/t/t6113-rev-list-bitmap-filters.sh
> [..]
> +TEST_PASSES_SANITIZE_LEAK=true

Yay. :)

-Peff
