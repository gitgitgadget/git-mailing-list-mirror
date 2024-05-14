Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0EB17EF
	for <git@vger.kernel.org>; Tue, 14 May 2024 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649286; cv=none; b=G8OVD8MA7efpxwG7ruWz4sjtNRzeWkPF/BCCu7T/ljQ5i44Zz9bxtMB09msqT/LXP4JkCIPBTW4eDlLM1vfG37mLXTSXXQtV7OjTH15QxmJC2f0MUtKOA8w0FsfFt7Exuoj2HAhTMVM88lQKDwa1lyMXl2qECcIeDijT3foB/cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649286; c=relaxed/simple;
	bh=/ob8zjoDc3OFTtBn2j8ILS+4LCJ16zClBzFbGe/kWMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uR+UVTPzbpyh5pDj+mzISfB4QFK4qvyWJ9DkHVOc2vwRrcVoIL7T4S2uUDrPYwqQZqM/cov46pcUae+VOXmOb8y16sYJQ1/DCtpyAyam98rK+ixZsjEPZVmLcT6WtMAUBYD4KFQjYl6Bjk5tJgS2sgkcJEwOxZlb+tuusgzC+u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZKRKaL77; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZKRKaL77"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A8AD389D8;
	Mon, 13 May 2024 21:14:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/ob8zjoDc3OF
	TtBn2j8ILS+4LCJ16zClBzFbGe/kWMg=; b=ZKRKaL77WSXEB+ri2UeerfdZ6g5M
	isUCUG9mYeVEtooJmhf48qLqtC1D/Zgu13vWJpr5r1czmmCYvB7Ch5Mj0OIT1KEW
	6DRGU1eyhHFTJCWIs52xMZgFn4BRce3xMY5yD5/U7B/+PfJneusPysxwZfRjukK8
	kZo92ASI58BaJc0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C6E389D7;
	Mon, 13 May 2024 21:14:44 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 09E8F389D4;
	Mon, 13 May 2024 21:14:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/5] Fix use of uninitialized hash algorithms
Date: Mon, 13 May 2024 18:14:32 -0700
Message-ID: <20240514011437.3779151-1-gitster@pobox.com>
X-Mailer: git-send-email 2.45.0-145-g3e4a232f6e
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
 55E0EAB6-118F-11EF-BD5E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
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
work with SHA-1 hashes, so arguably it should do so everywhere, not
just in SHA-1 repositories, but outside any repository), and when
there is none, we can use the existing GIT_DEFAULT_HASH environment
variable to let the user control the choice.

In this fourth iteration, I used the existing GIT_DEFAULT_HASH
environment variable that has been used to allow users to opt into
an early experiment of SHA-256 support.  I saw breakages in SHA-256
CI jobs for earlier rounds of this series, but hopefully this is now
good to go.  Knock wood...

Junio C Hamano (3):
  setup: add an escape hatch for "no more default hash algorithm" change
  t1517: test commands that are designed to be run outside repository
  apply: fix uninitialized hash function

Patrick Steinhardt (2):
  builtin/patch-id: fix uninitialized hash function
  builtin/hash-object: fix uninitialized hash function

 builtin/apply.c         |  4 +++
 builtin/hash-object.c   |  3 ++
 builtin/patch-id.c      | 13 +++++++++
 environment.h           |  1 +
 repository.c            | 40 +++++++++++++++++++++++++++
 setup.c                 |  2 --
 t/t1007-hash-object.sh  |  6 ++++
 t/t1517-outside-repo.sh | 61 +++++++++++++++++++++++++++++++++++++++++
 t/t4204-patch-id.sh     | 34 +++++++++++++++++++++++
 9 files changed, 162 insertions(+), 2 deletions(-)
 create mode 100755 t/t1517-outside-repo.sh

Range-diff against v3:
1:  7adbf0cc5f ! 1:  3038f73e1c setup: add an escape hatch for "no more d=
efault hash algorithm" change
    @@ Commit message
         Partially revert c8aed5e8 (repository: stop setting SHA1 as the
         default object hash, 2024-05-07), to keep end-user systems still
         broken when we have gap in our test coverage but yet give them a=
n
    -    escape hatch to set the GIT_TEST_DEFAULT_HASH_ALGORITHM environm=
ent
    -    variable to "sha1" in order to revert to the previous behaviour.
    +    escape hatch to set the GIT_DEFAULT_HASH environment variable to
    +    "sha1" in order to revert to the previous behaviour.  This varia=
ble
    +    has been in use for using SHA-256 hash by default, and it should=
 be
    +    a better fit than inventing a new and test-only knob.
    =20
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    =20
    + ## environment.h ##
    +@@ environment.h: const char *getenv_safe(struct strvec *argv, const=
 char *name);
    + #define GIT_OPTIONAL_LOCKS_ENVIRONMENT "GIT_OPTIONAL_LOCKS"
    + #define GIT_TEXT_DOMAIN_DIR_ENVIRONMENT "GIT_TEXTDOMAINDIR"
    + #define GIT_ATTR_SOURCE_ENVIRONMENT "GIT_ATTR_SOURCE"
    ++#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
    +=20
    + /*
    +  * Environment variable used in handshaking the wire protocol.
    +
      ## repository.c ##
    +@@
    + #include "git-compat-util.h"
    + #include "abspath.h"
    ++#include "environment.h"
    + #include "repository.h"
    + #include "object-store-ll.h"
    + #include "config.h"
     @@
      static struct repository the_repo;
      struct repository *the_repository =3D &the_repo;
    @@ repository.c
     +	const char *hash_name;
     +	int algo;
     +
    -+	hash_name =3D getenv("GIT_DEFAULT_HASH_ALGORITHM");
    ++	hash_name =3D getenv(GIT_DEFAULT_HASH_ENVIRONMENT);
     +	if (!hash_name)
     +		return;
     +	algo =3D hash_algo_by_name(hash_name);
    ++
    ++	/*
    ++	 * NEEDSWORK: after all, falling back to SHA-1 by assigning
    ++	 * GIT_HASH_SHA1 to algo here, instead of returning, may give
    ++	 * us better behaviour.
    ++	 */
     +	if (algo =3D=3D GIT_HASH_UNKNOWN)
     +		return;
    ++
     +	repo_set_hash_algo(repo, algo);
     +}
     +
    @@ repository.c: void initialize_repository(struct repository *repo)
     +	 * giving them an appropriate default individually; any
     +	 * unconverted codepath that tries to access the_hash_algo
     +	 * will thus fail.  The end-users however have an escape hatch
    -+	 * to set GIT_DEFAULT_HASH_ALGORITHM environment variable to
    -+	 * "sha1" get back the old behaviour of defaulting to SHA-1.
    ++	 * to set GIT_DEFAULT_HASH environment variable to "sha1" get
    ++	 * back the old behaviour of defaulting to SHA-1.
     +	 */
     +	if (repo =3D=3D the_repository)
     +		set_default_hash_algo(repo);
      }
     =20
      static void expand_base_dir(char **out, const char *in,
    +
    + ## setup.c ##
    +@@ setup.c: int daemonize(void)
    + #define TEST_FILEMODE 1
    + #endif
    +=20
    +-#define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
    +-
    + static void copy_templates_1(struct strbuf *path, struct strbuf *te=
mplate_path,
    + 			     DIR *dir)
    + {
2:  c40b2bc7b5 ! 2:  e56ae68961 t1517: test commands that are designed to=
 be run outside repository
    @@ t/t1517-outside-repo.sh (new)
     +TEST_PASSES_SANITIZE_LEAK=3Dtrue
     +. ./test-lib.sh
     +
    -+# Do not use the end-user workaround for this test.
    -+# GIT_DEFAULT_HASH_ALGORITHM=3Dsha1; export GIT_DEFAULT_HASH_ALGORI=
THM
    -+
     +test_expect_success 'set up a non-repo directory and test file' '
     +	GIT_CEILING_DIRECTORIES=3D$(pwd) &&
     +	export GIT_CEILING_DIRECTORIES &&
3:  48d83fe1fd ! 3:  e1ae0e95fc builtin/patch-id: fix uninitialized hash =
function
    @@ builtin/patch-id.c: int cmd_patch_id(int argc, const char **argv, =
const char *pr
     +	 * NEEDSWORK: This hack should be removed in favor of converting
     +	 * the code that computes patch IDs to always use SHA1.
     +	 */
    -+	if (!startup_info->have_repository)
    ++	if (!the_hash_algo)
     +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
     +
      	generate_id_list(opts ? opts > 1 : config.stable,
4:  a5bf0dfb0a ! 4:  1c8ce0d024 builtin/hash-object: fix uninitialized ha=
sh function
    @@ Commit message
         SHA1 as the default object hash, 2024-05-07), this will make us =
hit an
         uninitialized hash function, which subsequently leads to a segfa=
ult.
    =20
    -    Fix this by falling back to SHA-1 explicitly when running outsid=
e of a
    -    Git repository. Users can use GIT_DEFAULT_HASH_ALGORITHM environ=
ment to
    -    specify what hash algorithm they want, so arguably this code sho=
uld not
    -    be needed.
    +    Fix this by falling back to SHA-1 explicitly when running outsid=
e of
    +    a Git repository. Users can use GIT_DEFAULT_HASH environment to
    +    specify what hash algorithm they want, so arguably this code sho=
uld
    +    not be needed.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
5:  2b9e486c3f =3D 5:  5b0ec43757 apply: fix uninitialized hash function
