Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A79020380
	for <e@80x24.org>; Thu, 23 May 2019 09:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfEWJAA (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 05:00:00 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51316 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWJAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 05:00:00 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 742591F462;
        Thu, 23 May 2019 08:59:59 +0000 (UTC)
Date:   Thu, 23 May 2019 08:59:59 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] server-info: do not list unlinked packs
Message-ID: <20190523085959.4q76pokx2gy6wqq7@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
 <20190515203839.zixx23bwzeyto6a3@dcvr>
 <20190515214806.GA31693@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515214806.GA31693@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Wed, May 15, 2019 at 08:38:39PM +0000, Eric Wong wrote:
> 
> > I've also noticed objects/info/packs contains stale entries
> > after repack/gc runs on current git.
> > 
> > Tried adding reprepare_packed_git before update_server_info,
> > but that didn't seem to work; so maybe something isn't cleared.
> > Might have time to investigate more this week, might not...
> 
> We never delete entries from the in-memory packed_git list; a reprepare
> only adds to the list. You'd need to teach update_server_info() to
> ignore packs which are no longer present (or switch to exec-ing a
> separate update-server-info binary).

Ah, checking files_exists() and setting a bit seems sufficient.

--------8<---------
Subject: [PATCH] server-info: do not list unlinked packs

Having non-existent packs in objects/info/packs causes
dumb HTTP clients to abort.

There remains a small window where the old objects/info/packs
file can refer to unlinked packs.  That's unavoidable even on a
local FS given the time-of-use-time-of-check window between
listing and retrieving files.

Signed-off-by: Eric Wong <e@80x24.org>
---
  I think the small window I refer to can be worked around by
  teaching the dumb HTTP client to reread objects/info/packs
  if it 404s while trying to GET a pack...

 object-store.h | 1 +
 server-info.c  | 7 ++++++-
 t/t6500-gc.sh  | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/object-store.h b/object-store.h
index 272e01e452..2c9facc8f2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -77,6 +77,7 @@ struct packed_git {
 		 freshened:1,
 		 do_not_close:1,
 		 pack_promisor:1,
+		 pack_unlinked:1,
 		 multi_pack_index:1;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	struct revindex_entry *revindex;
diff --git a/server-info.c b/server-info.c
index 41274d098b..69e2c5279b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "repository.h"
 #include "refs.h"
 #include "object.h"
@@ -199,12 +200,16 @@ static void init_pack_info(const char *infofile, int force)
 		 */
 		if (!p->pack_local)
 			continue;
+		if (!file_exists(p->pack_name)) {
+			p->pack_unlinked = 1;
+			continue;
+		}
 		i++;
 	}
 	num_pack = i;
 	info = xcalloc(num_pack, sizeof(struct pack_info *));
 	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
-		if (!p->pack_local)
+		if (!p->pack_local || p->pack_unlinked)
 			continue;
 		assert(i < num_pack);
 		info[i] = xcalloc(1, sizeof(struct pack_info));
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 515c6735e9..c0f04dc6b0 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -71,6 +71,8 @@ test_expect_success 'gc --keep-largest-pack' '
 		git gc --keep-largest-pack &&
 		( cd .git/objects/pack && ls *.pack ) >pack-list &&
 		test_line_count = 2 pack-list &&
+		awk "/^P /{print \$2}" <.git/objects/info/packs >pack-info &&
+		test_line_count = 2 pack-info &&
 		test_path_is_file $BASE_PACK &&
 		git fsck
 	)

base-commit: aa25c82427ae70aebf3b8f970f2afd54e9a2a8c6
-- 
EW
