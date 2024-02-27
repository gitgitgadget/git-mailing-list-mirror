Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BDE50A68
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061935; cv=none; b=Zs53YuAWOl33/WAoJc9xK4oxkTX+/u+3Ja1im6j+zML97/BUJrkPQpTBUesf0KlMaTG3lh1sT7UkPQ2SLXid2FCcEQHhMrIB6AftHwwOR9l9MBaoKn0kBe7k25JgsIUSjGV122qu1veETAEL9TozU6Fx981rITaRV/s5TSUhVUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061935; c=relaxed/simple;
	bh=06eAoGO5s9OtrzgBUp0Ev7npw5pO8UloY2RyBcE+PDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDJhByg51FLKqIkHdbdEGFry8GB5GEiGCNHliH5P8BYmuXz74sSSvdzwqWaH+2TmY9wgJslq/DunBjbx9QzLy+RRng8h0bCXgJV5FpNc2BBWZaoqtuSbBDXgk0IKWPvdGHF4tGwNEezRoLQQ2J9JfyKoqCjJbvvxk6HLsRRIWeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16597 invoked by uid 109); 27 Feb 2024 19:25:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 19:25:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13269 invoked by uid 111); 27 Feb 2024 19:25:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 14:25:32 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 14:25:30 -0500
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	"'Randall S. Becker'" <the.n.e.key@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to
 write_in_full avoid truncation.
Message-ID: <20240227192530.GD3784114@coredump.intra.peff.net>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
 <20240227150934.7950-4-randall.becker@nexbridge.ca>
 <xmqq1q8xspht.fsf@gitster.g>
 <03be01da69af$d8366e10$88a34a30$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03be01da69af$d8366e10$88a34a30$@nexbridge.com>

On Tue, Feb 27, 2024 at 02:04:46PM -0500, rsbecker@nexbridge.com wrote:

> >> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c index
> >> e0a701f2b3..6935c4574e 100644
> >> --- a/builtin/unpack-objects.c
> >> +++ b/builtin/unpack-objects.c
> >> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char
> >> **argv, const char *prefix UNUSED)
> >>
> >>  	/* Write the last part of the buffer to stdout */
> >>  	while (len) {
> >> -		int ret = xwrite(1, buffer + offset, len);
> >> +		int ret = write_in_full(1, buffer + offset, len);
> >>  		if (ret <= 0)
> >>  			break;
> >>  		len -= ret;
> [...]
> I experimented with using write_in_full vs. keeping xwrite. With xwrite in
> this loop, t7704.9 consistently fails as described in the other thread. With
> write_in_full, the code works correctly. I assume there are side-effects
> that are present. This change is critical to having the code work on
> NonStop. Otherwise git seems to be at risk of actually being seriously
> broken if unpack does not work correctly. I am happy to have my series
> ignored as long as the problem is otherwise corrected.

I'm somewhat skeptical that this code is to blame, as it should be run
very rarely at all; it is just dumping any content in the pack stream
after the end of the checksum to stdout. But in normal use by Git, there
is no such content in the first place.

If I do this:

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e0a701f2b3..affe55035d 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -680,11 +680,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix UNUSED)
 
 	/* Write the last part of the buffer to stdout */
 	while (len) {
-		int ret = xwrite(1, buffer + offset, len);
-		if (ret <= 0)
-			break;
-		len -= ret;
-		offset += ret;
+		BUG("cruft at the end of the pack!");
 	}
 
 	/* All done */

then t7704 still passes, as it does not run this code at all. In fact,
nothing in the test suite fails. Which is not to say we should get rid
of those code. If we were writing today we might flag it as an error,
but we should keep it for historical compatibility.

But I do not see any bug in the code, and nor do I think it could
contribute to a test failure.

-Peff
