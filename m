Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5EA25755
	for <git@vger.kernel.org>; Mon, 13 May 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625396; cv=none; b=fdamHc6z5B+y5AhXju78lXWctSgIAJxXVZoSGU7CzndFi2diSy5s4Ar9gfRPxhUrtRye7dpNQ77YmyYIVUSOZX7oXpWLSs6VcduwWOT7tclcEZjhvsEIHfrRFfBKqHvZmTJK0z8BTEFYO6z0KPxFZP51kgmRVSRB/75eO5LtLN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625396; c=relaxed/simple;
	bh=7D8VePEtfdiQnoza/IAcGdE5xyjuAgLHbuwahSUjZ+I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msJRn3jLTdSumx04vCfm7YnOHKKlC4WnlsX/5ofDOQ5152znyUQhwOa08rAPKeBs+dFZgXkC6YqnXJZ9GS99EI/iQQ4A+fDtTClR9YfA4ua3z1EuX0iZxJ7sB9IsxxLnSLqgwVyWuzeWaauHfDQq1H4t44jF26DPHhCouVwIm6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yhev1lP7; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yhev1lP7"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 153B035D30;
	Mon, 13 May 2024 14:36:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7D8VePEtfdiQnoza/IAcGdE5xyjuAgLHbuwahS
	UjZ+I=; b=Yhev1lP7QDU3hqpxAkFcy2ItUn+g3t+2JIUOAfjSmUFnzBIOx0a0WL
	5KC35eS+Qd1qgQIBO/Ov2nMAgbvFP5VA8s9x1SordHXywS9TGMueDxztaQUWZGXt
	rnCJWwJ4+xVSwrFNofO+OUDVvbNVLG9+XDJfIvazGgz49bbolh2cs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0D76A35D2F;
	Mon, 13 May 2024 14:36:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8FBAB35D2C;
	Mon, 13 May 2024 14:36:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>,
    Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Fix use of uninitialized hash algos
In-Reply-To: <xmqqttj1hfb3.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 May 2024 09:01:04 -0700")
References: <cover.1715582857.git.ps@pks.im> <xmqqttj1hfb3.fsf@gitster.g>
Date: Mon, 13 May 2024 11:36:23 -0700
Message-ID: <xmqqcyppftjs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B3ACF47E-1157-11EF-837B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

>> I still consider it a good thing that we did the change regardless of
>> those crashes. In the case of git-patch-id(1) I would claim that using
>> `the_hash_algo` is wrong in the first place, as patch IDs should be
>> stable and are documented to always use SHA1. Thus, patch IDs in SHA256
>> repos are essentially broken. And in the case of git-hash-object(1), we
>> should expose a command line option to let the user specify the object
>> hash. So both cases demonstrate that there is room for improvement.
>
> It is good that the topic is kept outside 'master' (and it is in
> 'next' to give the topic a bit wider exposure than merely in 'seen'
> and the list archive).
>
> We may want a test file that explicitly make commands that ought
> to work outside a repository actually run outside a repository,
> making use of the GIT_CEILING_DIRECTORIES mechanism, something along
> the lines of the attached.

Another thought.  Perhaps we should do, in the meantime, the
attached patch?

Without your "fix patch-id" patch, one of the tests in 1517 will
fail, and the other fails as there is no fix posted yet, but with
the GIT_TEST_DEFAULT_HASH_IS_SHA1 set explicit to 1, they keep
passing.  This way, when we run out tests, we will always leave the
default hash uninitialized to catch more errors, the binary built
out of our source by default will crash to help our users catch more
errors for us, yet when they really really need to, the users can
set and export GIT_TEST_DEFAULT_HASH_IS_SHA1=1 to keep assuming that
SHA1 is the hash algorithm when there is no specified.


 repository.c            | 24 ++++++++++++++++++++++++
 t/t1517-outside-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 t/test-lib.sh           |  4 ++++
 3 files changed, 70 insertions(+)

diff --git c/repository.c w/repository.c
index 15c10015b0..6f67966e35 100644
--- c/repository.c
+++ w/repository.c
@@ -26,6 +26,30 @@ void initialize_repository(struct repository *repo)
 	repo->parsed_objects = parsed_object_pool_new();
 	ALLOC_ARRAY(repo->index, 1);
 	index_state_init(repo->index, repo);
+
+	/*
+	 * Unfortunately, we need to keep this hack around for the time being:
+	 *
+	 *   - Not setting up the hash algorithm for `the_repository` leads to
+	 *     crashes because `the_hash_algo` is a macro that expands to
+	 *     `the_repository->hash_algo`. So if Git commands try to access
+	 *     `the_hash_algo` without a Git directory we crash.
+	 *
+	 *   - Setting up the hash algorithm to be SHA1 by default breaks other
+	 *     commands when running with SHA256.
+	 *
+	 * This is another point in case why having global state is a bad idea.
+	 * Eventually, we should remove this hack and stop setting the hash
+	 * algorithm in this function altogether. Instead, it should only ever
+	 * be set via our repository setup procedures. But that requires more
+	 * work.
+	 *
+	 * As we discover the code paths that need fixing, we may remove this
+	 * code completely, but we are not there yet.
+	 */
+	if (repo == the_repository &&
+	    git_env_bool("GIT_TEST_DEFAULT_HASH_IS_SHA1", 0))
+		repo_set_hash_algo(repo, GIT_HASH_SHA1);
 }
 
 static void expand_base_dir(char **out, const char *in,
diff --git c/t/t1517-outside-repo.sh w/t/t1517-outside-repo.sh
new file mode 100755
index 0000000000..4c595c2ff7
--- /dev/null
+++ w/t/t1517-outside-repo.sh
@@ -0,0 +1,42 @@
+#!/bin/sh
+
+test_description='check random commands outside repo'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'set up a non-repo directory and test file' '
+	GIT_CEILING_DIRECTORIES=$(pwd) &&
+	export GIT_CEILING_DIRECTORIES &&
+	mkdir non-repo &&
+	(
+		cd non-repo &&
+		# confirm that git does not find a repo
+		test_must_fail git rev-parse --git-dir
+	) &&
+	test_write_lines one two three four >nums &&
+	git add nums &&
+	cp nums nums.old &&
+	test_write_lines five >>nums &&
+	git diff >sample.patch
+'
+
+test_expect_success 'apply a patch outside repository' '
+	(
+		cd non-repo &&
+		cp ../nums.old nums &&
+		git apply ../sample.patch
+	) &&
+	test_cmp nums non-repo/nums
+'
+
+test_expect_success 'compute a patch-id outside repository' '
+	git patch-id <sample.patch >patch-id.expect &&
+	(
+		cd non-repo &&
+		git patch-id <../sample.patch >../patch-id.actual
+	) &&
+	test_cmp patch-id.expect patch-id.actual
+'
+
+test_done
diff --git c/t/test-lib.sh w/t/test-lib.sh
index 79d3e0e7d9..36d311fb4a 100644
--- c/t/test-lib.sh
+++ w/t/test-lib.sh
@@ -542,6 +542,10 @@ export EDITOR
 
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-sha1}"
 export GIT_DEFAULT_HASH
+
+GIT_TEST_DEFAULT_HASH_IS_SHA1=0
+export GIT_TEST_DEFAULT_HASH_IS_SHA1
+
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"
 export GIT_DEFAULT_REF_FORMAT
 GIT_TEST_MERGE_ALGORITHM="${GIT_TEST_MERGE_ALGORITHM:-ort}"
