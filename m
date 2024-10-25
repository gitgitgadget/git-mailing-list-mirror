Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87318C03C
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839692; cv=none; b=AlOACApGqiQYvZwn+jbk/pJ6zoDfs7cAio13YHgZQqDGlVALjUZgVMPRsxJ67K0nbZx+rysH9ySFvah51Pt3WE7TLeeJU3Bcz+gWbbi6v84tbq/cZzSlwltal1sAV2Zb4+Am+DW+4umvg8xdfocFEn/jqqerCChO8P6fsGSopLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839692; c=relaxed/simple;
	bh=IGUcww4EptP2drMe9x7JEyDTWUxZ2QY5brhP0sQ7bX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=simGGLECFT9Z6sSC/OmMsMn7pQB6dpH0hdg0J/nfyrG9oGvt+SgPoHI7rgsdOc6G/lBcYg/g/uHjesp0J7sCh6Hr9Y0/JokecuZunHKTrSM5M+jTPWu1LokM3eGTWJ8/YKunZ1kKpG03IwH1ShqiDOF2pHyJO+PpsphYCx+v+Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Icds5HHH; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Icds5HHH"
Received: (qmail 527 invoked by uid 109); 25 Oct 2024 07:01:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=IGUcww4EptP2drMe9x7JEyDTWUxZ2QY5brhP0sQ7bX4=; b=Icds5HHHFJrLBJBAdZb5L4rfWU1Lgoa8REdc1xjxEzzxCj2tOJwzv/NddOJbXBp5+rcSp0JiAMwZ1zodZrTcfjJYo1VyOievlENeu+kcYS4Yz8lgIsBqL+/rkJ/mrroIFjTwaIgvAk8xgVvr9itsaBC87A/HQgSVNeIJPQizydwOSM1GPp45EnNBQhJ2ak4RZdNigUPiQUYorfSxdPG4n1XtusnJXnPTQJgqIhtabfQksE96NJcrVX5/Exz63R5k/TyqFanB7HwtkUjh2CTG6QZrReAjuc8mNxRAhZ7+6Je7doI3cIpLZ3sG9QlqrTOK9Ft5kq/T0DxsGfCEcX9/iQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12847 invoked by uid 111); 25 Oct 2024 07:01:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:01:26 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:01:25 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: fox <fox.gbr@townlong-yak.com>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
Subject: [PATCH 06/11] packfile: drop sha1_pack_index_name()
Message-ID: <20241025070125.GF2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

Like sha1_pack_name() that we dropped in the previous commit, this
function uses an error-prone static strbuf and the somewhat misleading
name "sha1".

The only caller left is in pack-redundant.c. While this command is
marked for potential removal in our BreakingChanges document, we still
have it for now. But it's simple enough to convert it to use its own
strbuf with the underlying odb_pack_name() function, letting us drop the
otherwise obsolete function.

Note that odb_pack_name() does its own strbuf_reset(), so it's safe to
use directly within a loop like this.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-redundant.c | 5 ++++-
 packfile.c               | 6 ------
 packfile.h               | 7 -------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 5809613002..d2c1c4e5ec 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -13,6 +13,7 @@
 
 #include "packfile.h"
 #include "object-store-ll.h"
+#include "strbuf.h"
 
 #define BLKSIZE 512
 
@@ -591,6 +592,7 @@ static void load_all(void)
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
 	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
 	struct llist *ignore;
+	struct strbuf idx_name = STRBUF_INIT;
 	char buf[GIT_MAX_HEXSZ + 2]; /* hex hash + \n + \0 */
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -688,7 +690,7 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pl = red = pack_list_difference(local_packs, min);
 	while (pl) {
 		printf("%s\n%s\n",
-		       sha1_pack_index_name(pl->pack->hash),
+		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
 		       pl->pack->pack_name);
 		pl = pl->next;
 	}
@@ -699,5 +701,6 @@ int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
 	pack_list_free(red);
 	pack_list_free(min);
 	llist_free(ignore);
+	strbuf_release(&idx_name);
 	return 0;
 }
diff --git a/packfile.c b/packfile.c
index 48d650161f..0d4fd2737a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -35,12 +35,6 @@ char *odb_pack_name(struct strbuf *buf,
 	return buf->buf;
 }
 
-char *sha1_pack_index_name(const unsigned char *sha1)
-{
-	static struct strbuf buf = STRBUF_INIT;
-	return odb_pack_name(&buf, sha1, "idx");
-}
-
 static unsigned int pack_used_ctr;
 static unsigned int pack_mmap_calls;
 static unsigned int peak_pack_open_windows;
diff --git a/packfile.h b/packfile.h
index 2bbcc58571..6812abaae0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -31,13 +31,6 @@ struct pack_entry {
  */
 char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
-/*
- * Return the name of the (local) pack index file with the specified
- * sha1 in its name.  The return value is a pointer to memory that is
- * overwritten each time this function is called.
- */
-char *sha1_pack_index_name(const unsigned char *sha1);
-
 /*
  * Return the basename of the packfile, omitting any containing directory
  * (e.g., "pack-1234abcd[...].pack").
-- 
2.47.0.363.g6e72b256be

