Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2E01F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 23:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754418AbcI1XfJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 19:35:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59928 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932776AbcI1Xay (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 19:30:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59CC24317F;
        Wed, 28 Sep 2016 19:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=OgX1
        Wglk8kH0jWWcei25bIlMwT4=; b=jyWUPVkmqXNLd/6vJ/L7z4MwVHgf1RElpmST
        I9+W+42zJaRGjBig2jFQ/S+8CMQraizg2K047L56WrLeJMULCzuMlFJ0tfmcZbP2
        /thnvqjllw8jziqLSL1ZvBof444zjCJe0GDYqjnGvwI0g66aSNN6AwN8w4db3Dxk
        g5fH/RI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        CVRLSZSvRb2+dKzNpBHiTJntcjjGSP6h6pMi60eWZlQf3nI2vl2FwJbKEc6rs2FI
        tZI07eBiawcs+xXinF9+PqHGw6I8FetGU5eDP/so2o7Vvw4MvnrllRjxaZatEOKP
        /TUHFJmsKfPELuB31DX60mz1db+r1oWOxpKf9il5NeU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 52FD34317E;
        Wed, 28 Sep 2016 19:30:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF804317D;
        Wed, 28 Sep 2016 19:30:51 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, torvalds@linux-foundation.org
Subject: [PATCH 1/4] config: allow customizing /etc/gitconfig location
Date:   Wed, 28 Sep 2016 16:30:44 -0700
Message-Id: <20160928233047.14313-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-584-gc9e068c
In-Reply-To: <20160928233047.14313-1-gitster@pobox.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com>
X-Pobox-Relay-ID: 9824EE54-85D3-11E6-AD89-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With a new environment variable GIT_ETC_GITCONFIG, the users can
specify a file that is used instead of /etc/gitconfig to read (and
write) the system-wide configuration.

Earlier, we introduced GIT_CONFIG_NOSYSTEM environment variable
ab88c363 ("allow suppressing of global and system config",
2008-02-06), primarily to protect our tests from random set of
configuration variables the system administrators would put in their
/etc/gitconfig file.  We can replace the use of this mechanism in
our tests by pointing GIT_ETC_GITCONFIG at our own instead.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * The next step is to add "[core]abbrev=7" to this file and update
   default_abbrev to 12 in environment.c and see what breaks.  I
   suspect that "git worktree list" would break without my recent
   patch.  I also know some tests expect "git config -l" to show
   only values they set to their local configuration, which would
   need to be corrected.  We'll see them in next steps.

 cache.h                |  1 +
 config.c               |  2 ++
 t/gitconfig-for-test   |  6 ++++++
 t/t1300-repo-config.sh | 15 +++++++++++++++
 t/test-lib.sh          |  4 ++--
 5 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 t/gitconfig-for-test

diff --git a/cache.h b/cache.h
index b0dae4b..81a07bf 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define GIT_ETC_GITCONFIG_ENVIRONMENT "GIT_ETC_GITCONFIG"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/config.c b/config.c
index 0dfed68..124699b 100644
--- a/config.c
+++ b/config.c
@@ -1253,6 +1253,8 @@ const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
+		system_wide = getenv(GIT_ETC_GITCONFIG_ENVIRONMENT);
+	if (!system_wide)
 		system_wide = system_path(ETC_GITCONFIG);
 	return system_wide;
 }
diff --git a/t/gitconfig-for-test b/t/gitconfig-for-test
new file mode 100644
index 0000000..4598885
--- /dev/null
+++ b/t/gitconfig-for-test
@@ -0,0 +1,6 @@
+;; This file is used as if it were /etc/gitconfig while running the
+;; test scripts in this directory.
+;;
+;; [user]
+;;	name = A U Thor
+;;	email = author@example.com
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 923bfc5..1184f43 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1372,4 +1372,19 @@ test_expect_success !MINGW '--show-origin blob ref' '
 	test_cmp expect output
 '
 
+test_expect_success 'system-wide configuration' '
+	system="$TRASH_DIRECTORY/system-wide" &&
+	>"$system" &&
+	git config -f "$system" --add frotz.nitfol xyzzy &&
+
+	git config -f "$system" frotz.nitfol >expect &&
+	GIT_ETC_GITCONFIG="$system" \
+	git config --system frotz.nitfol >actual &&
+
+	GIT_ETC_GITCONFIG="$system" \
+	git config --system --replace-all frotz.nitfol blorb &&
+	echo blorb >expect &&
+	GIT_ETC_GITCONFIG="$system" git config --system frotz.nitfol >actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac56512..6803212 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -851,9 +851,9 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-GIT_CONFIG_NOSYSTEM=1
+GIT_ETC_GITCONFIG="$GIT_BUILD_DIR/t/gitconfig-for-test"
 GIT_ATTR_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_ETC_GITCONFIG GIT_ATTR_NOSYSTEM
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.10.0-584-gc9e068c

