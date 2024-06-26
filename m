Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCB918FC85
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426690; cv=none; b=LcTCMBSuAR2SeYLaedg+Eoaxhuw73azA5MmtCTyHTCVir1CAwvzYRhrHkRGbnY3gLpMo4ragOveQlfFnU4cGh2aoHBTYvJCh+zOM40pgWynfOhLPRz/wd9r7GL1xVf3bczNqk01O7v57VNQYwcX3qkiGc5Ljfh5j4nM06Xf7We4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426690; c=relaxed/simple;
	bh=XehqHkcrDhfYElTk3qmZVzS1CGMCsd5idpitvbmJ9HI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h7oScAvDhCDqY9x6qpfp8ZpK3/DKhSJSwDQoloTAhqeHjMIlf/eh7pud3PHxIndcnuSVGwcxyiiKiYv1HJhl4eNVRtaaxxOmnxIhHXl7m6qC3wnypUDlwKA32dI3gUgc7OiCoqpstC8mXlS9W8Fb4771jwqBq0uETK2Z64PnOso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=sbau6KMM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sbau6KMM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4187023913;
	Wed, 26 Jun 2024 14:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XehqHkcrDhfYElTk3qmZVzS1CGMCsd5idpitvb
	mJ9HI=; b=sbau6KMMkt5o2u/Y71H7+60i7fgUtMijmluc5yF4GuplWgjRpNuk4O
	jAGGuyzpo6yXDplzPyQC9q6q/zxcPOzGE7wJBc37p1nwiJaW5fMjTZlo2gmnji+z
	TG3KxA9l2cecBqBIb76lha7AXBF0WJSaklUOl8vb908dQV5pUQlKg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38C6D23912;
	Wed, 26 Jun 2024 14:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9938B23911;
	Wed, 26 Jun 2024 14:31:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  Paul Millar <paul.millar@desy.de>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Elijah Newren <newren@gmail.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v5] describe: refresh the index when 'broken' flag is used
In-Reply-To: <20240626065223.28154-1-abhijeet.nkt@gmail.com> (Abhijeet Sonar's
	message of "Wed, 26 Jun 2024 12:22:11 +0530")
References: <xmqq34p1813n.fsf@gitster.g>
	<20240626065223.28154-1-abhijeet.nkt@gmail.com>
Date: Wed, 26 Jun 2024 11:31:25 -0700
Message-ID: <xmqqpls3zhc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4C408FCA-33EA-11EF-B915-965B910A682E-77302942!pb-smtp2.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> When describe is run with 'dirty' flag, we refresh the index
> to make sure it is in sync with the filesystem before
> determining if the working tree is dirty.  However, this is
> not done for the codepath where the 'broken' flag is used.
>
> This causes `git describe --broken --dirty` to false
> positively report the worktree being dirty if a file has
> different stat info than what is recorded in the index.
> Running `git update-index -q --refresh` to refresh the index
> before running diff-index fixes the problem.
>
> Also add tests to deliberately update stat info of a
> file before running describe to verify it behaves correctly.
>
> Reported-by: Paul Millar <paul.millar@desy.de>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---

As I screwed up with the suggestion to do child_process_clear()
after a failed run_command(), let me fix that up.  A suggested
change that can be squashed into this patch is attached at the end.

 * (style) a blank line between a block of variable declarations and
   the first statement;

 * run_command(&cp) cleans cp so no need for separate
   child_process_clear(&cp);

 * but child_process_init(&cp) is needed, just as 4d0984be (fsck: do
   not reuse child_process structs, 2018-11-12) explains, before
   reusing the structure for a separate call.

 * instead of "replace with a different file" which relies on having
   a working inum, use "test-tool chmtime" to reliably force dirty
   mtime.

 * everybody else compares "actual" against "expect", not
   "expected".  imitate them.

 * test "--dirty" and "--dirty --broken" separately in two separate
   tests.

Thanks.


 builtin/describe.c  |  5 +++--
 t/t6120-describe.sh | 28 ++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git c/builtin/describe.c w/builtin/describe.c
index a58f6134f0..e936d2c19f 100644
--- c/builtin/describe.c
+++ w/builtin/describe.c
@@ -649,13 +649,14 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+
 			strvec_pushv(&cp.args, update_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
 			cp.no_stdout = 1;
-			if (run_command(&cp))
-				child_process_clear(&cp);
+			run_command(&cp);
 
+			child_process_init(&cp);
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git c/t/t6120-describe.sh w/t/t6120-describe.sh
index 6c396e7abc..79e0f19deb 100755
--- c/t/t6120-describe.sh
+++ w/t/t6120-describe.sh
@@ -672,6 +672,7 @@ test_expect_success 'setup misleading taggerdates' '
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
 test_expect_success 'describe --dirty with a file with changed stat' '
+	test_when_finished "rm -fr stat-dirty" &&
 	git init stat-dirty &&
 	(
 		cd stat-dirty &&
@@ -680,18 +681,29 @@ test_expect_success 'describe --dirty with a file with changed stat' '
 		git add file &&
 		git commit -m A &&
 		git tag A -a -m A &&
+		echo "A" >expect &&
 
-		cat file >file.new &&
-		mv file.new file &&
+		test-tool chmtime -10 file &&
 		git describe --dirty >actual &&
-		echo "A" >expected &&
-		test_cmp expected actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'describe --broken --dirty with a file with changed stat' '
+	test_when_finished "rm -fr stat-dirty" &&
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
 
-		cat file >file.new &&
-		mv file.new file &&
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+		echo "A" >expect &&
+
+		test-tool chmtime -10 file &&
 		git describe --dirty --broken >actual &&
-		echo "A" >expected &&
-		test_cmp expected actual
+		test_cmp expect actual
 	)
 '
 
