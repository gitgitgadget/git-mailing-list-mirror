Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9AB20954
	for <e@80x24.org>; Fri,  1 Dec 2017 22:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751208AbdLAWjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 17:39:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:46030 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751031AbdLAWjr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 17:39:47 -0500
Received: (qmail 31730 invoked by uid 109); 1 Dec 2017 22:39:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 01 Dec 2017 22:39:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9880 invoked by uid 111); 1 Dec 2017 22:40:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Fri, 01 Dec 2017 17:40:07 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Dec 2017 17:39:45 -0500
Date:   Fri, 1 Dec 2017 17:39:45 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] sha1_file: use strbuf_add() instead of strbuf_addf()
Message-ID: <20171201223945.GB17334@sigill.intra.peff.net>
References: <20171201174956.143245-1-dstolee@microsoft.com>
 <20171201182238.GA27688@sigill.intra.peff.net>
 <54da89a5-bf20-cb20-9884-6285033f0d95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54da89a5-bf20-cb20-9884-6285033f0d95@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 01, 2017 at 02:50:05PM -0500, Derrick Stolee wrote:

> > > +	baselen = path->len;
> > We set this here so that the '/' is included as part of the base. Makes
> > sense, but can we now drop the earlier setting of baselen before the
> > opendir() call?
> 
> Yeah, probably. I had briefly considered just adding the '/' before the
> first assignment of "baselen", but didn't want to change the error output. I
> also don't know if there are side effects for other platforms by calling
> opendir() with a '/'-terminated path.

I noticed that, too. Since it's so easy to keep doing the opendir
without the slash, I'd prefer to avoid finding out if there are such
platforms. :)

> Good catch! A big reason to pull it inside and use strbuf_add over
> strbuf_addstr is to avoid a duplicate strlen() calculation. However, I can
> store the length before the conditional.

I'd give 50/50 odds no whether a compiler could optimize out that
strlen. We inline addstr exactly so that callsites can see that strlen
(it's primarily for string literals, where it can become a compile-time
constant, but I think it could apply here). But sometimes C's pointer
aliasing rules can be surprising in blocking "obviously correct"
optimizations like that.

The generated asm is a little dense, but I _think_ "gcc -O2" does in
fact do this with a single strlen based on the following tweak on top of
your patch:

diff --git a/sha1_file.c b/sha1_file.c
index 2160323c4a..f234519744 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1921,11 +1921,12 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
 
+		strbuf_setlen(path, baselen);
+		strbuf_addstr(path, de->d_name);
+
 		if (strlen(de->d_name) == GIT_SHA1_HEXSZ - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
 				  GIT_SHA1_RAWSZ - 1)) {
-			strbuf_setlen(path, baselen);
-			strbuf_add(path, de->d_name, GIT_SHA1_HEXSZ - 2);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)

Not that I overly mind the manual assignment of the strlen result in
this particular case. But I'm a curious fellow by nature, and knowing
these kinds of answers helps us build up an accurate gut instinct for
future cases.

> Small change by storing the length in advance of the conditional:
> 
> while (de = readdir(...)) {
>     int namelen = strlen(de->d_name);
>     strbuf_setlen(path, baselen);
>     strbuf_add(path, de->d_name, namelen);
> 
>     if (namelen == HEXSZ - 2)
>         obj_cb(path->buf)
>     else
>         cruft_cb(path->buf);
> }

Yup, I don't mind that approach either, but do please use size_t to
store the result of strlen (I know it's nearly impossible to overflow in
this case, but I've been trying to push the codebase in that direction
slowly over time).

> >    - there's an extra micro-optimization there, which is that if there's
> >      no obj_cb, we have no need to assemble the full path at all. I doubt
> >      it makes much of a difference, as most callers would pass an object
> >      callback (I'd be surprised if we even have one that doesn't).
> 
> After doing a few 'git grep' commands, I found several that include a NULL
> cruft_cb but none that have a NULL obj_cb.

Yeah, that agrees with my cursory look.

Thanks!

-Peff
