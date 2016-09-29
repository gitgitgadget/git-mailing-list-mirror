Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C12207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934128AbcI2VAW (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:00:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60483 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933604AbcI2VAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:00:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01FBF429E1;
        Thu, 29 Sep 2016 17:00:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=9JL6
        uZQRFh+CfYocu4pkpBiJxc8=; b=c/Kmu445crTRX5lzH33SVseS4mLImupOxNUm
        TbONeJVkeWWDjGAnJHDY5wUpv+Q4+Gda6bOEgr/57dF5PY73tNVsJ4TxzIGgehcb
        9JANppKQuc1lIOEw2Hg57pLugwTb3HnHrKCUXPz/0zndFVIhQSd0i8UeAZ77wRXB
        2nyFXSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:in-reply-to:references; q=dns; s=sasl; b=dUXjCp
        q5HNvXgZu5ymBczwhOgfZyuhoYPQkO/oSaUkIFZLcKhpEkxvR9AWyvTXloxHisvn
        7pVOXmS02JmLhaPLAGC8MbkfXJ6fZAkPEdDUK2fmIaW13EiKpqhfomb2saSc71Bm
        gMMV9OQB12PgOo6qtpXNeGsdYmOsFxzurIXW0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDD54429E0;
        Thu, 29 Sep 2016 17:00:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6400C429DF;
        Thu, 29 Sep 2016 17:00:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH v2 1/9] config: allow customizing /etc/gitconfig location with an environment
Date:   Thu, 29 Sep 2016 14:00:06 -0700
Message-Id: <20160929210014.3874-2-gitster@pobox.com>
X-Mailer: git-send-email 2.10.0-589-g5adf4e1
In-Reply-To: <20160929210014.3874-1-gitster@pobox.com>
References: <20160929210014.3874-1-gitster@pobox.com>
X-Pobox-Relay-ID: BA3682B4-8687-11E6-BADC-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We introduced GIT_CONFIG_NOSYSTEM environment variable at ab88c363
("allow suppressing of global and system config", 2008-02-06),
primarily to protect our tests from random set of configuration
variables the system administrators would put in /etc/gitconfig
file.

Introduce a new environment variable GIT_CONFIG_SYSTEM_PATH, and allow
the users to specify a file that is used instead of /etc/gitconfig
to read (and write) the system-wide configuration.  By doing so, we
can force our tests to honor certain configuration settings by
default by pointing GIT_CONFIG_SYSTEM_PATH at our own, in addition to the
existing GIT_CONFIG_NOSYSTEM mechanism.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 cache.h                |  1 +
 config.c               |  2 ++
 t/gitconfig-for-test   |  6 ++++++
 t/t1300-repo-config.sh | 15 +++++++++++++++
 t/test-lib.sh          |  4 ++--
 5 files changed, 26 insertions(+), 2 deletions(-)
 create mode 100644 t/gitconfig-for-test

diff --git a/cache.h b/cache.h
index b0dae4bac1a1..d4b689f386d6 100644
--- a/cache.h
+++ b/cache.h
@@ -408,6 +408,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
+#define GIT_CONFIG_SYSTEM_PATH_ENVIRONMENT "GIT_CONFIG_SYSTEM_PATH"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/config.c b/config.c
index 0dfed682b868..096bb754aad7 100644
--- a/config.c
+++ b/config.c
@@ -1253,6 +1253,8 @@ const char *git_etc_gitconfig(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
+		system_wide = getenv(GIT_CONFIG_SYSTEM_PATH_ENVIRONMENT);
+	if (!system_wide)
 		system_wide = system_path(ETC_GITCONFIG);
 	return system_wide;
 }
diff --git a/t/gitconfig-for-test b/t/gitconfig-for-test
new file mode 100644
index 000000000000..4598885ed5c3
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
index 923bfc5a2606..0543b62227bf 100755
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
+	GIT_CONFIG_SYSTEM_PATH="$system" \
+	git config --system frotz.nitfol >actual &&
+
+	GIT_CONFIG_SYSTEM_PATH="$system" \
+	git config --system --replace-all frotz.nitfol blorb &&
+	echo blorb >expect &&
+	GIT_CONFIG_SYSTEM_PATH="$system" git config --system frotz.nitfol >actual
+'
+
 test_done
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac56512a1c5e..b811e4c70273 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -851,9 +851,9 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-GIT_CONFIG_NOSYSTEM=1
+GIT_CONFIG_SYSTEM_PATH="$GIT_BUILD_DIR/t/gitconfig-for-test"
 GIT_ATTR_NOSYSTEM=1
-export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT_ATTR_NOSYSTEM
+export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_SYSTEM_PATH GIT_ATTR_NOSYSTEM
 
 if test -z "$GIT_TEST_CMP"
 then
-- 
2.10.0-589-g5adf4e1

