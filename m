From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 22:57:35 -0700
Message-ID: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org> <20120920034804.GA32313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 20 07:58:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEZm3-0003VZ-DY
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 07:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753097Ab2ITF56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 01:57:58 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43159 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab2ITF54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 01:57:56 -0400
Received: by qaas11 with SMTP id s11so112642qaa.19
        for <git@vger.kernel.org>; Wed, 19 Sep 2012 22:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=kECXSTySycRcNsYt66BKYFyUGmnZxnMcHxbuKoCyoK4=;
        b=NdNAOMA2h2dCOKQ62kNJNnJASIC0vE9fLe8aN6NjXPI0w+X2S8QPkodz4DHJonRnHV
         NrO9jQvoZP6ME0zw5t203TyfQcEmbdCnGfMvPc8kXc4Mvgz6/jwNMbFEFZPht9LlUukG
         ZZBXTq48DjgnkGDd4ht17rQBZyYc2KBRUpeK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=kECXSTySycRcNsYt66BKYFyUGmnZxnMcHxbuKoCyoK4=;
        b=SZx88RSyB2PF/KibULUsB6Bl+pOcTUIgTbVNpBJWwxnAJlbq4kp2VnfJJupwcwsnFz
         gHv3MNUGNI2dSZFHvMyyVXiQxyTpdbl5AN9h0BTVMLFG33dpn0vrUY4oy/DImOltJcu3
         rFhi5sE+ej+u+0w+q3XkC/afjjJetTlkDQZUP0sC1okAHT+6hTWCqyMS+PHcut2eAyVW
         u3/0Z7aR2uNmSNxnBRXGsmCcZQRf46r+FyMr0MOvWxJN3/Yj+ychepG1mO9gQaL5BXVt
         ESThwPJmywDP+XMzyLD6QQcfFOOrYYJ/wNTe84VEekovTTFl9moYYvm3rWAqvfNzSxVL
         QskA==
Received: by 10.224.175.204 with SMTP id bb12mr2529448qab.14.1348120675362;
 Wed, 19 Sep 2012 22:57:55 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Wed, 19 Sep 2012 22:57:35 -0700 (PDT)
In-Reply-To: <20120920034804.GA32313@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQl1oOZDIovsLPm7YkxTnFd9/cxlBi73XAHCmvyIUAYXjxQgSAY0Djff5/Li0vTvlVLP0lSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206035>

On Wed, Sep 19, 2012 at 8:48 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 19, 2012 at 07:55:53PM -0700, Shawn O. Pearce wrote:
>
>> If the user doesn't want to use the dumb HTTP protocol, she may
>> set GIT_CURL_FALLBACK=0 in the environment before invoking a Git
>> protocol operation. This is mostly useful when testing against
>> servers that are known to not support the dumb protocol. If the
>> smart service detection fails the client should not continue with
>> dumb behavior, but instead provide accurate HTTP failure data.
>
> I have been looking into this recently, as well. GitHub does not allow
> dumb http at all these days,

Interesting that GitHub doesn't support dumb transfer either.

> so transient errors on the initial smart
> contact can cause us to fall back to dumb,

Transient errors is actually what is leading me down this path. We see
about 0.0455% of our requests to the Android hosting service as these
dumb fallbacks. This means the client never got a proper smart service
reply. Server logs suggest we sent a valid response, so I am
suspecting transient proxy errors, but its hard to debug because
clients discard the error.

> and end up reporting a
> totally useless 403 Forbidden error.

Today I posted a change to JGit [1] to make this 406 Not Acceptable as
I think it better matches the description of the failure. It also no
longer reuses the common 403 Forbidden error that a server might
choose to return if a request was given with invalid credentials.

[1] https://git.eclipse.org/r/7847

>  I guess Google Code has a similar
> issue.

Yes, and {android,kernel,gerrit}.googlesource.com also only support
the smart protocol.

> Note that it is not really do not "fall back to dumb"; we detect the
> dumb nature from the response. It is really "fall back to trying the URL
> without the query string, because there are some servers that cannot
> handle it". With your patch, we might still end up performing a dumb
> transfer.

Yes, the server could ignore the parameter and return a dumb info/refs
response on the initial request, forcing the client to a dumb
transfer. I forgot this case being common on a dumb server. I have
only been working with or worrying about smart servers, whose
transient failures have this info/refs request that they always
fail... giving a poor user experience.

> I think what you're doing here is sane, because you have to turn it on
> manually, and thus there are no possible backwards compatibility issues.
> But it might be nice to make things work better out of the box. Here are
> two client-side changes I've been toying with:
>
>   1. If both smart and dumb requests fail, report the error for the
>      smart request. Now that smart-http clients are common, I'd expect
>      most http servers to be smart these days. Of course I don't have
>      any sort of numbers to back this up (nor am I sure how to get them;
>      obviously big sites like GitHub and Google Code do a lot of
>      traffic, but who knows how many one-off repo-on-a-generic-web-host
>      sites still exist?).

I suspect there are still a number of servers that rely on dumb
protocol to host repositories because its very simple to setup.
Breaking support for this wouldn't be a good idea.

kernel.org and eclipse.org both support the smart protocol, but I
think this is a common trend. Sites that host a lot of Git
repositories take the time to setup the smart protocol. Everyone else,
its hit-or-miss, mostly miss.

>      An alternative would be to simply be more verbose, and mention that
>      we tried to fallback and list both failures (or we could do this
>      with just "fetch -v").

I would bet the big hosting providers would appreciate having the
failure listed in non-verbose mode. Many Git users are going to use a
hosting service like GitHub or Google Code, or work with their
organization like kernel.org for central Git hosting. Consumers of
hosted projects that are less familiar with Git will be accessing
these sites often enough.

I considered logging this failure to stderr, but didn't.

>   2. Be more discerning about which errors will cause a fallback.
>      Something like "504 Gateway Timeout" should not give a fallback.
>      The problem is that you are really guessing at what kinds of http
>      errors you are going to get from a dumb server when you try the
>      smart URL.
>
> I dug back into the list thread that spawned the "retry
>      without query string" patch (703e6e7).
>
>      The thread is here:
>
>        http://thread.gmane.org/gmane.comp.version-control.git/137609
>
>      If you read the thread, it turns out that the problem in this case
>      (which is the only reported case I could find in the archive) is
>      that the server was misconfigured to treat _anything_ with a query
>      string as a gitweb URL. And then it got fixed pretty much
>      immediately.
>
>      So as far as we know, there may be zero servers for which this
>      fallback is actually doing anything useful.
>
> I'm tempted to just reverse the logic.

After re-reading that thread, it was a mistake to apply 703e6e76. We
should just revert it.

> Try the request with the query
> string and immediately fail if it doesn't work. For the few (if any)
> people who are hitting a server that will not serve the dumb file in
> that case, add a "remote.*.dumbhttp" setting that will turn off smart
> completely as a workaround.
>
> That would serve the (presumed) majority who are using smart http,
> everyone using dumb http on a reasonably-configured server, and still
> allow an easy workaround for people with badly configured servers.
>
> What do you think?

Yes, this is the better idea. Revert 703e6e76 and add a new feature to
disable the smart protocol entirely as an escape hatch.
