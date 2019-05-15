Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5B01F4B6
	for <e@80x24.org>; Wed, 15 May 2019 00:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfEOApx (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 20:45:53 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:51616 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfEOApx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 20:45:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 0F1421F461;
        Wed, 15 May 2019 00:45:52 +0000 (UTC)
Date:   Wed, 15 May 2019 00:45:51 +0000
From:   Eric Wong <e@80x24.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/1] server-info: conditionally update on fetch
Message-ID: <20190515004551.emrxvboqemwnqh4g@dcvr>
References: <20190511013455.5886-1-e@80x24.org>
 <87v9ygwoj0.fsf@evledraar.gmail.com>
 <20190512040825.GA25370@sigill.intra.peff.net>
 <87tve0w3ao.fsf@evledraar.gmail.com>
 <20190514094729.GA12256@sigill.intra.peff.net>
 <20190514115047.oncvfq24fhnp64re@dcvr>
 <87ftphw7mv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ftphw7mv.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Aside from this change, I wonder if making "fetch" optionally "exit 1"
> if no refs were updated would be useful, as in the below WIP. Of course
> it would be better to distinguish errors from "no refs to update".

Yes, we should've had this feature all along :)

And it's easy for me to build off your WIP to have fetch
update server info iff info/refs already exists:

-------8<-------
Subject: [PATCH 2/1] server-info: conditionally update on fetch

Since fetch can invalidate existing server info files, use the
new `updated_refs' counter to update server info files iff
info/refs already exists.

Note: this depends on Ævar's WIP in:
	https://public-inbox.org/git/87ftphw7mv.fsf@evledraar.gmail.com/

Signed-off-by: Eric Wong <e@80x24.org>
---
 builtin/fetch.c        |  3 +++
 server-info.c          | 22 +++++++++++++++++++---
 t/t5513-fetch-track.sh | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index da5414d9db..b35d4d105d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1681,6 +1681,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	close_all_packs(the_repository->objects);
 
+	if (updated_refs)
+		update_server_info(-1);
+
 	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
 	if (verbosity < 0)
 		argv_array_push(&argv_gc_auto, "--quiet");
diff --git a/server-info.c b/server-info.c
index e68f785c2f..d4065d56a3 100644
--- a/server-info.c
+++ b/server-info.c
@@ -7,6 +7,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "strbuf.h"
+#include "dir.h"
 
 struct update_info_ctx {
 	FILE *cur_fp;
@@ -170,10 +171,25 @@ static int generate_info_refs(struct update_info_ctx *uic)
 	return for_each_ref(add_info_ref, uic);
 }
 
-static int update_info_refs(int force)
+static int want_update(int *force, const char *path)
+{
+	if (*force < 0) {
+		if (file_exists(path))
+			*force = 0; /* continue to normal update */
+		else
+			return 0;
+	}
+	return 1;
+}
+
+static int update_info_refs(int *force)
 {
 	char *path = git_pathdup("info/refs");
-	int ret = update_info_file(path, generate_info_refs, force);
+	int ret = 0;
+
+	if (want_update(force, path))
+		ret = update_info_file(path, generate_info_refs, *force);
+
 	free(path);
 	return ret;
 }
@@ -361,7 +377,7 @@ int update_server_info(int force)
 	 */
 	int errs = 0;
 
-	errs = errs | update_info_refs(force);
+	errs = errs | update_info_refs(&force);
 	errs = errs | update_info_packs(force);
 
 	/* remove leftover rev-cache file if there is any */
diff --git a/t/t5513-fetch-track.sh b/t/t5513-fetch-track.sh
index 65d1e05bd6..421f16ddfd 100755
--- a/t/t5513-fetch-track.sh
+++ b/t/t5513-fetch-track.sh
@@ -27,4 +27,25 @@ test_expect_success fetch '
 	)
 '
 
+test_expect_success 'info/refs not created by fetch' '
+	(
+		cd other &&
+		test_path_is_dir .git/info &&
+		! test_path_is_file .git/info/refs
+	)
+'
+
+test_expect_success 'info/refs updated by fetch if it already exists' '
+	git branch b/for-info-refs &&
+	(
+		cd other &&
+		git update-server-info &&
+		test_path_is_file .git/info/refs &&
+		! grep b/for-info-refs .git/info/refs &&
+		git fetch &&
+		test_path_is_file .git/info/refs &&
+		grep b/for-info-refs .git/info/refs
+	)
+'
+
 test_done
-- 
EW
