Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C029A0
	for <git@vger.kernel.org>; Fri, 31 May 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717156838; cv=none; b=Pg8CnolvwHBy/CjVO5N3X58Cknw+KrQLeP6HqsetElbg3mBy7ZpctuSfKAvNPr6xreP/VyBfoL3mgHaswm2TRUyU8I9bNu9D9oqi5pvdQ8V0kg+8geKNBIATm/PtpuMjf+G4jeVyhD1e1yRuGC21WsIKk9jtHUJj2T3hL660wRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717156838; c=relaxed/simple;
	bh=e5aTqWkuw+PN1v9OAlvvy6QlH/CLsT10Fl1i6HbcW6U=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qK1NGuRcdR/MulTfuuDogCf091uJzPIR7og80BTg+6kx5rW41Dtt1LnBlXmUpi4WgYe9wnrjmYkhYswL9k+KZxQtHVuOAji+5HAERZ0UHhjf20Rv8iF8WjKlUcY71bUWUBBo70hBzyOZN0506Z7W33Pg8MtVyH8T29X1kUb1MLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22824 invoked by uid 109); 31 May 2024 12:00:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 12:00:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9557 invoked by uid 111); 31 May 2024 12:00:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 08:00:35 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 08:00:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
Message-ID: <20240531120034.GA442032@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We use add_patterns() to read .gitignore, .git/info/exclude, etc, as
well as other pattern-like files like sparse-checkout. The parser for
these uses an "int" as an index, meaning that files over 2GB will
generally cause signed integer overflow and out-of-bounds access.

This is unlikely to happen in any real files, but we do read .gitignore
files from the tree. A malicious tree could cause an out-of-bounds read
and segfault (we also write NULs over newlines, so in theory it could be
an out-of-bounds write, too, but as we go char-by-char, the first thing
that happens is trying to read a negative 2GB offset).

We could fix the most obvious issue by replacing one "int" with a
"size_t". But there are tons of "int" sprinkled throughout this code for
things like pattern lengths, number of patterns, and so on. Since nobody
would actually want a 2GB .gitignore file, an easy defensive measure is
to just refuse to parse them.

The "int" in question is in add_patterns_from_buffer(), so we could
catch it there. But by putting the checks in its two callers, we can
produce more useful error messages.

Signed-off-by: Jeff King <peff@peff.net>
---
Just something I noticed while working on leaks nearby.

 dir.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/dir.c b/dir.c
index f6066cc01d..914060edfd 100644
--- a/dir.c
+++ b/dir.c
@@ -30,6 +30,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "tree.h"
+#include "hex.h"
 
 /*
  * Tells read_directory_recursive how a file or directory should be treated.
@@ -1148,6 +1149,12 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 		}
 	}
 
+	if (size > INT_MAX) {
+		warning("ignoring excessively large pattern file: %s", fname);
+		free(buf);
+		return -1;
+	}
+
 	add_patterns_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
@@ -1204,6 +1211,13 @@ int add_patterns_from_blob_to_list(
 	if (r != 1)
 		return r;
 
+	if (size > INT_MAX) {
+		warning("ignoring excessively large pattern blob: %s",
+			oid_to_hex(oid));
+		free(buf);
+		return -1;
+	}
+
 	add_patterns_from_buffer(buf, size, base, baselen, pl);
 	return 0;
 }
-- 
2.45.1.727.ge984192922
