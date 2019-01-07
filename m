Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32D7D1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 08:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfAGIjf (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 03:39:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:56414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725550AbfAGIjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 03:39:35 -0500
Received: (qmail 1794 invoked by uid 109); 7 Jan 2019 08:39:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Jan 2019 08:39:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 857 invoked by uid 111); 7 Jan 2019 08:39:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 07 Jan 2019 03:39:13 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2019 03:39:33 -0500
Date:   Mon, 7 Jan 2019 03:39:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH 10/11] sha1-file: avoid "sha1 file" for generic use in
 messages
Message-ID: <20190107083933.GJ29431@sigill.intra.peff.net>
References: <20190107083150.GC21362@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These error messages say "sha1 file", which is vague and not common in
user-facing documentation. Unlike the conversions from the previous
commit, these do not always refer to loose objects.

In finalize_object_file() we could be dealing with a packfile. Let's
just say "unable to write file" instead; since we include the filename,
the nature of the file is clear from the rest of the message.

In force_object_loose(), we're calling into read_object(), which could
actually be _any_ type of object. Just say "object".

Signed-off-by: Jeff King <peff@peff.net>
---
 sha1-file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sha1-file.c b/sha1-file.c
index 07cc9b548b..55a4782844 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1521,7 +1521,7 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 	unlink_or_warn(tmpfile);
 	if (ret) {
 		if (ret != EEXIST) {
-			return error_errno(_("unable to write sha1 filename %s"), filename);
+			return error_errno(_("unable to write file %s"), filename);
 		}
 		/* FIXME!!! Collision check here ? */
 	}
@@ -1744,7 +1744,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 		return 0;
 	buf = read_object(oid, &type, &len);
 	if (!buf)
-		return error(_("cannot read sha1_file for %s"), oid_to_hex(oid));
+		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
 	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime);
 	free(buf);
-- 
2.20.1.470.g640a3e2614

