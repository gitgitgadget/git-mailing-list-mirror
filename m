Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889A1FCCEE
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118503; cv=none; b=aGVhqIQk+U7HxIxev6EDeS/TlB0mrLja0cQw96rSIJF+zWVaZ9b01aUDizsoEIAJbo4vgOhkVfCLj+sAhIPKnRw3KvmkjoJAxDy4vxE7QFrSKQWIxCJ9UyIEH+lWOXO1ZsDRXl9meibsUBxXxktgWzu5JhPYUQhm/BF5ACLBVaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118503; c=relaxed/simple;
	bh=CQ85c7ci26jovyosP/S1sH4QhZ/kacsh/qWBZNm4xkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY+5UZG21xlBk43osyBihWPytXPC8Nt/o9F5lxMq9xM3V1qujZJXor8dnGXJY1mdfln+jpJownTZyMnaaiWg/GKbXZSZK9NuqrW+2J88yg+LMGHRzvlUd1f/LML7/4gGZbpikhQQAEsNzTiZZxCh/cBsTYI3HvorOqgMSrp1FnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CtNgxeR7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CtNgxeR7"
Received: (qmail 21917 invoked by uid 109); 17 Jan 2025 12:55:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=CQ85c7ci26jovyosP/S1sH4QhZ/kacsh/qWBZNm4xkM=; b=CtNgxeR7ObasFyhjISHD6V7HznlY2H4HGmk91Thd532JFSfYSsZMcSMQqdifm9xNyNaZjNQRjYueIHZKk5pIIv7rQpWZ0asZOjvvnOfKBnebKSiAIrhDjjMiFz7ogEhqBbStUI5u0RyWYQGHRiUGVP5Su6H9AisknQVGvp7YahTPrY6Fh/CpPp2y9K3wVNH9aWuTOgPr9inhFNPdI8aigivd+z8b5Wlt8eRmOx+OWr0eTIsfMoK2jyCTrfe7nLuss5B8InMtox27DnljmAfOEA0pCdYYBz8DPjHQA6K5nyKElmaMAcX2fiKALsKM7guIY/2PLeCmiVH7nmIW7IdzUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 12:55:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8053 invoked by uid 111); 17 Jan 2025 12:54:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 07:54:59 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 07:54:59 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/3] packfile: factor out --pack_header argument parsing
Message-ID: <20250117125459.GA2893666@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117125207.GB2356599@coredump.intra.peff.net>

Both index-pack and unpack-objects accept a --pack_header argument. This
is an undocumented internal argument used by receive-pack and fetch to
pass along information about the header of the pack, which they've
already read from the incoming stream.

In preparation for a bugfix, let's factor the duplicated code into a
common helper.

The callers are still responsible for identifying the option. While this
could likewise be factored out, it is more flexible this way (e.g., if
they ever started using parse-options and wanted to handle both the
stuck and unstuck forms).

Likewise, the callers are responsible for reporting errors, though they
both just call die(). I've tweaked unpack-objects to match index-pack in
marking the error for translation.

Signed-off-by: Jeff King <peff@peff.net>
---
The generating side of this option is duplicate, too, between
receive-pack and fetch-pack. But it's so much simpler that I didn't
think it was worth factoring out. We could always do it later.

 builtin/index-pack.c     | 14 +++-----------
 builtin/unpack-objects.c | 16 ++++------------
 packfile.c               | 17 +++++++++++++++++
 packfile.h               |  6 ++++++
 4 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0b62b2589f..75b84f78f4 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1955,18 +1955,10 @@ int cmd_index_pack(int argc,
 					nr_threads = 1;
 				}
 			} else if (starts_with(arg, "--pack_header=")) {
-				struct pack_header *hdr;
-				char *c;
-
-				hdr = (struct pack_header *)input_buffer;
-				hdr->hdr_signature = htonl(PACK_SIGNATURE);
-				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
-				if (*c != ',')
-					die(_("bad %s"), arg);
-				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
-				if (*c)
+				if (parse_pack_header_option(arg + 14,
+							     input_buffer,
+							     &input_len) < 0)
 					die(_("bad %s"), arg);
-				input_len = sizeof(*hdr);
 			} else if (!strcmp(arg, "-v")) {
 				verbose = 1;
 			} else if (!strcmp(arg, "--progress-title")) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2197d6d933..cf2bc5c531 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -18,6 +18,7 @@
 #include "progress.h"
 #include "decorate.h"
 #include "fsck.h"
+#include "packfile.h"
 
 static int dry_run, quiet, recover, has_errors, strict;
 static const char unpack_usage[] = "git unpack-objects [-n] [-q] [-r] [--strict]";
@@ -645,18 +646,9 @@ int cmd_unpack_objects(int argc,
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
-				struct pack_header *hdr;
-				char *c;
-
-				hdr = (struct pack_header *)buffer;
-				hdr->hdr_signature = htonl(PACK_SIGNATURE);
-				hdr->hdr_version = htonl(strtoul(arg + 14, &c, 10));
-				if (*c != ',')
-					die("bad %s", arg);
-				hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
-				if (*c)
-					die("bad %s", arg);
-				len = sizeof(*hdr);
+				if (parse_pack_header_option(arg + 14,
+							     buffer, &len) < 0)
+					die(_("bad %s"), arg);
 				continue;
 			}
 			if (skip_prefix(arg, "--max-input-size=", &arg)) {
diff --git a/packfile.c b/packfile.c
index cc7ab6403a..2bf9e57330 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2315,3 +2315,20 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 	}
 	return oidset_contains(&promisor_objects, oid);
 }
+
+int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *len)
+{
+	struct pack_header *hdr;
+	char *c;
+
+	hdr = (struct pack_header *)out;
+	hdr->hdr_signature = htonl(PACK_SIGNATURE);
+	hdr->hdr_version = htonl(strtoul(in, &c, 10));
+	if (*c != ',')
+		return -1;
+	hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+	if (*c)
+		return -1;
+	*len = sizeof(*hdr);
+	return 0;
+}
diff --git a/packfile.h b/packfile.h
index 58104fa009..00ada7a938 100644
--- a/packfile.h
+++ b/packfile.h
@@ -216,4 +216,10 @@ int is_promisor_object(struct repository *r, const struct object_id *oid);
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 	     size_t idx_size, struct packed_git *p);
 
+/*
+ * Parse a --pack_header option as accepted by index-pack and unpack-objects,
+ * turning it into the matching bytes we'd find in a pack.
+ */
+int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *len);
+
 #endif
-- 
2.48.1.438.g7fbf7b046e

