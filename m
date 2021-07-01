Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC1C11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1476613D6
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhGAQqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:46:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhGAQqP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:46:15 -0400
Received: (qmail 28350 invoked by uid 109); 1 Jul 2021 16:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17478 invoked by uid 111); 1 Jul 2021 16:43:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:43:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Bruno Albuquerque <bga@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 7/8] serve: add support for a "startup" git_config()
 callback
Message-ID: <YN3wvy6fhD4V+FA3@coredump.intra.peff.net>
References: <cover-0.5-00000000000-20210616T141332Z-avarab@gmail.com>
 <cover-0.8-00000000000-20210628T191634Z-avarab@gmail.com>
 <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-7.8-0a4fb01ae38-20210628T191634Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 09:19:24PM +0200, Ævar Arnfjörð Bjarmason wrote:

> So let's support this common pattern as a "startup_config" callback,
> making use of our recently added "call_{advertise,command}()"
> functions. This allows us to simplify e.g. the "ensure_config_read()"
> function added in 59e1205d167 (ls-refs: report unborn targets of
> symrefs, 2021-02-05).
> 
> We could read all the config for all the protocol capabilities, but
> let's do it one callback at a time in anticipation that some won't be
> called at all, and that some might be more expensive than others in
> the future.

Sadly I don't think this addresses my "v2 receive-pack" concern. The
ls_refs_startup_config() function will get called after we've received a
request for "ls-refs", which is good. But:

> +static void read_startup_config(struct protocol_capability *command)
> +{
> +	if (!command->startup_config)
> +		return;
> +	if (command->have_startup_config++)
> +		return;
> +	git_config(command->startup_config, NULL);
> +}

...we don't pass any context to the config callback here. I thought
passing "command" might work, but looking at the ls_refs() function, it
is the one who actually reads the pkt-lines that will tell us "hey, I'm
doing an ls-refs for a push".

So none of the serve() infrastructure can help us there; we need to read
pkt-lines and _then_ read config.

I dunno. Maybe the solution is for ls_refs() to just do a separate
config call to pick up the operation-specific bits, like:

diff --git a/ls-refs.c b/ls-refs.c
index 88f6c3f60d..6ee70126aa 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -130,12 +130,13 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 
 static int ls_refs_config(const char *var, const char *value, void *data)
 {
+	struct ls_refs_data *d = data;
 	/*
 	 * We only serve fetches over v2 for now, so respect only "uploadpack"
 	 * config. This may need to eventually be expanded to "receive", but we
 	 * don't yet know how that information will be passed to ls-refs.
 	 */
-	return parse_hide_refs_config(var, value, "uploadpack");
+	return parse_hide_refs_config(var, value, d->for_push ? "receive" : "uploadpack");
 }
 
 int ls_refs(struct repository *r, struct strvec *keys,
@@ -147,7 +148,6 @@ int ls_refs(struct repository *r, struct strvec *keys,
 	strvec_init(&data.prefixes);
 
 	ensure_config_read();
-	git_config(ls_refs_config, NULL);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
@@ -161,8 +161,12 @@ int ls_refs(struct repository *r, struct strvec *keys,
 			strvec_push(&data.prefixes, out);
 		else if (!strcmp("unborn", arg))
 			data.unborn = allow_unborn;
+		else if (!strcmp("for-push", arg)) /* imagine this exists */
+			data.for_push = 1;
 	}
 
+	git_config(ls_refs_config, &data);
+
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after ls-refs arguments"));
 

And then it is a separate thing entirely from your "serve will read
config" code. It's arguably more confusing, because now config is read
in two places, but that is already true because of this
ensure_config_read() thing.

The patch above obviously makes no sense until we're working on v2
receive-pack. But I think it illustrates that your patch here is not
getting in the way (though technically I think that would also be true
of your v1, I do like this version better).

-Peff
