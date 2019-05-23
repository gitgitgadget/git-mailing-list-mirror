Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6908A20380
	for <e@80x24.org>; Thu, 23 May 2019 17:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbfEWR1Y (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 13:27:24 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:57170 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfEWR1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 13:27:24 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 843791F462;
        Thu, 23 May 2019 17:27:23 +0000 (UTC)
Date:   Thu, 23 May 2019 17:27:23 +0000
From:   Eric Wong <e@80x24.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] server-info: do not list unlinked packs
Message-ID: <20190523172723.eny6smdt57zxau6z@dcvr>
References: <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
 <20190515004551.emrxvboqemwnqh4g@dcvr>
 <20190515203839.zixx23bwzeyto6a3@dcvr>
 <20190515214806.GA31693@sigill.intra.peff.net>
 <20190523085959.4q76pokx2gy6wqq7@dcvr>
 <20190523102456.GA6583@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523102456.GA6583@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> wrote:
> On Thu, May 23, 2019 at 08:59:59AM +0000, Eric Wong wrote:
> 
> > > We never delete entries from the in-memory packed_git list; a reprepare
> > > only adds to the list. You'd need to teach update_server_info() to
> > > ignore packs which are no longer present (or switch to exec-ing a
> > > separate update-server-info binary).
> > 
> > Ah, checking files_exists() and setting a bit seems sufficient.
> 
> Yes, though we do we even need to store the bit?

I wanted to avoid the over-allocation, and I hit a bounds error
because I forgot to adjust num_pack as you mentioned below.

> I.e.,
> 
> > @@ -199,12 +200,16 @@ static void init_pack_info(const char *infofile, int force)
> >  		 */
> >  		if (!p->pack_local)
> >  			continue;
> > +		if (!file_exists(p->pack_name)) {
> > +			p->pack_unlinked = 1;
> > +			continue;
> > +		}
> >  		i++;
> >  	}
> >  	num_pack = i;
> >  	info = xcalloc(num_pack, sizeof(struct pack_info *));
> >  	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
> > -		if (!p->pack_local)
> > +		if (!p->pack_local || p->pack_unlinked)
> >  			continue;
> >  		assert(i < num_pack);
> >  		info[i] = xcalloc(1, sizeof(struct pack_info));
> 
> If we just check file_exists() in the second loop, then this is entirely
> local to update_server_info(). And other users of packed_git do not have
> to wonder who is responsible for setting that flag in the global list.
> 
> It does mean you'd over-allocate the array (and num_pack would have to
> be adjusted down to "i" after the second loop), but that's not a big
> deal.  I do think the whole two-loop thing would be more readable if we
> simply grew it on the fly with ALLOC_GROW().

ALLOC_GROW makes the whole thing much nicer.
Thanks for the hint :>

---------------------8<---------------------
Subject: [PATCH] server-info: do not list unlinked packs

Having non-existent packs in objects/info/packs causes
dumb HTTP clients to abort.

v2: use single loop with ALLOC_GROW as suggested by Jeff King

Signed-off-by: Eric Wong <e@80x24.org>
Helped-by: Jeff King <peff@peff.net>
---
Interdiff:
  diff --git a/object-store.h b/object-store.h
  index 2c9facc8f2..272e01e452 100644
  --- a/object-store.h
  +++ b/object-store.h
  @@ -77,7 +77,6 @@ struct packed_git {
   		 freshened:1,
   		 do_not_close:1,
   		 pack_promisor:1,
  -		 pack_unlinked:1,
   		 multi_pack_index:1;
   	unsigned char hash[GIT_MAX_RAWSZ];
   	struct revindex_entry *revindex;
  diff --git a/server-info.c b/server-info.c
  index 69e2c5279b..92187c70db 100644
  --- a/server-info.c
  +++ b/server-info.c
  @@ -192,30 +192,21 @@ static void init_pack_info(const char *infofile, int force)
   {
   	struct packed_git *p;
   	int stale;
  -	int i = 0;
  +	int i;
  +	size_t alloc = 0;
   
   	for (p = get_all_packs(the_repository); p; p = p->next) {
   		/* we ignore things on alternate path since they are
   		 * not available to the pullers in general.
   		 */
  -		if (!p->pack_local)
  -			continue;
  -		if (!file_exists(p->pack_name)) {
  -			p->pack_unlinked = 1;
  -			continue;
  -		}
  -		i++;
  -	}
  -	num_pack = i;
  -	info = xcalloc(num_pack, sizeof(struct pack_info *));
  -	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
  -		if (!p->pack_local || p->pack_unlinked)
  +		if (!p->pack_local || !file_exists(p->pack_name))
   			continue;
  -		assert(i < num_pack);
  +
  +		i = num_pack++;
  +		ALLOC_GROW(info, num_pack, alloc);
   		info[i] = xcalloc(1, sizeof(struct pack_info));
   		info[i]->p = p;
   		info[i]->old_num = -1;
  -		i++;
   	}
   
   	if (infofile && !force)

 server-info.c | 18 +++++++-----------
 t/t6500-gc.sh |  2 ++
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/server-info.c b/server-info.c
index 41274d098b..92187c70db 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "dir.h"
 #include "repository.h"
 #include "refs.h"
 #include "object.h"
@@ -191,26 +192,21 @@ static void init_pack_info(const char *infofile, int force)
 {
 	struct packed_git *p;
 	int stale;
-	int i = 0;
+	int i;
+	size_t alloc = 0;
 
 	for (p = get_all_packs(the_repository); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
-		if (!p->pack_local)
-			continue;
-		i++;
-	}
-	num_pack = i;
-	info = xcalloc(num_pack, sizeof(struct pack_info *));
-	for (i = 0, p = get_all_packs(the_repository); p; p = p->next) {
-		if (!p->pack_local)
+		if (!p->pack_local || !file_exists(p->pack_name))
 			continue;
-		assert(i < num_pack);
+
+		i = num_pack++;
+		ALLOC_GROW(info, num_pack, alloc);
 		info[i] = xcalloc(1, sizeof(struct pack_info));
 		info[i]->p = p;
 		info[i]->old_num = -1;
-		i++;
 	}
 
 	if (infofile && !force)
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
-- 
EW
