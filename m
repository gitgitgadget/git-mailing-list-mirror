Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CC173323
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718092300; cv=none; b=dYiUbcMNtmtK4n9kM0LJYwiQy0ImfeepwefqQFVUj+m0VNddCQ5pcOk7IJXjIqoaKafu+x8VA0kCwBcwWVIW+GOwPD5LqFLZV7cNGJpIvz0fMgqJEsIyIpi7V/u/4oqYiFhh6pt7K2EfeVxCVMWEd5VYwqBUyE1sYiNNlIBcZP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718092300; c=relaxed/simple;
	bh=awDaSckrXRgfiBEsE9kXh1nrpGTnch5EIjcejupEy/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUJMs3RwsH+cRx8h9LXsc5QLvX2poCuGjaGdpKIU6pnnq6rwHcoELxSPleINA4dXF93sexDIXv0mE2KGt1nX4eH9Iy75AueVyw7OWx4EQxS58shOG0bZrF6RSBZXLZXLlsPFDt5xdxeCiXHlL1pq8SKCFFayud07y2KsU02tY7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18121 invoked by uid 109); 11 Jun 2024 07:51:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 07:51:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24488 invoked by uid 111); 11 Jun 2024 07:51:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 03:51:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 03:51:37 -0400
From: Jeff King <peff@peff.net>
To: Mathew George <mathewegeorge@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Cannot override `remote.origin.url` with `-c` option
Message-ID: <20240611075137.GF3248245@coredump.intra.peff.net>
References: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83D801A8-3878-43C1-B7A7-78B3B7315FD8@gmail.com>

On Sun, Jun 09, 2024 at 12:21:47PM +0530, Mathew George wrote:

> > What did you expect to happen? (Expected behavior)
> 
> The '-c' option should allow me to override the remote URL,
> which, as a result of running `git remote add`, is configured as
> follows in test/.git/config:
> 
> ```
> [remote "origin"]
> 	url = wrong-url
> ```

I don't think "-c" is the culprit here, but rather that remote.*.url is
a multi-valued config option. Rather than having a single value with
"last one wins" semantics, multiple instances of the config variable
form a list. So you'd see the same thing with:
  
  [remote "origin"]
  url = wrong-url
  url = right-url

in the config file.

Of course that leaves two questions:

  1. What are multiple URLs actually good for? I have no idea. I
     couldn't find any useful documentation in the manpages for
     git-config, git-remote, or git-fetch. It looks like any URLs after
     the first are used as push-only URLs:

       $ git remote show -n origin
       * remote origin
       Fetch URL: wrong-url
       Push  URL: wrong-url
       Push  URL: right-url
       [...]

     There's also a "pushurl" config option, which _replaces_ the
     original URL for pushing, rather than including it.

     As far as I can tell there's no way to actually have multiple fetch
     URLs (and the corner cases would be weird anyway). I suspect we'd
     come up with different semantics if we were designing it these
     days, but it has been this way since at least 2007. So any changes
     would probably need a deprecation period.

  2. Is there a way to override the list?

     Sadly, no. For some config keys, we allow a value-less boolean
     entry to reset the list. But since the config code doesn't know
     about the semantics of each key, this has to be implemented
     individually for each key, and nobody has bothered to do so for
     remote.*.url.

     The value-less key is something like:

       [remote "origin"]
       url = wrong-url
       # this one resets the list to empty!
       url
       # and this one adds a new value
       url = right-url

     Or in "-c" terms, it would be:

       git -c remote.origin.url -c remote.origin.url=right-url ...

     The syntax is ugly, but it is backwards compatible (that value-less
     entry is currently an error). So we could do that now (I'll show a
     messy patch below).

Of course none of that helps your immediate case. I did think of one
workaround, though, which is to use the "insteadOf" config to rewrite
the URL. So:

  git -c url.right-url.insteadOf=wrong-url ...

will rewrite all instances of "wrong-url" to use "right-url" instead (in
origin and elsewhere).

-Peff

---
diff --git a/remote.c b/remote.c
index dcb5492c85..69b0f28637 100644
--- a/remote.c
+++ b/remote.c
@@ -63,6 +63,10 @@ static const char *alias_url(const char *url, struct rewrites *r)
 
 static void add_url(struct remote *remote, const char *url)
 {
+	if (!url) {
+		remote->url_nr = 0;
+		return;
+	}
 	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
 	remote->url[remote->url_nr++] = url;
 }
@@ -430,10 +434,7 @@ static int handle_config(const char *key, const char *value,
 	else if (!strcmp(subkey, "prunetags"))
 		remote->prune_tags = git_config_bool(key, value);
 	else if (!strcmp(subkey, "url")) {
-		char *v;
-		if (git_config_string(&v, key, value))
-			return -1;
-		add_url(remote, v);
+		add_url(remote, xstrdup_or_null(value));
 	} else if (!strcmp(subkey, "pushurl")) {
 		char *v;
 		if (git_config_string(&v, key, value))
