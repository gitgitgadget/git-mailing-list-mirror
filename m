Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E4983CD9
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635712; cv=none; b=UQiGiO7VK/UqT+5x96P19smLqrNzsHlG7T+8v8pvBiTojC8QIiMX091ZjG2NeUPD2AVSlwQBBSowOJAbdl/gUndsaYDH1RBSp1DWqmUGhSgnAAWZHUrDYtDAkF6bQLeAOTdv19DvymIbSKAHrtVPHDBrPlQIXLn5Gn6d+yrPBz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635712; c=relaxed/simple;
	bh=VJeLUojzryaTaArCz3Bye5MZieVMQ/Cfc/mgO5lPlDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3RJLSa6rbVXUBxbHLkTb4D5qvfcvqYZQWNzY5xk5r/ovnQ1uRMi/XGM5pk9RI2ubZaSI8pRjTIwQJxrsD4PA/6W2NpkU7efi7bp+r059IaPHcacDKzz+O6azReTzCLlYqH3neKZzsTNKrjh2OD6WGbdJIB4z0JZM73snFjViX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=aUsQ4DBQ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="aUsQ4DBQ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 292D8369A6;
	Mon, 13 May 2024 17:28:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VJeLUojzryaTaArCz3Bye5MZieVMQ/Cfc/mgO5
	lPlDY=; b=aUsQ4DBQ84bo0oBzg+92b3UVvGYXH3UMbudZiLuQTeotCakDvhffth
	RuFiiAE18ZOc9Mz9+3o8KoCr3gM/jl3QWbe/o28bqh2z9MZDLGRF8x88GCAVz7Xa
	Vb8ZmdzFlWouqDADUciHTb4nEgZPv2H453bTk43CDq8tvMprU1dDs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20746369A5;
	Mon, 13 May 2024 17:28:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86BE5369A4;
	Mon, 13 May 2024 17:28:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/4] apply: fix uninitialized hash function
In-Reply-To: <20240513192112.866021-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 13 May 2024 12:21:08 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240513192112.866021-1-gitster@pobox.com>
Date: Mon, 13 May 2024 14:28:27 -0700
Message-ID: <xmqqcyppe70k.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BD3C38FC-116F-11EF-A52B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"git apply" can work outside a repository as a better "GNU patch",
but when it does so, it still assumed that it can access
the_hash_algo, which is no longer true in the new world order.

Make sure we explicitly fall back to SHA-1 algorithm for backward
compatibility.  Just like we argued for hash-objects, we probably
should have a mechanism to specify the hash algorithm used outside
a repository.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * After finishing these steps, it started to dawn on me that we
   probably can instead add GIT_DEFAULT_HASH_ALGO environment
   variable for exactly that purpose.  Then the escape hatch I
   introduced in [1/4] can become just that.

 builtin/apply.c         | 4 ++++
 t/t1517-outside-repo.sh | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 861a01910c..e9175f820f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "repository.h"
+#include "hash.h"
 #include "apply.h"
 
 static const char * const apply_usage[] = {
@@ -18,6 +19,9 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	if (init_apply_state(&state, the_repository, prefix))
 		exit(128);
 
+	if (!the_hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	argc = apply_parse_options(argc, argv,
 				   &state, &force_apply, &options,
 				   apply_usage);
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 854bb8f343..6f32a40c6d 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -39,7 +39,7 @@ test_expect_success 'hash-object outside repository' '
 	test_cmp hash.expect hash.actual
 '
 
-test_expect_failure 'apply a patch outside repository' '
+test_expect_success 'apply a patch outside repository' '
 	(
 		cd non-repo &&
 		cp ../nums.old nums &&
-- 
2.45.0-145-g3e4a232f6e

