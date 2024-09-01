Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9F23AB
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725204378; cv=none; b=mww+U4eUZVzl9/rsUaDq8GHUugs3uDFlT3FyTEtarmY4PeYZMK+R/mPeNbGDdU63GtX5YWpQFijNUnuFMzQCJt43/DeZpBGWvC7w7Asuclrbg1jvYcIAm2VJv4GSTAGtIPa41u5MDBTzgC0A+O4dfmCcj5qtDnJtrjZOn6IXpLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725204378; c=relaxed/simple;
	bh=7q3JtsclLhAemgyvIP5werCoZHVH1I/1I4dKwrGoOcs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BI2711nGg2Ja8sSkxw9AG6Y01ggzuTiCW7KTy+Ru3b9WhouM1hGOZJHU5yWKBwvJJHg8Spqb491HSR+sWzxskaJz5spgJD6L4UFhHHydUebBvfSqn7lEfvLrPfQ/spNIpCu+ArJDEZ9osRFDR2nbcvUgfGTi1E8d43aj/zlhuxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ieJOfbYS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ieJOfbYS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B0DE37FFE;
	Sun,  1 Sep 2024 11:26:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7q3JtsclLhAemgyvIP5werCoZHVH1I/1I4dKwr
	GoOcs=; b=ieJOfbYS/3lPjeDMLPDhFPRvFgxMkDB/SpzqZfOePwQpjX42vlgAv0
	aecjrIZwXZJMPXTRX7TQC5tviTNGaQTdLuc7jrwKv40IpWL2gR8vH13eRh7ajEsa
	twSJ55jN8IjrOd4EU50nJdL91OARz79JG+hzEMVFcs9GfPJ8B08bY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6020937FFD;
	Sun,  1 Sep 2024 11:26:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A31637FFC;
	Sun,  1 Sep 2024 11:26:09 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ilya K <me@0upti.me>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: git 2.46.0 crashes when trying to verify-pack outside of a repo
In-Reply-To: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me> (Ilya K.'s
	message of "Sat, 31 Aug 2024 09:46:10 +0300")
References: <14ec9394-a7ea-456c-800a-6a84c52e5cda@0upti.me>
Date: Sun, 01 Sep 2024 08:26:08 -0700
Message-ID: <xmqq7cbvpf8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 83AF3CC0-6876-11EF-8E81-9B0F950A682E-77302942!pb-smtp2.pobox.com

Ilya K <me@0upti.me> writes:

> We've updated to Git 2.46.0 in NixOS, and encountered an issue
> with Dulwich (a Python Git implementation) tests failing[0]
> because it attempts to call `git verify-pack` on a bare pack, with
> no surrounding repo. This used to work in Git 2.45.x, but in 2.46
> it simply prints "error: index-pack died of signal 11".

Thanks.  This is a fallout from code-wide clean-up in 2.46.0 where
we do not assume that everybody runs SHA-1.

------- >8 -------
Subject: verify-pack: fall back to SHA-1 outside a repo

In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
2024-05-07), we have stopped setting the default hash algorithm for
`the_repository`. Consequently, code that relies on `the_hash_algo` will
now crash when it hasn't explicitly been initialized, which may be the
case when running outside of a Git repository.

As the verify-pack command ought to be able to infer what algorithm
is used in the input file (and if the input file does not have such
an information, that by itself is a problem), and the command allows
an option to explicitly tell what algorithm to use in case it cannot
be guessed from the input file, in theory we shouldn't have to use
the default algorithm anywhere in the operation of the command, but
we fail fairly early in the process when run outside a repository
without any default algorithm set.

Resurrect the setting of the default algorithm just like we used to
do before 2.46.0

Reported-by: Ilya K <me@0upti.me>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/verify-pack.c  | 4 ++++
 t/t5300-pack-object.sh | 4 ++++
 2 files changed, 8 insertions(+)

diff --git c/builtin/verify-pack.c w/builtin/verify-pack.c
index 011dddd2dc..5b663905ae 100644
--- c/builtin/verify-pack.c
+++ w/builtin/verify-pack.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
+#include "hash.h"
 #include "run-command.h"
 #include "parse-options.h"
 #include "strbuf.h"
@@ -77,6 +78,9 @@ int cmd_verify_pack(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	git_config(git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, verify_pack_options,
 			     verify_pack_usage, 0);
diff --git c/t/t5300-pack-object.sh w/t/t5300-pack-object.sh
index 4ad023c846..d6f45d8923 100755
--- c/t/t5300-pack-object.sh
+++ w/t/t5300-pack-object.sh
@@ -322,6 +322,10 @@ test_expect_success 'verify-pack catches a corrupted sum of the index file itsel
 	fi
 '
 
+test_expect_success 'verify-pack outside a repository' '
+	nongit git verify-pack -v "$(pwd)/test-1-${packname_1}.idx"
+'
+
 test_expect_success 'build pack index for an existing pack' '
 	cat test-1-${packname_1}.pack >test-3.pack &&
 	git index-pack -o tmp.idx test-3.pack &&
