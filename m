Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C72EAE9
	for <git@vger.kernel.org>; Mon, 15 Jul 2024 16:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721060558; cv=none; b=FvOzHZ29FvG+h1Qgs/Z6wE7lC9YXqcyWNKWHKhYO7ol3D9m+QjGtuteqoiiFwv8A/r75Czvkr8AQ9WkmpKi8bFO/80dHsqF0TC27DGGUEprMte3CvhgK0b0D660p9hJY+pjAThJ0Vns3AA2eAQ9AESX9QWfzW3C0oWrS9RflE28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721060558; c=relaxed/simple;
	bh=dKXYLgdgp04SB9gVzVkaVe8NI7uqtKQfxQBZmdLAfzQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tTgPKd6WbBq0q/JPMrAjqjbhDoMgu4NOHjVQzIAGuqeVcByvTzj9ddFo8X9doQz9ojr3r1aMgqSAoGioH/Pm3VvK9P8b5c0fLP3Ioo74tMwOGfA/Q3cfMIuii1vEY/DDy/d3MP2Yi3GhlYpMhIi5F083b7ayVH11HrLGk/CAl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=egc6wESI; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="egc6wESI"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AB5BB1FBC7;
	Mon, 15 Jul 2024 12:22:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dKXYLgdgp04SB9gVzVkaVe8NI7uqtKQfxQBZmd
	LAfzQ=; b=egc6wESIp4N6RwiE8/7z1CjGnP/tTtFWrFayBrKWJc1u2/GAnlOFpR
	Si0H+KR+mPpy1vHuSIMzdD8bdg0QjIbtnxLSzcojakqBIhi5RwGaisBMgcCgtUM6
	ysf87fyrA8KHaPRgfSgiDn+1U7vIIAxE8VMe3wOthScNQhBktNgjk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3AB51FBC6;
	Mon, 15 Jul 2024 12:22:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0FB1F1FBC3;
	Mon, 15 Jul 2024 12:22:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re* [PATCH v2] show-index: fix uninitialized hash function
In-Reply-To: <20240715102344.182388-1-abhijeet.nkt@gmail.com> (Abhijeet
	Sonar's message of "Mon, 15 Jul 2024 15:53:43 +0530")
References: <xmqqbk32oc7g.fsf@gitster.g>
	<20240715102344.182388-1-abhijeet.nkt@gmail.com>
Date: Mon, 15 Jul 2024 09:22:33 -0700
Message-ID: <xmqqzfqi4oc6.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 71BB669A-42C6-11EF-BBD3-965B910A682E-77302942!pb-smtp2.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

>  t/t8101-show-index-hash-function.sh | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
>  create mode 100755 t/t8101-show-index-hash-function.sh

Thanks.  But let's not waste the scarce resource that is a test
number for a single oddball test (and as t/README says t8xxx series
is for forensics Porcelains).

> +test_expect_success 'show-index: should not fail outside a repository' '
> +    git init --object-format=sha1 && (
> +        echo "" | git hash-object -w --stdin | git pack-objects test &&

Our tests run in an already initialized repository, and some test
configuration would use sha256 to initialize that repository.  So
the above is not a good idea, unless you use a new directory.  We
often create a new directory inside the initial directory the test
begins in, and then in a subshell chdir into the directory.

We frown upon a pipeline that has "git" as an upstream, because the
exit status from such invocation of "git" will be hidden.

	git init --object-format=sha1 sample &&
	(
		cd sample &&
		O=$(git hash-object -w /dev/null) &&
		T=$(echo "$O" | git pack-objects test) &&

would give you a pair of files "test-$T.idx" and "test-$T.pack" and
it will notice if hash-object or pack-objects fail.

> +        rm -rf .git &&

This alone does *not* necessarily make the directory you are using
for test completely unassociated with any repository.  If you are
working with the source code of Git from a repository (as opposed to
extracted tar archive), with that "rm -fr", you may have made the
directory not a Git repository, but then that directory is now a
mere subdirectory "t/trash directory.t8101-show-index-hash-function"
of the repository that houses the Git source code (unless you are
using the --root=<directory> option to run the tests).

When we test behaviour of commands outside a repository, we use the
GIT_CEILING_DIRECTORIES feature, often via the nongit helper function
that is defined in t/test-lib-functions.sh (which becomes available
to tests by doing ". ./test-lib.sh".

In t5300-pack-object.sh we see these bits already.

    test_expect_success 'index-pack --stdin complains of non-repo' '
            nongit test_must_fail git index-pack \
                    --object-format=$(test_oid algo) --stdin <foo.pack &&
            test_path_is_missing non-repo/.git
    '

    test_expect_success 'index-pack <pack> works in non-repo' '
            nongit git index-pack \
                    --object-format=$(test_oid algo) ../foo.pack &&
            test_path_is_file foo.idx
    '

I wonder if it is sufficient to add a new test after these two
steps, something like

    test_expect_success SHA1 'show-index works OK outside a repository' '
	    nongit git show-index <foo.idx
    '

perhaps?

With that, your patch would become like so:

------------ >8 ----------------------- >8 ------------
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Date: Mon, 15 Jul 2024 15:53:43 +0530
Subject: [PATCH] show-index: fix uninitialized hash function

As stated in the docs, show-index should use SHA1 as the default
hash algorithm when run outside a repository.

However, 'the_hash_algo' is left uninitialized if we are not in a
repository and no explicit hash function is specified, causing a
crash.

Fix it by falling back to SHA1 when it is found uninitialized. Also
add test that verifies this behaviour.

Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
[jc: fixed up the test]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/show-index.c   | 3 +++
 t/t5300-pack-object.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/show-index.c b/builtin/show-index.c
index 540dc3dad1..bb6d9e3c40 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -35,6 +35,9 @@ int cmd_show_index(int argc, const char **argv, const char *prefix)
 		repo_set_hash_algo(the_repository, hash_algo);
 	}
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	hashsz = the_hash_algo->rawsz;
 
 	if (fread(top_index, 2 * 4, 1, stdin) != 1)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 4ad023c846..83933eca5d 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
 	test_path_is_file foo.idx
 '
 
+test_expect_success SHA1 'show-index works OK outside a repository' '
+	nongit git show-index <foo.idx
+'
+
 test_expect_success !PTHREADS,!FAIL_PREREQS \
 	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
 	test_must_fail git index-pack --threads=2 2>err &&
-- 
2.46.0-rc0-140-g824782812f


