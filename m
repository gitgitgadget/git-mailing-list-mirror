From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Thu, 20 Sep 2012 16:05:03 -0700
Message-ID: <CAJo=hJvyEtTDVJ6+Gv1kgqs1=UQEVbLaSFMEmUmCX-JWRCrDxA@mail.gmail.com>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
 <20120920034804.GA32313@sigill.intra.peff.net> <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <20120920172408.GC18655@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 21 01:05:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEpoY-0008HM-Ge
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 01:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396Ab2ITXF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 19:05:26 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39006 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab2ITXFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 19:05:25 -0400
Received: by qcro28 with SMTP id o28so2156188qcr.19
        for <git@vger.kernel.org>; Thu, 20 Sep 2012 16:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DuZobNb6FTSUjbYiH6qgAKNOubWDbj+sX3nKSc8eu5A=;
        b=ZftBNSi+cyRZS/nkwlfi+yD/cFA6y+Mx1T8mj/ipnAh8VYP8Mui6QpiBY9UBTR01Sh
         9OHmG1Xp8litFQc1vriQEZ1y0KTl+Qhz0heOxBZPa+kL1QjoQw4We7mGgk6/WwkKqNdg
         p21HkDcQK7ApOAlRQl9a7pAJkwGMkwMMj20SU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=DuZobNb6FTSUjbYiH6qgAKNOubWDbj+sX3nKSc8eu5A=;
        b=kpCeLTEHb4j3cQ+S4kElhtCkZKkwR5IifiqEfkDXVo40Y2q+GohzKVmwCdIzm9dBTy
         P0GNyqTT6VwQWuu2wy38uh2JRG23wGXWfD7yFbWwKy/wU9hUlwzIooMmvkMEqH1+PBq5
         KhA3+KnPijlMQShy4+mfl+9aFucqFP1ixUSnlP8ujJH6wss8jVxfCMw0wRj+fFCa3ZjI
         7Qxkdmi/HYStKCVOYZ7MJGjT8jOICoJFgyG8Jy4Eckn4GsBEYua9dtqEgqpDD01zfb2a
         1Vrtc4mv/R5flxKzxwLA4BvEMeSzjfqjJEJSj2/875XwR30/CnLPVQz38Q1Wj20PhMfi
         2gAA==
Received: by 10.224.213.198 with SMTP id gx6mr8452552qab.9.1348182324097; Thu,
 20 Sep 2012 16:05:24 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 20 Sep 2012 16:05:03 -0700 (PDT)
In-Reply-To: <20120920172408.GC18655@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQk4RGcpIN8PXejQ2QcFpjgcT6V8s7LrIzTLLKnq63+SRlqnhmfizuu9H75gVZyCSL5GjpIk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206100>

On Thu, Sep 20, 2012 at 10:24 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Sep 19, 2012 at 10:57:35PM -0700, Shawn O. Pearce wrote:
>
>> > so transient errors on the initial smart
>> > contact can cause us to fall back to dumb,
>>
>> Transient errors is actually what is leading me down this path. We see
>> about 0.0455% of our requests to the Android hosting service as these
>> dumb fallbacks. This means the client never got a proper smart service
>> reply. Server logs suggest we sent a valid response, so I am
>> suspecting transient proxy errors, but its hard to debug because
>> clients discard the error.
>
> Yup, we see the same thing. I've tracked a few down manually to actual
> things like gateway timeouts on our reverse proxy.

Our reverse proxies also fail sometimes. :-)

But right now I am seeing failures in libcurl's SSL connection that
may also be causing the smart connection failures. For example this
trace, where libcurl was just not able to connect to respond to the
401 with a password. I suspect what is happening is the SSL session
dropped out of cache on our servers, and libcurl couldn't reuse the
existing SSL session. Instead of discarding the bad session and
retrying, Git aborts. I'm willing to bet modern browsers just discard
the bad session and start a new one, because clients can't assume the
remote server will be able to remember their session forever.


* Couldn't find host android.googlesource.com in the .netrc file; using defaults
* About to connect() to android.googlesource.com port 443 (#0)
*   Trying 2607:f8b0:400e:c02::52... * Connected to
android.googlesource.com (2607:f8b0:400e:c02::52) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: none
  CApath: /etc/ssl/certs
* SSL connection using RC4-SHA
* Server certificate:
*        subject: C=US; ST=California; L=Mountain View; O=Google Inc;
CN=*.googlecode.com
*        start date: 2012-08-16 12:25:39 GMT
*        expire date: 2013-06-07 19:43:27 GMT
*        subjectAltName: android.googlesource.com matched
*        issuer: C=US; O=Google Inc; CN=Google Internet Authority
*        SSL certificate verify ok.
> GET /a/platform/tools/build/info/refs?service=git-upload-pack HTTP/1.1
User-Agent: git/1.7.12.1.1.g9b7ccb3
Host: android.googlesource.com
Accept: */*
Pragma: no-cache

* The requested URL returned error: 401
* Closing connection #0
* Couldn't find host android.googlesource.com in the .netrc file; using defaults
* About to connect() to android.googlesource.com port 443 (#0)
*   Trying 2607:f8b0:400e:c02::52... * Connected to
android.googlesource.com (2607:f8b0:400e:c02::52) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: none
  CApath: /etc/ssl/certs
* SSL re-using session ID
* Unknown SSL protocol error in connection to android.googlesource.com:443
* Expire cleared
* Closing connection #0
error: Unknown SSL protocol error in connection to
android.googlesource.com:443  while accessing
https://android.googlesource.com/a/platform/tools/build/info/refs?service=git-upload-pack
fatal: HTTP request failed
