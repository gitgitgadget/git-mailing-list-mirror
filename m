Return-Path: <SRS0=PYw/=CU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49707C43461
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12961223EA
	for <git@archiver.kernel.org>; Fri, 11 Sep 2020 15:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIKPBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:01:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:54488 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbgIKO76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Sep 2020 10:59:58 -0400
Received: (qmail 887 invoked by uid 109); 11 Sep 2020 13:59:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2020 13:59:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2650 invoked by uid 111); 11 Sep 2020 13:59:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2020 09:59:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Sep 2020 09:59:28 -0400
From:   Jeff King <peff@peff.net>
To:     Ondrej Pohorelsky <opohorel@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Git doesn't honor NO_PROXY environment variable while cloning
Message-ID: <20200911135928.GA1986935@coredump.intra.peff.net>
References: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+B51BGRuLfF7FpiK93Wih0XhsC7rJLGjkF2CzrEsUkBEif+jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[tl;dr This looks to me like a problem in libcurl. I've included my
 whole line of reasoning below. Folks interested in libcurl might want
 to jump straight to the backtrace].

On Fri, Sep 11, 2020 at 02:15:59PM +0200, Ondrej Pohorelsky wrote:

> we've got a bug[0] reported in Red Hat Bugzilla. It seems like Git
> doesn't honor NO_PROXY environment variable while cloning repositories

It's not so much "doesn't honor NO_PROXY" as "NO_PROXY seems to trigger
another bug". Here's a slightly simplified recipe:

  [set up our bogus proxy]
  $ export HTTPS_PROXY=https://user:pass@bad.proxy

  [so far so good; we expect this to complain about the proxy]
  $ git clone https://github.com/git/git
  Cloning into 'git'...
  fatal: unable to access 'https://github.com/git/git/': Could not resolve proxy: bad.proxy

  [now let's set NO_PROXY]
  $ export NO_PROXY=github.com
  $ git clone https://github.com/git/git
  Cloning into 'git'...
  $ echo $?
  128

So we are looking at the variable, but then we exit with failure (and
with nothing to stderr!). That was with v2.28 above. But let's try it
with the current tip of master:

  $ git clone https://github.com/git/git
  Cloning into 'git'...
  error: git-remote-https died of signal 11

Ah, that's interesting. The switch in behavior is due to 675df192c5
(transport-helper: do not run git-remote-ext etc. in dashed form,
2020-08-26). Before that patch the transport code ran git-remote-https
directly. If it returned a non-zero exit code, we just assumed it had
printed its own error to stdout and exited. But after that patch we run
"git remote-https", and the git.c wrapper has code to complain about
segfaults.

So that's a little digression from our real bug. But it points us in the
right direction: remote-https is segfaulting. So here's a more direct
reproduction:

  export HTTPS_PROXY=https://user:pass@bad.proxy
  export NO_PROXY=github.com
  echo list | ./git-remote-https https://github.com/git/git

which results in a segfault. And we can run that process under gdb to
get a backtrace:

  echo list >input
  gdb -ex 'set args https://github.com/git/git <input' \
      -ex 'run' \
      -ex 'bt' \
      ./git-remote-https

which yields (after install debug symbols for system curl, etc):

  #0  __strlen_avx2 () at ../sysdeps/x86_64/multiarch/strlen-avx2.S:65
  #1  0x00007ffff7da6934 in __GI___inet_pton (af=af@entry=2, src=src@entry=0x0, dst=dst@entry=0x7fffffffd600)
      at inet_pton.c:69

Well, the issue is clear enough. Somebody is passing NULL to
inet_pton(). But who?

  #2  0x00007ffff7f88a08 in ossl_connect_step1 (conn=conn@entry=0x5555558275b0, sockindex=sockindex@entry=0)
      at vtls/openssl.c:3136
  #3  0x00007ffff7f8a62f in ossl_connect_common (conn=0x5555558275b0, sockindex=0, nonblocking=true, 
      done=0x555555827bea) at vtls/openssl.c:3985
  #4  0x00007ffff7f8b43b in Curl_ssl_connect_nonblocking (conn=conn@entry=0x5555558275b0, sockindex=sockindex@entry=0, 
      done=done@entry=0x555555827bea) at vtls/vtls.c:331
  #5  0x00007ffff7f552db in https_proxy_connect (sockindex=0, conn=0x5555558275b0) at http_proxy.c:57
  #6  Curl_proxy_connect (conn=0x5555558275b0, sockindex=0) at http_proxy.c:77
  #7  0x00007ffff7f4c148 in Curl_http_connect (conn=0x5555558275b0, done=0x7fffffffdc58) at http.c:1397
  #8  0x00007ffff7f5ffa6 in multi_runsingle (multi=0x555555811240, now=..., data=0x555555821c90) at multi.c:1802
  #9  0x00007ffff7f610e1 in curl_multi_perform (multi=0x555555811240, running_handles=0x7fffffffddc8) at multi.c:2420

Uh oh, it's deep within libcurl. It may be that we're passing it bogus
data, but I don't think so. The rest of our backtrace shows what Git is
doing:

  #10 0x0000555555566f41 in step_active_slots () at http.c:1458
  #11 0x0000555555566f9c in run_active_slot (slot=0x555555814370) at http.c:1479
  #12 0x000055555556762e in run_one_slot (slot=0x555555814370, results=0x7fffffffe050) at http.c:1680
  #13 0x000055555556813b in http_request (
      url=0x555555812ae0 "https://github.com/git/git/info/refs?service=git-upload-pack", result=0x7fffffffe210, 
      target=0, options=0x7fffffffe160) at http.c:1964
  #14 0x0000555555568371 in http_request_reauth (
      url=0x555555812ae0 "https://github.com/git/git/info/refs?service=git-upload-pack", result=0x7fffffffe210, 
      target=0, options=0x7fffffffe160) at http.c:2040
  #15 0x0000555555568514 in http_get_strbuf (
      url=0x555555812ae0 "https://github.com/git/git/info/refs?service=git-upload-pack", result=0x7fffffffe210, 
      options=0x7fffffffe160) at http.c:2088
  #16 0x00005555555605fb in discover_refs (service=0x5555556f73fb "git-upload-pack", for_push=0) at remote-curl.c:484
  [...]

So that's the very first http request we make of libcurl. And I don't
think we'll have regained control via any callbacks, etc. It's possible
we've screwed up passing the NO_PROXY variable somehow, but we don't
really do anything interesting with it:

  $ git grep -A2 NO_PROXY
  http.c:         var_override(&curl_no_proxy, getenv("NO_PROXY"));
  http.c-         var_override(&curl_no_proxy, getenv("no_proxy"));
  http.c-         curl_easy_setopt(result, CURLOPT_NOPROXY, curl_no_proxy);

And if I comment out that curl_easy_setopt() line, we still hit the
problem (because modern libcurl will read NO_PROXY itself).

So it seems at first glance that this is a curl bug. It's triggering via
ssl routines, so let's try plain http:

  $ export http_proxy=http://user:pass@proxy.example.com
  $ export NO_PROXY=example.com
  $ git clone https://example.com
  Cloning into 'example.com'...
  fatal: repository 'http://example.com/' not found

No segfault, and it seems to have actually contacted the server (and you
can verify that with GIT_CURL_VERBOSE=1 in the environment).

We can't do quite the same test with github.com because it will redirect
http to https. But its result is interesting, too:

  $ export NO_PROXY=github.com
  $ git clone http://github.com/git/git foo
  Cloning into 'foo'...
  warning: redirecting to https://github.com/git/git/
  remote: Enumerating objects: 292855, done.
  [...etc...]

So it _does_ work after the redirect. It only fails if the initial
request is https.

So I dunno. This seems like a libcurl bug, but it's possible we're feeding
it data wrong somehow.

-Peff
