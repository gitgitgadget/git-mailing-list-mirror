Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46E94201A7
	for <e@80x24.org>; Mon, 15 May 2017 23:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752614AbdEOXHe (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 19:07:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:52239 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752542AbdEOXHc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 19:07:32 -0400
Received: (qmail 2853 invoked by uid 109); 15 May 2017 23:07:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 23:07:30 +0000
Received: (qmail 22689 invoked by uid 111); 15 May 2017 23:08:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 19:08:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 19:07:27 -0400
Date:   Mon, 15 May 2017 19:07:27 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCHv3 1/4] clone: respect additional configured fetch
 refspecs during initial fetch
Message-ID: <20170515230727.hw75whugf25asuor@sigill.intra.peff.net>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
 <20170515110557.11913-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170515110557.11913-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 01:05:54PM +0200, SZEDER Gábor wrote:

> The initial fetch during a clone doesn't transfer refs matching
> additional fetch refspecs given on the command line as configuration
> variables.  This contradicts to the documentation stating that

Minor gramm-o: s/to the/the/

> @@ -989,6 +994,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_reset(&value);
>  
>  	remote = remote_get(option_origin);
> +	REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr + 1);
> +	memcpy(remote->fetch+remote->fetch_refspec_nr, refspec,
> +	       sizeof(*refspec));

Here we append to remote->fetch. We are assuming then that
remote->fetch_refspec has already been parsed into remote->fetch. Which
I think it always is by remote_get(), but given that it lazy-parses in
some cases, it feels a little dangerous.

I also notice that you don't touch remote->fetch_refspec_nr, nor
fetch_refspec_alloc. So the remote struct doesn't actually know about
this entry.  It would probably be wrong if you _did_ update them,
because remote->fetch_refspec (the list of refspec strings) would not
have a matching entry, and would potentially access uninitialized
memory.

I think the whole thing would be a lot less messy if "struct remote" let
you add a new refspec (as a string) after the initial parse, and it
would handle the details. Just making the existing add_fetch_refspec()
public isn't quite enough, because you'd need to invalidate and re-parse
the matching "fetch" array, too. Something like:

diff --git a/remote.c b/remote.c
index 9c8912ab1..0881ed32c 100644
--- a/remote.c
+++ b/remote.c
@@ -2319,3 +2319,17 @@ void apply_push_cas(struct push_cas_option *cas,
 	for (ref = remote_refs; ref; ref = ref->next)
 		apply_cas(cas, remote, ref);
 }
+
+void remote_add_fetch_refspec(struct remote *remote, const char *refspec)
+{
+	add_fetch_refspec(remote, refspec);
+	if (remote->fetch) {
+		struct refspec *parsed;
+
+		parsed = parse_refspec_internal(1, &refspec, 1, 0);
+		REALLOC_ARRAY(remote->fetch, remote->fetch_refspec_nr);
+		remote->fetch[remote->fetch_refspec_nr - 1] = *parsed;
+		/* Not free_refspec, as we copied its pointers above */
+		free(parsed);
+	}
+}

That feels a bit dirty, too, but at least it's not reaching across
module boundaries. I think the cleanest thing would be to actually add
it to the config before calling remote_get().

I think in the earlier discussion you mentioned there are some ordering
problems with writing out the new on-disk config. But could we add it to
the temporary environment, like:

  strbuf_addf(&key, "remote.%s.fetch=%s", option_origin, refspec_pattern);
  git_config_push_parameter(key.buf);

?

Come to think of it, though, I thought the reason we weren't using
remote_get() in the first place is that some code paths (like
single-branch) needed to actually get the remote ref list before we knew
the refspec? So how does this approach work at all? :)

I guess that doesn't apply here. We always feed the transport code with
a broad refspec, and then narrow it down later. It's only that we can't
write the final config to disk until we've computed the correct branch
based on the remote refs. gotten the branch.

If all that's correct, then I think the push_parameter() thing would
work. It does feel like a round-a-bout way to solve the problem, but
it's at least manipulating solid, public APIs.

-Peff
