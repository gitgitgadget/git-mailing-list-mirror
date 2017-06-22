Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B3020802
	for <e@80x24.org>; Thu, 22 Jun 2017 23:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753840AbdFVXKo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 19:10:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:49594 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753645AbdFVXKn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 19:10:43 -0400
Received: (qmail 30610 invoked by uid 109); 22 Jun 2017 23:10:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 22 Jun 2017 23:10:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7011 invoked by uid 111); 22 Jun 2017 23:10:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Jun 2017 19:10:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Jun 2017 19:10:41 -0400
Date:   Thu, 22 Jun 2017 19:10:41 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] sha1_name: cache readdir(3) results in
 find_short_object_filename()
Message-ID: <20170622231041.2zdjypviwmndjnsb@sigill.intra.peff.net>
References: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
 <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
 <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
 <20170615055654.efvsouhr3leszz3i@sigill.intra.peff.net>
 <ec36f9fa-5f3e-b511-3985-3d0301b4847f@web.de>
 <20170615132532.nivmj22dctowxssm@sigill.intra.peff.net>
 <b728352d-7fa5-2adb-af00-5f232b85b2bf@web.de>
 <20170618115017.wyroncb3jka6lrdt@sigill.intra.peff.net>
 <xmqqd1a0vb2t.fsf@gitster.mtv.corp.google.com>
 <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d06fb033-294e-f364-3dde-394624e83cd6@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 22, 2017 at 08:19:48PM +0200, René Scharfe wrote:

> Read each loose object subdirectory at most once when looking for unique
> abbreviated hashes.  This speeds up commands like "git log --pretty=%h"
> considerably, which previously caused one readdir(3) call for each
> candidate, even for subdirectories that were visited before.

Is it worth adding a perf test that's heavy on abbreviations?

> The new cache is kept until the program ends and never invalidated.  The
> same is already true for pack indexes.  The inherent racy nature of
> finding unique short hashes makes it still fit for this purpose -- a
> conflicting new object may be added at any time.  Tasks with higher
> consistency requirements should not use it, though.
> 
> The cached object names are stored in an oid_array, which is quite
> compact.  The bitmap for remembering which subdir was already read is
> stored as a char array, with one char per directory -- that's not quite
> as compact, but really simple and incurs only an overhead equivalent to
> 11 hashes after all.

Sounds reasonable. The code itself looks good, with one minor nit below.

> @@ -1593,6 +1594,16 @@ extern struct alternate_object_database {
>  	struct strbuf scratch;
>  	size_t base_len;
>  
> +	/*
> +	 * Used to store the results of readdir(3) calls when searching
> +	 * for unique abbreviated hashes.  This cache is never
> +	 * invalidated, thus it's racy and not necessarily accurate.
> +	 * That's fine for its purpose; don't use it for tasks requiring
> +	 * greater accuracy!
> +	 */
> +	char loose_objects_subdir_seen[256];
> +	struct oid_array loose_objects_cache;
> +

Thanks for adding this comment.

> @@ -1811,6 +1822,12 @@ typedef int each_loose_cruft_fn(const char *basename,
>  typedef int each_loose_subdir_fn(int nr,
>  				 const char *path,
>  				 void *data);
> +int for_each_file_in_obj_subdir(int subdir_nr,
> +				struct strbuf *path,
> +				each_loose_object_fn obj_cb,
> +				each_loose_cruft_fn cruft_cb,
> +				each_loose_subdir_fn subdir_cb,
> +				void *data);

Now that this is becoming public, I think we need to document what
should be in "path" here. It is the complete path, including the 2-hex
subdir.

That's redundant with "subdir_nr". Should we push that logic down into
the function, and basically do:

  if (subdir_nr < 0 || subdir_nr > 256)
	BUG("object subdir number out of range");
  orig_len = path->len;
  strbuf_addf(path, "/%02x", subdir_nr);
  baselen = path->len;

  ...

  strbuf_setlen(path, orig_len);

That's one less thing for the caller to worry about, and it's easy to
explain the argument as "the path to the object directory root".

> +		if (!alt->loose_objects_subdir_seen[subdir_nr]) {
> +			struct strbuf *buf = alt_scratch_buf(alt);
> +			strbuf_addf(buf, "%02x/", subdir_nr);
> +			for_each_file_in_obj_subdir(subdir_nr, buf,
> +						    append_loose_object,
> +						    NULL, NULL,
> +						    &alt->loose_objects_cache);

I think the trailing slash here is superfluous. If you take my
suggestion above, that line goes away. But then the front slash it adds
becomes superfluous. It should probably just do:

  strbuf_complete(path, '/');
  strbuf_addf(path, "%02x", subdir_nr);

-Peff
