Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA64C153BDE
	for <git@vger.kernel.org>; Fri, 31 May 2024 08:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717145014; cv=none; b=VRQXSJmHkKunNRgVwfS9t3bvKE/t4T6iiLO7akFR5bWtaTxFvKZHrHndM+h9N53tBgkTM5fkiq9lX47uIVkqeXYeDMzeZEBKEYMnLMNjFZ/yGyyHQc1toNlY1oA3T6BcrOB0wDe9yc2M6Aom6b8yFHWzJiOUSg5mw22mI9se708=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717145014; c=relaxed/simple;
	bh=JIaxLxunFlTEuhM67Y6oU8bxDg0QPsRwpbaFTLEZu3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h5QDRqBzoTFZlnTcP4nCDs5nxi4uAVuu2CsyWbIavC4jNIeQqFDaJZudNeSF7FdphSHdyhtFR2in9qXEon7YkRRUtNPhK/j5mjh50ioU2piMmoiRb/w2f4tilUsfekXqHhLyFQdkwlvjaCNk1itFAmN3BE0qY1itP9F+5Ks9/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o5iY1vPT; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o5iY1vPT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D968839036;
	Fri, 31 May 2024 04:43:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JIaxLxunFlTEuhM67Y6oU8bxDg0QPsRwpbaFTL
	EZu3w=; b=o5iY1vPTIGhQK4kWZiw/S02Os2Ws0e6fwpkXX7d5dRtQf9xDihj7zn
	dfnK2osfVu8ToiqlsAkl38KpaalCnivQzHm1v7CIfhicupXLuhzWYpF+cZ+/5s7F
	b9+094G1IIQ0dNqysePl+Y4tcZDVS9VQbz4d8jwxfw/OEbWViOxz8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C44E139035;
	Fri, 31 May 2024 04:43:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CE9D739034;
	Fri, 31 May 2024 04:43:28 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2] t1517: more coverage for commands that work without
 repository
In-Reply-To: <xmqqbk4np77d.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	30 May 2024 09:58:46 -0700")
References: <xmqqbk4np77d.fsf@gitster.g>
Date: Fri, 31 May 2024 01:43:27 -0700
Message-ID: <xmqqwmnajrrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DA50F104-1F29-11EF-88E4-ACC938F0AE34-77302942!pb-smtp20.pobox.com

While most of the commands in Git suite are designed to do useful
things in Git repositories, some commands are also usable outside
any repository.  Building on top of an earlier work abece6e9 (t1517:
test commands that are designed to be run outside repository,
2024-05-20) that adds tests for such commands, let's give coverage
to some more commands.

This patch covers commands whose code has hits for

    $ git grep setup_git_directory_gently

and passes a pointer to nongit_ok variable it uses to allow it to
run outside a Git repository, but mostly they are tested only to see
that they start up (as opposed to dying with "not in a git
repository" complaint).  We may want to update them to actually do
something useful later, but this would at least help us catch
regressions by mistake.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The previous iteration was buggy when the repository was using
   sha256, as the nongit invocation of "git diff" will use sha1.

 t/t1517-outside-repo.sh | 52 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index 557808ffa7..990a036582 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -56,4 +56,56 @@ test_expect_success 'grep outside repository' '
 	test_cmp expect actual
 '
 
+test_expect_success 'imap-send outside repository' '
+	test_config_global imap.host imaps://localhost &&
+	test_config_global imap.folder Drafts &&
+
+	echo nothing to send >expect &&
+	test_must_fail git imap-send -v </dev/null 2>actual &&
+	test_cmp expect actual &&
+
+	(
+		cd non-repo &&
+		test_must_fail git imap-send -v </dev/null 2>../actual
+	) &&
+	test_cmp expect actual
+'
+
+test_expect_success 'check-ref-format outside repository' '
+	git check-ref-format --branch refs/heads/xyzzy >expect &&
+	nongit git check-ref-format --branch refs/heads/xyzzy >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'diff outside repository' '
+	echo one >one &&
+	echo two >two &&
+	test_must_fail git diff --no-index one two >expect.raw &&
+	(
+		cd non-repo &&
+		cp ../one . &&
+		cp ../two . &&
+		test_must_fail git diff one two >../actual.raw
+	) &&
+	# outside repository diff falls back to SHA-1 but
+	# GIT_DEFAULT_HASH may be set to sha256 on the in-repo side.
+	sed -e "/^index /d" expect.raw >expect &&
+	sed -e "/^index /d" actual.raw >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'stripspace outside repository' '
+	nongit git stripspace -s </dev/null
+'
+
+test_expect_success 'remote-http outside repository' '
+	test_must_fail git remote-http 2>actual &&
+	test_grep "^error: remote-curl" actual &&
+	(
+		cd non-repo &&
+		test_must_fail git remote-http 2>../actual
+	) &&
+	test_grep "^error: remote-curl" actual
+'
+
 test_done

Interdiff against v1:
  diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
  index b77017ac5f..990a036582 100755
  --- a/t/t1517-outside-repo.sh
  +++ b/t/t1517-outside-repo.sh
  @@ -80,13 +80,17 @@ test_expect_success 'check-ref-format outside repository' '
   test_expect_success 'diff outside repository' '
   	echo one >one &&
   	echo two >two &&
  -	test_must_fail git diff --no-index one two >expect &&
  +	test_must_fail git diff --no-index one two >expect.raw &&
   	(
   		cd non-repo &&
   		cp ../one . &&
   		cp ../two . &&
  -		test_must_fail git diff one two >../actual
  +		test_must_fail git diff one two >../actual.raw
   	) &&
  +	# outside repository diff falls back to SHA-1 but
  +	# GIT_DEFAULT_HASH may be set to sha256 on the in-repo side.
  +	sed -e "/^index /d" expect.raw >expect &&
  +	sed -e "/^index /d" actual.raw >actual &&
   	test_cmp expect actual
   '
   
-- 
2.45.2-584-g20241e85ff

