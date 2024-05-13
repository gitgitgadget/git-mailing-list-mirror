Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE024147C60
	for <git@vger.kernel.org>; Mon, 13 May 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616074; cv=none; b=IyAuIoNr1lPkKk9Gq3zLMINqVuCik8HodDoryn5DacuSYGxE9Ht78yzlUzFHU158vYJDTQfRJR2V+f2y1qoHcCAQgisLZWfE3dLl9jKJwM5zGMtVoDJLwEW2g5mzz3M/YL3ngC0nHls/dkNlfTbRlWM8eZnk4KKctyxIYDgBjTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616074; c=relaxed/simple;
	bh=hjMvIo96tgfUGlNaA237olbJFzEQUaxiy35Fsnhfz/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKsZeUU1Pze5UU9n9uENhFaD4fmzFFFhX0skX2buJEbzd5df1tiWp/U05TNABC0vVPlJlJkU/jC0BwIYLjOlYgdMSU0hXJ+DnlSKhD+BGNXzDwPzklwvUfwbQzM8HnwR/zVMP5OUiXT2cGo+fYGX6eU6yLDuiojyQAln0Q5sVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=C1eoEI7B; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="C1eoEI7B"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A43725BA9;
	Mon, 13 May 2024 12:01:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hjMvIo96tgfUGlNaA237olbJFzEQUaxiy35Fsn
	hfz/Q=; b=C1eoEI7BqiTLFSYM3zgIS1kDlivXzenwiiYXDPHiz2twcaOkluMWT5
	djzK6ZlmlQUBcrEBUIFfbGR72JthXpDNXxrAvM3C1rGODYgRCzd2EPkSlGwofhAZ
	7+N4dBFQ81UC0P7JaUZUvJzDmM8DiaUMx1UgWS2AmOt1+aqM96qtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D46725BA8;
	Mon, 13 May 2024 12:01:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8B6AE25BA7;
	Mon, 13 May 2024 12:01:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix use of uninitialized hash algos
In-Reply-To: <cover.1715582857.git.ps@pks.im> (Patrick Steinhardt's message of
	"Mon, 13 May 2024 09:15:04 +0200")
References: <cover.1715582857.git.ps@pks.im>
Date: Mon, 13 May 2024 09:01:04 -0700
Message-ID: <xmqqttj1hfb3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 011BE172-1142-11EF-B1AA-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> with c8aed5e8da (repository: stop setting SHA1 as the default object
> hash, 2024-05-07), we have stopped setting up the default hash function
> for `the_repository`. This change was done so that we stop implicitly
> using SHA1 in places where we don't really intend to. Instead, code
> where we try to access `the_hash_algo` without having `the_repository`
> properly initialized will now crash hard.
>
> I have found two more cases where this can now be triggered:
>
>   - git-patch-id(1) can read diffs from stdin.
>
>   - git-hash-object(1) can hash data from stdin.
>
> Both cases can work without a repository, and if they don't have one
> they will now crash.

Perhaps we should double-check with all commands that are designed
to be able to work outside a repository, e.g. "git apply", "git grep
--no-index", "git diff --no-index" (tried to be exhausitive without
consulting documentation, so the list is not exhausitive at all).

> I still consider it a good thing that we did the change regardless of
> those crashes. In the case of git-patch-id(1) I would claim that using
> `the_hash_algo` is wrong in the first place, as patch IDs should be
> stable and are documented to always use SHA1. Thus, patch IDs in SHA256
> repos are essentially broken. And in the case of git-hash-object(1), we
> should expose a command line option to let the user specify the object
> hash. So both cases demonstrate that there is room for improvement.

It is good that the topic is kept outside 'master' (and it is in
'next' to give the topic a bit wider exposure than merely in 'seen'
and the list archive).

We may want a test file that explicitly make commands that ought
to work outside a repository actually run outside a repository,
making use of the GIT_CEILING_DIRECTORIES mechanism, something along
the lines of the attached.

 t/t1517-outside-repo.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

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
