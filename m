Received: from www133.your-server.de (www133.your-server.de [88.198.195.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4645A2C68C
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 20:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tb6.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tb6.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tb6.eu header.i=@tb6.eu header.b="kM1aUqkw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tb6.eu;
	s=default2109; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=nU4LK+maprhBAf/rywtGISArzpNN8CwkHOL0sYOI15E=; b=kM1aUqkwMfChteAUrDLVZiQ+NF
	Od0+2LjG40u+SNenTGOZa/+goamSW6jgI7OYEHqmnj38PC/jtBvA2/+ktdVKd3gGddKgulG8qSMq3
	nr3Pv17zgDIsWpH2xBt7trA/eK9tB6w/Ia0rhNxHp3gZOFFiL4d8FoULK/LoaXAkz7F36h39EutOn
	nCugTWgPUToU3Gf64O/IccVfModUIsKaPCc70HQA3wwprrhGYK6QcIw5X1q0Pwu5PIVcJKaKQTfwF
	I65Z3+ZZGOrTV24j6IlxEiloNxVj4OU+/dXAOyQVujEBhYzWuSrLe7i+aoqWNWgQGEoRk/RNoxXd4
	OlQE9uuA==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www133.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <dev@tb6.eu>)
	id 1rLUIF-000Ftj-4i; Thu, 04 Jan 2024 21:26:19 +0100
Received: from [2a02:810d:1380:a8:3d72:5b35:9164:f910] (helo=localhost.localdomain)
	by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <dev@tb6.eu>)
	id 1rLUIE-000CKp-T8; Thu, 04 Jan 2024 21:26:18 +0100
From: Tamino Bauknecht <dev@tb6.eu>
To: git@vger.kernel.org
Cc: Tamino Bauknecht <dev@tb6.eu>
Subject: [PATCH] fetch: add new config option fetch.all
Date: Thu,  4 Jan 2024 21:25:00 +0100
Message-ID: <20240104202605.7382-1-dev@tb6.eu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: dev@tb6.eu
X-Virus-Scanned: Clear (ClamAV 0.103.10/27144/Thu Jan  4 10:39:55 2024)

This commit introduces the new boolean configuration option fetch.all
which allows to fetch all available remotes by default. The config
option can be overridden by explicitly specifying a remote.
The behavior for --all is unchanged and calling git-fetch with --all and
a remote will still result in an error.

The option was also added to the config documentation and new tests
cover the expected behavior.

Signed-off-by: Tamino Bauknecht <dev@tb6.eu>
---
I hopefully incorporated the feedback of all of you, thanks for the
valuable suggestions.

I'm still not entirely happy with the tests (especially the `cp` in
there) and the heredoc doesn't seem to respect the one additional
space of its indentation - I am admittedly not the best POSIX shell
developer, if anyone has an idea on how to improve it, your suggestion
is welcome.

 Documentation/config/fetch.txt |  5 +++
 builtin/fetch.c                | 11 +++++
 t/t5514-fetch-multiple.sh      | 75 ++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/Documentation/config/fetch.txt b/Documentation/config/fetch.txt
index aea5b97477..0638cf276e 100644
--- a/Documentation/config/fetch.txt
+++ b/Documentation/config/fetch.txt
@@ -50,6 +50,11 @@ fetch.pruneTags::
 	refs. See also `remote.<name>.pruneTags` and the PRUNING
 	section of linkgit:git-fetch[1].
 
+fetch.all::
+	If true, fetch will attempt to update all available remotes.
+	This behavior can be overridden by explicitly specifying one or
+	more remote(s) to fetch from. Defaults to false.
+
 fetch.output::
 	Control how ref update status is printed. Valid values are
 	`full` and `compact`. Default value is `full`. See the
diff --git a/builtin/fetch.c b/builtin/fetch.c
index a284b970ef..f1ad3e608e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -102,6 +102,7 @@ static struct string_list negotiation_tip = STRING_LIST_INIT_NODUP;
 
 struct fetch_config {
 	enum display_format display_format;
+	int all;
 	int prune;
 	int prune_tags;
 	int show_forced_updates;
@@ -115,6 +116,11 @@ static int git_fetch_config(const char *k, const char *v,
 {
 	struct fetch_config *fetch_config = cb;
 
+	if (!strcmp(k, "fetch.all")) {
+		fetch_config->all = git_config_bool(k, v);
+		return 0;
+	}
+
 	if (!strcmp(k, "fetch.prune")) {
 		fetch_config->prune = git_config_bool(k, v);
 		return 0;
@@ -2121,6 +2127,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct fetch_config config = {
 		.display_format = DISPLAY_FORMAT_FULL,
+		.all = -1,
 		.prune = -1,
 		.prune_tags = -1,
 		.show_forced_updates = 1,
@@ -2342,6 +2349,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			die(_("fetch --all does not take a repository argument"));
 		else if (argc > 1)
 			die(_("fetch --all does not make sense with refspecs"));
+	}
+
+	if (all || (config.all > 0 && !argc)) {
+		/* Only use fetch.all config option if no remotes were explicitly given */
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 
 		/* do not do fetch_multiple() of one */
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index a95841dc36..806b87c727 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -24,6 +24,15 @@ setup_repository () {
 	)
 }
 
+setup_test_clone () {
+	test_dir="$1"
+	git clone one "$test_dir"
+	for r in one two three
+	do
+		git -C "$test_dir" remote add "$r" "../$r" || return 1
+	done
+}
+
 test_expect_success setup '
 	setup_repository one &&
 	setup_repository two &&
@@ -209,4 +218,70 @@ test_expect_success 'git fetch --multiple --jobs=0 picks a default' '
 	 git fetch --multiple --jobs=0)
 '
 
+for fetch_all in true false
+do
+	test_expect_success "git fetch --all (works with fetch.all = $fetch_all)" '
+		test_dir="test_fetch_all_$fetch_all" &&
+		setup_test_clone "$test_dir" && (
+		 cd "$test_dir" &&
+		 git config fetch.all $fetch_all &&
+		 git fetch --all &&
+		 cat >expect <<-\ EOF &&
+		  one/main
+		  one/side
+		  origin/HEAD -> origin/main
+		  origin/main
+		  origin/side
+		  three/another
+		  three/main
+		  three/side
+		  two/another
+		  two/main
+		  two/side
+		 EOF
+		 git branch -r >actual &&
+		 test_cmp expect actual)
+	'
+done
+
+test_expect_success 'git fetch (fetch all remotes with fetch.all = true)' '
+	setup_test_clone test9 && (
+	 cd test9 &&
+	 git config fetch.all true &&
+	 git fetch --all &&
+	 git branch -r >actual &&
+	 cp ../test_fetch_all_true/expect . &&
+	 test_cmp expect actual)
+'
+
+test_expect_success 'git fetch one (explicit remote overrides fetch.all)' '
+	setup_test_clone test10 && (
+	 cd test10 &&
+	 git config fetch.all true &&
+	 git fetch one &&
+	 cat >expect <<-\ EOF &&
+	  one/main
+	  one/side
+	  origin/HEAD -> origin/main
+	  origin/main
+	  origin/side
+	 EOF
+	 git branch -r >actual &&
+	 test_cmp expect actual)
+'
+
+test_expect_success 'git config fetch.all false (fetch only default remote)' '
+	setup_test_clone test11 && (
+	 cd test11 &&
+	 git config fetch.all false &&
+	 git fetch &&
+	 cat >expect <<-\ EOF &&
+	  origin/HEAD -> origin/main
+	  origin/main
+	  origin/side
+	 EOF
+	 git branch -r >actual &&
+	 test_cmp expect actual)
+'
+
 test_done
-- 
2.43.0

