Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7713B7BC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215083; cv=none; b=fk86f6HouLghXYw/fNVJcd+T1b2zOiedGJPhernIYIuon9Uxw7Xr3b/76nHjZF4yTix3Jv59Z27wth3TtbVimysyawsPHiDbASoMJQOqhZ8fknZIvxCvrD6fnveuqWd28wTVZvijkyuaZt7s9KjON1AZ72cQcWM3b7WCD9fTMqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215083; c=relaxed/simple;
	bh=SJSJLrZueDT8kZzYhZA+eO9mRzSskgGH82LtB7OOCHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CugZh3QQIBgWryNNz7MmWVPwcM1kifxp4Eb0qeaFRrCS4QvoTNPzs8fwMX0jjW8lHDGSgsY/FRL46jwBc9EYJeao0/7pUue9Vzf0T39Wv/l5MCUzzo+BPz1Iu2pN/lydEgxK/nh0UF4EzIlW5D8CX8DV/JcDMwcqPnpsRr9CshY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15483 invoked by uid 109); 24 Sep 2024 21:58:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:58:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18601 invoked by uid 111); 24 Sep 2024 21:58:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:58:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:58:00 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 11/28] fetch-pack: clear pack lockfiles list
Message-ID: <20240924215800.GK1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

If the --lock-pack option is passed (which it typically is when
fetch-pack is used under the hood by smart-http), then we may end up
with entries in our pack_lockfiles string_list. We need to clear them
before returning to avoid a leak.

In git-fetch this isn't a problem, since the same cleanup happens via
transport_unlock_pack(). But the leak is detectable in t5551, which does
http fetches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index ef4143eef3..62e8c3aa6b 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -295,5 +295,6 @@ int cmd_fetch_pack(int argc,
 	free_refs(remote_refs);
 	list_objects_filter_release(&args.filter_options);
 	oid_array_clear(&shallow);
+	string_list_clear(&pack_lockfiles, 0);
 	return ret;
 }
-- 
2.46.2.1011.gf1f9323e02

