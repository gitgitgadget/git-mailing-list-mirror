Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F484CDE5
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013899; cv=none; b=FcQVVPcVrNeq/IhbKTVWT3eObm2OTVELXrz6nnoL6oVmBS+pxODI+k+o4R4oPK8aydOFgIpdpclgoUIxj4u7J0oSuVKNYLRuqB4oEgML/HhgcGg3Jd/hZ4gF0Zq0sUxB7wh5jBXLqG6r6pB9QOpG2b615pooVaL8H8PqmnSlUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013899; c=relaxed/simple;
	bh=uu0V+k99cwcO/urkrPT+oDt1nmeSho6mXJ1So6BJisw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RB9CBS31e0afBZ/rHjk8FQh+u1iajjV/7+xLEPDoHafuKnEAoHrYxe0Zh/Zap19Teu1FklbJ7p7KVu35M2o2wvpyF9jEEbccLM7edBFrapmJP71tgTJ34HGYg0Hu+Kb9qzOw0AEqKWtMltlvMj1ZoJd6abFXaEbsKCPXqTh3CJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=SecX6Hp5; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="SecX6Hp5"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A59A1D84C6;
	Tue, 27 Feb 2024 01:04:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uu0V+k99cwcO/urkrPT+oDt1nmeSho6mXJ1So6
	BJisw=; b=SecX6Hp5g4AowyAWLyawqo0hdXmoXJ0TqKkdNTzyRuArW7Bf/nNW+g
	S7xHFlS1LtrHwzgIb064ptbuStY6KKJI1t5m9PWXQw3uNTsuSNYsQu7N7MGX3v73
	NlxYsPlmUJYPvyQNOKv+f+dtmaTlXEb4UkmcIqQuPWzAqw5EHj5JI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 425A21D84C5;
	Tue, 27 Feb 2024 01:04:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A11F41D84C4;
	Tue, 27 Feb 2024 01:04:55 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] git: extend --no-lazy-fetch to work across subprocesses
In-Reply-To: <20240217054048.GD539459@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Feb 2024 00:40:48 -0500")
References: <xmqq1q9mmtpw.fsf@gitster.g>
	<20240215053056.GD2821179@coredump.intra.peff.net>
	<xmqqv86pslos.fsf@gitster.g> <xmqq1q9cl3xv.fsf@gitster.g>
	<xmqqr0hcglpk.fsf_-_@gitster.g>
	<20240217054048.GD539459@coredump.intra.peff.net>
Date: Mon, 26 Feb 2024 22:04:54 -0800
Message-ID: <xmqqfrxexx15.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 212F4FDC-D536-11EE-8DC0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 2f1cb3ef4e..be2829003d 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -183,6 +183,8 @@ If you just want to run git as if it was started in `<path>` then use
>>  	Do not fetch missing objects from the promisor remote on
>>  	demand.  Useful together with `git cat-file -e <object>` to
>>  	see if the object is locally available.
>> +	This is equivalent to setting the `GIT_NO_LAZY_FETCH`
>> +	environment variable to `1`.
>
> As with the other patch, I'd suggest adding an entry to the list of
> environment variables later in the manpage.

Thanks, done.

We'll have to make a separate patch to add GIT_NO_REPLACE_OBJECTS to
the list, by the way (#leftoverbits), which I used as a model to
find what needs to be updated.

>> --- a/environment.h
>> +++ b/environment.h
>> @@ -35,6 +35,7 @@ const char *getenv_safe(struct strvec *argv, const char *name);
>>  #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
>>  #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
>>  #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
>> +#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
>>  #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
>>  #define GITATTRIBUTES_FILE ".gitattributes"
>>  #define INFOATTRIBUTES_FILE "info/attributes"
>
> A small nit, but maybe worth keeping the two replace-related variables
> next to each other, rather than sticking the new one in the middle?

OK.

>> diff --git a/git.c b/git.c
>> index 28e8bf7497..d11d4dc77b 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -189,6 +189,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>>  				*envchanged = 1;
>>  		} else if (!strcmp(cmd, "--no-lazy-fetch")) {
>>  			fetch_if_missing = 0;
>> +			setenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
>> +			if (envchanged)
>> +				*envchanged = 1;
>>  		} else if (!strcmp(cmd, "--no-replace-objects")) {
>>  			disable_replace_refs();
>>  			setenv(NO_REPLACE_OBJECTS_ENVIRONMENT, "1", 1);
>
> I _suspect_ this makes the fetch_if_missing call redundant, since we
> should be parsing these before doing any repo setup that would trigger
> the code that reads the environment variable.

True.  Again, we'd need to clean-up the NO_REPLACE_OBJECTS codepath
as well---the disable_replace_refs() call should also be redundant,
which I mimicked to add the no-lazy-fetch codepath (#leftoverbits).

> This should probably also be xsetenv(), though as you can see in the
> context we are not very consistent about using it. :) But certainly if
> we failed to set it I would prefer to see an error rather than
> accidentally lazy-fetching.

I'd probably leave it outside the scope of this series; as nobody
uses xsetenv() in git.c currently, it would be a clean-up topic on
its own (#leftoverbits).

>> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
>> index 5b7bee888d..59629cea1f 100755
>> --- a/t/t0410-partial-clone.sh
>> +++ b/t/t0410-partial-clone.sh
>> @@ -665,6 +665,15 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
>>  	git -C partial.git rev-list --objects --missing=print HEAD >out &&
>>  	grep "[?]$FILE_HASH" out &&
>>  
>> +	# The no-lazy-fetch mechanism prevents Git from fetching
>> +	test_must_fail env GIT_NO_LAZY_FETCH=1 \
>> +		git -C partial.git cat-file -e "$FILE_HASH" &&
>> +	test_must_fail git --no-lazy-fetch -C partial.git cat-file -e "$FILE_HASH" &&
>> +
>> +	# Sanity check that the file is still missing
>> +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
>> +	grep "[?]$FILE_HASH" out &&
>
> OK, we exercise it by setting the variable directly. A more interesting
> one might be:
>
>   git -c alias.foo='!git cat-file' --no-lazy-fetch ...
>
> which should fail without the patch.

True, again.  I'll test all three variants (i.e. environment,
command line option to "git", forced subprocess turning command line
option to "git" into environment).

Thanks.



----- >8 --------- >8 --------- >8 --------- >8 -----
Subject: [PATCH v2 3/3] git: extend --no-lazy-fetch to work across subprocesses

Modeling after how the `--no-replace-objects` option is made usable
across subprocess spawning (e.g., cURL based remote helpers are
spawned as a separate process while running "git fetch"), allow the
`--no-lazy-fetch` option to be passed across process boundaries.

Do not model how the value of GIT_NO_REPLACE_OBJECTS environment
variable is ignored, though.  Just use the usual git_env_bool() to
allow "export GIT_NO_LAZY_FETCH=0" and "unset GIT_NO_LAZY_FETCH"
to be equivalents.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Range-diff:
1:  00e202b679 ! 1:  e0764f2e21 git: extend --no-lazy-fetch to work across subprocesses
    @@ Documentation/git.txt: If you just want to run git as if it was started in `<pat
      
      --literal-pathspecs::
      	Treat pathspecs literally (i.e. no globbing, no pathspec magic).
    +@@ Documentation/git.txt: for full details.
    + 	Setting this Boolean environment variable to true will cause Git to treat all
    + 	pathspecs as case-insensitive.
    + 
    ++`GIT_NO_LAZY_FETCH`::
    ++	Setting this Boolean environment variable to true tells Git
    ++	not to lazily fetch missing objects from the promisor remote
    ++	on demand.
    ++
    + `GIT_REFLOG_ACTION`::
    + 	When a ref is updated, reflog entries are created to keep
    + 	track of the reason why the ref was updated (which is
     
      ## environment.c ##
     @@ environment.c: const char * const local_repo_env[] = {
    @@ environment.c: void setup_git_env(const char *git_dir)
     
      ## environment.h ##
     @@ environment.h: const char *getenv_safe(struct strvec *argv, const char *name);
    - #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
      #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
      #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
    -+#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
      #define GIT_REPLACE_REF_BASE_ENVIRONMENT "GIT_REPLACE_REF_BASE"
    ++#define NO_LAZY_FETCH_ENVIRONMENT "GIT_NO_LAZY_FETCH"
      #define GITATTRIBUTES_FILE ".gitattributes"
      #define INFOATTRIBUTES_FILE "info/attributes"
    + #define ATTRIBUTE_MACRO_PREFIX "[attr]"
     
      ## git.c ##
     @@ git.c: static int handle_options(const char ***argv, int *argc, int *envchanged)
    @@ t/t0410-partial-clone.sh: test_expect_success 'lazy-fetch when accessing object
     +	# The no-lazy-fetch mechanism prevents Git from fetching
     +	test_must_fail env GIT_NO_LAZY_FETCH=1 \
     +		git -C partial.git cat-file -e "$FILE_HASH" &&
    ++
    ++	# The same with command line option to "git"
     +	test_must_fail git --no-lazy-fetch -C partial.git cat-file -e "$FILE_HASH" &&
     +
    ++	# The same, forcing a subprocess via an alias
    ++	test_must_fail git --no-lazy-fetch -C partial.git \
    ++		-c alias.foo="!git cat-file" foo -e "$FILE_HASH" &&
    ++
     +	# Sanity check that the file is still missing
     +	git -C partial.git rev-list --objects --missing=print HEAD >out &&
     +	grep "[?]$FILE_HASH" out &&

 Documentation/git.txt    |  7 +++++++
 environment.c            |  4 ++++
 environment.h            |  1 +
 git.c                    |  3 +++
 t/t0410-partial-clone.sh | 15 +++++++++++++++
 5 files changed, 30 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 2f1cb3ef4e..6fbaa9dd2b 100644
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
@@ -896,6 +898,11 @@ for full details.
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

