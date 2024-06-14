Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28931946CF
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361008; cv=none; b=b1z0PGQm0meblmfjdZ/4+dwsayRqSYH8XrqD5FEE+VDwhu3ty3sHbHgdWUMsxV+E3TYP7qvvHPMgn0vQcNbKPJDZoa92wt9QF7IJHzyzD5xnBL3x5HmgJFc+LnYtS/cP3U1lhbrnQKMB5PMjCIBIOp8jk2afTrPFxMZ498iJstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361008; c=relaxed/simple;
	bh=Tseg8e4OiM5F6mcjcdWNDXpH1MaNsbBV1dEB0JOw3vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtQi4HwzGWmwJOzTGTS7hdFGBjkn6Uq452emaG7X06MVfYYY1tBMafwSPuW/ydLsHgeP5yfCOWt4+GzTZlgAVNL4MzrOleJndIRGqHLYIHJmNRF83E+2E2Owx53vcGuwqEjw4n4uLUDu2qkiAJv7W96B6HHOiz12J5SrEk/KaHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16556 invoked by uid 109); 14 Jun 2024 10:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27218 invoked by uid 111); 14 Jun 2024 10:30:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:30:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:30:05 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 06/11] config: document remote.*.url/pushurl interaction
Message-ID: <20240614103005.GF222445@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240614102439.GA222287@coredump.intra.peff.net>

The documentation for these keys gives a very terse definition and
points you to the fetch/push manpages. But from reading those pages it
was not at all obvious to me that:

  - these are keys that can be defined multiple times with meaningful
    behavior (especially remote.*.url)

  - the way that pushurl overrides url (the git-push page does mention
    that "pushurl defaults to url", but it is not immediately clear what
    a multi-valued url would do in that situation).

Let's try to summarize the current behavior.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config/remote.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 0678b4bcfe..eef0bf4f62 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -5,10 +5,16 @@ remote.pushDefault::
 
 remote.<name>.url::
 	The URL of a remote repository.  See linkgit:git-fetch[1] or
-	linkgit:git-push[1].
+	linkgit:git-push[1]. A configured remote can have multiple URLs;
+	in this case the first is used for fetching, and all are used
+	for pushing (assuming no `remote.<name>.pushurl` is defined).
 
 remote.<name>.pushurl::
 	The push URL of a remote repository.  See linkgit:git-push[1].
+	If a `pushurl` option is present in a configured remote, it
+	is used for pushing instead of `remote.<name>.url`. A configured
+	remote can have multiple push URLs; in this case a push goes to
+	all of them.
 
 remote.<name>.proxy::
 	For remotes that require curl (http, https and ftp), the URL to
-- 
2.45.2.937.g0bcb3c087a

