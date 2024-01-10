Received: from mx-out2.startmail.com (mx-out2.startmail.com [145.131.90.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A3C4BA9E
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=to1.studio
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="ExDom9Hz"
From: Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1704896197;
	bh=9ibwpVGYgdzAZuHlFl0HBrpectlfyPa86zvWZhmH6vs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
	 Content-Type:Content-Transfer-Encoding:Content-Disposition:
	 Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
	b=ExDom9HzwXK6AN89ZbgcT2bosPwOuJmNCN/XTrZamWGTPwFViCTF1Oxsgq3lpIiX/
	 8Jx0NjW1WV4wVGsOzo4HmaC2jv0mRo0vcttyaaOOcBtpXE1ZBAaWN10H426v/m4hmq
	 eo0CfSRYTWE+BSl5WglefgP3teIoBicBlcwvwMvia7ecbzUQASbPVVRN1Df8jR6DUR
	 4eYFTAxJmsMt6E7W1488yBDNy/y1IkGXGoRLBSxTn54/MXYx15ZZB+Bn1ijujdzYc5
	 rkqlwj0FPzwD1oji5Xi2wNb7eJgMDHINtmIaZ7EJlP3pq3bSyWVKW2Xz+/CKyLv42T
	 oByCBTp9quwOA==
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 1/1] builtin/show-ref: treat directory directory as non-existing in --exists
Date: Wed, 10 Jan 2024 15:15:59 +0100
Message-ID: <20240110141559.387815-2-toon@iotcl.com>
In-Reply-To: <20240110141559.387815-1-toon@iotcl.com>
References: <20240110141559.387815-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently [1] the option --exists was added to git-show-ref(1). When you
use this option against a ref that doesn't exist, but it is a parent
directory of an existing ref, you're getting the following error:

    $ git show-ref --exists refs/heads
    error: failed to look up reference: Is a directory

This error is confusing to the user. Instead, print the same error as
when the ref was not found:

    error: reference does not exist

[1]: 9080a7f178 (builtin/show-ref: add new mode to check for reference
existence, 2023-10-31)

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 builtin/show-ref.c  | 2 +-
 t/t1403-show-ref.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index aaa2c39b2f..79955c2856 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -238,7 +238,7 @@ static int cmd_show_ref__exists(const char **refs)
 	if (refs_read_raw_ref(get_main_ref_store(the_repository), ref,
 			      &unused_oid, &unused_referent, &unused_type,
 			      &failure_errno)) {
-		if (failure_errno == ENOENT) {
+		if (failure_errno == ENOENT || failure_errno == EISDIR) {
 			error(_("reference does not exist"));
 			ret = 2;
 		} else {
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index ec1957b709..d0a8f7b121 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -262,9 +262,9 @@ test_expect_success '--exists with non-commit object' '
 
 test_expect_success '--exists with directory fails with generic error' '
 	cat >expect <<-EOF &&
-	error: failed to look up reference: Is a directory
+	error: reference does not exist
 	EOF
-	test_expect_code 1 git show-ref --exists refs/heads 2>err &&
+	test_expect_code 2 git show-ref --exists refs/heads 2>err &&
 	test_cmp expect err
 '
 
-- 
2.42.1

