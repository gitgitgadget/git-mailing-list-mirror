Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 323871F576
	for <e@80x24.org>; Mon, 26 Feb 2018 09:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBZJxO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 04:53:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:36950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751022AbeBZJxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 04:53:14 -0500
Received: (qmail 2378 invoked by uid 109); 26 Feb 2018 09:53:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 09:53:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11075 invoked by uid 111); 26 Feb 2018 09:54:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Feb 2018 04:54:02 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2018 04:53:11 -0500
Date:   Mon, 26 Feb 2018 04:53:11 -0500
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Use of uninitialised value of size 8 in sha1_name.c
Message-ID: <20180226095311.GA14831@sigill.intra.peff.net>
References: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 10:04:22AM +0100, Christian Couder wrote:

> ==21455== Use of uninitialised value of size 8
> ==21455==    at 0x2D2A73: get_hex_char_from_oid (sha1_name.c:492)
> ==21455==    by 0x2D2AFE: extend_abbrev_len (sha1_name.c:502)
> ==21455==    by 0x2D2C3D: find_abbrev_len_for_pack (sha1_name.c:551)
> ==21455==    by 0x2D2CFF: find_abbrev_len_packed (sha1_name.c:569)
> ==21455==    by 0x2D2E12: find_unique_abbrev_r (sha1_name.c:608)
> ==21455==    by 0x2DCB66: strbuf_add_unique_abbrev (strbuf.c:877)
> ==21455==    by 0x14F7CE: update_local_ref (fetch.c:700)
> ==21455==    by 0x1500CF: store_updated_refs (fetch.c:871)
> ==21455==    by 0x15035B: fetch_refs (fetch.c:932)
> ==21455==    by 0x150CF8: do_fetch (fetch.c:1146)
> ==21455==    by 0x1515AB: fetch_one (fetch.c:1370)
> ==21455==    by 0x151A1D: cmd_fetch (fetch.c:1457)
> ==21455==  Uninitialised value was created by a stack allocation
> ==21455==    at 0x2D2B2E: find_abbrev_len_for_pack (sha1_name.c:513)
> ==21455==
> 
> A quick git blame seems to point to 0e87b85683 (sha1_name: minimize
> OID comparisons during disambiguation, 2017-10-12).
> 
> It is difficult to tell for sure though as t5616-partial-clone.sh was
> added after that commit.

I think that commit is to blame, though the error isn't exactly where
that stack trace puts it. Try this:

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..6f7f36436f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -547,7 +547,10 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
 	 */
 	mad->init_len = 0;
 	if (!match) {
-		nth_packed_object_oid(&oid, p, first);
+		warning("p->num_objects = %u, first = %u",
+			p->num_objects, first);
+		if (!nth_packed_object_oid(&oid, p, first))
+			die("oops!");
 		extend_abbrev_len(&oid, mad);
 	} else if (first < num - 1) {
 		nth_packed_object_oid(&oid, p, first + 1);

I get failures all over the test suite, like this:

  warning: p->num_objects = 4, first = 3
  warning: p->num_objects = 8, first = 6
  warning: p->num_objects = 10, first = 0
  warning: p->num_objects = 4, first = 0
  warning: p->num_objects = 8, first = 0
  warning: p->num_objects = 10, first = 10
  fatal: oops!

Any time the abbreviated hex would go after the last object in the pack,
then first==p->num_objects, and nth_packed_object_oid() will fail. That
leaves uninitialized data in "oid", which is what valgrind complains
about when we examine it in extend_abbrev_len().

Most of the time the code behaves correctly anyway, because the
uninitialized bytes are unlikely to match up with our hex and extend the
length. Probably we just need to detect that case and skip the call to
extend_abbrev_len() altogether.

-Peff
