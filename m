Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07837C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 19:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKUTWO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 14:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiKUTWC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 14:22:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2360819C1D
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 11:22:00 -0800 (PST)
Received: (qmail 12511 invoked by uid 109); 21 Nov 2022 19:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 21 Nov 2022 19:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26641 invoked by uid 111); 21 Nov 2022 19:22:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Nov 2022 14:22:00 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Nov 2022 14:21:59 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] parse_object(): check on-disk type of suspected blob
Message-ID: <Y3vP16OJSP19VMMy@coredump.intra.peff.net>
References: <Y3a3qcqNG8W3ueeb@coredump.intra.peff.net>
 <Y3a4jKzsHSooYFqj@coredump.intra.peff.net>
 <221118.86cz9lgjxu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221118.86cz9lgjxu.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2022 at 01:36:23AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > -	if ((obj && obj->type == OBJ_BLOB && repo_has_object_file(r, oid)) ||
> > -	    (!obj && oid_object_info(r, oid, NULL) == OBJ_BLOB)) {
> > +	if ((!obj || (obj && obj->type == OBJ_BLOB)) &&
> > +	    oid_object_info(r, oid, NULL) == OBJ_BLOB) {
> >  		if (!skip_hash && stream_object_signature(r, repl) < 0) {
> >  			error(_("hash mismatch %s"), oid_to_hex(oid));
> >  			return NULL;
> 
> But why:
> 
> 	if ((!x || (x && x->m)) && ...)
> 
> Instead of:
> 
> 	if ((!x || x->m)) && ...)
> 
> If "!obj" is false then "obj" must be non-NULL, so you don't need to
> check it again and can lose the "obj &&".

Just that it was one more round of refactoring than I did. :)

I agree that it's much more readable. It looks like the original hit
'next', so I'll send a patch on top.

> I applied this on top of "master", and adjusted your test to be this
> instead:
> 
> 	test_expect_success 'traverse unexpected non-blob tag (lone)' '
> 		cat >expect <<-EOF &&
> 		error: object $commit is a blob, not a commit
> 		fatal: bad object $commit
> 		EOF
> 		test_must_fail git rev-list --objects $tag >out 2>actual &&
> 		test_must_be_empty out &&
> 		test_cmp expect actual
> 	'
> 
> Which passes, showing that we're still not correctly identifying it, but
> we are doing it for the purposes of erroring out, but the incorrect type
> persists.
> 
> Now, this all does seem quite familiar... :) :
> https://lore.kernel.org/git/patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com/
> 
> I.e. that's the rest of the fix for this issue. I applied this change on
> my local branch with that, and they combine nicely. the "test_must_fail"
> here works as intended, *and* we'll correctly report & store the type.

Right. It's hitting the exact same code path as all of the other object
types now. You suggested adding to the test here, but I'd prefer not to
do that. Noticing that we have a type mismatch is what is fixed, and it
now does that just like all the other object types. Dealing with the
message reversal is orthogonal.

> > But more importantly, it looks like pw/test-todo would provide us with a
> > much nicer pattern there. It seems to be stalled on review, so let's see
> > if we can get that moving again.
> 
> The "TODO (should fail!)" didn't stand out? But yeah, having a "todo" or
> "test_expect_todo" or "test_expect_failure" not suck would be nice.

I did double-take on the "TODO" just because that is not our usual
pattern, but that was easily fixed. What I really don't like about the
"switch failure to success" pattern is that it requires rewriting the
test to expect the wrong thing! So when somebody later fixes the bug,
they get a confusing failure, but must also rewrite the test back to
what it originally should have been.

That was not too hard here, where it was just replacing a
test_must_fail, but that earlier hunk in cf10c5b4cf that actualy adds in
expected output (that we know is the wrong thing to be printing!) seems
a bit over the top to me. Anybody who encounters it has to dig into the
history to understand what is going on.

-Peff
