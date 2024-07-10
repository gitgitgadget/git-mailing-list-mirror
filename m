Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A64257D
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720626390; cv=none; b=DGHNPwxxsVA4nCLONQTkyox8JRycES5+4mKI6etjSVCokgforZBOF9xhbpeVCHkQvbOlPKrXFks9DrODbHBFE8QLn4B25019EmCF4/I/MYVCOB7FQWHOZ+L7Rwf5OFq3Y038zabuCcOA5Tw1XKYkyjNuS0oQXfKtMDw9RXswqwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720626390; c=relaxed/simple;
	bh=Kvac3NN14V67O6Rih4kMC82oioIvOrsRtqyrQ9HWkzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxsqnJGO+JMeXAjtRQ1nIEGn/5+fIoK1p4hHrXVR51xFe1eXTx177pP/V79pxsCqBAgiSP/4lf30D9GzPAu03YoxCuvjnFx5/krUhbPhKm7F6nLOh5xo0XFIAszHGn5Qn1Is+HSWor5pNCaLP69v8QgFrahPGZa4tIQFnUwqL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6433 invoked by uid 109); 10 Jul 2024 15:46:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 15:46:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13987 invoked by uid 111); 10 Jul 2024 15:46:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 11:46:20 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 11:46:20 -0400
From: Jeff King <peff@peff.net>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating
 remote
Message-ID: <20240710154620.GA3097664@coredump.intra.peff.net>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240709144931.1146528-1-karthik.188@gmail.com>
 <xmqq4j8yflrq.fsf@gitster.g>
 <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>

On Wed, Jul 10, 2024 at 06:12:21AM -0700, Karthik Nayak wrote:

> > In any case, an obvious additional fix on top of your change might
> > be to do something like this:
> >
> >         diff --git i/remote.c w/remote.c
> >         index 5fa046c8f8..d7f9ba3571 100644
> >         --- i/remote.c
> >         +++ w/remote.c
> >         @@ -682,7 +682,7 @@ remotes_remote_get_1(
> >                 struct remote *ret;
> >                 int name_given = 0;
> >
> >         -	if (name)
> >         +	if (name && *name)
> >                         name_given = 1;
> >                 else
> >                         name = get_default(remote_state, remote_state->current_branch,
> >
> > which would give us the default remote name, and we would not call
> > add_url_alias() with a bogus empty string to nuke the list.
> >
> 
> I'm a bit skeptical of making this change. Mostly from the user's
> perspective.
> 
> With my patch currently:
> 
>     $ git push "" refs/heads/master
>     fatal: bad repository ''
> 
> But with this added, we'd be doing
> 
>     $ git push "" refs/heads/master
>     Everything up-to-date
> 
> This is because we actually obtained the default remote here. Isn't this
> confusing from a user's perspective? I mean I agree that an empty repo
> name is something we should support, but it also shouldn't be something
> we simply ignore?

Oh, I misread Junio's patch in my earlier response. I was focused on not
setting name_given, which I thought would result in a NULL return value,
and didn't notice that it would also mean using the default remote.
Something like:

diff --git a/remote.c b/remote.c
index 7f6406aaa2..883cf6086e 100644
--- a/remote.c
+++ b/remote.c
@@ -703,7 +703,7 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 		if (!valid_remote(ret))
 			read_branches_file(remote_state, ret);
 	}
-	if (name_given && !valid_remote(ret))
+	if (name_given && *name && !valid_remote(ret))
 		add_url_alias(remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;

was more what I was thinking. That is, inhibit the empty string
explicitly rather than letting the emergent behavior of add_url_alias()
do it for us. Or maybe even just:

diff --git a/remote.c b/remote.c
index 7f6406aaa2..a0b166131f 100644
--- a/remote.c
+++ b/remote.c
@@ -690,9 +690,11 @@ remotes_remote_get_1(struct remote_state *remote_state, const char *name,
 	struct remote *ret;
 	int name_given = 0;
 
-	if (name)
+	if (name) {
+		if (!name)
+			return NULL;
 		name_given = 1;
-	else
+	} else
 		name = get_default(remote_state, remote_state->current_branch,
 				   &name_given);
 

to bail immediately.

But all of that would be internal refactoring / cleanup on top of your
patch. The user-facing behavior would be the same.

-Peff
