Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01BE221F30
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747336154; cv=none; b=qOBwYgkZkLvo8HCnv95jIh11jxVSP0ZF4+GxhjaTm/+OeaOi/bfZFp3i/A8qH/zE9W5gG8MUlaMqz79TCC4TWoMX+9bPrQs3CxzykIkdmNB6MIPLDR5hkhnHriGfSzgU0XfYFC4MWN1fydq0dnYi/xRfJf8FnJGtktfhfU5JpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747336154; c=relaxed/simple;
	bh=pDdYfr213kJq9jXtSaqWX9kPqkJxoe2wGihsYQmMNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKMv8LarJ1X1Jct8X+9Sd+Z+Dc73R9WXr16Da4WHYa1MMy9tCfTj9gUWOLS7ySLGZfLJ1/RL3JS31GFMOdaxA6fbh1LQfxgzQmhdFMrgHsPh3tYlonPKEAyMXCqzFLDTNZvKKrsXu3eA6H8c5to7DHW6n1G85N5dpo7lMOUohbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=B5+lmXZ2; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="B5+lmXZ2"
Received: (qmail 32689 invoked by uid 109); 15 May 2025 19:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=pDdYfr213kJq9jXtSaqWX9kPqkJxoe2wGihsYQmMNy0=; b=B5+lmXZ2CoEMzw1zxfLsixjIZNow3Ax67vdiRnWKRqNpPKLivpHGUlOQiwpjF0SVnNcSMZuHLt+jntvTISSG3+DFURemJDp+uDGmS0OcwRh/f+z7AADf8Ml8wzJ4dcwsBNxB2PttfoVEiUCoSHLWlXcjeqlAqtF90duq3uXJ8r45QH4tNKDIZsKjkeZFrhnmgKruih5FiDX7UsPf/QUtwy9zXRtzcmzwnjOG8YnXT3oVJXyrhxjSw73dvJ3UyYHnW7qxF3MGbTf4nBfVFrPJ1ilf+n8DQuYziToqS3B/YlGmIenbB/1JV77lVki7ZOd3MDw5Kyc1LGf7p7xPzhmK0g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 May 2025 19:09:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29841 invoked by uid 111); 15 May 2025 19:09:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 May 2025 15:09:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 May 2025 15:09:09 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im, gitster@pobox.com
Subject: Re: [PATCH v2 4/4] receive-pack: use batched reference updates
Message-ID: <20250515190909.GA3320028@coredump.intra.peff.net>
References: <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-0-80cbaaa55d2e@gmail.com>
 <20250515-501-update-git-fetch-1-to-use-partial-transactions-v2-4-80cbaaa55d2e@gmail.com>
 <20250515185535.GA3309052@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250515185535.GA3309052@coredump.intra.peff.net>

On Thu, May 15, 2025 at 02:55:36PM -0400, Jeff King wrote:

> On Thu, May 15, 2025 at 04:07:28PM +0200, Karthik Nayak wrote:
> 
> > +failure:
> > +	for (cmd = commands; cmd; cmd = cmd->next) {
> > +		if (reported_error)
> > +			cmd->error_string = reported_error;
> > +		else if (strmap_contains(&failed_refs, cmd->ref_name))
> > +			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
> >  	}

BTW, one other funny thing about this code: we duplicate the strings
that we assign to cmd->error_string. But no other call path does so. So
now we have allocated memory, but nobody can ever free() it because
often it is not allocated!

I'm surprised LSan does not report a leak here, so I might be missing
something.

It looks like there is some magic in the struct here to handle this
like:

  cmd->error_string = cmd->error_string_owned = xstrdup(...);

which would solve it. But I wonder: do these need to be allocated at
all? We are pulling out strings owned by the strmap, which will free
them. So as-is, yes, we need to make our own copies.

But does the strmap need to own them in the first place? It is taking
the values from ref_transaction_error_msg(). That returns an allocated
string, but it doesn't need to. It could just return the string literals
directly, which are valid for the life of the program. That would save
other callers from having to call free(), though it does mean we have to
cast away the constness when putting them into the strmap (since it
accepts a non-const void pointer). Something like:

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4a3c46eca7..cf0bcf1ad0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1665,10 +1665,9 @@ static void ref_transaction_rejection_handler(const char *refname,
 			"branches"), data->remote_name);
 		data->conflict_msg_shown = 1;
 	} else {
-		char *reason = ref_transaction_error_msg(err);
+		const char *reason = ref_transaction_error_msg(err);
 
 		error(_("fetching ref %s failed: %s"), refname, reason);
-		free(reason);
 	}
 
 	*data->retcode = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bd0fb729ff..4cef2ddd3d 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1855,7 +1855,7 @@ static void ref_transaction_rejection_handler(const char *refname,
 {
 	struct strmap *failed_refs = cb_data;
 
-	strmap_put(failed_refs, refname, ref_transaction_error_msg(err));
+	strmap_put(failed_refs, refname, (char *)ref_transaction_error_msg(err));
 }
 
 static void execute_commands_non_atomic(struct command *commands,
@@ -1897,15 +1897,16 @@ static void execute_commands_non_atomic(struct command *commands,
 
 failure:
 	for (cmd = commands; cmd; cmd = cmd->next) {
+		const char *reason;
 		if (reported_error)
 			cmd->error_string = reported_error;
-		else if (strmap_contains(&failed_refs, cmd->ref_name))
-			cmd->error_string = xstrdup(strmap_get(&failed_refs, cmd->ref_name));
+		else if ((reason = strmap_get(&failed_refs, cmd->ref_name)))
+			cmd->error_string = reason;
 	}
 
 cleanup:
 	ref_transaction_free(transaction);
-	strmap_clear(&failed_refs, 1);
+	strmap_clear(&failed_refs, 0);
 	strbuf_release(&err);
 }
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 09b99143bf..1e6131e04a 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -575,15 +575,14 @@ static void print_rejected_refs(const char *refname,
 				void *cb_data UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
-	char *reason = ref_transaction_error_msg(err);
+	const char *reason = ref_transaction_error_msg(err);
 
 	strbuf_addf(&sb, "rejected %s %s %s %s\n", refname,
 		    new_oid ? oid_to_hex(new_oid) : new_target,
 		    old_oid ? oid_to_hex(old_oid) : old_target,
 		    reason);
 
 	fwrite(sb.buf, sb.len, 1, stdout);
-	free(reason);
 	strbuf_release(&sb);
 }
 
diff --git a/refs.c b/refs.c
index 351ed52deb..953f83bb52 100644
--- a/refs.c
+++ b/refs.c
@@ -3315,7 +3315,7 @@ int ref_update_expects_existing_old_ref(struct ref_update *update)
 		(!is_null_oid(&update->old_oid) || update->old_target);
 }
 
-char *ref_transaction_error_msg(enum ref_transaction_error err)
+const char *ref_transaction_error_msg(enum ref_transaction_error err)
 {
 	const char *reason = "";
 
@@ -3342,5 +3342,5 @@ char *ref_transaction_error_msg(enum ref_transaction_error err)
 		reason = "unkown failure";
 	}
 
-	return xstrdup(reason);
+	return reason;
 }
diff --git a/refs.h b/refs.h
index a0b2e3c43d..2d58af3d88 100644
--- a/refs.h
+++ b/refs.h
@@ -910,7 +910,7 @@ void ref_transaction_for_each_rejected_update(struct ref_transaction *transactio
 /*
  * Translate errors to human readable error messages.
  */
-char *ref_transaction_error_msg(enum ref_transaction_error err);
+const char *ref_transaction_error_msg(enum ref_transaction_error err);
 
 /*
  * Free `*transaction` and all associated data.

-Peff
