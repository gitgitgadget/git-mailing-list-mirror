From: Jeff King <peff@peff.net>
Subject: Re: git no longer prompting for password
Date: Sat, 25 Aug 2012 16:39:05 -0400
Message-ID: <20120825203904.GA10470@sigill.intra.peff.net>
References: <5037E1D0.6030900@gmail.com>
 <20120824212501.GA16285@sigill.intra.peff.net>
 <5038E781.1090008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Iain Paton <ipaton0@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 22:39:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5N8a-0007E4-Lb
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 22:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559Ab2HYUjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 16:39:14 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48450 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751931Ab2HYUjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 16:39:12 -0400
Received: (qmail 14187 invoked by uid 107); 25 Aug 2012 20:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 25 Aug 2012 16:39:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Aug 2012 16:39:05 -0400
Content-Disposition: inline
In-Reply-To: <5038E781.1090008@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204286>

On Sat, Aug 25, 2012 at 03:56:01PM +0100, Iain Paton wrote:

> > It's like the initial http requests do not get a 401, and the push
> > proceeds, and then some later request causes a 401 when we do not expect
> > it. Which is doubly odd, since we should also be able to handle that
> > case (the first 401 we get should cause us to ask for a password).
> 
> Yes, I deliberately have it set for anonymous pull and authenticated push. 
> So the initial contact with the server doesn't ask for auth.

OK, I see what's going on. It looks like it is configured to do so by
rejecting the POST request. So this first request works:

> > GET /git/test.git/info/refs?service=git-receive-pack HTTP/1.1
> User-Agent: git/1.7.8
> Host: 10.44.16.74
> Accept: */*
> Pragma: no-cache
> 
> < HTTP/1.1 200 OK

which is the first step of the conversation, in which the client gets
the set of refs from the remote. Then it tries to POST the pack:

> > POST /git/test.git/git-receive-pack HTTP/1.1
> User-Agent: git/1.7.8
> Host: 10.44.16.74
> Accept-Encoding: deflate, gzip
> Content-Type: application/x-git-receive-pack-request
> Accept: application/x-git-receive-pack-result
> Content-Length: 412
> 
> * upload completely sent off: 412 out of 412 bytes
> < HTTP/1.1 401 Unauthorized

And we get blocked on that request. I didn't quote it above, but note
how the client actually generates and sends the full pack before being
told "no, you can't do this".

So that explains the output you see; we really are generating and
sending the pack, and only then getting a 401. And it also explains why
git does not prompt and retry; we follow a different code path for POSTs
that does not trigger the retry code.

This is not optimal, as we send the pack data only to find out that we
are not authenticated. There is code to avoid sending the _whole_ pack
(it's the probe_rpc code in remote-curl.c), so I think you'd just be
wasting 64K, which is not too bad. So we could teach git to retry if the
POST fails, and I think it would work OK.

But I don't think there is any reason not to block the push request
right from the first receive-pack request we see, which catches the
issue even earlier, and with less overhead (and of course works with
existing git clients :) ).

> apache config has the following:
> [...]
> <LocationMatch "^/git/.*/git-receive-pack$">
>         AuthType Basic
>         AuthUserFile /data/git/htpasswd
>         AuthGroupfile /data/git/groups 
>         AuthName "Git Access"
> 
>         Require group committers
> </LocationMatch>
> 
> nothing untoward there I think and google turns up lots of examples where 
> people are doing essentially the same thing.

I think your regex is the culprit. The first request comes in with:

> > GET /git/test.git/info/refs?service=git-receive-pack HTTP/1.1

The odd URL is because we are probing to see if the server even supports
smart-http. But note that it does not match your regex above, which
requires "/git-receive-pack". It looks like that is pulled straight from
the git-http-backend manpage. I think the change in v1.7.8 broke people
using that configuration.

I tend to think the right thing is to fix the configuration (both on
your system and in the documentation), but we should probably also fix
git to handle this situation more gracefully, since it used to work and
has been advertised in the documentation for a long time.

-Peff
