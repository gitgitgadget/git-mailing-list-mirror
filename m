Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266BFC433E0
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E11066199A
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 11:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhCaLCR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 07:02:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:38458 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235531AbhCaLCF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 07:02:05 -0400
Received: (qmail 28550 invoked by uid 109); 31 Mar 2021 11:02:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 31 Mar 2021 11:02:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3191 invoked by uid 111); 31 Mar 2021 11:02:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Mar 2021 07:02:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Mar 2021 07:02:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
Message-ID: <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq35wdfaw5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 29, 2021 at 10:50:18PM -0700, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
> 
> > Fix a regression in 89e4202f982 ([PATCH] Parse tags for absent
> > objects, 2005-06-21) (yes, that ancient!) and correctly report an
> > error on a tag like:
> >
> >     object <a tree hash>
> >     type commit
> >
> > As:
> >
> >     error: object <a tree hash> is tree, not a commit
> >
> > Instead of our long-standing misbehavior of inverting the two, and
> > reporting:
> >
> >     error: object <a tree hash> is commit, not a tree
> >
> > Which, as can be trivially seen with 'git cat-file -t <a tree hash>'
> > is incorrect.
> 
> Hmph, I've always thought it is just "supposed to be a" missing in
> the sentence ;-)

So going with the discussion elsewhere in the thread, I'd probably say
something like:

  error: object <oid> seen as both a commit and a tree

which precisely says what we do know, without implying which is correct.

Ævar's patch tries to improve the case where we might _know_ which is
correct (because we're actually parsing the object contents), but of
course it covers only a fraction of cases. I'm not really opposed to
that per se, but I probably wouldn't bother myself.

  Side note: this is all making the assumption that what is in the
  object itself is "correct", but of course that is not necessarily
  true, even. All of these cases are the result of bugs, so it is
  possible that the bug was in the writing of the original object
  contents, and not the object that is referring to it. Likewise, I'd
  imagine an easy way to get into this situation is with a bogus
  refs/replace object that switches type.

> > Hence the non-intuitive solution of adding a
> > lookup_{blob,commit,tag,tree}_type() function. It's to distinguish
> > calls from parse_object_buffer() where we actually know the type, from
> > a parse_tag_buffer() where we're just guessing about the type.
> 
> I think it makes sense to allow the caller to express distinction
> between "I know that this object is a blob, because I just read its
> object header" and "Another object tells me that this object must be
> a blob, because it is in a tree entry whose mode bits are 100644".
> 
> I wish we found a set of names better than lookup_<type>_type() for
> that, though.  It's just between
> 
>       lookup_tag_type(r, oid, OBJ_NONE);
>       lookup_tag_type(r, oid, OBJ_TAG);
> 
> I cannot quite tell which one is which.  I also wonder if the last
> arg should just be a boolean ("I know it is a tag" vs "I heard it
> must be a tag").

Yeah, I also found that very confusing. AFAICT lookup_tag_type() would
only ever see OBJ_NONE or OBJ_TAG. Making it more than a boolean makes
both the interface and implementation more complicated.

I also think the manual handling of OBJ_NONE in each lookup_* function
is confusing. They all call object_as_type() because the point of that
function is both to type-check the struct and to convert it away from
OBJ_NONE.

If we handled this error there, then I think it would be much more
natural, because we'd have already covered the OBJ_NONE case, and
because it's already the place we're emitting the existing error. E.g.:

diff --git a/object.c b/object.c
index 2c32691dc4..e6345541f7 100644
--- a/object.c
+++ b/object.c
@@ -157,7 +157,7 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
 	return obj;
 }
 
-void *object_as_type(struct object *obj, enum object_type type, int quiet)
+void *object_as_type(struct object *obj, enum object_type type, unsigned flags)
 {
 	if (obj->type == type)
 		return obj;
@@ -169,10 +169,16 @@ void *object_as_type(struct object *obj, enum object_type type, int quiet)
 		return obj;
 	}
 	else {
-		if (!quiet)
-			error(_("object %s is a %s, not a %s"),
-			      oid_to_hex(&obj->oid),
-			      type_name(obj->type), type_name(type));
+		if (!(flags & OBJECT_AS_TYPE_QUIET)) {
+			if (flags & OBJECT_AS_TYPE_EXPECT_PARSED)
+				error(_("object %s is a %s, but was referred to as a %s"),
+				      oid_to_hex(&obj->oid), type_name(obj->type),
+				      type_name(type));
+			else
+				error(_("object %s referred to as both a %s and a %s"),
+				      oid_to_hex(&obj->oid),
+				      type_name(obj->type), type_name(type));
+		}
 		return NULL;
 	}
 }

-Peff
