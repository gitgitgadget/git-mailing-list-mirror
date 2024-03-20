Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C932C60
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710927261; cv=none; b=Tl7Ypu8uO3tSX6QkWtsWjrDgtpE+mPUTOBbSIKYzY6KZXxpXPz8dgUrxymdQdyrkySSmNGzXFpCGtWZ+/DlmaRjvHqvFy6RVbp015/17QMg3npSkjOeNZNVgksXJv7GkTye116ZG21fxdkOKRtpC9K06SylO3U42xuZJu1iYvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710927261; c=relaxed/simple;
	bh=5LeEmjwgr33OLxkTJibajZhWfSQ6wo8C/xFJzLqBcK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzsZCi/HL8IyRd2VuEaeR6B6GpuvyqeunwuZyGqsnyShjhXbwIcYXHTikE8/kW9Rd44MuywbZdC50T0dO6txZ5Pp37tVdVEvWiFVuOi+mRs64snyL/GwyKyG8+ypujNuYdgWje9++K94Hrq4sMldUrwvZ3xIzqb6OUkU5dP+bpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11185 invoked by uid 109); 20 Mar 2024 09:34:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 09:34:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16755 invoked by uid 111); 20 Mar 2024 09:34:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Mar 2024 05:34:23 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 20 Mar 2024 05:34:17 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Eric W. Biederman" <ebiederm@gmail.com>
Subject: [PATCH 1/3] transport-helper: use write helpers more consistently
Message-ID: <20240320093417.GA2445682@coredump.intra.peff.net>
References: <20240320093226.GA2445531@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320093226.GA2445531@coredump.intra.peff.net>

The transport-helper code provides some functions for writing to the
helper process, but there are a few spots that don't use them. We should
do so consistently because:

  1. They detect errors on write (though in practice this means the
     helper process went away, and we'd see the problem as soon as we
     try to read the response).

  2. They dump the written bytes to the GIT_TRANSPORT_HELPER_DEBUG
     stream. It's doubly confusing to miss some writes but not others,
     as you see a partial conversation.

The "list" ones go all the way back to the beginning of the transport
helper code; they were just missed when most writes were converted in
bf3c523c3f (Add remote helper debug mode, 2009-12-09). The nearby
"object-format" write presumably just cargo-culted them, as it's only a
few lines away.

Signed-off-by: Jeff King <peff@peff.net>
---
I also find the output kind of verbose (especially the constant
"waiting" lines), and because it's not GIT_TRACE_TRANSPORT_HELPER, it's
annoying to use with the test scripts (it gets eaten by the test
harness, and you can't even redirect it to an alternative file).
So I was tempted to convert it, but it felt like too deep a rabbit hole
for today.

 transport-helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index b660b7942f..7f6bbd06bb 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1211,15 +1211,15 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	helper = get_helper(transport);
 
 	if (data->object_format) {
-		write_str_in_full(helper->in, "option object-format\n");
+		write_constant(helper->in, "option object-format\n");
 		if (recvline(data, &buf) || strcmp(buf.buf, "ok"))
 			exit(128);
 	}
 
 	if (data->push && for_push)
-		write_str_in_full(helper->in, "list for-push\n");
+		write_constant(helper->in, "list for-push\n");
 	else
-		write_str_in_full(helper->in, "list\n");
+		write_constant(helper->in, "list\n");
 
 	while (1) {
 		char *eov, *eon;
-- 
2.44.0.650.g4615f65fe0

