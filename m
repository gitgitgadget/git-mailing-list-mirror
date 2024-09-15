Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10A38C
	for <git@vger.kernel.org>; Sun, 15 Sep 2024 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726399879; cv=none; b=khVHFyfnibKz4NJGwdD85OVPCXu7x7vYURQIYSmbSAROmwYBxnULt4K2ezzC84+l/amwHOUtPkrpj8kI50NOMXtMsT5m//ckx6P3yqOfFehR/tkSeMmfCoc4NWIooHGEwHmczmYrqPKz5bDHHgsWLrOGzIXncWBYq/q2DyXIUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726399879; c=relaxed/simple;
	bh=/r4T3Yv6n9jOI6jfBuw0zO11SbEvMeFGGvCptRkO3LI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XwTlOz4i4jpHAyooDl0FmCmNAu0VvG8JgCVsxYIl5N+nuA7iZMV0eIbJEIzMC/H83WAjWpZQfb14Zzv4iM9DzRn4e126UXo/UPxB20e9Q+S3AGY9+g89/Isv8hKwaEULG+jOLvKF0f67Cx5CcO1Sb1h1h5PBGhuSiMyS2DUR7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 8143 invoked by uid 109); 15 Sep 2024 11:31:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Sep 2024 11:31:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22227 invoked by uid 111); 15 Sep 2024 11:31:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Sep 2024 07:31:15 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Sep 2024 07:31:15 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] t9001: use a more distinct fake BugID
Message-ID: <20240915113115.GA2019070@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

In the test "cc list is sanitized", we feed a commit with a variety of
trailers to send-email, and then check its output to see how it handled
them. For most of them, we are grepping for a specific mention of the
header, but there's a "BugID" header which we expect to be ignored. We
confirm this by grepping for "12345", the fake BugID, and making sure it
is not present.

But we can be fooled by false positives! I just tracked down a flaky
test failure here that was caused by matching this unrelated line in the
output:

  <20240914090449.612345-1-author@example.com>

which will change from run to run based on the time, pid, etc.

Ideally we'd tighten the regex to make this more specifically, but since
the point is that it _shouldn't_ be mentioned, it's hard to say what the
right match would be (e.g., would there be a leading space?).

Instead, let's just choose a match that is much less likely to appear.
The actual content of the header isn't important, since it's supposed to
be ignored.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess this is fairly unlikely, as re-running the test with --stress
didn't reproduce after a few hundred attempts. Back of the envelope, I
guess any 5-digit sequence has a 1-in-10^5 chance of matching our
target. There are 2 in chances in a 6-digit pid. Some in the date, but
as there's no December 34th or hour 34, you're limited to a few specific
times like 01:23:45 (or at 11am), 12:34:5x, or perhaps 23:45 on the 1st,
11th, or 21st of the month.

So I think I just got really unlucky, but after spending several minutes
debugging, I wouldn't want to wish it on anybody else. ;)

 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index df5336bb7e..e2430f7bfa 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1324,7 +1324,7 @@ test_expect_success $PREREQ 'cc list is sanitized' '
 	Reviewed-by: Füñný Nâmé <odd_?=mail@example.com>
 	Reported-by: bugger on Jira
 	Reported-by: Douglas Reporter <doug@example.com> [from Jira profile]
-	BugID: 12345
+	BugID: 12345should-not-appear
 	Co-developed-by: "C. O. Developer" <codev@example.com>
 	Signed-off-by: A. U. Thor <thor.au@example.com>
 	EOF
@@ -1337,7 +1337,7 @@ test_expect_success $PREREQ 'cc list is sanitized' '
 " <odd_?=mail@example.com>" actual-show-all-headers &&
 	test_grep "^(body) Ignoring Reported-by .* bugger on Jira" actual-show-all-headers &&
 	test_grep "^(body) Adding cc: Douglas Reporter <doug@example.com>" actual-show-all-headers &&
-	test_grep ! "12345" actual-show-all-headers &&
+	test_grep ! "12345should-not-appear" actual-show-all-headers &&
 	test_grep "^(body) Adding cc: \"C. O. Developer\" <codev@example.com>" actual-show-all-headers &&
 	test_grep "^(body) Adding cc: \"A. U. Thor\" <thor.au@example.com>" actual-show-all-headers
 '
-- 
2.46.1.893.gc4b01a7614
