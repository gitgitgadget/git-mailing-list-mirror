Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933BA1170A
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312898; cv=none; b=NqY7wtVqzmOl4PYW70WEvkxJJPoRZf3uzWVbfAMuoEck4hI3qE9UdZG8lyJq5pQYa21Y6w6hPIu7bwYxehpjmuWlL/Ak/CQlsF4DbmYXamMjUxodF5lBTwKLVz6qDsK7htACyOeYX51FphCu5PTJJLLMzn5S1oyZWNi/rIWtU3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312898; c=relaxed/simple;
	bh=W67bzfJdxsub27bNAUowcrjDEiBli2EIEA3TmiUqvHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=svn8CBNqKqWVR3pxwzU0d4egaAXSpV+/iFRrfT7w1zDTM6eJ/dGv/xIPwHckopH911eL4rgXOD7uwlywaBYeiKKM5UPhZeEf89TrlWDp2/eYDcBKeHNnJZK5ldW3RHGZ1ys09X5XeevJ/p8zzmSFi8+WoWEa+6m3NIsgiEnv8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30178 invoked by uid 109); 13 Mar 2024 06:54:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Mar 2024 06:54:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4656 invoked by uid 111); 13 Mar 2024 06:54:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Mar 2024 02:54:59 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Mar 2024 02:54:54 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] log-tree: take ownership of pointer
Message-ID: <20240313065454.GB125150@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <3b12a8cf393b6d8f0877fd7d87173c565d7d5a90.1709841147.git.code@khaugsbakk.name>
 <20240312092959.GA96171@coredump.intra.peff.net>
 <73a4cb87-2800-4ad1-b7a2-33c6465fcc50@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a4cb87-2800-4ad1-b7a2-33c6465fcc50@app.fastmail.com>

On Tue, Mar 12, 2024 at 06:43:55PM +0100, Kristoffer Haugsbakk wrote:

> > Hmm, OK. This patch by itself introduces a memory leak. It would be nice
> > if we could couple it with the matching free() so that we can see that
> > the issue is fixed. It sounds like your patch 2 is going to introduce
> > such a free, but I'm not sure it's complete.
> 
> Is it okay if it is done in patch 2?

I don't think it's the end of the world to do it in patch 2, as long as
we end up in a good spot. But IMHO it's really hard for reviewers to
understand what is going on, because it's intermingled with so many
other changes. It would be much easier to read if we had a preparatory
patch that switched the memory ownership of the field, and then built on
top of that.

But I recognize that sometimes that's hard to do, because the state is
so tangled that the functional change is what untangles it. I'm not sure
if that's the case here or not; you'd probably have a better idea as
somebody who looked carefully at it recently.

> > It frees the old extra_headers before reassigning it, but nobody
> > cleans it up after handling the final commit.
> 
> I didn’t get any leak errors from the CI. `extra_headers` in `show_log`
> is populated by calling `log_write_email_headers`. Then later it is
> assigned to
> 
>     ctx.after_subject = extra_headers;
> 
> Then `ctx.after_subject is freed later
> 
>     free((char *)ctx.after_subject);
> 
> Am I missing something?

Ah, I see. I was confused by looking for a free of an extra_headers
field. We have rev_info.extra_headers, and that is _not_ owned by
rev_info. We used to assign that to a variable in
log_write_email_headers(), but now we actually make a copy of it. And so
the copy is freed in that function when we replace it with a version
containing extra mime headers here:

                  strbuf_addf(&subject_buffer,
                           "%s"
                           "MIME-Version: 1.0\n"
                           "Content-Type: multipart/mixed;"
                           " boundary=\"%s%s\"\n"
                           "\n"
                           "This is a multi-part message in MIME "
                           "format.\n"
                           "--%s%s\n"
                           "Content-Type: text/plain; "
                           "charset=UTF-8; format=fixed\n"
                           "Content-Transfer-Encoding: 8bit\n\n",
                           extra_headers ? extra_headers : "",
                           mime_boundary_leader, opt->mime_boundary,
                           mime_boundary_leader, opt->mime_boundary);
                  free((char *)extra_headers);
                  extra_headers = strbuf_detach(&subject_buffer, NULL);

But the actual ownership is passed out via the extra_headers_p variable,
and that is what is assigned to ctx.after_subject (which now takes
ownership).

I think in the snippet I quoted above that extra_headers could never be
NULL now, right? We'll always return at least an empty string. But
moreover, we are formatting it into a strbuf, only to potentially copy
it it another strbuf. Couldn't we just do it all in one strbuf?

Something like this:

 log-tree.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 9196b4f1d4..0a703a0303 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -469,29 +469,22 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 	}
 }
 
-static char *extra_and_pe_headers(const char *extra_headers, const char *pe_headers) {
-	struct strbuf all_headers = STRBUF_INIT;
-
-	if (extra_headers)
-		strbuf_addstr(&all_headers, extra_headers);
-	if (pe_headers) {
-		strbuf_addstr(&all_headers, pe_headers);
-	}
-	return strbuf_detach(&all_headers, NULL);
-}
-
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			     const char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers =
-		extra_and_pe_headers(opt->extra_headers, opt->pe_headers);
+	struct strbuf headers = STRBUF_INIT;
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
 	*need_8bit_cte_p = 0; /* unknown */
 
+	if (opt->extra_headers)
+		strbuf_addstr(&headers, opt->extra_headers);
+	if (opt->pe_headers)
+		strbuf_addstr(&headers, opt->pe_headers);
+
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
 	graph_show_oneline(opt->graph);
 	if (opt->message_id) {
@@ -508,16 +501,13 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
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
@@ -528,11 +518,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 "Content-Type: text/plain; "
 			 "charset=UTF-8; format=fixed\n"
 			 "Content-Transfer-Encoding: 8bit\n\n",
-			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		free((char *)extra_headers);
-		extra_headers = strbuf_detach(&subject_buffer, NULL);
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -552,7 +539,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		opt->diffopt.stat_sep = buffer.buf;
 		strbuf_release(&filename);
 	}
-	*extra_headers_p = extra_headers;
+	*extra_headers_p = headers.len ? strbuf_detach(&headers, NULL) : NULL;
 }
 
 static void show_sig_lines(struct rev_info *opt, int status, const char *bol)


The resulting code is shorter and (IMHO) easier to understand. It
avoids an extra allocation and copy when using mime. It also avoids the
allocation of an empty string when opt->extra_headers and
opt->pe_headers are both NULL. It does make an extra copy when
extra_headers is non-NULL but pe_headers is NULL (and you're not using
MIME), as we could just use opt->extra_headers as-is, then. But since
the caller needs to take ownership, we can't avoid that copy.

I think you could even do this cleanup before adding pe_headers,
especially if it was coupled with cleaning up the memory ownership
issues.

-Peff
