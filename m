Return-Path: <SRS0=IlH6=24=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5A2C33C99
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EE62077B
	for <git@archiver.kernel.org>; Tue,  7 Jan 2020 11:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgAGLWP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jan 2020 06:22:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:58872 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726937AbgAGLWO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jan 2020 06:22:14 -0500
Received: (qmail 11273 invoked by uid 109); 7 Jan 2020 11:22:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 Jan 2020 11:22:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29235 invoked by uid 111); 7 Jan 2020 11:27:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jan 2020 06:27:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jan 2020 06:22:13 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH v2] sha1-file: remove OBJECT_INFO_SKIP_CACHED
Message-ID: <20200107112213.GD1073219@coredump.intra.peff.net>
References: <20191230211027.37002-1-jonathantanmy@google.com>
 <20200102201630.180969-1-jonathantanmy@google.com>
 <20200104001331.GA130883@google.com>
 <20200106211730.GB980197@coredump.intra.peff.net>
 <20200106234753.GB92456@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200106234753.GB92456@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 06, 2020 at 03:47:53PM -0800, Jonathan Nieder wrote:

> >> + * Callers are responsible for calling write_object_file to record the
> >> + * object in persistent storage before writing any other new objects
> >> + * that reference it.
> >> + */
> >>  int pretend_object_file(void *, unsigned long, enum object_type,
> >>  			struct object_id *oid);
> >
> > I think this is an improvement over the status quo, but it's still a
> > potential trap for code which happens to run in the same process (see my
> > other email in the thread).
> >
> > Should the message perhaps be even more scary?
> 
> A pet peeve of mine is warning volume escalation: if it becomes common
> for us to say
> 
>  * Warning: callers are reponsible for [...]
> 
> then new warnings trying to stand out might say
> 
>  * WARNING: callers are responsible for [...]
> 
> and then after we are desensitized to that, we may switch to
> 
>  * WARNING WARNING WARNING, not the usual blah-blah: callers are
> 
> and so on.  The main way I have found to counteract that is to make
> the "dangerous curve" markers context-specific enough that people
> don't learn to ignore them.  After all, sometimes a concurrency
> warning is important to me, at other times warnings about clarity may
> be what attract my interest, and so on.

I meant less about the number of capital letters, and more that we
should be saying "this interface is dangerous; don't use it". Because
it's not just "callers are responsible". It's "this can cause subtle
and hard-to-debug issues because it's writing to global state".

My preferred solution would actually be to rip it out entirely, but we'd
need some solution for git-blame, the sole caller. Possibly it could
insert the value straight into the diff_filespec. But according to the
thread that I linked earlier, I poked at that last year but it didn't
look trivial.

> I don't have a good suggestion here.  Perhaps "Callers are responsible
> for" is too slow and something more terse would help?
> 
>  /*
>   * Adds an object to the in-memory object store, without writing it
>   * to disk.
>   *
>   * Use with caution!  Unless you call write_object_file to record the
>   * in-memory object to persistent storage, any other new objects that
>   * reference it will point to a missing (in memory only) object,
>   * resulting in a corrupt repository.
>   */

Yeah, that's more what I had in mind.

> It would be even better if we have some automated way to catch this
> kind of issue.  Should tests run "git fsck" after each test?  Should
> write_object_file have a paranoid mode that checks integrity?
> 
> I don't know an efficient way to do that.  Ultimately I am comfortable
> counting on reviewers to be aware of this kind of pitfall.  While
> nonlocal invariants are always hard to maintain, this pitfall is
> inherent in the semantics of the function, so I am not too worried
> that reviewers will overlook it.

Yeah, given the scope of the problem (we have a single caller, and this
mechanism is over a decade old) I'm fine with review as the enforcement
mechanism, too.

> A less error-prone interface would tie the result of
> pretend_object_file to a short-lived overlay on the_repository without
> affecting global state.  We could even enforce read-only access in
> that overlay.  I don't think the "struct repository" interface and
> callers are ready for that yet, though.

I agree that would be better, though it's still kind-of global (in that
the repository object is effectively a global for most processes).

-Peff
