Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F24121F4C1
	for <e@80x24.org>; Thu, 17 Oct 2019 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393088AbfJQMKq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 08:10:46 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:55506 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731634AbfJQMKq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 08:10:46 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 9A7651F4C0;
        Thu, 17 Oct 2019 12:10:45 +0000 (UTC)
Date:   Thu, 17 Oct 2019 12:10:45 +0000
From:   Eric Wong <e@80x24.org>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [RFC/WIP] range-diff: show old/new blob OIDs in comments
Message-ID: <20191017121045.GA15364@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(WIP, mostly stream-of-concious notes + reasoning)

When using "git format-patch --range-diff", the pre and
post-image blob OIDs are in each email, while the exact
commit OIDs are rarely shared via emails (only the tip
commit from "git request-pull").

These blob OIDs make it easy to search for or lookup the
full emails which create them, or the blob itself once
it's fetched via git.

public-inbox indexes and allows querying specifically for blob
OIDs via dfpre:/dfpost: since June 2017.  As of Jan 2019,
public-inbox also supports recreating blobs out of patch emails
(querying internally with dfpre:/dfpost: and doing "git apply")

Searching on these blob OIDs also makes it easier to find
previous versions of the patch sets using any mail search
engine.

Future changes to public-inbox may allow generating custom
diffs out of any blobs it can find or recreate.

Most of this is pretty public-inbox-specific and would've
made some future changes to public-inbox much easier....
(if we had this from the start of range-diff).

Unfortunately, it won't help with cases where range-diffs
are already published, but range-diff isn't too old.

I'm also still learning my way around git's C internals, but
using patch.{old,new}_oid_prefix seems alright...

FIXME: tests, t3206 needs updating

Not-signed-off-by: Eric Wong <e@80x24.org>
---
 range-diff.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 7fed5a3b4b..85d2f1f58f 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -118,13 +118,24 @@ static int read_patches(const char *range, struct string_list *list)
 				die(_("could not parse git header '%.*s'"), (int)len, line);
 			strbuf_addstr(&buf, " ## ");
 			if (patch.is_new > 0)
-				strbuf_addf(&buf, "%s (new)", patch.new_name);
+				strbuf_addf(&buf, "%s (new %s)",
+						patch.new_name,
+						patch.new_oid_prefix);
 			else if (patch.is_delete > 0)
-				strbuf_addf(&buf, "%s (deleted)", patch.old_name);
+				strbuf_addf(&buf, "%s (deleted %s)",
+						patch.old_name,
+						patch.old_oid_prefix);
 			else if (patch.is_rename)
-				strbuf_addf(&buf, "%s => %s", patch.old_name, patch.new_name);
+				strbuf_addf(&buf, "%s => %s (%s..%s)",
+						patch.old_name,
+						patch.new_name,
+						patch.old_oid_prefix,
+						patch.new_oid_prefix);
 			else
-				strbuf_addstr(&buf, patch.new_name);
+				strbuf_addf(&buf, "%s (%s..%s)",
+						patch.new_name,
+						patch.old_oid_prefix,
+						patch.new_oid_prefix);
 
 			free(current_filename);
 			if (patch.is_delete > 0)

