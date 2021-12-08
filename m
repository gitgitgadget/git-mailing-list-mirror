Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC540C433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 03:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbhLHDa3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 22:30:29 -0500
Received: from cloud.peff.net ([104.130.231.41]:46404 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243850AbhLHDa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 22:30:28 -0500
Received: (qmail 9217 invoked by uid 109); 8 Dec 2021 03:26:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Dec 2021 03:26:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28215 invoked by uid 111); 8 Dec 2021 03:26:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Dec 2021 22:26:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Dec 2021 22:26:56 -0500
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Fwd: coverity problems in reftable code
Message-ID: <YbAmANn6t9S5qKWA@coredump.intra.peff.net>
References: <YarO3nkrutmWF7nb@coredump.intra.peff.net>
 <CAFQ2z_OK5949p1WfovJ00Katk5hTv_oeLo-ZRCi1XqrtzQqL2g@mail.gmail.com>
 <CAFQ2z_OrN+RkwnMyrJHdh5xN6ueOP8KKBVQ7-U4kEkA3ApcuNg@mail.gmail.com>
 <YbAOZMxGDELhgfut@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbAOZMxGDELhgfut@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 07, 2021 at 08:46:12PM -0500, Jeff King wrote:

> > > The summary of issues is below. You can get more details on their site.
> > > I _think_ I've configured it so that anybody can look at:
> > >
> > >   https://scan.coverity.com/projects/peff-git/view_defects
> > 
> > Alas, it says I have no access, even after I logged in.
> 
> ...hrmph. I have it "open to all users", but maybe you have to be
> associated with the project. I'll send you an "invite" through the
> Coverity site and see if that works (of course don't feel obligated if
> you don't want to deal further with Coverity; it _does_ produce a ton of
> false positives, but it sometimes says useful things, too).

I also applied your coverity fixups to my tree, and pushed up the
result. As expected, Coverity claims many problems fixed, but also a few
new ones found.

Summary is below, but I'm not sure it's that useful without the whole
code flow. The unreachable-code one seems just wrong. We can get there
via the "goto done" in the BLOCK_TYPE_LOG conditional, it looks like.

The first FORWARD_NULL doesn't look obvious to me from the code. But it
triggers a segfault running "test-tool reftable". (It didn't immediately
for me on Linux, but Windows CI shows it, and compiling with ASan on
Linux does too).

-- >8 --
** CID 1467061:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 356 in test_reftable_obj_record_roundtrip()

________________________________________________________________________________________________________
*** CID 1467061:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 356 in test_reftable_obj_record_roundtrip()
350     
351     		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
352     		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
353     
354     		EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
355     			       in.u.obj.hash_prefix_len));
>>>     CID 1467061:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "out.u.obj.offsets" to "memcmp", which dereferences it.
356     		EXPECT(0 == memcmp(in.u.obj.offsets, out.u.obj.offsets,
357     				   sizeof(uint64_t) * in.u.obj.offset_len));
358     		strbuf_release(&key);
359     		reftable_record_release(&out);
360     	}
361     }

** CID 1467060:  Possible Control flow issues  (DEADCODE)
/reftable/block.c: 263 in block_reader_init()


________________________________________________________________________________________________________
*** CID 1467060:  Possible Control flow issues  (DEADCODE)
/reftable/block.c: 263 in block_reader_init()
257     	br->header_off = header_off;
258     	br->restart_count = restart_count;
259     	br->restart_bytes = restart_bytes;
260     
261     done:
262     	if (uncompressed) {
>>>     CID 1467060:  Possible Control flow issues  (DEADCODE)
>>>     Execution cannot reach this statement: "reftable_free(uncompressed);".
263     		reftable_free(uncompressed);
264     	}
265     	return err;
266     }
267     
268     static uint32_t block_reader_restart_offset(struct block_reader *br, int i)

** CID 1467059:  Null pointer dereferences  (FORWARD_NULL)


________________________________________________________________________________________________________
*** CID 1467059:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 155 in test_reftable_ref_record_roundtrip()
149     		EXPECT(n > 0);
150     
151     		/* decode into a non-zero reftable_record to test for leaks. */
152     		m = reftable_record_decode(&out, key, i, dest, GIT_SHA1_RAWSZ);
153     		EXPECT(n == m);
154     
>>>     CID 1467059:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing "&out.u.ref" to "reftable_ref_record_equal", which dereferences null "out.u.ref.refname".
155     		EXPECT(reftable_ref_record_equal(&in.u.ref, &out.u.ref,
156     						 GIT_SHA1_RAWSZ));
157     		reftable_record_release(&in);
158     
159     		strbuf_release(&key);
160     		reftable_record_release(&out);

** CID 1467058:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 354 in test_reftable_obj_record_roundtrip()


________________________________________________________________________________________________________
*** CID 1467058:  Null pointer dereferences  (FORWARD_NULL)
/reftable/record_test.c: 354 in test_reftable_obj_record_roundtrip()
348     					   GIT_SHA1_RAWSZ);
349     		EXPECT(n == m);
350     
351     		EXPECT(in.u.obj.hash_prefix_len == out.u.obj.hash_prefix_len);
352     		EXPECT(in.u.obj.offset_len == out.u.obj.offset_len);
353     
>>>     CID 1467058:  Null pointer dereferences  (FORWARD_NULL)
>>>     Passing null pointer "out.u.obj.hash_prefix" to "memcmp", which dereferences it.
354     		EXPECT(!memcmp(in.u.obj.hash_prefix, out.u.obj.hash_prefix,
355     			       in.u.obj.hash_prefix_len));
356     		EXPECT(0 == memcmp(in.u.obj.offsets, out.u.obj.offsets,
357     				   sizeof(uint64_t) * in.u.obj.offset_len));
358     		strbuf_release(&key);
359     		reftable_record_release(&out);
