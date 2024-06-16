Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680616C6A4
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718513981; cv=none; b=U2k8yMlnz0H86m/ikZK3swX6Qq4fDkdusblrXUYX9EPZNs6EuJ0kDzwDwJNViFRtEm26c/QwnpVoU2LRTD6ccttxrMlksVn0JpFTVut/ja8+EWOaI4rys6LUYGRj08Xns5WzDO4a8JC7Cl4SSozjOHGUcoKnn/RKB5nJs8iBKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718513981; c=relaxed/simple;
	bh=D8JTd4Nq7SGs6yb0Lbc0sM0dJoUDR6OUU2g1CCn0Aj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8ywedV3whSjZ5o+2MWnNXGXYudEDWeGBPYc3cFAUs9+zUFfFpRPeKRkGM3q5/vYrj0+jo4jN8puoFfpOkeqPFdJ/gRBGY4aeJ8T/2JM/qwMuQh7i6mPv5GY3HlPYxT8mthqFu/hd7Sn/R2XSBUKBitjCzntsyWhPKSr//E5FDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2636 invoked by uid 109); 16 Jun 2024 04:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Jun 2024 04:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14770 invoked by uid 111); 16 Jun 2024 04:59:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Jun 2024 00:59:36 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 16 Jun 2024 00:59:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Mathew George <mathewegeorge@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 03/11] remote: transfer ownership of memory in add_url(),
 etc
Message-ID: <20240616045937.GB17750@coredump.intra.peff.net>
References: <20240614102439.GA222287@coredump.intra.peff.net>
 <20240614102722.GC222445@coredump.intra.peff.net>
 <xmqq1q4zh2vh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1q4zh2vh.fsf@gitster.g>

On Fri, Jun 14, 2024 at 10:04:50AM -0700, Junio C Hamano wrote:

> >  static void add_pushurl_alias(struct remote_state *remote_state,
> > @@ -79,6 +79,7 @@ static void add_pushurl_alias(struct remote_state *remote_state,
> >  	char *alias = alias_url(url, &remote_state->rewrites_push);
> >  	if (alias)
> >  		add_pushurl(remote, alias);
> > +	free(alias);
> >  }
> 
> OK.  I wondered if we want to strdup(url) in my review on the
> previous step, but now we are making the add_url() responsible
> for making a copy, we instead do the opposite, i.e. free alias
> that was allocated for us because we no longer need it.

Yeah. Possibly the two should be squashed. I was trying to make this
patch a little less long/confusing, but maybe breaking things up just
posed new questions. :)

> > @@ -336,7 +338,7 @@ static void read_branches_file(struct remote_state *remote_state,
> >  	else
> >  		frag = to_free = repo_default_branch_name(the_repository, 0);
> >  
> > -	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
> > +	add_url_alias(remote_state, remote, buf.buf);
> 
> It is curious that you delay ...
> 
> > @@ -347,6 +349,7 @@ static void read_branches_file(struct remote_state *remote_state,
> >  	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
> >  	remote->fetch_tags = 1; /* always auto-follow */
> >  
> > +	strbuf_release(&buf);
> >  	free(to_free);
> >  }
> 
> ... strbuf_release() of the buf to the very end of the function.  
> 
> In the original, buf became invalid by doing strbuf_detach(), so we
> could do strbuf_release() immediately after add_url_alias() returns
> to us if we wanted to.

Right. I had originally written it that way, since that would be the
mechanical conversion. But since there was already cleanup at the bottom
of the function, it felt more natural to shuffle it there. Which is
correct as long as there are no other references to buf nor early
returns. You can't see that from the context, but it is true in this
case.

Bumping to --inter-hunk-context=4 does it a little more obvious.

> > @@ -431,15 +434,13 @@ static int handle_config(const char *key, const char *value,
> >  	else if (!strcmp(subkey, "prunetags"))
> >  		remote->prune_tags = git_config_bool(key, value);
> >  	else if (!strcmp(subkey, "url")) {
> > -		char *v;
> > -		if (git_config_string(&v, key, value))
> > -			return -1;
> > -		add_url(remote, v);
> > +		if (!value)
> > +			return config_error_nonbool(key);
> > +		add_url(remote, value);
> 
> OK.  config_string() does (1) check for "I exist hence I am true"
> boolean, and (2) give us a duplicate of the value.  We do not want
> the latter, so we do the former ourselves here.  The same story
> repeats for pushurl below (ellided).

Yep. If we followed through on the "bool means reset" approach, then these
extra NULL checks would go away in favor of one in add_url(). I didn't
pursue that here. And if we do, I think we should do it in all the other
spots, too, for consistency.

-Peff
