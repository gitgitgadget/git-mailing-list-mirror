Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40926198A1B
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360729; cv=none; b=OxRrQvK0F48fn6Yr2b/3/zJZrkgmGmv+lsceDdi0S3d3htDhG9fJQX1rmqSNwAWw4eIZm0pN3yxw8gG8zYS4Cq3+oG4pea8vJUk2r6Sc6F9tFw909zJS3ciThmakawVL/vLniXRt9VuRc1mnkcxS/cwpLKzz8K6qOZ+j3vr3CaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360729; c=relaxed/simple;
	bh=WxqY6klkHDteK4kYJO4ehL4L/uKPjzoGnzFXrKKj6So=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvrJKnXEN70qsIdTeVfc6TqjHh4k8DgeAC0Euc2+YP0Gr2f9aHT35YjupH0psDEoTj0028UcHDbCShOfD3BPlY/7zCJ63P5i8m6XqhjtvK9u7WDp2887igHZK//Ok+oD5g8OdR/xv8rLsoFbjEM0MwQMZuUdHPLe+Xt9ymvHths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16458 invoked by uid 109); 14 Jun 2024 10:25:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Jun 2024 10:25:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27084 invoked by uid 111); 14 Jun 2024 10:25:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Jun 2024 06:25:23 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Jun 2024 06:25:25 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: [PATCH 01/11] archive: fix check for missing url
Message-ID: <20240614102525.GA222445@coredump.intra.peff.net>
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

Running "git archive --remote" checks that we have at least one url for
the remote. It does so by looking at remote.url[0], but that won't work;
if we have no url at all, then remote.url will be NULL, and we'll
segfault.

Check url_nr instead, which is a more direct way of asking what we
want.

You can trigger the segfault like this:

  git -c remote.foo.vcs=bar archive --remote=foo

but I didn't bother adding a test. This is the tip of the iceberg for
no-url remotes, and a later patch will improve that situation. I just
wanted to clean up this bug so it didn't make further refactoring of
this code more confusing.

Signed-off-by: Jeff King <peff@peff.net>
---
This code actually goes away in patch 10, but it's possible we'd want to
take a different approach there. So I preferred to fix this up front
anyway.

 builtin/archive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index 15ee1ec7bb..f35560042e 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -31,7 +31,7 @@ static int run_remote_archiver(int argc, const char **argv,
 	struct packet_reader reader;
 
 	_remote = remote_get(remote);
-	if (!_remote->url[0])
+	if (!_remote->url_nr)
 		die(_("git archive: Remote with no URL"));
 	transport = transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
-- 
2.45.2.937.g0bcb3c087a

