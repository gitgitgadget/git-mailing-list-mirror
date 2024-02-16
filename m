Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81213B29C
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117790; cv=none; b=MX/9cw8EQgIGLJfaFKHeybILhHTbNeNyQMPLMCDQ6dQGhGbH0qme5anhSN76jVBCtotRZk+nKEYlHU5IwQZDSCVqBt79hqoSa6tdHjKt5Hc+ukpUc7Lu9hUx7ZPGJ7iETPU/hJihyLu4/ssWazTvwczqjf6TPC7sSdgh89Sq/zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117790; c=relaxed/simple;
	bh=V5+MmxkO6D5bIrTmpPsdSDMMa/byllrMcSly3lPP5as=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JafipGtU8+xlqj+AjDo1Mo4uuw2yagZ6f5TA8ken7aBt+lWBYhExVUac9sPKNVYlx73FkK5fbUfAEiJxVhAwwCAiRkLj7EQMqBCYBbJnWG50InhrRIJHGX92IFx9yLWlRG3kaKD2B3iJ0H/1AO8Rt/Nfz+RBPpJuAtGn0R93N+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Smapbf+1; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Smapbf+1"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0A1DF363A0;
	Fri, 16 Feb 2024 16:09:48 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V5+MmxkO6D5bIrTmpPsdSDMMa/byllrMcSly3l
	PP5as=; b=Smapbf+1kg9IsGNBvkMW5ANL6T76UFoLr2SFVc8xgR43PQPqnSawDv
	no5e5OYr5/DNXqMwbcTQQYjQPxBKt+VXPerHgTo9rCL49MT5dL9Vb6YWc7dUkJKE
	bxivPpP4XXtdM3+gmG/d4ZT50zABSox43Z3LRi6pTfIu2q/g2b6LM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0206A3639F;
	Fri, 16 Feb 2024 16:09:48 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 93FD13639E;
	Fri, 16 Feb 2024 16:09:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,  Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
In-Reply-To: <xmqq1q9cl3xv.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	16 Feb 2024 09:22:20 -0800")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g>
Date: Fri, 16 Feb 2024 13:09:43 -0800
Message-ID: <xmqqr0hcglpk.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B55FC7EC-CD0F-11EE-AABD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Modeling after how the `--no-replace-objects` option is made usable
across subprocess spawning (e.g., cURL based remote helpers are
spawned as a separate process while running "git fetch"), allow the
`--no-lazy-fetch` option to be passed across process boundary.

Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
variable is ignored, though.  Just use the usual git_env_bool() to
allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
to be equivalents.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this comes on top of the original one plus the documentation
   update for GIT_NO_REPLACE_OBJECTS.

 Documentation/git.txt    | 2 ++
 environment.c            | 4 ++++
 environment.h            | 1 +
 git.c                    | 3 +++
 t/t0410-partial-clone.sh | 9 +++++++++
 5 files changed, 19 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2f1cb3ef4e..be2829003d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -183,6 +183,8 @@ If you just want to run git as if it was started in `<path>` then use
 	Do not fetch missing objects from the promisor remote on
 	demand.  Useful together with `git cat-file -e <object>` to
 	see if the object is locally available.
+	This is equivalent to setting the `GIT_NO_LAZY_FETCH`
+	environment variable to `1`.
 
 --literal-pathspecs::
 	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
diff --git a/environment.c b/environment.c
index 9e37bf58c0..afad78a3f8 100644
--- a/environment.c
+++ b/environment.c
@@ -136,6 +136,7 @@ const char * const local_repo_env[] = {
 	GRAFT_ENVIRONMENT,
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	NO_LAZY_FETCH_ENVIRONMENT,
 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
@@ -207,6 +208,9 @@ void setup_git_env(const char *git_dir)
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(the_repository, shallow_file, 0);
+
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
+		fetch_if_missing = 0;
 }
 
 int is_bare_repository(void)
diff --git a/environment.h b/environment.h
index e5351c9dd9..74b3124f55 100644
--- a/environment.h
+++ b/environment.h
@@ -35,6 +35,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
+#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
diff --git a/git.c b/git.c
index 28e8bf7497..d11d4dc77b 100644
--- a/git.c
+++ b/git.c
@@ -189,6 +189,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
 			fetch_if_missing = 0;
+			setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
+			if (envchanged)
+				*envchanged = 1;
 		} else if (!strcmp(cmd, "--no-replace-objects")) {
 			disable_replace_refs();
 			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5b7bee888d..59629cea1f 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -665,6 +665,15 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
 	grep "[?]$FILE_HASH" out &&
 
+	# The no-lazy-fetch mechanism prevents Git from fetching
+	test_must_fail env GIT_NO_LAZY_FETCH=1 \
+		git -C partial.git cat-file -e "$FILE_HASH" &&
+	test_must_fail git --no-lazy-fetch -C partial.git cat-file -e "$FILE_HASH" &&
+
+	# Sanity check that the file is still missing
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out &&
+
 	git -C full cat-file -s "$FILE_HASH" >expect &&
 	test-tool partial-clone object-info partial.git "$FILE_HASH" >actual &&
 	test_cmp expect actual &&
-- 
2.44.0-rc1-17-g3e0d3cd5c7

