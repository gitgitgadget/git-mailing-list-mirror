Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AE512E7F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632F3D5F
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 02:36:56 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
	by bluemchen.kde.org (Postfix) with ESMTP id E55E8240A4;
	Fri, 20 Oct 2023 05:36:54 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
	id 1qtlw6-s5c-00; Fri, 20 Oct 2023 11:36:54 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 1/3] rebase: simplify code related to imply_merge()
Date: Fri, 20 Oct 2023 11:36:52 +0200
Message-ID: <20231020093654.922890-2-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
References: <20230809171531.2564844-1-oswald.buddenhagen@gmx.de>
 <20231020093654.922890-1-oswald.buddenhagen@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code's evolution left in some bits surrounding enum rebase_type that
don't really make sense any more. In particular, it makes no sense to
invoke imply_merge() if the type is already known not to be
REBASE_APPLY, and it makes no sense to assign the type after calling
imply_merge().

enum rebase_type had more values until commit a74b35081c ("rebase: drop
support for `--preserve-merges`") and commit 10cdb9f38a ("rebase: rename
the two primary rebase backends"). The latter commit also renamed
imply_interactive() to imply_merge().

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- more verbose commit message

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
---
 builtin/rebase.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 50cb85751f..44cc1eed12 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -386,7 +386,6 @@ static int parse_opt_keep_empty(const struct option *opt, const char *arg,
 
 	imply_merge(opts, unset ? "--no-keep-empty" : "--keep-empty");
 	opts->keep_empty = !unset;
-	opts->type = REBASE_MERGE;
 	return 0;
 }
 
@@ -1505,9 +1504,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (options.type == REBASE_MERGE)
-		imply_merge(&options, "--merge");
-
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
@@ -1552,7 +1548,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	if (options.type == REBASE_UNSPECIFIED) {
 		if (!strcmp(options.default_backend, "merge"))
-			imply_merge(&options, "--merge");
+			options.type = REBASE_MERGE;
 		else if (!strcmp(options.default_backend, "apply"))
 			options.type = REBASE_APPLY;
 		else
-- 
2.42.0.419.g70bf8a5751

