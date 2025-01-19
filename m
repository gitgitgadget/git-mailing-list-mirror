Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDED2913
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 13:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293021; cv=none; b=N6E6lMZJpXgRyHlsxSGnRsMLdm1A7vWYJaV8pB0Vt2C6NfDSnghfTz8uVnMDkRZaAOAEfLddlfu3zQvqiK+j0j04lsa+pUFd3cRhHQtavlVM4R46O9EwfngMVhM2EaWRwxknGOxLZBEhRvVQOx6O3pH8yhtSayvxN9/qyM5ucbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293021; c=relaxed/simple;
	bh=M601vB9sRbik5FJIH0h1AYpNfUThGTn4Pn4XlJbl9mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC+7CnOfouu5vuJw7EZzb8/VCRHjckD8zCmToxUHhMdXdhyyE8cZ+G/0HV6kDznnrsMkgoTrn81bL9W37DpgZBjWo8gzOKMWWy65YTIpOrWyIpggImw0T7KF1DXOuNltvtKh7YkUVSZMFnFMrc9iS0S2xzTbdb4fbgoptljfwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=S5vJQxyQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="S5vJQxyQ"
Received: (qmail 7973 invoked by uid 109); 19 Jan 2025 13:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=M601vB9sRbik5FJIH0h1AYpNfUThGTn4Pn4XlJbl9mA=; b=S5vJQxyQzHEUh7Ot1DARojslyqqGIEJrQakv3Wlcd/9HGP54gaIHzeR/dl0tCZxCjg1XjgWoWRjS+lvUEfmSlcXbRwcnnHvEzsiG+rvZ37VBU/fLwsGbMo6qTb+E7ffW02VH+5Dehzg0lEom2rFcWbVg9jSFIMIEn1M4fWvEbyxFQkaZTshZ3V1GLoJsTSFvTPykfwVQkeBkML0v3SfLHLXGG491GePjuZdP/OETWncSxB3+M756PhGKZ5jWR1fFzTgjm8LtSo6opehpI1VRH0Uap22ZdXylStG8SRGnfWmiP08f0KSST0LwEIN04TqzjZHUCELHwIgQ4yfiBAD7Mg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 13:23:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 742 invoked by uid 111); 19 Jan 2025 13:23:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 08:23:38 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 08:23:37 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 2/5] packfile: factor out --pack_header argument parsing
Message-ID: <20250119132337.GB1552263@coredump.intra.peff.net>
References: <20250119131224.GA1541095@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119131224.GA1541095@coredump.intra.peff.net>

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
Same as before.

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
2.48.1.466.g22b8cfd1fa

