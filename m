Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4181C20
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536685; cv=none; b=AfZkmQJ3Ubcft8YiUojrV94eCrEUNA1PpLnxNW7S8cd2Ro9yDrJT6ixdd8CKsmcqklmPp31G1uZcWF+RDnS2Zi6uKzYJk1RM1qSueFRZ6Km8Q6fyaDATgkhowzV9dzvM2pBbvmAJ2WcXiVGgPpzP/0rN0fqt9XHPlcZihI4CMDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536685; c=relaxed/simple;
	bh=aAx7cAOqG7s7FRPj7Pe8QnjXTFQHcyFq/S/ukO3Rshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLAeAPoHsK7Q/nB1IfGOpzw3F2iY7zO2pbRVgnlm7d4ex8PJTagKKYRAxLQdQQaXxjSZyNjRTBfKY6ot9Cw83kA26JmRGamvPps5AOGN7jmUadYlQAsWZlBAaEWfZ8RupRLnKc0kcrePb3BjSDGiy+W1gKWcI64KQju87sH2kgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7382 invoked by uid 109); 21 Feb 2024 17:31:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 17:31:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6098 invoked by uid 111); 21 Feb 2024 17:31:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 12:31:22 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 12:31:21 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yasushi SHOJI <yasushi.shoji@gmail.com>
Subject: Re: [PATCH 1/2] object-name: detect and report empty reflogs
Message-ID: <20240221173121.GA634809@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im>
 <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>

On Wed, Feb 21, 2024 at 10:56:36AM +0100, Patrick Steinhardt wrote:

> This behaviour goes back to 6436a20284 (refs: allow @{n} to work with
> n-sized reflog, 2021-01-07), which fixed a bug that wouldn't allow a
> user to return the n'th reflog entry with an n-sized reflog. With this
> commit, `read_ref_at()` started to special case reading the first entry
> of the reflog via a separate `read_ref_at_ent_newest()` function. The
> problem here is that we forgot to check whether the callback was invoked
> at all, and thus we don't notice empty reflogs.

I'm on the fence no whether the current @{0} behavior is sensible and
should be preserved. I agree it mostly worked by luck, but the presence
of the test makes me think at least the intention was there.

But assuming that is a good direction, there's one thing that puzzles me
about your patch:

> @@ -1084,6 +1084,7 @@ static int read_ref_at_ent_newest(struct object_id *ooid UNUSED,
>  	struct read_ref_at_cb *cb = cb_data;
>  
>  	set_read_ref_cutoffs(cb, timestamp, tz, message);
> +	cb->found_it = 1;
>  	oidcpy(cb->oid, noid);
>  	/* We just want the first entry */
>  	return 1;

OK, so we note whether the callback was invoked, which is good...

> @@ -1123,7 +1124,7 @@ int read_ref_at(struct ref_store *refs, const char *refname,
>  
>  	if (cb.cnt == 0) {
>  		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
> -		return 0;
> +		return !cb.found_it;
>  	}

...but here we just return without an error message. Whereas later in
the function, we have logic to produce the "log for %s is empty"
message. So now we will produce a message if you ask for branch@{1} in
an empty reflog, but not for branch@{0}, and the caller is responsible
for printing an error in the latter case.

If we instead set reccnt for branch@{0} as we would for branch@{1}, then
we can fall through and share the error handling (like it was before
6436a20284, when they used the same callback):

diff --git a/refs.c b/refs.c
index c633abf284..7d5e7a9ba6 100644
--- a/refs.c
+++ b/refs.c
@@ -1084,6 +1084,8 @@ static int read_ref_at_ent_newest(struct object_id *ooid UNUSED,
 	struct read_ref_at_cb *cb = cb_data;
 
 	set_read_ref_cutoffs(cb, timestamp, tz, message);
+	cb->reccnt++;
+	cb->found_it = 1;
 	oidcpy(cb->oid, noid);
 	/* We just want the first entry */
 	return 1;
@@ -1121,12 +1123,10 @@ int read_ref_at(struct ref_store *refs, const char *refname,
 	cb.cutoff_cnt = cutoff_cnt;
 	cb.oid = oid;
 
-	if (cb.cnt == 0) {
+	if (cb.cnt == 0)
 		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent_newest, &cb);
-		return 0;
-	}
-
-	refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
+	else
+		refs_for_each_reflog_ent_reverse(refs, refname, read_ref_at_ent, &cb);
 
 	if (!cb.reccnt) {
 		if (flags & GET_OID_QUIETLY)

And it all just works without having to touch get_oid_basic() or
cmd_show_branch() at all. Do note that one of the tests needs to be
updated to account for the slightly different format of the error
message; but again, I think that is showing off the inconsistency in
having the error message in two places.

-Peff
