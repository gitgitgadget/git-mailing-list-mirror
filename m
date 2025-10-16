Received: from lamorak.hansenpartnership.com (lamorak.hansenpartnership.com [198.37.111.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B55E334680
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.37.111.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760641179; cv=none; b=ADJSHwjXipvqtJmXCdWQMEeHve9ookkBspKTC4Nwg858TwcUBFzyeOJsqCdYHIt0tTF8eKpPOi/M+D7dfdMx8Z8z+7bl5QQodhtSpS7Ke9FcRF3DwxgY9e9h2O3D894a0qMCUx0qHz9k4cTgaHVSU2syTbwQjPkEGSZurmrX67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760641179; c=relaxed/simple;
	bh=Uz5Y3eOnhrUPyNmjFAJSTUGJ3us7EXq6NDj4o8Vsj9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wcsm/HTn7qAkOHr/HSUkrOHhlz4MJ66yCw8fla6oizMxawKtxKhWlbRjtOYiaPehpv2yzbcOZvVC2Mpkj70BB6CMhj4d+TBxiPnTgMYQWnMaR3Dnq32Kwvo62jzCfCRJ8uPo7l7x1XuWrN/twHVj50mLgX/hpDqntryAOp6QsfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iOjwTyKG; arc=none smtp.client-ip=198.37.111.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iOjwTyKG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1760641176;
	bh=Uz5Y3eOnhrUPyNmjFAJSTUGJ3us7EXq6NDj4o8Vsj9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:From;
	b=iOjwTyKGdXq4VhAubns/aXun/Oz3fSuIYkKIfXCSkZmK15IxQ3+oP8uDzD8QuaVF5
	 OyQ9NaPO6yUuvzHQ4pTM14dg3w2wRTOjLhPEzS8qIr8HxnGkAqGvNjv8vUlJgU6APf
	 ERH6fS4m+VHBwg10JD+tTJLI3sIViVAKLb7WjXpg=
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by lamorak.hansenpartnership.com (Postfix) with ESMTP id 272331C01EF
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 14:59:36 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: git@vger.kernel.org
Subject: [PATCH 3/3] t4150-am: add a test for message-id header collection
Date: Thu, 16 Oct 2025 14:57:58 -0400
Message-ID: <20251016185758.21996-4-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
References: <20251016185758.21996-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since git am now always adds the message-id header, fix test 'am
applies patch e-mail not in a mbox' not to add the header because
otherwise the commit won't be equivalent to second and add a new test
that the message-id header gets correctly added.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 t/t4150-am.sh | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 699a81ab5c..82603b2bbf 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -109,6 +109,12 @@ test_expect_success setup '
 		echo "X-Fake-Field: Line Three" &&
 		git format-patch --stdout first | sed -e "1d"
 	} > patch1.eml &&
+	{
+		echo "X-Fake-Field: Line One" &&
+		echo "X-Fake-Field: Line Two" &&
+		echo "X-Fake-Field: Line Three" &&
+		git format-patch --stdout first | sed -e "1d"
+	} > patch1-nomsgid.eml &&
 	{
 		echo "X-Fake-Field: Line One" &&
 		echo "X-Fake-Field: Line Two" &&
@@ -235,13 +241,25 @@ test_expect_success 'am applies patch e-mail not in a mbox' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
 	git checkout first &&
-	git am patch1.eml &&
+	git am patch1-nomsgid.eml &&
 	test_path_is_missing .git/rebase-apply &&
 	git diff --exit-code second &&
 	test "$(git rev-parse second)" = "$(git rev-parse HEAD)" &&
 	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)"
 '
 
+test_expect_success 'am adds message-id to the header' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout first &&
+	git am patch1.eml &&
+	test_path_is_missing .git/rebase-apply &&
+	git diff --exit-code second &&
+	test "$(git rev-parse second)" != "$(git rev-parse HEAD)" &&
+	test "$(git rev-parse second^)" = "$(git rev-parse HEAD^)" &&
+	git show --pretty=raw HEAD | grep "^message-id <1226501681-24923-1-git-send-email-bda@mnsspb.ru>"
+'
+
 test_expect_success 'am applies patch e-mail not in a mbox with CRLF' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
-- 
2.51.0

