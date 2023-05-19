Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC7C77B7D
	for <git@archiver.kernel.org>; Fri, 19 May 2023 00:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjESAGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 20:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjESAGE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 20:06:04 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA037198D
        for <git@vger.kernel.org>; Thu, 18 May 2023 17:05:44 -0700 (PDT)
Received: (qmail 6104 invoked by uid 109); 19 May 2023 00:05:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 May 2023 00:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26675 invoked by uid 111); 19 May 2023 00:05:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 May 2023 20:05:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 May 2023 20:05:43 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] format-patch: free elements of rev.ref_message_ids list
Message-ID: <20230519000543.GB1975194@coredump.intra.peff.net>
References: <20230519000239.GA1975039@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230519000239.GA1975039@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are showing multiple patches with format-patch, we have to
repeatedly overwrite the rev.message_id field. We take care to avoid
leaking the old value by either freeing it, or adding it to
ref_message_ids, a string list of ids to reference in subsequent
messages.

But unfortunately we do leak the value via that string list. We try
to clear the string list, courtesy of 89f45cf4eb (format-patch: don't
leak "extra_headers" or "ref_message_ids", 2022-04-13). But since it was
initialized as "nodup", the string list doesn't realize it owns the
strings, and it leaks them.

We have two options here:

  1. Continue to init with "nodup", but then tweak the value of
     ref_message_ids.strdup_strings just before clearing.

  2. Init with "dup", but use "append_nodup" when transferring ownership
     of strings to the list. Clearing just works.

I picked the second here, as I think it calls attention to the tricky
part (transferring ownership via the nodup call).

There's one other related fix we have to do, though. We also insert the
result of clean_message_id() into the list. This _sometimes_ allocates
and sometimes does not, depending on whether we have to remove cruft
from the end of the string. Let's teach it to consistently return an
allocated string, so that the caller knows it must be freed.

There's no new test here, as the leak can already be see in t4014.44 (as
well as others in that script). We can't mark all of t4014 as leak-free,
though, as there are other unrelated leaks that it triggers.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ab74760386..fee5834c0f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1401,7 +1401,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	}
 }
 
-static const char *clean_message_id(const char *msg_id)
+static char *clean_message_id(const char *msg_id)
 {
 	char ch;
 	const char *a, *z, *m;
@@ -1419,7 +1419,7 @@ static const char *clean_message_id(const char *msg_id)
 	if (!z)
 		die(_("insane in-reply-to: %s"), msg_id);
 	if (++z == m)
-		return a;
+		return xstrdup(a);
 	return xmemdupz(a, z - a);
 }
 
@@ -2305,11 +2305,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (in_reply_to || thread || cover_letter) {
 		rev.ref_message_ids = xmalloc(sizeof(*rev.ref_message_ids));
-		string_list_init_nodup(rev.ref_message_ids);
+		string_list_init_dup(rev.ref_message_ids);
 	}
 	if (in_reply_to) {
-		const char *msgid = clean_message_id(in_reply_to);
-		string_list_append(rev.ref_message_ids, msgid);
+		char *msgid = clean_message_id(in_reply_to);
+		string_list_append_nodup(rev.ref_message_ids, msgid);
 	}
 	rev.numbered_files = just_numbers;
 	rev.patch_suffix = fmt_patch_suffix;
@@ -2365,8 +2365,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 				    && (!cover_letter || rev.nr > 1))
 					free(rev.message_id);
 				else
-					string_list_append(rev.ref_message_ids,
-							   rev.message_id);
+					string_list_append_nodup(rev.ref_message_ids,
+								 rev.message_id);
 			}
 			gen_message_id(&rev, oid_to_hex(&commit->object.oid));
 		}
-- 
2.41.0.rc0.359.g22664e20e7
