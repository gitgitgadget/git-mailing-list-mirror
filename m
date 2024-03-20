Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC37464
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895397; cv=none; b=QBKGfq3gvsLu6yXvbfOdjst5ZyipNwXdNqZObtGZZ8c2tG/qGLINAS0NBcRZpsVXJs/863v1ssDFKMUl+NijAOGfqjEGgE9qfA6DPowkft2TMpzoFzRyIGZp+8UFfWJBdv3s9Yrc/Tx+mhT/TUUh/g/SjXjCvkNWW0gZi1IqqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895397; c=relaxed/simple;
	bh=FkpEUruk8k8sYzB0QKDo1VhH/w9Lm26oXuFgL256Vqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBzWClk9Pu/9hmgVmVv7DbgGBAoJnj6uGC4IHHNI1E9Yy0SvGNbD2GbfqTFEkIlGK4436etG3ArSKgxG3tqSgEnKXbK0bLx5T4mpf7uPO/U/7bMiu6cviVGmShxqmpDq/y86OXCnbAvF5+HKjnxK88B8o1tr1BzJHJPxwkfA97k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5712 invoked by uid 109); 20 Mar 2024 00:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13490 invoked by uid 111); 20 Mar 2024 00:43:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:43:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:43:14 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] revision: add a per-email field to rev-info
Message-ID: <20240320004314.GA907161@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
 <20240320002555.GB903718@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320002555.GB903718@coredump.intra.peff.net>

On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:

> Having now stared at this code for a bit, I do think there's another,
> much simpler option for your series: keep the same ugly static-strbuf
> allocation pattern in log_write_email_headers(), but extend it further.
> I'll show that in a moment, too.

So something like this:

diff --git a/log-tree.c b/log-tree.c
index e5438b029d..ae0f4fc502 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -474,12 +474,21 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers = opt->extra_headers;
+	static struct strbuf headers = STRBUF_INIT;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
+	strbuf_reset(&headers);
+	if (opt->extra_headers)
+		strbuf_addstr(&headers, opt->extra_headers);
+	/*
+	 * here's where you'd do your pe_headers; I wonder if you could even
+	 * just run the header command directly here and not need to shove the
+	 * string into rev_info?
+	 */
+
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
@@ -496,16 +505,13 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary && maybe_multipart) {
-		static struct strbuf subject_buffer = STRBUF_INIT;
 		static struct strbuf buffer = STRBUF_INIT;
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 
-		strbuf_reset(&subject_buffer);
 		strbuf_reset(&buffer);
 
-		strbuf_addf(&subject_buffer,
-			 "%s"
+		strbuf_addf(&headers,
 			 "MIME-Version: 1.0\n"
 			 "Content-Type: multipart/mixed;"
 			 " boundary=\"%s%s\"\n"
@@ -516,10 +522,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 "Content-Type: text/plain; "
 			 "charset=UTF-8; format=fixed\n"
 			 "Content-Transfer-Encoding: 8bit\n\n",
-			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer.buf;
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -539,7 +543,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p = extra_headers;
+	*extra_headers_p = headers.len ? headers.buf : NULL;
 }
 
 static void show_sig_lines(struct rev_info *opt, int status, const char *bol)

And then the callers can continue not caring about how or when to free
the returned pointer. I think in the long run the cleanups I showed are
a nicer place to end up, but I'd just worry that your feature work will
be held hostage by my desire to clean. ;)

If you did it this way (probably as a separate preparatory patch minus
the pe_headers comment), then either I could do my cleanups on top, or
they could even graduate independently (though obviously there will be a
little bit of tricky merging at the end).

-Peff
