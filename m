Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F44C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7538207FF
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 21:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgAFVOu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:14:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:58208 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726683AbgAFVOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 16:14:50 -0500
Received: (qmail 3130 invoked by uid 109); 6 Jan 2020 21:14:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Jan 2020 21:14:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25094 invoked by uid 111); 6 Jan 2020 21:20:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2020 16:20:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 6 Jan 2020 16:14:49 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20200106211449.GA980197@coredump.intra.peff.net>
References: <20191230211027.37002-1-jonathantanmy@google.com>
 <20200102201630.180969-1-jonathantanmy@google.com>
 <xmqqftgxedtk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqftgxedtk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 02, 2020 at 01:41:27PM -0800, Junio C Hamano wrote:

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > As a historical note, the function now known as repo_read_object_file()
> > was taught the empty tree in 346245a1bb ("hard-code the empty tree
> > object", 2008-02-13), and the function now known as oid_object_info()
> > was taught the empty tree in c4d9986f5f ("sha1_object_info: examine
> > cached_object store too", 2011-02-07). repo_has_object_file() was never
> > updated, perhaps due to oversight. The flag OBJECT_INFO_SKIP_CACHED,
> > introduced later in dfdd4afcf9 ("sha1_file: teach
> > sha1_object_info_extended more flags", 2017-06-26) and used in
> > e83e71c5e1 ("sha1_file: refactor has_sha1_file_with_flags", 2017-06-26),
> > was introduced to preserve this difference in empty-tree handling, but
> > now it can be removed.
> 
> I am not 100% sure if the implication of this change is safe to
> allow us to say "now it can be".
> 
> The has_object_file() helper wanted to say "no" when given a
> non-existing object registered via the pretend_object_file(),
> presumably because we wanted to allow a use pattern like:
> 
>  - prepare an in-core representation of an object we tentatively
>    expect, but not absolutely sure, to be necessary.
> 
>  - perform operations, using the object data obtained via
>    read_object() API, which is capable of yielding data even for
>    such "pretend" objects (perhaps we are creating a tentative merge
>    parents during a recursive merge).
> 
>  - write out final set of objects by enumerating those that do not
>    really exist yet (via has_object_file() API).
> 
> Teaching about the empty tree to has_object_file() is a good thing
> (especially because we do not necessarily write an empty tree object
> to our repositories), but as a collateral damage of doing so, we
> make such use pattern impossible.  
> 
> It is not a large loss---the third bullet in the above list can just
> be made to unconditionally call write_object_file() without
> filtering with has_object_file() and write_object_file() will apply
> the right optimization anyway, so it probably is OK.

I agree that whoever called pretend_object_file() can be careful and
write out the final set of objects itself via write_object_file(). But
I'd worry a bit about a caller who doesn't necessarily realize that they
need to do that. E.g., imagine we call pretend_object_file() for some
blob oid, expecting it to be read-only. And then in the same process,
some other bit of the code writes out a tree that mentions that blob.
Oops, that tree is now corrupt after we exit the process. And IMHO
neither the pretend-caller nor the tree-writer are to blame; the problem
is that they shared global state they were not expecting.

This is pretty far-fetched given that the only user of
pretend_object_file() is in git-blame right now. But it does give me
pause. Overall, though, I'm more inclined to say that we should be
dropping SKIP_CACHED here and considering pretend_object_file() to be a
bit dangerous (i.e., to keep it in mind if somebody proposes more
calls).

Another point of reference (in favor of Jonathan's patch):

  https://lore.kernel.org/git/20190304174053.GA27497@sigill.intra.peff.net/

is a bug that would not have happened if this patch had been applied
(there's also some discussion of the greater issue, but nothing that wasn't
already brought up here, I think).

-Peff
