Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BAF3603EB
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 04:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103313; cv=none; b=V4GY3dyWoShxfdJ6If1TGZQs4KqcZ7JmnbP8H/JxdC4HLagTIa7NA8dPZzyyfAAuavK41eE+SmhWtjBQ21HTH/XnTs30xQStMFpoPvh/xBmwBD9aEV9waYO+zQUTs2D0VpndOnYqmiHFQPHfBWeprm9W7JJ4DoHy3KCKg/B2Vwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103313; c=relaxed/simple;
	bh=UouGnZdBeYrtlkuT3ncpJH3UdbrU72T2O7r2bmSSfeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUJOqLtr44+bZzAmsahzSI79RAcihCJr0mMukJGCzd+dDgIyJO3X1a1hXIO8m8/OCuQmWObJa2dkM0VSLle47326kD8rOf9PFoDeoirqjv/YnzM8oGxRR4Uh6qiO9aqqroE8uFAVQtR4gppLs6WdCd6qbg4cX8baPP3tzbOOH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DD/t7usG; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DD/t7usG"
Received: (qmail 218898 invoked by uid 106); 2 Apr 2026 04:15:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UouGnZdBeYrtlkuT3ncpJH3UdbrU72T2O7r2bmSSfeY=; b=DD/t7usGHJQMtdTX2yv2OCmPag88P3EAPIkokcramS/kkfkDj+x3rDq8oYCQgNZstTWYKnxmjAAWFzRFCED1jE10z+VONbIfTU4FpyHD4gbbUReRaaqYJPd+eoMcste4G52c8I0hD7IW1y1DKKaSp1uT/wvaD5inaWaMxrWfKTVk4NQXRSs3xPw1fPb1HUp1wbp5Ey4qLjtB7ReSZNrCKGYXIhBpWItp+PWsg2uqEKGONaOxQJ+8k8NFWKXYsEHfUFmTt1SMCG5fN6weGm12H8k0X9n6C7NEBfqIQKZyEC/rb/BpYldhyLl5OEGo+C9sDatJkTVEDvD5mAxxJQUn1w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Apr 2026 04:15:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 349774 invoked by uid 111); 2 Apr 2026 04:15:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 02 Apr 2026 00:15:10 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 2 Apr 2026 00:15:10 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Collin Funk <collin.funk1@gmail.com>,
	Michael J Gruber <git@grubix.eu>
Subject: [PATCH v2 09/12] pkt-line: make packet_reader.line non-const
Message-ID: <20260402041510.GI3501239@coredump.intra.peff.net>
References: <20260402041433.GA3501120@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260402041433.GA3501120@coredump.intra.peff.net>

The "line" member of a packet_reader struct is marked as const. This
kind of makes sense, because it's not its own allocated buffer that
should be freed, and we often use const to indicate that. But it is
always writable, because it points into the non-const "buffer" member.

And we rely on this writability in places like send-pack and
receive-pack, where we parse incoming packet contents by writing NULs
over delimiters. This has traditionally worked because we implicitly
cast away the constness with strchr() like:

  const char *head;
  char *p;

  head = reader->line;
  p = strchr(head, ' ');

Since C23 libc provides a generic strchr() to detect this implicit
const removal, this now generate a compiler warning on some platforms
(like recent glibc).

We can fix it by marking "line" as non-const, as well as a few
intermediate variables (like "head" in the above example). Note that by
itself, switching to a non-const variable would cause problems with this
line in send-pack.c:

  if (!skip_prefix(reader->line, "unpack ", &reader->line))

But due to our skip_prefix() magic introduced in the previous commit,
this compiles fine (both the in and out-parameters are non-const, so we
know it is safe).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 7 ++++---
 pkt-line.h             | 2 +-
 send-pack.c            | 7 ++++---
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..a6af16c4e7 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1025,8 +1025,8 @@ static int read_proc_receive_report(struct packet_reader *reader,
 
 	for (;;) {
 		struct object_id old_oid, new_oid;
-		const char *head;
-		const char *refname;
+		char *head;
+		char *refname;
 		char *p;
 		enum packet_read_status status;
 
@@ -1050,7 +1050,8 @@ static int read_proc_receive_report(struct packet_reader *reader,
 		}
 		*p++ = '\0';
 		if (!strcmp(head, "option")) {
-			const char *key, *val;
+			char *key;
+			const char *val;
 
 			if (!hint || !(report || new_report)) {
 				if (!once++)
diff --git a/pkt-line.h b/pkt-line.h
index 3b33cc64f3..e6cf85e34e 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -184,7 +184,7 @@ struct packet_reader {
 	int pktlen;
 
 	/* the last line read */
-	const char *line;
+	char *line;
 
 	/* indicates if a line has been peeked */
 	int line_peeked;
diff --git a/send-pack.c b/send-pack.c
index 07ecfae4de..b4361d5610 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -175,8 +175,8 @@ static int receive_status(struct repository *r,
 	ret = receive_unpack_status(reader);
 	while (1) {
 		struct object_id old_oid, new_oid;
-		const char *head;
-		const char *refname;
+		char *head;
+		char *refname;
 		char *p;
 		if (packet_reader_read(reader) != PACKET_READ_NORMAL)
 			break;
@@ -190,7 +190,8 @@ static int receive_status(struct repository *r,
 		*p++ = '\0';
 
 		if (!strcmp(head, "option")) {
-			const char *key, *val;
+			char *key;
+			const char *val;
 
 			if (!hint || !(report || new_report)) {
 				if (!once++)
-- 
2.53.0.1172.ge9e20b5838

