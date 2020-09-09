Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32CCC433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1AA21D6C
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 19:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIITRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:17:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:52538 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIITRs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 15:17:48 -0400
Received: (qmail 6996 invoked by uid 109); 9 Sep 2020 19:17:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Sep 2020 19:17:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4841 invoked by uid 111); 9 Sep 2020 19:17:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Sep 2020 15:17:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Sep 2020 15:17:46 -0400
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        whydoubt@gmail.com, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] blame.c: replace instance of !oidcmp for oideq
Message-ID: <20200909191746.GA2514794@coredump.intra.peff.net>
References: <20200907171639.766547-1-eantoranz@gmail.com>
 <ce94b41f-e829-d7ca-a5f5-e41748caea81@gmail.com>
 <20200909091149.GB2496536@coredump.intra.peff.net>
 <CAOc6etZS3mGxsPPh25XFi2-qR0TNzq0Gx1NrydgQwmHbsjxejA@mail.gmail.com>
 <20200909191345.GA2511547@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200909191345.GA2511547@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 09, 2020 at 03:13:46PM -0400, Jeff King wrote:

> Which really _seems_ like a bug in coccinelle, unless I am missing
> something. Because both of those parameters look like object_id pointers
> (and the compiler would be complaining if it were not the case).  But I
> also wonder if giving the specific types in the coccinelle rule is
> buying us anything. If you passed two void pointers or ints or whatever
> to !oidcmp(), we'd still want to rewrite it as oideq().

And indeed, just blindly swapping out "struct object_id" for
"expression" in the coccinelle file (patch below), shows another spot
that was missed:

diff -u -p a/packfile.c b/packfile.c
--- a/packfile.c
+++ b/packfile.c
@@ -735,7 +735,7 @@ struct packed_git *add_packed_git(const
 	p->mtime = st.st_mtime;
 	if (path_len < the_hash_algo->hexsz ||
 	    get_sha1_hex(path + path_len - the_hash_algo->hexsz, p->hash))
-		hashclr(p->hash);
+		oidclr(p);
 	return p;
 }
 

Maybe it's worth being looser in our cocci patch definitions. I'm having
trouble thinking of a downside...

-Peff

-- >8 --
Here's the patch to loosen object_id.cocci. Perhaps we'd want to do the
same in other files.

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index ddf4f22bd7..738c60923e 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -1,62 +1,62 @@
 @@
-struct object_id OID;
+expression OID;
 @@
 - is_null_sha1(OID.hash)
 + is_null_oid(&OID)
 
 @@
-struct object_id *OIDPTR;
+expression *OIDPTR;
 @@
 - is_null_sha1(OIDPTR->hash)
 + is_null_oid(OIDPTR)
 
 @@
-struct object_id OID;
+expression OID;
 @@
 - hashclr(OID.hash)
 + oidclr(&OID)
 
 @@
 identifier f != oidclr;
-struct object_id *OIDPTR;
+expression *OIDPTR;
 @@
   f(...) {<...
 - hashclr(OIDPTR->hash)
 + oidclr(OIDPTR)
   ...>}
 
 @@
-struct object_id OID1, OID2;
+expression OID1, OID2;
 @@
 - hashcmp(OID1.hash, OID2.hash)
 + oidcmp(&OID1, &OID2)
 
 @@
 identifier f != oidcmp;
-struct object_id *OIDPTR1, OIDPTR2;
+expression *OIDPTR1, OIDPTR2;
 @@
   f(...) {<...
 - hashcmp(OIDPTR1->hash, OIDPTR2->hash)
 + oidcmp(OIDPTR1, OIDPTR2)
   ...>}
 
 @@
-struct object_id *OIDPTR;
-struct object_id OID;
+expression *OIDPTR;
+expression OID;
 @@
 - hashcmp(OIDPTR->hash, OID.hash)
 + oidcmp(OIDPTR, &OID)
 
 @@
-struct object_id *OIDPTR;
-struct object_id OID;
+expression *OIDPTR;
+expression OID;
 @@
 - hashcmp(OID.hash, OIDPTR->hash)
 + oidcmp(&OID, OIDPTR)
 
 @@
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
+expression OIDPTR1;
+expression OIDPTR2;
 @@
 - oidcmp(OIDPTR1, OIDPTR2) == 0
 + oideq(OIDPTR1, OIDPTR2)
@@ -71,8 +71,8 @@ expression E1, E2;
   ...>}
 
 @@
-struct object_id *OIDPTR1;
-struct object_id *OIDPTR2;
+expression *OIDPTR1;
+expression *OIDPTR2;
 @@
 - oidcmp(OIDPTR1, OIDPTR2) != 0
 + !oideq(OIDPTR1, OIDPTR2)
