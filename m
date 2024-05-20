Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC3045035
	for <git@vger.kernel.org>; Mon, 20 May 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716246880; cv=none; b=a5I0fjVzyu54KlnUJvLuyIQ9DcHWdfIrZ1FNHFGG+mheVUiGmuVMV5KZoWJ5b+3hlU3Q3OfPYRmfBEpwcnCZDdBmwsACvczzCdEP/P0GxYbqdtDp3Y2ZsxkyT6E/5JHjrt0jNndU92gD3J3A9LA2LC5uI4PiM3BB3+SNsGJGZb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716246880; c=relaxed/simple;
	bh=L6lV8h6zLeeHMBFn8XDqK2prEz3IlmCxpG510ZbS3B4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BO5bN3D9Ig7tCRHk1abFlYRDn+76aRZkomKNagr+nYr52ox7TDUMRm3/IvhpSmqq4kkodHi5gXfTD3OQ39MRFuQzh3U7yB+5LzIne/D3QxuCwQwOZCMjocBISNLZ6JTdFc6Bett4u1bRssTJZXkOfBz/kBrrgHmtBCNT2zIY5yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WcVnxv/h; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WcVnxv/h"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 82D4829B86;
	Mon, 20 May 2024 19:14:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=L6lV8h6zLeeH
	MBFn8XDqK2prEz3IlmCxpG510ZbS3B4=; b=WcVnxv/hoK2rU16if7gQziSeQhC/
	Px7SZOHzSklqurdKHXxtU2dd5Cjk1+P/IIa3EzEnpC1Wg+o6/7EYjKhVGD/C5qsR
	vnxhT2RvdwfXZLXbZ+KyFRVNtoe1wCCpGdpEQNIIv/PmQbogZ4U/0KFd9sf6ChkS
	e9D3qepU02lw/5Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AFF929B85;
	Mon, 20 May 2024 19:14:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BA7C829B84;
	Mon, 20 May 2024 19:14:35 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 0/5] Fix use of uninitialized hash algorithms
Date: Mon, 20 May 2024 16:14:29 -0700
Message-ID: <20240520231434.1816979-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-216-g4365c6fcf9
In-Reply-To: <cover.1715582857.git.ps@pks.im>
References: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Pobox-Relay-ID:
 B948451C-16FE-11EF-9BDE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

A change recently merged to 'next' stops us from defaulting to using
SHA-1 unless other code (like a logic early in the start-up sequence
to see what hash is being used in the repository we are working in)
explicitly sets it, leading to a (deliberate) crash of "git" when we
forgot to cover certain code paths.

It turns out we have a few.  Notable ones are all operations that
are designed to work outside a repository.  We should go over all
such code paths and give them a reasonable default when there is one
available (e.g. for historical reasons, patch-id is documented to
work with SHA-1 hashes, so arguably it, or at least when it is
invoked with the "--stable" option, should do so everywhere, not
just in SHA-1 repositories, but in SHA-256 repository or outside any
repository).  In the meantime, if an end-user hits such a "bug"
before we can fix it, it would be nice to give them an escape hatch
to restore the historical behaviour of falling back to use SHA-1.

These patches are designed to apply on a merge of c8aed5e8
(repository: stop setting SHA1 as the default object hash,
2024-05-07) into 3e4a232f (The third batch, 2024-05-13), which has
been the same base throughout the past iterations.

In this fifth iteration:

 - The first step no longer falls back to GIT_DEFAULT_HASH; the
   escape hatch is a dedicated GIT_TEST_DEFAULT_HASH_ALGO
   environment variable, but hopefully we do not have to advertise
   it all that often.

 - The second step has been simplified somewhat to use the "nongit"
   helper when we only need to run a single "git" command in t1517.
   The way the expected output files were prepared in the previous
   versions did not correctly force use of SHA-1 algorithm, which
   has been corrected.  The third step and fourth step for t1517
   continue to be "flip expect_failure to expect_success", but you
   can see context differences in the range-diff.

 - The fourth step also has a fix for t1007 where the previous
   iterations did not correctly force use of SHA-1 to prepare the
   expected output.

Otherwise this round should be ready, modulo possible typoes.


Junio C Hamano (3):
  setup: add an escape hatch for "no more default hash algorithm" change
  t1517: test commands that are designed to be run outside repository
  apply: fix uninitialized hash function

Patrick Steinhardt (2):
  builtin/patch-id: fix uninitialized hash function
  builtin/hash-object: fix uninitialized hash function

 builtin/apply.c         |  4 +++
 builtin/hash-object.c   |  3 +++
 builtin/patch-id.c      | 13 +++++++++
 repository.c            | 44 ++++++++++++++++++++++++++++++
 t/t1007-hash-object.sh  |  6 +++++
 t/t1517-outside-repo.sh | 59 +++++++++++++++++++++++++++++++++++++++++
 t/t4204-patch-id.sh     | 34 ++++++++++++++++++++++++
 7 files changed, 163 insertions(+)
 create mode 100755 t/t1517-outside-repo.sh

--=20
2.45.1-216-g4365c6fcf9

1:  3038f73e1c ! 1:  f5e6868a61 setup: add an escape hatch for "no more d=
efault hash algorithm" change
    @@ Commit message
         Partially revert c8aed5e8 (repository: stop setting SHA1 as the
         default object hash, 2024-05-07), to keep end-user systems still
         broken when we have gap in our test coverage but yet give them a=
n
    -    escape hatch to set the GIT_DEFAULT_HASH environment variable to
    -    "sha1" in order to revert to the previous behaviour.  This varia=
ble
    -    has been in use for using SHA-256 hash by default, and it should=
 be
    -    a better fit than inventing a new and test-only knob.
    +    escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGO environment
    +    variable to "sha1" in order to revert to the previous behaviour.
    =20
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    +    Due to the way the end-user facing GIT_DEFAULT_HASH environment
    +    variable is used in our test suite, we unfortunately cannot reus=
e it
    +    for this purpose.
    =20
    - ## environment.h ##
    -@@ environment.h: const char *getenv_safe(struct strvec *argv, const=
 char *name);
    - #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
    - #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
    - #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
    -+#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
    -=20
    - /*
    -  * Environment variable used in handshaking the wire protocol.
    +    Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
      ## repository.c ##
    -@@
    - #include "git-compat-util.h"
    - #include "abspath.h"
    -+#include "environment.h"
    - #include "repository.h"
    - #include "object-store-ll.h"
    - #include "config.h"
     @@
      static struct repository the_repo;
      struct repository *the_repository =3D &the_repo;
     =20
    ++/*
    ++ * An escape hatch: if we hit a bug in the production code that fai=
ls
    ++ * to set an appropriate hash algorithm (most likely to happen when
    ++ * running outside a repository), we can tell the user who reported
    ++ * the crash to set the environment variable to "sha1" (all lowerca=
se)
    ++ * to revert to the historical behaviour of defaulting to SHA-1.
    ++ */
     +static void set_default_hash_algo(struct repository *repo)
     +{
     +	const char *hash_name;
     +	int algo;
     +
    -+	hash_name =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
    ++	hash_name =3D getenv("GIT_TEST_DEFAULT_HASH_ALGO");
     +	if (!hash_name)
     +		return;
     +	algo =3D hash_algo_by_name(hash_name);
    -+
    -+	/*
    -+	 * NEEDSWORK: after all, falling back to SHA-1 by assigning
    -+	 * GIT_HASH_SHA1 to algo here, instead of returning, may give
    -+	 * us better behaviour.
    -+	 */
     +	if (algo =3D=3D GIT_HASH_UNKNOWN)
     +		return;
     +
    @@ repository.c: void initialize_repository(struct repository *repo)
     +	 * of the hashed value to see if their input looks like a
     +	 * plausible hash value.
     +	 *
    -+	 * We are in the process of identifying the codepaths and
    ++	 * We are in the process of identifying such code paths and
     +	 * giving them an appropriate default individually; any
    -+	 * unconverted codepath that tries to access the_hash_algo
    ++	 * unconverted code paths that try to access the_hash_algo
     +	 * will thus fail.  The end-users however have an escape hatch
    -+	 * to set GIT_DEFAULT_HASH environment variable to "sha1" get
    -+	 * back the old behaviour of defaulting to SHA-1.
    ++	 * to set GIT_TEST_DEFAULT_HASH_ALGO environment variable to
    ++	 * "sha1" to get back the old behaviour of defaulting to SHA-1.
    ++	 *
    ++	 * This escape hatch is deliberately kept unadvertised, so
    ++	 * that they see crashes and we can get a report before
    ++	 * telling them about it.
     +	 */
     +	if (repo =3D=3D the_repository)
     +		set_default_hash_algo(repo);
      }
     =20
      static void expand_base_dir(char **out, const char *in,
    -
    - ## setup.c ##
    -@@ setup.c: int daemonize(void)
    - #define TEST_FILEMODE 1
    - #endif
    -=20
    --#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
    --
    - static void copy_templates_1(struct strbuf *path, struct strbuf *te=
mplate_path,
    - 			     DIR *dir)
    - {
2:  e56ae68961 ! 2:  f3f9bf0480 t1517: test commands that are designed to=
 be run outside repository
    @@ t/t1517-outside-repo.sh (new)
     +	git diff >sample.patch
     +'
     +
    -+test_expect_failure 'compute a patch-id outside repository' '
    -+	git patch-id <sample.patch >patch-id.expect &&
    -+	(
    -+		cd non-repo &&
    -+		git patch-id <../sample.patch >../patch-id.actual
    -+	) &&
    ++test_expect_failure 'compute a patch-id outside repository (uses SH=
A-1)' '
    ++	nongit env GIT_DEFAULT_HASH=3Dsha1 \
    ++		git patch-id <sample.patch >patch-id.expect &&
    ++	nongit \
    ++		git patch-id <sample.patch >patch-id.actual &&
     +	test_cmp patch-id.expect patch-id.actual
     +'
     +
    -+test_expect_failure 'hash-object outside repository' '
    -+	git hash-object --stdin <sample.patch >hash.expect &&
    -+	(
    -+		cd non-repo &&
    -+		git hash-object --stdin <../sample.patch >../hash.actual
    -+	) &&
    ++test_expect_failure 'hash-object outside repository (uses SHA-1)' '
    ++	nongit env GIT_DEFAULT_HASH=3Dsha1 \
    ++		git hash-object --stdin <sample.patch >hash.expect &&
    ++	nongit \
    ++		git hash-object --stdin <sample.patch >hash.actual &&
     +	test_cmp hash.expect hash.actual
     +'
     +
3:  e1ae0e95fc ! 3:  246cf395d0 builtin/patch-id: fix uninitialized hash =
function
    @@ t/t1517-outside-repo.sh: test_expect_success 'set up a non-repo di=
rectory and te
      	git diff >sample.patch
      '
     =20
    --test_expect_failure 'compute a patch-id outside repository' '
    -+test_expect_success 'compute a patch-id outside repository' '
    - 	git patch-id <sample.patch >patch-id.expect &&
    - 	(
    - 		cd non-repo &&
    +-test_expect_failure 'compute a patch-id outside repository (uses SH=
A-1)' '
    ++test_expect_success 'compute a patch-id outside repository (uses SH=
A-1)' '
    + 	nongit env GIT_DEFAULT_HASH=3Dsha1 \
    + 		git patch-id <sample.patch >patch-id.expect &&
    + 	nongit \
    =20
      ## t/t4204-patch-id.sh ##
     @@ t/t4204-patch-id.sh: test_expect_success 'patch-id handles diffs =
with one line of before/after' '
4:  1c8ce0d024 ! 4:  fe14490548 builtin/hash-object: fix uninitialized ha=
sh function
    @@ t/t1007-hash-object.sh: test_expect_success '--literally with extr=
a-long type' '
      	echo example | git hash-object -t $t --literally --stdin
      '
     =20
    -+test_expect_success '--stdin outside of repository' '
    ++test_expect_success '--stdin outside of repository (uses SHA-1)' '
     +	nongit git hash-object --stdin <hello >actual &&
    -+	echo "$(test_oid hello)" >expect &&
    ++	echo "$(test_oid --hash=3Dsha1 hello)" >expect &&
     +	test_cmp expect actual
     +'
     +
      test_done
    =20
      ## t/t1517-outside-repo.sh ##
    -@@ t/t1517-outside-repo.sh: test_expect_success 'compute a patch-id =
outside repository' '
    +@@ t/t1517-outside-repo.sh: test_expect_success 'compute a patch-id =
outside repository (uses SHA-1)' '
      	test_cmp patch-id.expect patch-id.actual
      '
     =20
    --test_expect_failure 'hash-object outside repository' '
    -+test_expect_success 'hash-object outside repository' '
    - 	git hash-object --stdin <sample.patch >hash.expect &&
    - 	(
    - 		cd non-repo &&
    +-test_expect_failure 'hash-object outside repository (uses SHA-1)' '
    ++test_expect_success 'hash-object outside repository (uses SHA-1)' '
    + 	nongit env GIT_DEFAULT_HASH=3Dsha1 \
    + 		git hash-object --stdin <sample.patch >hash.expect &&
    + 	nongit \
5:  5b0ec43757 ! 5:  c6d5e68374 apply: fix uninitialized hash function
    @@ builtin/apply.c: int cmd_apply(int argc, const char **argv, const =
char *prefix)
      				   apply_usage);
    =20
      ## t/t1517-outside-repo.sh ##
    -@@ t/t1517-outside-repo.sh: test_expect_success 'hash-object outside=
 repository' '
    +@@ t/t1517-outside-repo.sh: test_expect_success 'hash-object outside=
 repository (uses SHA-1)' '
      	test_cmp hash.expect hash.actual
      '
     =20
