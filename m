Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAD53B1A1
	for <git@vger.kernel.org>; Thu, 30 May 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088333; cv=none; b=D4d8lUFJultF2J+2Az5OMy9HaGplUzauf+9G/rrmKYZ+oPcJVCRs1ZAuwM6ohPewszHjU4+h6WzkfwMYKsLMZCFoRgRxwRfxu9BkM9G5qhpaYB5OnhwMVukyfYR5pdLS5jl42H0E0V04qqqj+ArzIvxm9OeLdKSi5N/kc/SWh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088333; c=relaxed/simple;
	bh=UlHAAaifDpEKpPJM5orc8WFNB6juQspnY+P8V2Fal+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YtegV1zuYwbKgYjCT1smIMqV5C7+vd+zNhAe3AaD+GLhqEraQWFsAJbIwF4tKYofCn/DkPCB5Eh0KnsH8QArxqgVDXLRWR+zUfzj91USORaZuUmq2mjpeJIhy/VTAd67YeycW29Be29eHzs27Q2euDF9qsKiN/V4/3YLrSwcnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EKL/55kH; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EKL/55kH"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 19C183A922;
	Thu, 30 May 2024 12:58:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=U
	lHAAaifDpEKpPJM5orc8WFNB6juQspnY+P8V2Fal+s=; b=EKL/55kHjYLOrrzMh
	e2N/ZcUi+9cHehVl30g/p2VBDkRMmSQB9kWDxcsDSxlW2cZTfNt0hZZDhbM1Va/W
	yMz3KSRMEHpSD+Y+w16BiGjQ424ofrLD4YDODnjBU2MrBap9laDBYda1GuJpXqca
	oP2Ur/xXEVOFPSOcFVPdDEcWHY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 12DCE3A921;
	Thu, 30 May 2024 12:58:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 29CDB3A91F;
	Thu, 30 May 2024 12:58:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] t1517: more coverage for commands that work without repository
Date: Thu, 30 May 2024 09:58:46 -0700
Message-ID: <xmqqbk4np77d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E2000126-1EA5-11EF-8824-8F8B087618E4-77302942!pb-smtp21.pobox.com

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

 * Designed to apply on top of jc/undecided-is-not-necessarily-sha1-fix
   that introduces t1517.

 t/t1517-outside-repo.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git c/t/t1517-outside-repo.sh w/t/t1517-outside-repo.sh
index 557808ffa7..b77017ac5f 100755
--- c/t/t1517-outside-repo.sh
+++ w/t/t1517-outside-repo.sh
@@ -56,4 +56,52 @@ test_expect_success 'grep outside repository' '
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
+	test_must_fail git diff --no-index one two >expect &&
+	(
+		cd non-repo &&
+		cp ../one . &&
+		cp ../two . &&
+		test_must_fail git diff one two >../actual
+	) &&
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
