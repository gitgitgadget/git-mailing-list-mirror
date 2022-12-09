Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47755C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 02:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiLICUO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 21:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLICUM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 21:20:12 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D211D643
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 18:20:11 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3ACF1C5411;
        Thu,  8 Dec 2022 21:20:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=b7tG3jAkXdUPKDAaToQ6Vz9t+FKtZT0/Ax1jVYo
        /JMk=; b=J7/JtTyImatXYi0paDRLQyvkxNJ+UhywwibENYo75fdXo72ifJfGrdK
        X8gH/gL6KFHRgNlY8R9wQLV2/DMSChrVyo+SmvxBjcfbvmBdqNyPHGBi/uV5hrYA
        WP9mJyX5IdInNgTSIjiguv9VMUoyr58OVhIrakf6CYrjjTITamdw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA2181C5410;
        Thu,  8 Dec 2022 21:20:08 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6C8661C540A;
        Thu,  8 Dec 2022 21:20:03 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Thu, 8 Dec 2022 21:20:00 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: t5559-http-fetch-smart-http2 failures
Message-ID: <Y5KbUBC1ENOAVuTV@pobox.com>
References: <Y4fUntdlc1mqwad5@pobox.com>
 <Y4kNu9iFQuKjuub1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4kNu9iFQuKjuub1@coredump.intra.peff.net>
X-Pobox-Relay-ID: FD976FE6-7767-11ED-A5B1-C2DA088D43B2-09356542!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the delay.  I wanted to gather some data but could
only do it in small chunks at a time.  Hopefully that
doesn't make this too rambling and/or disjointed.

One upside is that I finally got around to teaching the
Fedora builds to include not just the failing test output,
but tar up the contents of test-results and any trash
directories on failures.  That makes it easier to poke
around when a build fails on a remote build system where I
can't get a shell. :)

Jeff King wrote:
> On Wed, Nov 30, 2022 at 05:09:34PM -0500, Todd Zullinger wrote:
> 
>> The changes in 73c49a4474 (t: run t5551 tests with both HTTP
>> and HTTP/2, 2022-11-11) seem to rather frequently trigger
>> test failures on Fedora.
> 
> Thanks for the report. I can't seem to reproduce here on my Debian
> system, even with --stress.

One notable difference between Debian/Ubuntu and Fedora is
that Debian/Ubuntu uses mod_http2 included with the upstream
Apache httpd source.  Fedora is using the newer, stand-alone
module (which is the upstream source for the http2 module).

Ubuntu 22.04.1 has httpd-2.4.52 with mod_http2-1.15.26 (per
MOD_HTTP2_VERSION in modules/http2/h2_version.h).

Fedora 37, 36, and rawhide have httpd-httpd-2.4.54 with
mod_http2-2.0.9.  They also have curl-7.86 in rawhide (where
I've done the most testing), 7.85.0 in 37, and 7.82.0 in 36.

Interestingly, if I build the same git source rpm against
RHEL-9 which has httpd-2.4.53 and mod_http2-1.15.19, I don't
see any failures.

I'm tempted to do a build of mod_http2-1.x or the embedded
mod_http2 and test with that, but I have not yet made time
to do so.

Searching for errors similar to what I found in the test
failures, I found an old curl issue and a related Fedora
bug:

    https://github.com/curl/curl/issues/3750
    https://bugzilla.redhat.com/show_bug.cgi?id=1690971

Of course, these are from 2019 so you'd think this
particular issue was long-gone.  But perhaps with mod_http2
still being actively developed, similar bugs can crop up.

> I can try a Fedora chroot or vm, but it may take some time to set up. It
> also sounds like you're not able to reproduce it locally on a Fedora
> system? Have you tried "./t5559-* --stress"?

I had, but at the time the failures I got seemed unrelated,
particularly because they triggered on earlier tests and
somewhat randomly.

After I changed the test to append $test_count to err so I
could see the reason for the failure more clearly, I think
they are more similar.

With --stress, http2 fails at various points with errors
like:

    expecting success of 5559.6 'fetch changes via http': 
	    echo content >>file &&
	    git commit -a -m two &&
	    git push public &&
	    (cd clone && git pull) &&
	    test_cmp file clone/file

    +++ echo content
    +++ git commit -a -m two
    [main 5647d5f] two
     Author: A U Thor <author@example.com>
     1 file changed, 1 insertion(+)
    +++ git push public
    To /builddir/build/BUILD/git-2.39.0.rc2/t/trash directory.t5559-http-fetch-smart-http2.stress-13/httpd/www/repo.git
       f39a923..5647d5f  main -> main
    +++ cd clone
    +++ git pull
    error: RPC failed; curl 16 Error in the HTTP2 framing layer
    fatal: expected flush after ref listing
    error: last command exited with $?=1
    not ok 6 - fetch changes via http

or sometimes with the same error in test 30, as below.

>> The most frequent test to fail is "large fetch-pack requests
>> can be sent using chunked encoding" (t5559.30), but earlier
>> tests have also failed on occasion.  For the common failure,
>> the test exits with:
>> 
>>     expecting success of 5559.30 'large fetch-pack requests can be sent using chunked encoding': 
>> 	    GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
>> 		    clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
>> 	    {
>> 		    test_have_prereq HTTP2 ||
>> 		    grep "^=> Send header: Transfer-Encoding: chunked" err
>> 	    }
>>     +++ GIT_TRACE_CURL=true
>>     +++ git -c http.postbuffer=65536 clone --bare http://127.0.0.1:5559/smart/repo.git split.git
>>     error: last command exited with $?=128
>>     not ok 30 - large fetch-pack requests can be sent using chunked encoding
>> 
>> (Less frequently, I've seen the last command exit 141.)
> 
> Interesting. 141 implies SIGPIPE, but that may be a red herring. The
> operation isn't supposed to fail, but if it does due to the server
> bailing, then the client sometimes hitting SIGPIPE is a known unrelated
> problem.
> 
> Is it possible to see the contents of "err" here? That will have the
> message from the client, but also the curl trace, which is probably
> helpful.

Appending -$test_count to err in all the places it's used in
the test helped here, e.g.:

    sed -Ei 's/\berr\b/&-$test_count/' t/t5551-http-fetch-smart.sh

With that, one of the more common errors is:

    error: RPC failed; HTTP 101 curl 92 HTTP/2 stream 1 was not closed cleanly before end of the underlying stream

others are:

    error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer
    fatal: expected flush after ref listing

    error: RPC failed; HTTP 101 curl 16 Error in the HTTP2 framing layer

    error: RPC failed; curl 16 Error in the HTTP2 framing layer 
    fatal: expected 'packfile'

The full err output is usually around 5k lines, so it's not
ideal for inclusion here, but I've saved a number of them
and can either extract portions or post them somewhere and
link to them, if you think they might be useful.

> It might also be interesting to see the server's view, which would be in
> httpd/error.log in the trash directory (also access.log, but probably
> that is not interesting).

The error.log looks the same for the failed runs I've
collected:

    [Tue Dec 06 16:35:40.840250 2022] [mpm_event:notice] [pid 298654:tid 298654] AH00489: Apache/2.4.54 (Fedora Linux) configured -- resuming normal operations
    [Tue Dec 06 16:35:40.840388 2022] [core:notice] [pid 298654:tid 298654] AH00094: Command line: '/usr/sbin/httpd -d /tmp/git-t.oOfy/trash directory.t5559-http-fetch-smart-http2/httpd -f /builddir/build/BUILD/git-2.39.0.rc2/t/lib-httpd/apache.conf -D HTTP2 -c Listen 127.0.0.1:5559'
    [Tue Dec 06 16:35:42.372099 2022] [cgi:error] [pid 298658:tid 298768] [remote 127.0.0.1:55644] AH01215: stderr from /builddir/build/BUILD/git-2.39.0.rc2/git-http-backend: Unsupported service: getanyfile
    [Tue Dec 06 16:35:46.209758 2022] [cgi:error] [pid 300664:tid 300695] [client 127.0.0.1:60712] AH01215: stderr from /builddir/build/BUILD/git-2.39.0.rc2/git-http-backend: fatal: git upload-pack: not our ref 51c0379e3f0bea4537b50664334a941865f61b94
    [Tue Dec 06 16:35:46.912816 2022] [cgi:error] [pid 298659:tid 298663] [remote 127.0.0.1:60718] AH01215: stderr from /builddir/build/BUILD/git-2.39.0.rc2/git-http-backend: fatal: git upload-pack: not our ref 51c0379e3f0bea4537b50664334a941865f61b94
    [Tue Dec 06 16:35:53.962296 2022] [auth_basic:error] [pid 300664:tid 300707] [client 127.0.0.1:60926] AH01618: user bogus not found: /auth/smart/repo.git/info/refs
    [Tue Dec 06 16:35:56.627946 2022] [auth_basic:error] [pid 300664:tid 300713] [client 127.0.0.1:37644] AH01617: user user@host: authentication failure for "/auth/smart/repo.git/info/refs": Password Mismatch
    [Tue Dec 06 16:35:58.185699 2022] [mpm_event:notice] [pid 298654:tid 298654] AH00491: caught SIGTERM, shutting down

The LogLevel might need to be adjusted to get more useful
output there, perhaps?

> If t5551 isn't failing similarly, then presumably the problem is either:
> 
>   1. There is some race or bad interaction between curl and apache
>      speaking http2 (possibly a buggy version of one?)
> 
>   2. http2 requires using mpm_event instead of mpm_prefork. Maybe this
>      introduces problems with apache on this system?
> 
>   3. there is a bug in git. ;) This is always a possibility, of course,
>      but we literally do nothing differently from our end, except pass
>      it to curl via CURLOPT_HTTP_VERSION.
> 
> It would be interesting to see if doing this:
> 
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 0294739a77..b24ca44a95 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -73,16 +73,9 @@ LockFile accept.lock
>  	LoadModule unixd_module modules/mod_unixd.so
>  </IfModule>
>  
> -<IfDefine HTTP2>
>  <IfModule !mod_mpm_event.c>
>  	LoadModule mpm_event_module modules/mod_mpm_event.so
>  </IfModule>
> -</IfDefine>
> -<IfDefine !HTTP2>
> -<IfModule !mod_mpm_prefork.c>
> -	LoadModule mpm_prefork_module modules/mod_mpm_prefork.so
> -</IfModule>
> -</IfDefine>
>  </IfVersion>
>  
>  PassEnv GIT_VALGRIND
> 
> also causes t5551 to start failing. If so, then we can blame mpm_event,
> and not http2.

Good idea.  With that applied, I've still not seen a failure
in t5551, not even when run via --stress for some minutes.

I'm not sure whether any of this points to a bug in Git's
http2 code at all.  It _seems_ like it's going to be
elsewhere, in curl and/or httpd/mod_http2.  In other words,
your 1 above.

If nothing jumps out to point to a possible issue in git,
I'll extract a reproduction recipe from the test suite and
file a Fedora bug.  Maybe the folks who have looked at
similar issues in curl and httpd/mod_http2 will spot
something.

Thanks!

-- 
Todd
