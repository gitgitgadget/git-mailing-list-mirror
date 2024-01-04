Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A282C85A
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="tP/l1+7z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=JZnE8mVWBiAzAKErawPNNzIluR7TCYH6mHdDBsM6XsA=; b=tP/l1+7zyIIfV2Xwr6WheYcAKs
	H1T/vFbAvpeyhvCMUdGu6jTddKQPYuB3hVy5kkp+Ez+HwgSFfsLu9ajCUOkpx0RTkjvtCAkMjct14
	7/GBWwXGKmiwO7vKyTbdnKKIj4v6sGhdDtJkOpGTpuXb3atZlwkrwcIYi71Qhg9qfXPa96dTDfNZq
	KDmaPHoeZb4J5Y+Joq7IYWeOgFPGl7/FtuoaLlTEMNRez6p85tDeQJ1+kkPNXs3kKpuPImg/pfkVO
	h0mDmSy2IjT6Audv5jGIlvgp/28PZcsYSqL7XICPWVC6I7+8/oGQMZXQT5gWztaDnyLkKNZC6+scD
	GHwSXoKQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rLW7Z-0004Dg-39; Thu, 04 Jan 2024 23:23:25 +0100
Received: from [2a02:810d:1380:a8:3d72:5b35:9164:f910] (helo=localhost.localdomain)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rLW7Y-0003rM-St; Thu, 04 Jan 2024 23:23:24 +0100
From: Tamino Bauknecht <dev@tb6.eu>
To: git@vger.kernel.org
Cc: Tamino Bauknecht <dev@tb6.eu>
Subject: [PATCH v2 2/2] fetch: add cli option --default-only
Date: Thu,  4 Jan 2024 23:22:10 +0100
Message-ID: <20240104222259.15659-2-dev@tb6.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104222259.15659-1-dev@tb6.eu>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
 <20240104222259.15659-1-dev@tb6.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27144/Thu Jan  4 10:39:55 2024)

This option can be used to restore the default behavior of "git fetch"
if the "fetch.all" config option is enabled.
The flag cannot be used in combination with "--all" or explicit
remote(s).

Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
---
A first proposal for the command line option Junio mentioned.
It's called "--default-only" for now, but I don't have a strong opinion
on that matter and am open to suggestions. Alternatives I considered
were "--default-remote" and only "--default".
I'm also not sure about the positioning in code and documentation, is
there some kind of convention about the order? For now, I simply added
it behind "all" since it is related to (although incompatible with) it.

 Documentation/config/fetch.txt  |  5 ++--
 Documentation/fetch-options.txt |  4 ++++
 builtin/fetch.c                 | 21 +++++++++++++----
 t/t5514-fetch-multiple.sh       | 41 +++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index 0638cf276e..6c3a9bc3f6 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -52,8 +52,9 @@ fetch.pruneTags::
 
 fetch.all::
 	If true, fetch will attempt to update all available remotes.
-	This behavior can be overridden by explicitly specifying one or
-	more remote(s) to fetch from. Defaults to false.
+	This behavior can be overridden by passing `--default-only` or
+	by explicitly specifying one or more remote(s) to fetch from.
+	Defaults to false.
 
 fetch.output::
 	Control how ref update status is printed. Valid values are
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index a1d6633a4f..61da5915f1 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -1,6 +1,10 @@
 --all::
 	Fetch all remotes.
 
+--default-only::
+	Fetch only default remote. This flag can be used to overrule the
+	`fetch.all` configuration option and restore the default behavior.
+
 -a::
 --append::
 	Append ref names and object names of fetched refs to the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index f1ad3e608e..de1f659b96 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2140,6 +2140,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
 	int all = 0, multiple = 0;
+	int default_only = 0;
 	int result = 0;
 	int prune_tags_ok = 1;
 	int enable_auto_gc = 1;
@@ -2157,6 +2158,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSITY(&verbosity),
 		OPT_BOOL(0, "all", &all,
 			 N_("fetch from all remotes")),
+		OPT_BOOL(0, "default-only", &default_only,
+			 N_("only fetch default remote")),
 		OPT_BOOL(0, "set-upstream", &set_upstream,
 			 N_("set upstream for git pull/fetch")),
 		OPT_BOOL('a', "append", &append,
@@ -2344,15 +2347,23 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	    fetch_bundle_uri(the_repository, bundle_uri, NULL))
 		warning(_("failed to fetch bundles from '%s'"), bundle_uri);
 
-	if (all) {
+	if (all && default_only) {
+		die(_("fetch --all does not work with fetch --default-only"));
+	} else if (all || default_only) {
+		const char *fetch_argument = all ? "--all" : "--default-only";
 		if (argc == 1)
-			die(_("fetch --all does not take a repository argument"));
+			die(_("fetch %s does not take a repository argument"),
+			    fetch_argument);
 		else if (argc > 1)
-			die(_("fetch --all does not make sense with refspecs"));
+			die(_("fetch %s does not make sense with refspecs"),
+			    fetch_argument);
 	}
 
-	if (all || (config.all > 0 && !argc)) {
-		/* Only use fetch.all config option if no remotes were explicitly given */
+	if (all || (config.all > 0 && !argc && !default_only)) {
+		/*
+		 * Only use fetch.all config option if no remotes were
+		 * explicitly given and if --default-only was not passed
+		 */
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 
 		/* do not do fetch_multiple() of one */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 781c781808..1b23eef32c 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -304,4 +304,45 @@ test_expect_success 'git config fetch.all false (fetch only default remote)' '
 	)
 '
 
+for fetch_all in true false
+do
+	test_expect_success "git fetch --default-only (fetch only default remote with fetch.all = $fetch_all)" '
+		test_dir="test_default_only_$fetch_all" &&
+		setup_test_clone "$test_dir" &&
+		(
+			cd "$test_dir" &&
+			git config fetch.all $fetch_all &&
+			git fetch --default-only &&
+			cat >expect <<-\EOF &&
+			  origin/HEAD -> origin/main
+			  origin/main
+			  origin/side
+			EOF
+			git branch -r >actual &&
+			test_cmp expect actual
+		)
+	'
+done
+
+test_expect_success 'git fetch --all does not work with --default-only' '
+	(
+		cd test &&
+		test_must_fail git fetch --all --default-only
+	)
+'
+
+test_expect_success 'git fetch --default-only does not accept one explicit remote' '
+	(
+		cd test &&
+		test_must_fail git fetch --default-only one
+	)
+'
+
+test_expect_success 'git fetch --default-only does not accept multiple explicit remotes' '
+	(
+		cd test &&
+		test_must_fail git fetch --default-only one two three
+	)
+'
+
 test_done
-- 
2.43.0

