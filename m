Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E941278F34
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631498; cv=none; b=ak0cvsqZbOULuzrljZjFXZFjTSndRshCnnCUVW0lb2fr1tdQKJ6k2wOnSlEDO4cK/UJevFGtHveckLrwHukgcYJ28Ez+LPGzAgOWNtCmc6sfmhEd2WOuUzdP7F1MSYjAushdFeY1oYx0zDjqy9DlpLwLqK1RNE2gByI1UrcCqJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631498; c=relaxed/simple;
	bh=AFRorMwdvC9yDj1T7hrzYmIS0cjlKKzGRzo+/GNDAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3tNERvtbsH9mm8CbHRiU56CUmGDMvuDJ+QvF2cW0N4z2KsAqrHvYLfVsDAS0zyxyYS9pbKNUyBzt8072aE4zVuAwMbRIhfleO/8CWguVDgzbmWBoknQW/f3BSyLcMXC7rcjIO8oZIhI9ltBhZLgKZeKtcC3P29YodY7H4O+9ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dNiqtw6m; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dNiqtw6m"
Received: (qmail 31188 invoked by uid 109); 19 Aug 2025 19:24:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AFRorMwdvC9yDj1T7hrzYmIS0cjlKKzGRzo+/GNDAi4=; b=dNiqtw6mKKCaXBhUUhbprv5hgVIJz+BDHgfvLQxPIsuN3DkeBznFakzBy1JvNCNbAtGeZ3n7pniJUynKF5UIietJxnepockXWW+pvuDiJf0OcN6vXYF7eEXsdTUNjkdKx62U2d95oKLl49Xdnp0X7G+EWytSVAOZJu+/IELN7Vcz08SA9xFoSAkCbJJtv/kYT6IFCoxX4jLWy1lEEw44yqk+in74OETteBUR6M0Gvnhy1XvjZYdMvCO09jzHIWwoambvENefuaILtnpwqZwNmRGRaDmfs3x3ye4Ns5x8VkJClQla1la6KvjOMBBMYpsyoyK26CAlhHodjDCxE+dtUQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:24:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46390 invoked by uid 111); 19 Aug 2025 19:24:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:24:55 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:24:55 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/4] t5510: make confusing config cleanup more explicit
Message-ID: <20250819192455.GA1059295@coredump.intra.peff.net>
References: <20250819192004.GA1058857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192004.GA1058857@coredump.intra.peff.net>

Several tests set a config variable in a sub-repo we chdir into via a
subshell, like this:

  (
	cd "$D" &&
	cd two &&
	git config foo.bar baz
  )

But they also clean up the variable with a when_finished directive
outside of the subshell, like this:

  test_when_finished "git config unset foo.bar"

At first glance, this shouldn't work! The cleanup clause cannot be run
from the subshell (since environment changes there are lost by the time
the test snippet finishes). But since the cleanup command runs outside
the subshell, our working directory will not have been switched into
"two".

But it does work. Why?

The answer is that an earlier test does a "cd two" that moves the whole
test's working directory out of $TRASH_DIRECTORY and into "two". So the
subshell is a bit of a red herring; we are already in the right
directory! That's why we need the "cd $D" at the top of the shell, to
put us back to a known spot.

Let's make this cleanup code more explicitly specify where we expect the
config command to run. That makes the script more robust against running
a subset of the tests, and ultimately will make it easier to refactor
the script to avoid these top-level chdirs.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5510-fetch.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ebc696546b..64fea9f4a5 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -119,7 +119,7 @@ test_expect_success "fetch test remote HEAD change" '
 	test "z$head" = "z$branch"'
 
 test_expect_success "fetch test followRemoteHEAD never" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -134,7 +134,7 @@ test_expect_success "fetch test followRemoteHEAD never" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn no change" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -154,7 +154,7 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn create" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -170,7 +170,7 @@ test_expect_success "fetch test followRemoteHEAD warn create" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn detached" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -187,7 +187,7 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn quiet" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -205,7 +205,7 @@ test_expect_success "fetch test followRemoteHEAD warn quiet" '
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -223,7 +223,7 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is sa
 '
 
 test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -243,7 +243,7 @@ test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is di
 '
 
 test_expect_success "fetch test followRemoteHEAD always" '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
@@ -260,7 +260,7 @@ test_expect_success "fetch test followRemoteHEAD always" '
 '
 
 test_expect_success 'followRemoteHEAD does not kick in with refspecs' '
-	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	test_when_finished "git -C \"$D/two\" config unset remote.origin.followRemoteHEAD" &&
 	(
 		cd "$D" &&
 		cd two &&
-- 
2.51.0.326.gecbb38d78e

