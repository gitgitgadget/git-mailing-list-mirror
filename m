Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB44C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3635E61107
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 03:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237708AbhIUDcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 23:32:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:51378 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231878AbhIUDKd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 23:10:33 -0400
Received: (qmail 3126 invoked by uid 109); 21 Sep 2021 03:09:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 03:09:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27240 invoked by uid 111); 21 Sep 2021 03:09:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Sep 2021 23:09:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Sep 2021 23:09:00 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] log: UNLEAK rev to silence a large number of leaks
Message-ID: <YUlMzJ6WNPxefYlm@coredump.intra.peff.net>
References: <pull.1092.git.git.1631972978.gitgitgadget@gmail.com>
 <6d54bc264e2f9ce519f32c0673167a00bab55573.1631972978.git.gitgitgadget@gmail.com>
 <YUZG0D5ayEWd7MLP@carlos-mbp.lan>
 <87o88obkb1.fsf@evledraar.gmail.com>
 <YUes7yxKHKW7cXcl@carlos-mbp.lan>
 <CAPig+cT-ajKsoj19ChPnkNByf-6P-vX=SG0NmgYt8CXyNH8y-w@mail.gmail.com>
 <YUj/gFRh6pwrZalY@carlos-mbp.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUj/gFRh6pwrZalY@carlos-mbp.lan>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 20, 2021 at 02:39:12PM -0700, Carlo Marcelo Arenas Belón wrote:

> > Therefore (if I'm reading this correctly), it is absolutely correct
> > for add_rev_cmdline() to be duplicating that string to ensure that the
> > hexified OID value remains valid, and incorrect for this patch to be
> > removing the call to xstrdup().
> 
> Indeed, but the values that are being strdup were never used anyway, so
> I suspect the original code might had just put it as a logical default.

We do look at them in a few cases, like "fast-export", but only if they
are not marked UNINTERESTING. And add_rev_cmdline_list(), the variant
that writes the hex values, only ever gets called with the UNINTERESTING
flag.

So I think you're right that these ones would never be seen. I did
wonder if we'd ever show them with "log --source" or similar, but that
pulls the name from object_array_entry, I think.

> -------- >8 --------
> Subject: [PATCH] revision: remove xstrdup() of name in add_rev_cmdline()
> 
> a765499a08 (revision.c: treat A...B merge bases as if manually
> specified, 2013-05-13) adds calls to this function in a loop,
> abusing oid_to_hex (at that time called sha1_to_hex).
> 
> df835d3a0c (add_rev_cmdline(): make a copy of the name argument,
> 2013-05-25) adds the strdup, introducing a leak.
> 
> All names we will ever get should come from the commandline or be
> constant values, so it is safe not to xstrdup and clean them up.

This last paragraph is questionable, I think. We feed the argv from
setup_revisions() here, but that is not always coming from the actual
command line. Most cases seem to finish with the traversal before what
they've passed in goes out of scope, but not all. The call in
bisect_rev_setup() intentionally leaks the strvec (even though it
doesn't need to do so with the current code). The one in
cmd__fast_rebase() does clear its strvec after setup_revisions() but
before the actual traversal. I wouldn't be surprised if your patch
triggered memory problems there.

> @@ -1504,10 +1499,10 @@ static void add_rev_cmdline_list(struct rev_info *revs,
>  				 int whence,
>  				 unsigned flags)
>  {
> +	static const char *synthetic = ".synthetic";

I don't think there's any point in making this static. It's not an
array, but rather a pointer to a string literal. That string literal
will remain valid regardless (the standard does not guarantee we get the
_same_ string literal every time, but that doesn't matter for our
purposes. And in practice it will be the same one).

> @@ -1753,7 +1748,7 @@ struct add_alternate_refs_data {
>  static void add_one_alternate_ref(const struct object_id *oid,
>  				  void *vdata)
>  {
> -	const char *name = ".alternate";
> +	static const char *name = ".alternate";
>  	struct add_alternate_refs_data *data = vdata;
>  	struct object *obj;

Ditto here.

> @@ -1940,7 +1935,7 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
>  			   struct object_context *a_oc,
>  			   struct object_context *b_oc)
>  {
> -	const char *a_name, *b_name;
> +	static const char *a_name, *b_name;
>  	struct object_id a_oid, b_oid;
>  	struct object *a_obj, *b_obj;
>  	unsigned int a_flags, b_flags;

And I don't see how this changes anything at all. Our pointers will live
on, but the memory they point to is not affected.

-Peff
