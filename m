Return-Path: <SRS0=R7wA=DM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68035C4363A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E4A32075A
	for <git@archiver.kernel.org>; Mon,  5 Oct 2020 08:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgJEIU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Oct 2020 04:20:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:49362 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgJEIUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Oct 2020 04:20:25 -0400
Received: (qmail 31160 invoked by uid 109); 5 Oct 2020 08:20:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 05 Oct 2020 08:20:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17113 invoked by uid 111); 5 Oct 2020 08:20:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Oct 2020 04:20:24 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Oct 2020 04:20:23 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/7] fsck_tree(): fix shadowed variable
Message-ID: <20201005082023.GA2862927@coredump.intra.peff.net>
References: <20201005071751.GA2290770@coredump.intra.peff.net>
 <20201005071905.GA2291074@coredump.intra.peff.net>
 <20201005074404.GD1166820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005074404.GD1166820@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 05, 2020 at 12:44:04AM -0700, Jonathan Nieder wrote:

> > Our tests didn't catch this because they checked only that we found the
> > expected fsck problem, not that it was attached to the correct object.
> 
> Oh, goodness.  Does this mean we should be similarly checking oid in
> the rest of the fsck test scripts?  (I'm not saying this patch should
> do so, just curious about what you think on the subject.)

I don't feel strongly either way. It would be a bigger change than you
might hope, I'd expect, because it requires collecting the oid of the
bad object in the test script as we create it. So I'm not planning to
work on it, but if somebody else wants to, be my guest.

> > Let's rename both variables in the function to avoid confusion. This
> > makes the diff a little noisy (e.g., all of the report() calls outside
> > the loop wee already correct but need touched), but makes sure we catch
> 
> nit: s/wee/are/, s/need touched/need to be touched/

Foiled by my last-minute editing. It was originally "are", but I meant
to change it to "were".

> > -static int fsck_tree(const struct object_id *oid,
> > +static int fsck_tree(const struct object_id *tree_oid,
> 
> optional: we could call it "tree".

Yeah, I started that way but wondered if it was confusing with a "struct
tree" (which we don't have here; the point of the change that introduced
the shadowing was getting rid of that). Being longer doesn't hurt too
much and is quite clear.

> > @@ -664,11 +664,11 @@ static int fsck_tree(const struct object_id *oid,
> >  	while (desc.size) {
> >  		unsigned short mode;
> >  		const char *name, *backslash;
> > -		const struct object_id *oid;
> > +		const struct object_id *entry_oid;
> >  
> > -		oid = tree_entry_extract(&desc, &name, &mode);
> > +		entry_oid = tree_entry_extract(&desc, &name, &mode);
> 
> optional: could call it "child".

IMHO that's too vague. We have a child name, a child mode, etc.

Another option is to just refer to desc.entry.oid directly, but that's
longer and seemed a bit too intimate with how tree_entry_extract works.

> not about this patch: Could report() notice when the oid doesn't match
> the type passed in, to more easily catch this kind of mistake?

Hmm. It would incur an extra hash lookup, but since we expect to
report() infrequently, I don't think the cost would be too high. I
suspect we could even drop the "type" field and have report() figure it
out from the oid, but that is working in the opposite direction of your
suggestion. ;)

I'm not 100% sure we'd always be able to look up such a struct, though.
This code path also gets called from index-pack as it's checking objects
(so likewise we might not even have something in the object database
yet).

> >  		# Check not only that we fail, but that it is due to the
> >  		# symlink detector; this grep string comes from the config
> >  		# variable name and will not be translated.
> >  		test_must_fail git fsck 2>output &&
> > -		test_i18ngrep gitmodulesSymlink output
> > +		test_i18ngrep "tree $tree: gitmodulesSymlink" output
> 
> Makes sense.
> 
> By the way, why does GETTEXT_POISON lose the gitmodulesSymlink
> keyword?  Is this just a limitation of GETTEXT_POISON losing
> information that's passed in with %s?

Yes, I think so. It comes from 674ba34038 (fsck: mark strings for
translation, 2018-11-10) which is passing through our string. Arguably
that commit made the comment lines rather confusing and pointless.

Though hmm. Looks like the "tree %s: %s" part is in the translated
string. So a translation _could_ change it, though I'd expect it to only
change the words and not the syntax. Maybe an RTL language would. I
dunno.

-Peff
