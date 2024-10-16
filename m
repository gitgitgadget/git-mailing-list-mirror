Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D2720821C
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 14:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090551; cv=none; b=PncmW6ldEYHyUDw7DhbUlBkTdc2wNzD/LyRGiuuazxbG2E5PnPsWRoA5faNhAAhrws+WeoTihmeU/tJW6KxRHKTbMSgOsTH6J/zWGiLhHQhbwR1BXoIl0pD9/v0+gEuN/6A+LEFV+nEQwThZAiDHngIQ/VA9UIpxOuhuI9uBTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090551; c=relaxed/simple;
	bh=/bDFCJ4boy725LIpq6V1FxzySGrx0W/tRXdR40qVP7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBVeQfEavSGJsu3XwLE6l4FEzzk+2xdYzGhrjb5U9JVwvkdo2z6kb2fue/pv01zKJIupwWeCHaaP/m1hqyy92r+LjfleUg5BTED7moq6II4zN4aeAe6kYUdJ+aLe/jaW+WpDKPlsdnNi+18XYjcdk0xjw6FmKNv0P60fk49mD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=doqMBJAF; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="doqMBJAF"
Received: (qmail 20561 invoked by uid 109); 16 Oct 2024 14:55:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/bDFCJ4boy725LIpq6V1FxzySGrx0W/tRXdR40qVP7k=; b=doqMBJAF5GszqtPRLSZCk9zBYMCuWrBD0Uq0pp/iATbgEESRkq1WHLwNwN7LVhybi1i6ePgn9o5eEZPU+sylRENew6P+GRqPEgFFgbBvZ86wbAjyxXY4iNfVNZ1mU92d4dus5J2YknAwoCxJ0Ym7mjpDJRLix1Ng+lHYxSXLOSJhPLy2Z0RrNtYj12T7oGAV5TsgnnPd31O+WAfsKHhmbzrIaw284ef2RrcqV1/5rBlDmKOaZuDNnEr6AVtPXMYQ/7V+bp6CdfluzBl7g8hPyp4EWbj1Cv7nE1xUE6PdoTti3SSybqVNbYG8dtcWapPskq+DrdsHfWxnSjrGu/fQpg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Oct 2024 14:55:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19749 invoked by uid 111); 16 Oct 2024 14:55:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Oct 2024 10:55:40 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Oct 2024 10:55:39 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>
Subject: Re: [PATCH] builtin/credential-cache--daemon: fix error when
 "exit"ing on Cygwin
Message-ID: <20241016145539.GA703747@coredump.intra.peff.net>
References: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4472d6d1551e7c25540c4c8361bcb6b1c9f92ff.1729084997.git.ps@pks.im>

On Wed, Oct 16, 2024 at 04:21:36PM +0200, Patrick Steinhardt wrote:

> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
> index bc22f5c6d24..5a09df5c167 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -156,13 +156,11 @@ static void serve_one_client(FILE *in, FILE *out)
>  	}
>  	else if (!strcmp(action.buf, "exit")) {
>  		/*
> -		 * It's important that we clean up our socket first, and then
> -		 * signal the client only once we have finished the cleanup.
> -		 * Calling exit() directly does this, because we clean up in
> -		 * our atexit() handler, and then signal the client when our
> -		 * process actually ends, which closes the socket and gives
> -		 * them EOF.
> +		 * We must close our file handles before we exit such that the
> +		 * client will receive an EOF.
>  		 */
> +		fclose(in);
> +		fclose(out);
>  		exit(0);
>  	}

This breaks the thing the comment was trying to protect against. We want
to unlink() the socket file before closing the descriptors.

From 7d5e9c9849 (which you can find with blame or "git log --follow
-Satexit builtin/credential-cache--daemon.c"):

    credential-cache--daemon: clarify "exit" action semantics

    When this code was originally written, there wasn't much
    thought given to the timing between a client asking for
    "exit", the daemon signaling that the action is done (with
    EOF), and the actual cleanup of the socket.

    However, we need to care about this so that our test scripts
    do not end up racy (e.g., by asking for an exit and checking
    that the socket was cleaned up). The code that is already
    there happens to behave very reasonably; let's add a comment
    to make it clear that any changes should retain the same
    behavior.

So with the proposed change, t0301 will now fail racily. We need that
unlink() to happen before the fclose(). Just calling exit() does things
in the right order, but it should also be OK to do an explicit:

  delete_tempfile(&socket_file);
  fclose(in);
  fclose(out);

That would probably require making socket_file a global variable. (You
can't just return out of the serving loop, since that closes the sockets
first before deleting the tempfile).

> Clients can signal the git-credential-cache(1) daemon that it is
> supposed to exit by sending it an "exit" command. The details around
> how exactly the daemon exits seem to be rather intricate as spelt out by
> a comment surrounding our call to exit(3p), as we need to be mindful
> around closing the client streams before we signal the client.
> 
> The logic is broken on Cygwin though: when a client asks the daemon to
> exit, they won't see the EOF and will instead get an error message:
> 
>   fatal: read error from cache daemon: Software caused connection abort
> 
> This issue is known in Cygwin, see for example [1], but the exact root
> cause is not known.
> [...]
> [1]: https://github.com/cygporter/git/issues/51

I don't see any details at that issue, but I'm not sure how it would fix
things. From the client's perspective, they are going to see the
descriptor either way. Unless there is some magic that fclose() does
that a normal descriptor-close-on-exit does not do.

That "Software caused connection abort" thing seems like a weird
not-standard-Unix errno value. Searching for it mostly yields people
complaining about getting it from ssh under cygwin. :)

If the magic that cygwin needs is actually "fclose before unlink", then
that is in opposition to other platforms (and I suspect would make t0301
racy there).

> As it turns out, we can avoid the issue by explicitly closing the client
> streams via fclose(3p). I'm not sure at all where the claimed atexit(3p)
> handler mentioned in the comment is supposed to live, but from all I can
> see we do not have any installed that would close the sockets for us. So
> this leaves me with a bit of a sour taste overall.

The mention of atexit is a little oblique these days. We moved from a
manual atexit handler to using the tempfile.c handler in 9e9033166b
(credential-cache--daemon: use tempfile module, 2015-08-10).

> That being said, I couldn't spot anything obviously wrong with closing
> the streams ourselves, and it does fix the issue on Cygwin without any
> regressions on other platforms as far as I can see. So let's go for this
> fix, even though I cannot properly explain it.

Running t0301 with --stress on Linux failed for me after a minute or so.

-Peff
