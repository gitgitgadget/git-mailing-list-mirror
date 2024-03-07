Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1398E839E3
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802950; cv=none; b=JpK85Rbc68JZjo+yM2i8MnhXyjA40Gvz11wQO+SOF+nRSzSqpXvAP02WfNrKw9lPaNooQGeHRNAVkqmP8F8mEXKudCD2Nh6bKUp57axzMqzrx4biBseRSmIObR5aPZjN30qzdZGDJPsoE5lBk9NbGRet6Og/Ce8kF57LjOEP1Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802950; c=relaxed/simple;
	bh=WZwXQB5LdEQa9DMMM96SK3oQehHJk6F6W2dNg+gAsvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAFJ3sCojicSf1rVxoMHINiDQyDo5p8y8+CHHeykEke92teLsdyW1laIJCQ4OKF27QpiNuy7BLIE1OIp38Vk8pbskFnNQQCv9/FoF6XijSo+XG6ffT0sOqskVGXP2JRW4dJ+BRwTYRf9dF4I5l7P7CSpSKCaVRVJEiXUypoWXpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6821 invoked by uid 109); 7 Mar 2024 09:15:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:15:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12530 invoked by uid 111); 7 Mar 2024 09:15:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:15:52 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:15:47 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 01/15] strbuf: simplify comment-handling in add_lines() helper
Message-ID: <20240307091547.GA2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

In strbuf_add_commented_lines(), we prepare two strings with potential
prefixes: one with just the comment char, and one with an additional
space. In the add_lines() helper, we use the one without the extra space
for blank lines or lines starting with a tab.

While passing in two separate prefixes to the helper is very flexible,
it's more flexibility than we actually use (or are likely to use, since
the rules inside add_lines() only make sense if "prefix2" is a variant
of "prefix1" without the extra space). And setting up the two strings
makes refactoring in strbuf_add_commented_lines() awkward.

Instead, let's pass in a single string, and just let add_lines() add the
extra space to the result as appropriate.

We do still need to pass in a flag to trigger this behavior. The helper
is shared by strbuf_add_lines(), which passes in a NULL "prefix2" to
inhibit this extra handling.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..689d8acd5e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -340,18 +340,17 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 }
 
 static void add_lines(struct strbuf *out,
-			const char *prefix1,
-			const char *prefix2,
-			const char *buf, size_t size)
+			const char *prefix,
+			const char *buf, size_t size,
+			int space_after_prefix)
 {
 	while (size) {
-		const char *prefix;
 		const char *next = memchr(buf, '\n', size);
 		next = next ? (next + 1) : (buf + size);
 
-		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
-			  ? prefix2 : prefix1);
 		strbuf_addstr(out, prefix);
+		if (space_after_prefix && buf[0] != '\n' && buf[0] != '\t')
+			strbuf_addch(out, ' ');
 		strbuf_add(out, buf, next - buf);
 		size -= next - buf;
 		buf = next;
@@ -362,14 +361,11 @@ static void add_lines(struct strbuf *out,
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 				size_t size, char comment_line_char)
 {
-	static char prefix1[3];
-	static char prefix2[2];
+	static char prefix[2];
 
-	if (prefix1[0] != comment_line_char) {
-		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
-		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
-	}
-	add_lines(out, prefix1, prefix2, buf, size);
+	if (prefix[0] != comment_line_char)
+		xsnprintf(prefix, sizeof(prefix), "%c", comment_line_char);
+	add_lines(out, prefix, buf, size, 1);
 }
 
 void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
@@ -750,7 +746,7 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 void strbuf_add_lines(struct strbuf *out, const char *prefix,
 		      const char *buf, size_t size)
 {
-	add_lines(out, prefix, NULL, buf, size);
+	add_lines(out, prefix, buf, size, 0);
 }
 
 void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
-- 
2.44.0.463.g71abcb3a9f

