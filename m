Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1219713D8B2
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 09:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269904; cv=none; b=d4JJnG7fM69Rwfd36yh6cw7xHDbJbHV5LDxhEjh2pbOo+ux8h18bkiTm6hmspB9BWJBu2/O3ZUl/QwPDD4S53xO24rly2jy0a3tisSxzNG4fSveLIKQqbgFWGUnQzcF+Gj5FFG7XAo5v6o6kJitZ3lCnndNlL6iTLPri6KNofDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269904; c=relaxed/simple;
	bh=tnPgnhocuhhMzM/323dtT/hE5jQixPJGvsLdjepTMG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oc+tC6IPwvWh6O+GLNXu1dxnobepBUCgKrTQwXwQCpqanyMCwxpHBIeNEd5j8QWul0N9gBeKRGNOCIZHIL34M6T2c0iX4UFT8N2/pp5f0ST8kUyxtVulbq55cnhyq9hhFekaEIweP+vZ5zYaCE90QydOD7M8PIjuSmkt0fL/zmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24099 invoked by uid 109); 13 Jun 2024 09:11:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Jun 2024 09:11:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15309 invoked by uid 111); 13 Jun 2024 09:11:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Jun 2024 05:11:32 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Jun 2024 05:11:34 -0400
From: Jeff King <peff@peff.net>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Report rejections over HTTP when the remote rejects
 during the transfer
Message-ID: <20240613091134.GA796372@coredump.intra.peff.net>
References: <20240612115028.1169183-1-cmn@dwim.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612115028.1169183-1-cmn@dwim.me>

On Wed, Jun 12, 2024 at 01:50:24PM +0200, Carlos Martín Nieto wrote:

> While investigating a difference between HTTP and SSH when rejecting a push due
> to it being too large, I noticed that rejecting a push without receiving the
> entire packfile causes git to print out the error message "pack exceeds maximum
> allowed size" but it also shows "Everything up-to-date" instead of the rejection
> of every ref update like the server has specified.
> 
> This is the result of two issues in git, of which I aim to fix one here, namely
> 
>   1) when the server sends the response and closes the connection, remote-curl
>   sees that as an error and stops processing the send-pack output, combined with
> 
>   2) git does not remember what it asked the remote helper to push so it cannot
>   distinguish whether an empty report means "I had an error and did nothing" or
>   "everything was up to date and I didn't have to do anything".
> 
> The latter issue is more complex so here I'm concentrating on the former, which
> has a simple solution but a complex test. The solution is to read in to the end
> of what send-pack is telling us (it's creating the whole packfile that we're
> throwing away anyway) so we can report back to the user.

Hmm. I think the second one is much more important, though. If the
remote helper dies unexpectedly for any reason, shouldn't the parent
git-push realize this and propagate the error? It sounds like you are
fixing one _specific_ case where the remote helper dies so that we don't
run into the problem caused by (2).

But if we fixed (2), then (1) would not be nearly as important anymore
(if at all). But I think there is a little more going on with this
specific case...

> The testing however proved a bit complicated as this bug requires the server to
> cut off the connection while git is uploading the packfile. The existing HTTP
> tests use CGI and as far as I've been able to test, httpd buffers too much for
> us to be able to replicate the situation.

It is not buffering that gets in your way, but rather that Apache will
actually drain the remainder of the request (throwing away the extra
bytes) if the CGI dies. You can see this by running your test against
apache and strace-ing the apache process. It is in a read/write loop
streaming the packfile from network to the CGI's stdin, it hits EPIPE on
the write(), and then it switches to just read().

Which makes sense, because you can't send back the HTTP 200 response
until you've read the whole request. RFC 7230 does make an exception for
error responses:

  A client sending a message body SHOULD monitor the network connection
  for an error response while it is transmitting the request.  If the
  client sees a response that indicates the server does not wish to
  receive the message body and is closing the connection, the client
  SHOULD immediately cease transmitting the body and close its side of
  the connection.

That's just a "SHOULD" but I think curl does this properly. In the case
of GitHub's servers, a fatal condition from index-pack seems to trigger
an HTTP 500. So that is OK by the standard above, but it does mean we
lose the opportunity to provide any error report at the Git protocol
level. And so you end up with output like:

  error: RPC failed; HTTP 500 curl 22 The requested URL returned error: 500
  send-pack: unexpected disconnect while reading sideband packet
  fatal: the remote end hung up unexpectedly

whereas the same push over ssh produces[1]:

  remote: fatal: non-blob object size limit exceeded (commit ddc6d4e7091229184537d078666afb241ea8ef62 is 104857798 bytes)
  error: remote unpack failed: index-pack failed
  To github.com:peff/test.git
   ! [remote rejected] main -> main (failed)
  error: failed to push some refs to 'github.com:peff/test.git'

And even if we teach the remote helper to soak up the whole pack, we're
still going to see the same useless output. So I would argue that the
first fix here needs to be at the server level. It should be soaking up
all of the request bytes if possible so that we can write back an HTTP
200 with the appropriate error report.

Of course it's kind of lame that we don't cut off the client and let it
keep sending useless bytes (though really it is not any different than
fsck errors, which we queue after reading the whole input).

It might be possible to send an application/x-git-receive-pack-result as
the body of the 500 response. And then we could teach the client side to
notice and handle that better. We could possibly even use a different
code (413 Payload Too Large?), and I suspect existing clients would
behave sensibly (and new ones could give a better message). We _might_
even be able to get away with a "200" response here, though even if curl
is OK with it, I think we are stretching the RFC a bit.

[1] The keen-eyed observer may notice this is failing due to a different
    reason than "pack exceeds maximum allowed size". I happen to know
    that GitHub's version of index-pack will also reject commits over 100MB
    in the same unceremonious way, so we can generate the same condition
    without having to spend tons of bandwidth:

      # start with one small commit
      git init
      git commit --allow-empty -m foo

      # now make a too-big one. Note that it will compress well with
      # zlib!
      git cat-file commit HEAD >commit
      perl -e 'print "a" x 79, "\n" for (1..1310720)' >>commit
      commit=$(git hash-object -t commit -w commit)
      git update-ref HEAD $commit

      # pushing just the commit above will not generate the issue,
      # because we'll (racily) have sent the rest of the pack by
      # the time the server notices the problem. So tack on a bunch of
      # big (and uncompressible) irrelevant data.
      dd if=/dev/urandom of=foo.rand bs=1M count=90
      git add foo.rand
      git commit -m 'big data'

    And now pushing over http will quickly-ish get you to the ugly
    output (but over ssh is OK). But note this only work with GitHub!
    Upstream Git does not have the same object-size check.

> This is why there's a python Git server in this patch series that doesn't rely
> on CGI but streams the data both ways so it can close the stream as soon as
> receive-pack exits. There's already some python tooling in the project and I'm
> much more familiar with it than e.g. perl, so I hope that's fine. I tried to
> make it as simple as possible while still being able to stream bidirectionally.

I admit that I don't love carrying a separate webserver implementation,
but I doubt we can convince Apache not to do the draining behavior.
Though based on what I wrote above, I'm not sure that non-draining is a
behavior we care about testing that much (we _do_ care about getting an
HTTP 500 and bailing from the helper, but that is much easier to test).

If we are going to carry some custom server code, python brings some
complications. We don't currently depend on python at all in the test
suite, outside of the git-p4 tests. And those are disabled if NO_PYTHON
is set. We do assume that we have access to perl in the test suite even
if NO_PERL is set, but we try to limit ourselves to a very vanilla
subset that would work even on ancient versions of perl (so basically
treating perl like sed/awk as being in the "it's everywhere" unix
toolbox).

I don't know if we could do the same with python. I suspect there are
systems without it, even these days. I'm also not sure what portability
issues we might see on the specific components you're using. E.g., is
http.server always available?

So I think at the very least we'd need to be able to push this behind a
test prereq and skip the test when we can't spin up the webserver.

I do think doing something similar in perl would be nicer, if only
because it keeps the number of languages we use in the test suite the
same. But I also have a personal bias towards perl (mostly from
exposure). And even with perl, we'd be relying on non-standard modules
that would still require a prereq/skip setup.

-Peff
