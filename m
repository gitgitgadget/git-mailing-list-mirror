Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D24D2576B
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052522; cv=none; b=I+eYFnuMzWpYsCOyw4jmosyHqCD4QpKC+u5b0EYXVhstCnC1MAVsaS2hGgNOPeMFFcICJA+cKMDZTGdjkqZLYIez07173fxL1CBDD3hGlQdTd5B1Bpbh5WM0tE5rW4R890oFyQh1QGxZzcka0Esp4XfTgALzO1/GKuPO6r1UxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052522; c=relaxed/simple;
	bh=mfOj1MvgchApT+xs5/xzMI3L4YjSSOt86669Ziyq6F8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kKuER7faA8XgVOkviKqzN1XNRYWkVuLJYiqbPwBzJQaD+/M00sr8ESHJgwmDEmKFNW50LK+bTuORbSbMcE31NPrVEbGlr42tyFqIRHMjPlFyr5bUHI2HJkD6wnkwSFzJAOZZHGqeeT+siHpxzR5hNrgwdLBFmyTk9Bfg4yr/Ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MDh8TMt7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MDh8TMt7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B17D23743;
	Tue, 27 Feb 2024 11:48:34 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mfOj1MvgchApT+xs5/xzMI3L4YjSSOt86669Zi
	yq6F8=; b=MDh8TMt76dr7+JJHNeOBiy8V+1ZMMzsTIqPjqQyrSa4MjSU5mxcZE2
	c1XjOO5w7Hi4LB5UHzbL7Asu8oICZSCJCa5n/rkYYR+Tkca7vp+aleAm6lBzLfBk
	+AZy62ZS3RYE0fQbjLFkfR7K9NkVNXUGspV6gfhiR/+Irc//Ln3CI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 83FB623742;
	Tue, 27 Feb 2024 11:48:34 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B0E8823740;
	Tue, 27 Feb 2024 11:48:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
In-Reply-To: <20240227074903.GD3263678@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 27 Feb 2024 02:49:03 -0500")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g>
	<xmqqr0hcglpk.fsf_-_@gitster.g>
	<20240217054048.GD539459@coredump.intra.peff.net>
	<xmqqfrxexx15.fsf@gitster.g>
	<20240227074903.GD3263678@coredump.intra.peff.net>
Date: Tue, 27 Feb 2024 08:48:29 -0800
Message-ID: <xmqq1q8xx38i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 098E768C-D590-11EE-8F30-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> There's some prior art there, I think, in how GIT_CEILING_DIRECTORIES
> works, or even something like "git --literal-pathspecs", neither of
> which appear in local_repo_env.

Unlike GIT_CEILING_DIRECTORIES that is more or less permanent and a
part of configuring an everyday environment for real work, I view
this --no-lazy-fetch thing as solely a debugging aid.  A repository
with promisor wouldn't be able to "fill the gap" by forbidding
on-demand fetching of promised objects while running say "git fetch"
from elsewhere and it just will die with "some objects we are
supposed to have are missing from this repository".

So I do not have a strong opinion either way, if it is more
convenient to propagate the request out to other repositories when
we run processes in two or more repositories (e.g. "git clone
--local"), or if it is more convenient to make sure that the request
is limited to the target repository.  Here is a version without the
local_repo_env[] change.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH v3 3/3] git: extend --no-lazy-fetch to work across subprocesses

Modeling after how the `--no-replace-objects` option is made usable
across subprocess spawning (e.g., cURL based remote helpers are
spawned as a separate process while running "git fetch"), allow the
`--no-lazy-fetch` option to be passed across process boundaries.

Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
variable is ignored, though.  Just use the usual git_env_bool() to
allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
to be equivalents.

Also do not model how the request is not propagated to subprocesses
we spawn (e.g. "git clone --local" that spawns a new process to work
in the origin repository, while the original one working in the
newly created one) by the "--no-replace-objects" option, as this "do
not lazily fetch from the promisor" is more about a per-request
debugging aid, not "this repository's promisor should not be relied
upon" property specific to a repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff:
1:  5fa7ddbf68 ! 1:  ea40bb9a1d git: extend --no-lazy-fetch to work across subprocesses
    @@ Commit message
         allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
         to be equivalents.
     
    +    Also do not model how the request is not propagated to subprocesses
    +    we spawn (e.g. "git clone --local" that spawns a new process to work
    +    in the origin repository, while the original one working in the
    +    newly created one) by the "--no-replace-objects" option, as this "do
    +    not lazily fetch from the promisor" is more about a per-request
    +    debugging aid, not "this repository's promisor should not be relied
    +    upon" property specific to a repository.
    +
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/git.txt ##
    @@ Documentation/git.txt: for full details.
      	track of the reason why the ref was updated (which is
     
      ## environment.c ##
    -@@ environment.c: const char * const local_repo_env[] = {
    - 	GRAFT_ENVIRONMENT,
    - 	INDEX_ENVIRONMENT,
    - 	NO_REPLACE_OBJECTS_ENVIRONMENT,
    -+	NO_LAZY_FETCH_ENVIRONMENT,
    - 	GIT_REPLACE_REF_BASE_ENVIRONMENT,
    - 	GIT_PREFIX_ENVIRONMENT,
    - 	GIT_SHALLOW_FILE_ENVIRONMENT,
     @@ environment.c: void setup_git_env(const char *git_dir)
      	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
      	if (shallow_file)

 Documentation/git.txt    |  7 +++++++
 environment.c            |  3 +++
 environment.h            |  1 +
 git.c                    |  3 +++
 t/t0410-partial-clone.sh | 15 +++++++++++++++
 5 files changed, 29 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index b1f754e84b..a517d94a7a 100644
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
@@ -900,6 +902,11 @@ for full details.
 	Setting this Boolean environment variable to true will cause Git to treat all
 	pathspecs as case-insensitive.
 
+`GIT_NO_LAZY_FETCH`::
+	Setting this Boolean environment variable to true tells Git
+	not to lazily fetch missing objects from the promisor remote
+	on demand.
+
 `GIT_REFLOG_ACTION`::
 	When a ref is updated, reflog entries are created to keep
 	track of the reason why the ref was updated (which is
diff --git a/environment.c b/environment.c
index 9e37bf58c0..0ae5bbd4a1 100644
--- a/environment.c
+++ b/environment.c
@@ -207,6 +207,9 @@ void setup_git_env(const char *git_dir)
 	shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
 	if (shallow_file)
 		set_alternate_shallow_file(the_repository, shallow_file, 0);
+
+	if (git_env_bool(NO_LAZY_FETCH_ENVIRONMENT, 0))
+		fetch_if_missing = 0;
 }
 
 int is_bare_repository(void)
diff --git a/environment.h b/environment.h
index e5351c9dd9..5cec19cecc 100644
--- a/environment.h
+++ b/environment.h
@@ -36,6 +36,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
 #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
+#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
 #define GITATTRIBUTES_FILE ".gitattributes"
 #define INFOATTRIBUTES_FILE "info/attributes"
 #define ATTRIBUTE_MACRO_PREFIX "[attr]"
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
index 5b7bee888d..c282851af7 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -665,6 +665,21 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	git -C partial.git rev-list --objects --missing=print HEAD >out &&
 	grep "[?]$FILE_HASH" out &&
 
+	# The no-lazy-fetch mechanism prevents Git from fetching
+	test_must_fail env GIT_NO_LAZY_FETCH=1 \
+		git -C partial.git cat-file -e "$FILE_HASH" &&
+
+	# The same with command line option to "git"
+	test_must_fail git --no-lazy-fetch -C partial.git cat-file -e "$FILE_HASH" &&
+
+	# The same, forcing a subprocess via an alias
+	test_must_fail git --no-lazy-fetch -C partial.git \
+		-c alias.foo="!git cat-file" foo -e "$FILE_HASH" &&
+
+	# Sanity check that the file is still missing
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out &&
+
 	git -C full cat-file -s "$FILE_HASH" >expect &&
 	test-tool partial-clone object-info partial.git "$FILE_HASH" >actual &&
 	test_cmp expect actual &&
-- 
2.44.0-35-ga2082dbdd3


