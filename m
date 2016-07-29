Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 814E31F858
	for <e@80x24.org>; Fri, 29 Jul 2016 00:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcG2AoV (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 20:44:21 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:36346 "EHLO
	mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbcG2AoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 20:44:18 -0400
Received: by mail-pf0-f172.google.com with SMTP id h186so26704661pfg.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 17:44:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x+RfcMMjpqyW+Y9cKbhSQJceJ+oj/LeKqWNXn43DaQo=;
        b=iRkf/qJmyGdDNNlsv3+eR7gjUnggARLVr4n8cxGgxoKUT+PzmzICV6Ko587nWEXP/Y
         BenclkHhjdoeirJB02M8fAeOE9w40f08R/hhoQzhVAkNC9NXinBNMQIQwn72/QW18Cjb
         yufJL7AeBOjgnGF2JC0wk+Qb3yNwaXA7DqgaTRJPSuCoMbxkIprIjP4J1pHEEnflRtj8
         LA0BHtq0cwvmtk1a6rkqth71UjH6vK7zOk+5ioTnGuFX8cRVQqJnADOvZfsFr5qJ/FYX
         5fziDWSSplkv2bMZ/LgBXHuEy2BqmqyP5MJx0gYphSP6eu9R2I1GtMDcoH5ursPjL4r1
         oDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=x+RfcMMjpqyW+Y9cKbhSQJceJ+oj/LeKqWNXn43DaQo=;
        b=kRhO8VZC0tC8iKZOA3b7HfBvjv9GENuqg9QDQUvXTisJykTSFvMIvdYqZX45Va8Hva
         iN738fqAt/Zm6yDZPYmwADCLnfjFg7OCsBpcSKpatd6FG8/G4kXwlv9bKTdrnJokmZOU
         HSHqCBC5HTzTurAvtG69KepOU6t35/QKBxMuSrhYvdxzqI9rntrfkch4lazW354Zem0y
         ciQNHvb/SkUlfz0fHB7nKLomPjuwIVyH162r/dJbs8GurnwObWRcdaHlVOm4kuq+XlA/
         1VSQ8Fca23xURc/gPMNAw3mLTg7g9VhbIzow0tFYycWgxGb7JDG75IRLxxRpzjo7MOv9
         nv/A==
X-Gm-Message-State: AEkooutIWhOkRUm8714s3oYTAA1xKNEJ5V9VQQAk3PxKLVei9/l2v6sUX8nFGgCMMT3POiC0
X-Received: by 10.98.9.194 with SMTP id 63mr64146605pfj.56.1469753057912;
        Thu, 28 Jul 2016 17:44:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:6dbf:17d9:7b5c:47ec])
        by smtp.gmail.com with ESMTPSA id l81sm19814961pfi.50.2016.07.28.17.44.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 28 Jul 2016 17:44:17 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, apenwarr@gmail.com,
	jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/7] submodule update: respect depth in subsequent fetches
Date:	Thu, 28 Jul 2016 17:44:04 -0700
Message-Id: <20160729004409.2072-3-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.472.g1ffb07c.dirty
In-Reply-To: <20160729004409.2072-1-sbeller@google.com>
References: <20160729004409.2072-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When depth is given the user may have a reasonable expectation that
any remote operation is using the given depth. Add a test to demonstrate
we still get the desired sha1 even if the depth is too short to
include the actual commit.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh            |  9 +++++----
 t/t7406-submodule-update.sh | 16 ++++++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 4ec7546..174f4ea 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -481,7 +481,8 @@ fetch_in_submodule () (
 	'')
 		git fetch ;;
 	*)
-		git fetch $(get_default_remote) "$2" ;;
+		shift
+		git fetch $(get_default_remote) "$@" ;;
 	esac
 )
 
@@ -619,7 +620,7 @@ cmd_update()
 			if test -z "$nofetch"
 			then
 				# Fetch remote before determining tracking $sha1
-				fetch_in_submodule "$sm_path" ||
+				fetch_in_submodule "$sm_path" $depth ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'")"
 			fi
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
@@ -642,13 +643,13 @@ cmd_update()
 				# Run fetch only if $sha1 isn't present or it
 				# is not reachable from a ref.
 				is_tip_reachable "$sm_path" "$sha1" ||
-				fetch_in_submodule "$sm_path" ||
+				fetch_in_submodule "$sm_path" $depth ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 
 				# Now we tried the usual fetch, but $sha1 may
 				# not be reachable from any of the refs
 				is_tip_reachable "$sm_path" "$sha1" ||
-				fetch_in_submodule "$sm_path" "$sha1" ||
+				fetch_in_submodule "$sm_path" $depth "$sha1" ||
 				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 8fc3a25..1bb1f43 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -856,6 +856,22 @@ test_expect_success 'submodule update clone shallow submodule' '
 	)
 '
 
+test_expect_success 'submodule update clone shallow submodule outside of depth' '
+	test_when_finished "rm -rf super3" &&
+	git clone cloned super3 &&
+	pwd=$(pwd) &&
+	(
+		cd super3 &&
+		sed -e "s#url = ../#url = file://$pwd/#" <.gitmodules >.gitmodules.tmp &&
+		mv -f .gitmodules.tmp .gitmodules &&
+		test_must_fail git submodule update --init --depth=1 2>actual &&
+		test_i18ngrep "Direct fetching of that commit failed." actual &&
+		git -C ../submodule config uploadpack.allowReachableSHA1InWant true &&
+		git submodule update --init --depth=1 >actual &&
+		test 1 = $(git -C submodule log --oneline | wc -l)
+	)
+'
+
 test_expect_success 'submodule update --recursive drops module name before recursing' '
 	(cd super2 &&
 	 (cd deeper/submodule/subsubmodule &&
-- 
2.9.2.472.g1ffb07c.dirty

