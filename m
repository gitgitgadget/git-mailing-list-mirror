Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411B23BBC0
	for <git@vger.kernel.org>; Fri, 29 Mar 2024 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711690653; cv=none; b=Auzr387aLzPH6ks9uJjTmyM3hOWgkbqa8zsQFlnkGGpnE8wagjltC3W5JSmbHlfYuQF1gJZNdLTGwT8cq8DxIcYKyVNLdgwfU+tmxvwhRivAh+FszrQ2k8An5xlBh0EC7JYBBPfnD1yrzBEJ8KRToJjpv28sjuqqxgYmT2d3PvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711690653; c=relaxed/simple;
	bh=0/MBRIRboZoCLFg53lFalwmb5OMEtjxw2h+oALcDubc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G/Dvy3guNOLF78MGcW8KuzIVXSL9zI6bqJeK9qZodBW9Je8gRCixOuzmwdvtFVHImTbt83KQysNRVbcnpqH1ZuUCvkiunX59BkyutxcezhHoyQ6u/tz41UkIJyd8Ug3V/g7ZGnRkLt9l+XBm5muk8y3sjhDMAoMZYzOCA6MNmt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zgvgg3yC; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zgvgg3yC"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 665112C764;
	Fri, 29 Mar 2024 01:37:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0/MBRIRboZoCLFg53lFalwmb5OMEtjxw2h+oAL
	cDubc=; b=Zgvgg3yCQBGHYpsD0NwT8t8QXyGSNdssK5COkmxPl7r9AjjyHOhJr/
	vV7Y5nagRzMkglz5QgAYuCYMrKDmobeQOgdXYZGGXF5hHLNniMr6gMjhKSXze4aE
	bMcJchOHrvFy44eXlQHLP7RSznW2l+Dv8+yf/3eH8DjfMejYTiMdc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 52C5B2C762;
	Fri, 29 Mar 2024 01:37:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8BFF2C756;
	Fri, 29 Mar 2024 01:37:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,  Jeff King <peff@peff.net>,
  Han Young <hanyang.tony@bytedance.com>,  Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t4126: fix "funny directory name" test on Windows (again)
In-Reply-To: <xmqqil15srub.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	28 Mar 2024 19:18:52 -0700")
References: <20240319095212.42332-1-hanyang.tony@bytedance.com>
	<xmqqttl2qml9.fsf@gitster.g> <xmqqfrwlltjn.fsf@gitster.g>
	<xmqqsf0bz5oj.fsf@gitster.g>
	<20240328103254.GA898963@coredump.intra.peff.net>
	<20240328114038.GA1394725@coredump.intra.peff.net>
	<CAPig+cQe1rAN2MUFTwo7JoCt3sO2eCk_psnJL9D=Rs=Q9MWO9A@mail.gmail.com>
	<xmqqa5miuutd.fsf@gitster.g> <xmqqh6gqt674.fsf_-_@gitster.g>
	<xmqqil15srub.fsf@gitster.g>
Date: Thu, 28 Mar 2024 22:37:25 -0700
Message-ID: <xmqqwmplvbsa.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6D34A6B4-ED8E-11EE-BAA2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Even though "git update-index --cacheinfo" ought to be filesystem
agnostic, somehow

    $ git update-index --add --cacheinfo "100644,$empty_blob,funny /empty"

fails only there.  That unfortunately makes the approach of the
previous step unworkable.

Resurrect the earlier approach to protect the test with a
prerequisite to make sure we do not needlessly fail the CI.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4126-apply-empty.sh | 43 +++++++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 2462cdf904..d2ac7a486f 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -66,29 +66,38 @@ test_expect_success 'apply --index create' '
 	git diff --exit-code
 '
 
-test_expect_success 'parsing a patch with no-contents and a funny pathname' '
+test_expect_success 'setup patches in dir ending in SP' '
+	test_when_finished "rm -fr \"funny \"" &&
+	mkdir "funny " &&
+	>"funny /empty" &&
+	git add "funny /empty" &&
+	git diff HEAD -- "funny /" >sample.patch &&
+	git diff -R HEAD -- "funny /" >elpmas.patch &&
 	git reset --hard &&
-	empty_blob=$(test_oid empty_blob) &&
-	echo "$empty_blob" >expect &&
 
-	git update-index --add --cacheinfo "100644,$empty_blob,funny /empty" &&
-	git diff --cached HEAD -- "funny /" >sample.patch &&
-	git diff --cached -R HEAD -- "funny /" >elpmas.patch &&
-	git reset &&
+	if  grep "a/funny /empty b/funny /empty" sample.patch &&
+	    grep "b/funny /empty a/funny /empty" elpmas.patch
+	then
+		test_set_prereq DIR_ENDS_WITH_SP
+	else
+		# Win test???
+		ls -l
+	fi
+'
+
+test_expect_success DIR_ENDS_WITH_SP 'apply with no-contents and a funny pathname' '
 
-	git apply --cached --stat --check --apply sample.patch &&
-	git rev-parse --verify ":funny /empty" >actual &&
-	test_cmp expect actual &&
+	git apply --stat --check --apply sample.patch &&
+	test_must_be_empty "funny /empty" &&
 
-	git apply --cached --stat --check --apply elpmas.patch &&
-	test_must_fail git rev-parse --verify ":funny /empty" &&
+	git apply --stat --check --apply elpmas.patch &&
+	test_path_is_missing "funny /empty" &&
 
-	git apply -R --cached --stat --check --apply elpmas.patch &&
-	git rev-parse --verify ":funny /empty" >actual &&
-	test_cmp expect actual &&
+	git apply -R --stat --check --apply elpmas.patch &&
+	test_must_be_empty "funny /empty" &&
 
-	git apply -R --cached --stat --check --apply sample.patch &&
-	test_must_fail git rev-parse --verify ":funny /empty"
+	git apply -R --stat --check --apply sample.patch &&
+	test_path_is_missing "funny /empty"
 '
 
 test_done
-- 
2.44.0-413-gd6fd04375f

