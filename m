Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A66C54EE9
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 19:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiI0TDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 15:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiI0TDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 15:03:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BE4106519
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 12:03:16 -0700 (PDT)
Received: (qmail 32732 invoked by uid 109); 27 Sep 2022 19:03:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Sep 2022 19:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21222 invoked by uid 111); 27 Sep 2022 19:03:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Sep 2022 15:03:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Sep 2022 15:03:14 -0400
From:   Jeff King <peff@peff.net>
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Message-ID: <YzNI8tEpREMLNUpg@coredump.intra.peff.net>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
 <YzLiI1HZeBszsIJq@coredump.intra.peff.net>
 <1B4D6262-532A-401E-B1A2-709BEECA4B67@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1B4D6262-532A-401E-B1A2-709BEECA4B67@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 27, 2022 at 09:50:43AM -0400, John Cai wrote:

> > diff --git a/tmp-objdir.c b/tmp-objdir.c
> > index a8be92bca1..10549e95db 100644
> > --- a/tmp-objdir.c
> > +++ b/tmp-objdir.c
> > @@ -169,7 +169,6 @@ struct tmp_objdir *tmp_objdir_create(const char *prefix)
> >  	the_tmp_objdir = t;
> >  	if (!installed_handlers) {
> >  		atexit(remove_tmp_objdir);
> > -		sigchain_push_common(remove_tmp_objdir_on_signal);
> >  		installed_handlers++;
> >  	}
> 
> This makes sense and is a clean solution. I guess the only case where we would
> benefit in calling into remove_tmp_objdir_on_signal() is if the temp dir exists
> but is empty. I'm not sure how often this would happen to make it worth it?
> Probably not...

It's more or less never, as the first thing we do after creating it is
call tmp_objdir_setup(), which creates the pack subdirectory. We _could_
try removing them both manually, like:

diff --git a/tmp-objdir.c b/tmp-objdir.c
index adf6033549..509eb58363 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -49,7 +49,17 @@ static int tmp_objdir_destroy_1(struct tmp_objdir *t, int on_signal)
 	 * have pre-grown t->path sufficiently so that this
 	 * doesn't happen in practice.
 	 */
-	err = remove_dir_recursively(&t->path, 0);
+	if (!on_signal)
+		err = remove_dir_recursively(&t->path, 0);
+	else {
+		size_t orig_len = t->path.len;
+
+		strbuf_addstr(&t->path, "/pack");
+		rmdir(t->path.buf);
+		strbuf_setlen(&t->path, orig_len);
+
+		rmdir(t->path.buf);
+	}
 
 	/*
 	 * When we are cleaning up due to a signal, we won't bother

but even that would rarely do anything useful. As soon as the child
index-pack receives even a single byte, we'll have an actual pack
tmpfile with an unknown name, which will cause rmdir() to fail (ditto
for unpack-objects, though it would probably write as soon as we've
received a whole single object).

If we can't enumerate the list of objects via readdir() or similar, I
think there's really not much we can do.

-Peff
