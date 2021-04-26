Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570ECC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9DA61175
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 15:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbhDZPqF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 11:46:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:35392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233919AbhDZPqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 11:46:04 -0400
Received: (qmail 29991 invoked by uid 109); 26 Apr 2021 15:45:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Apr 2021 15:45:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7493 invoked by uid 111); 26 Apr 2021 15:45:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Apr 2021 11:45:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Apr 2021 11:45:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 5/6] fsck: report invalid types recorded in objects
Message-ID: <YIbgEaY+cie/4h2X@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com>
 <cover-0.6-00000000000-20210413T093734Z-avarab@gmail.com>
 <patch-5.6-5fb6ac4faee-20210413T093734Z-avarab@gmail.com>
 <YILbk34nwqCPmxGQ@coredump.intra.peff.net>
 <87im493yos.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87im493yos.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 26, 2021 at 04:28:30PM +0200, Ævar Arnfjörð Bjarmason wrote:

> >> @@ -92,7 +93,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> >>  	switch (opt) {
> >>  	case 't':
> >>  		oi.type_name = &sb;
> >> -		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
> >> +		ret = oid_object_info_extended(the_repository, &oid, &oi, flags);
> >> +		if (!unknown_type && ret < 0)
> >>  			die("git cat-file: could not get object info");
> >>  		if (sb.len) {
> >>  			printf("%s\n", sb.buf);
> >
> > Surprised to see changes to cat-file here, since the commit message is
> > all about fsck. Did the semantics of oid_object_info_extended() change?
> > I.e., this hunk implies to me that it is now returning -1 when we said
> > unknown types were OK, and we got one. But in that case, how do we
> > distinguish that from a real error?
> >
> > Or more concretely, this patch causes this:
> >
> >   $ git cat-file -t 1234567890123456789012345678901234567890
> >   fatal: git cat-file: could not get object info
> >
> >   $ git.compile cat-file --allow-unknown-type -t 1234567890123456789012345678901234567890
> >   fatal: git cat-file 1234567890123456789012345678901234567890: bad file
> >
> > Or much worse, from the next hunk:
> >
> >   $ git cat-file -s 1234567890123456789012345678901234567890
> >   fatal: git cat-file: could not get object info
> >
> >   $ git cat-file --allow-unknown-type -s 1234567890123456789012345678901234567890
> >   140732113568960
> >
> > That seems wrong (so I think my "this hunk implies" is not true, but
> > then I am left with: what is the point of this hunk?).
> 
> That's very well spotted.
> 
> I started re-rolling this today but ran out of time. For what it's worth
> the combination of this and 6/6 "makes sense" in the sense that all
> tests pass at the end of this series.
> 
> But the cases you're pointing out are ones we don't have tests for,
> i.e. the combination of "allow unknown" and a non-existing object, as
> opposed to a garbage one.
> 
> Hence the bug with passing up an invalid (uninitialized) size in that
> case. It's fallout from other partial lib-ification changes of these
> APIs, i.e. making them return bad values upstream instead of dying right
> away.

I'm not sure I understand. The problem seems solely in the hunk above.
Before, if we got an error from oid_object_info_extended(), we stopped
immediately. But after, we look at the results even though it told us
there was an error. In general, I would think that a "-1" return value
from oid_object_info_extended() is "all bets are off" (remember that
unlike oid_object_info(), this is a strict error return, and not trying
to force the object type into the return value).

And that's independent of what the other patches in the series are
doing, I think.

> I'll sort that out in some sensible way. Starting with adding meaningful
> test coverage for the existing behavior.

Yeah, that sounds fine. I think the current behavior there is perfectly
reasonable (fail with "could not get object info").

-Peff
