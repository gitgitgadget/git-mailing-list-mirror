Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F25E70044
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709159929; cv=none; b=i2MmCMer8sVlNAOQ8J0RBJFzsY+QYI/fNeIHUShRaLaxirIEgvX99UUIQuppQ4wW5HefG/tBtIeJiXngdddhqgS4GsJBZEC8eVZWDMTXwdJQX933aw9RthEvhjuWfjz6zBCVJ0SeuWGHVrHIkaXIO32EViEjeG1bhFGZLj0IBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709159929; c=relaxed/simple;
	bh=7ZTTurmzE4Pl6EQfZ+vQrz3GY9VBJZBkAhaHEznCBdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Torr8ynnLsCHdoZxnYvJIHs4DVL7+4LoHtN+jY5WSHf8ur51fcWHdRs8OqZhzckMy7lS0UHxcr2TdZ4URaQfi13NE3joj7f5m5WuUMl+cVz9tU3uuMzNAH5DWUOCfot3bisWcXbkuK2CN/Ae+V0fLYLSpOqiNt+1hrtsrfuXyew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23680 invoked by uid 109); 28 Feb 2024 22:38:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Feb 2024 22:38:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26762 invoked by uid 111); 28 Feb 2024 22:38:48 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Feb 2024 17:38:48 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Feb 2024 17:38:46 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Benjamin Flesch <benjaminflesch@icloud.com>
Subject: [PATCH 5/9] upload-pack: accept only a single packfile-uri line
Message-ID: <20240228223846.GE1158131@coredump.intra.peff.net>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228223700.GA1157826@coredump.intra.peff.net>

When we see a packfile-uri line from the client, we use
string_list_split() to split it on commas and store the result in a
string_list.  A single packfile-uri line is therefore limited to storing
~64kb, the size of a pkt-line.

But we'll happily accept multiple such lines, and each line appends to
the string list, growing without bound.

In theory this could be useful, making:

  0017packfile-uris http
  0018packfile-uris https

equivalent to:

  001dpackfile-uris http,https

But the protocol documentation doesn't indicate that this should work
(and indeed, refers to this in the singular as "the following argument
can be included in the client's request"). And the client-side
implementation in fetch-pack has always sent a single line (JGit appears
to understand the line on the server side but has no client-side
implementation, and libgit2 understands neither).

If we were worried about compatibility, we could instead just put a
limit on the maximum number of values we'd accept. The current client
implementation limits itself to only two values: "http" and "https", so
something like "256" would be more than enough. But accepting only a
single line seems more in line with the protocol documentation, and
matches other parts of the protocol (e.g., we will not accept a second
"filter" line).

We'll also make this more explicit in the protocol documentation; as
above, I think this was always the intent, but there's no harm in making
it clear.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/gitprotocol-v2.txt | 3 ++-
 upload-pack.c                    | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
index 837ea6171e..414bc625d5 100644
--- a/Documentation/gitprotocol-v2.txt
+++ b/Documentation/gitprotocol-v2.txt
@@ -362,7 +362,8 @@ included in the client's request:
 If the 'packfile-uris' feature is advertised, the following argument
 can be included in the client's request as well as the potential
 addition of the 'packfile-uris' section in the server's response as
-explained below.
+explained below. Note that at most one `packfile-uris` line can be sent
+to the server.
 
     packfile-uris <comma-separated-list-of-protocols>
 	Indicates to the server that the client is willing to receive
diff --git a/upload-pack.c b/upload-pack.c
index 8b47576ec7..2a5c52666e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1646,6 +1646,9 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if (skip_prefix(arg, "packfile-uris ", &p)) {
+			if (data->uri_protocols.nr)
+				send_err_and_die(data,
+						 "multiple packfile-uris lines forbidden");
 			string_list_split(&data->uri_protocols, p, ',', -1);
 			continue;
 		}
-- 
2.44.0.rc2.424.gbdbf4d014b

