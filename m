Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09980629
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894960; cv=none; b=gQUroPAUCdeEEbKaJYS7WKfYv/DNPysE/U4uwXHQ2WLMJ+ZpYZ0zXsxEaZqY4SwGgKMDIzjd4WPIqv3StmgBReLgU9m3f7QytIHs1ZEaPUQ7yWfaBITmkmtsEcGaAsRUvQNBqt/1xUraDtmEYT8D+CIHgG6n4wAeLyMmC4LB7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894960; c=relaxed/simple;
	bh=sKx05az7kG55bBUMe5/zqsKW3jagUEHJrhzfLyLNKAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=duCtetyBD9DffH3IiRVmZFO0weBAgFtvWNgS8671f9CL9nKPg3yE/uhGTFPqqv6XHZBYOAG3RjbZxZSTRDLpx1keB2tMNnqvRgdXEjY43SoYG+DfQmiEXbefPmS5GIBYuQvp2C6mShZmUPcHRFr1k/aoGUA3pTNc8rfRC567+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5664 invoked by uid 109); 20 Mar 2024 00:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:35:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13443 invoked by uid 111); 20 Mar 2024 00:36:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:36:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:35:57 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 6/6] format-patch: simplify after-subject MIME header handling
Message-ID: <20240320003557.GF904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320002555.GB903718@coredump.intra.peff.net>

In log_write_email_headers(), we append our MIME headers to the set of
extra headers by creating a new strbuf, adding the existing headers, and
then adding our new ones.  We had to do it this way when our output
buffer might point to the constant opt->extra_headers variable.

But since the previous commit, we always make a local copy of that
variable. Let's turn that into a strbuf, which lets the MIME code simply
append to it. That simplifies the function and avoids a pointless extra
copy of the headers.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 5092a75958..eb2e841046 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -474,12 +474,15 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	char *extra_headers = xstrdup_or_null(opt->extra_headers);
+	struct strbuf headers = STRBUF_INIT;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
+	if (opt->extra_headers)
+		strbuf_addstr(&headers, opt->extra_headers);
+
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
@@ -496,15 +499,13 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary && maybe_multipart) {
-		struct strbuf subject_buffer = STRBUF_INIT;
 		static struct strbuf buffer = STRBUF_INIT;
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 
 		strbuf_reset(&buffer);
 
-		strbuf_addf(&subject_buffer,
-			 "%s"
+		strbuf_addf(&headers,
 			 "MIME-Version: 1.0\n"
 			 "Content-Type: multipart/mixed;"
 			 " boundary=\"%s%s\"\n"
@@ -515,11 +516,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 "Content-Type: text/plain; "
 			 "charset=UTF-8; format=fixed\n"
 			 "Content-Transfer-Encoding: 8bit\n\n",
-			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		free(extra_headers);
-		extra_headers = strbuf_detach(&subject_buffer, NULL);
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -539,7 +537,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p = extra_headers;
+	*extra_headers_p = headers.len ? strbuf_detach(&headers, NULL) : NULL;
 }
 
 static void show_sig_lines(struct rev_info *opt, int status, const char *bol)
-- 
2.44.0.643.g35f318e502
