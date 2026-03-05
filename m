Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339983644BD
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752199; cv=none; b=mrM48bBC9qcwBwAOC10MO+zr8O+rqK7iznvP2dydXpBQs70BkubScEWc787Ovl1qx9+xuCoFPSGlMAT3hAHr90jTZnIQgQmo6xIg7PMwp4mvS5qjDRjJPfYLUEXHzfkt7lx5Tiflqb0qE4Ljeda2gwxFgYK3gAvzsufq+eoLe0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752199; c=relaxed/simple;
	bh=9ciUT0Lhe4XgUgUlsTWZvHlNBQAnSu1jmAJrffK/OCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idWe5gg/51i2zoWEwp1t4teldx9HtGsTUGohZO1FgxrOvhSxo+5RMOBX/ZhVu8XH47TWEwKdgNpkBGlBn1kt949xHVO25faKAcJfUhSr/uEj512GAItyg6ovWyEMXV68Au9kIRYg1glKMkXkAUmLGh3sKomvY4mqcJxheREzDYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QU/8epuG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QU/8epuG"
Received: (qmail 2679 invoked by uid 106); 5 Mar 2026 23:09:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9ciUT0Lhe4XgUgUlsTWZvHlNBQAnSu1jmAJrffK/OCI=; b=QU/8epuGVPt4Umy4RS+Geoy7HhjtGZfraAFtm7r/rIXFzrN19jS10LClGkDE6DTziMQV50O1F+YFGEtth2VsOT7ou+CBpzKXXLDnt4mBmRP5MLmDfwO0TgOsw5vx4sZ9k0dt1FvQvTS65Z5VqproiZuSabN9J+PkIPyrNNQLOQMXFz5hdyyJZdvqzxgh1O7vjxGdDYSXu28cQHf6xe+/39DoWxdG6P+Rp1uzZOnUnjEcSHmoTqxXNmGzCTswPhWCGAHB10UZ6n/ESuyBeNtLGBB6joPXJPSf/ERL4BkaIGoLvOIr5OmGHHGhiowmMRgrsaJreyAv6Myo0JQ6N6oLyQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 23:09:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393490 invoked by uid 111); 5 Mar 2026 23:09:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 18:09:59 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 18:09:56 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 2/4] check_connected(): fix leak of pack-index mmap
Message-ID: <20260305230956.GB2901305@coredump.intra.peff.net>
References: <20260305230315.GA2354983@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305230315.GA2354983@coredump.intra.peff.net>

Since c6807a40dc (clone: open a shortcut for connectivity check,
2013-05-26), we may open a one-off packed_git struct to check what's in
the pack we just received. At the end of the function we throw away the
struct (rather than linking it into the repository struct as usual).

We used to leak the struct until dd4143e7bf (connected.c: free the
"struct packed_git", 2022-11-08), which calls free(). But that's not
sufficient; inside the struct we'll have mmap'd the pack idx data from
disk, which needs an munmap() call.

Building with SANITIZE=leak doesn't detect this, because we are leaking
our own mmap(), and it only finds heap allocations from malloc(). But if
we use our compat mmap implementation like this:

  make NO_MMAP=MapsBecomeMallocs SANITIZE=leak

then LSan will notice the leak, because now it's a regular heap buffer
allocated by malloc().

We can fix it by calling close_pack(), which will free any associated
memory. Note that we need to check for NULL ourselves; unlike free(), it
is not safe to pass a NULL pointer to close_pack().

Signed-off-by: Jeff King <peff@peff.net>
---
 connected.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index 530357de54..6718503649 100644
--- a/connected.c
+++ b/connected.c
@@ -159,6 +159,9 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
-	free(new_pack);
+	if (new_pack) {
+		close_pack(new_pack);
+		free(new_pack);
+	}
 	return finish_command(&rev_list) || err;
 }
-- 
2.53.0.786.g466665faa3

