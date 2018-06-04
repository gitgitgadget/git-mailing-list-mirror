Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 407281F403
	for <e@80x24.org>; Mon,  4 Jun 2018 04:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751273AbeFDEoM (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 00:44:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:32952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750826AbeFDEoL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 00:44:11 -0400
Received: (qmail 2657 invoked by uid 109); 4 Jun 2018 04:44:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Jun 2018 04:44:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11635 invoked by uid 111); 4 Jun 2018 04:44:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Jun 2018 00:44:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jun 2018 00:44:09 -0400
Date:   Mon, 4 Jun 2018 00:44:09 -0400
From:   Jeff King <peff@peff.net>
To:     Max Kirillov <max@max630.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Florian Manschwetus <manschwetus@cs-software-gmbh.de>,
        Chris Packham <judge.packham@gmail.com>,
        Konstantin Khomoutov <kostix+git@007spb.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v7 2/2] http-backend: respect CONTENT_LENGTH for
 receive-pack
Message-ID: <20180604044408.GD14451@sigill.intra.peff.net>
References: <20180602212749.21324-1-max@max630.net>
 <20180602212749.21324-3-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180602212749.21324-3-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 03, 2018 at 12:27:49AM +0300, Max Kirillov wrote:

> Push passes to another commands, as described in
> https://public-inbox.org/git/20171129032214.GB32345@sigill.intra.peff.net/
> 
> As it gets complicated to correctly track the data length, instead transfer
> the data through parent process and cut the pipe as the specified length is
> reached. Do it only when CONTENT_LENGTH is set, otherwise pass the input
> directly to the forked commands.

I think this approach is reasonable. It's basically converting the
known-length case to a read-to-eof case for the sub-program, which
should paper over any problems of this type. And it's what we really
_want_ the web server to be doing in the first place.

Since this is slightly less efficient, and because it only matters if
the web server does not already close the pipe, should this have a
run-time configuration knob, even if it defaults to
safe-but-slightly-slower?

I admit I don't overly care that much myself (the only large-scale Git
server deployment I am personally familiar with does not use
git-http-backend at all), but it might be nice to leave an escape hatch.

There are a few things in the patch worth fixing, but overall I think it
looks like a pretty good direction. Comments inline.

> diff --git a/http-backend.c b/http-backend.c
> index 3066697a24..78a588c551 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -351,23 +351,22 @@ static ssize_t get_content_length(void)
>  	return val;
>  }
>  
> -static ssize_t read_request(int fd, unsigned char **out)
> +static ssize_t read_request(int fd, unsigned char **out, ssize_t req_len)
>  {
> -	ssize_t req_len = get_content_length();
> -
>  	if (req_len < 0)
>  		return read_request_eof(fd, out);
>  	else
>  		return read_request_fixed_len(fd, req_len, out);
>  }

Minor nit, but it might have been nice to build in this infrastructure
in the first patch, rather than refactoring it here. It would also make
it much more obvious that the first one is not handling some cases,
since we'd have "req_len" but not pass it to all of the code paths. ;)

> @@ -379,11 +378,18 @@ static void inflate_request(const char *prog_name, int out, int buffer_input)
>  			if (full_request)
>  				n = 0; /* nothing left to read */
>  			else
> -				n = read_request(0, &full_request);
> +				n = read_request(0, &full_request, req_len);
>  			stream.next_in = full_request;
>  		} else {
> -			n = xread(0, in_buf, sizeof(in_buf));
> +			ssize_t buffer_len;
> +			if (req_remaining_len < 0 || req_remaining_len > sizeof(in_buf))
> +			    buffer_len = sizeof(in_buf);
> +			else
> +			    buffer_len = req_remaining_len;
> +			n = xread(0, in_buf, buffer_len);
>  			stream.next_in = in_buf;
> +			if (req_remaining_len >= 0)
> +				req_remaining_len -= n;
>  		}

What happens here if xread() returns an error? We probably don't want to
modify req_remaining_len (it probably doesn't matter since we'd report
the errot after this, but it feels funny not to check here).

> +static void pipe_fixed_length(const char *prog_name, int out, size_t req_len)
> +{
> +	unsigned char buf[8192];
> +	size_t remaining_len = req_len;
> +
> +	while (remaining_len > 0) {
> +		size_t chunk_length = remaining_len > sizeof(buf) ? sizeof(buf) : remaining_len;
> +		size_t n = xread(0, buf, chunk_length);
> +		if (n < 0)
> +			die_errno("Reading request failed");

I was going to complain that we usually start our error messages with a
lowercase, but this program seems to be an exception. So here you've
followed the local custom, which is OK.

> +		if (write_in_full(out, buf, n) < 0)
> +			die_errno("%s aborted reading request", prog_name);

We don't necessarily know why the write failed. If it's EPIPE, then yes,
the program probably did abort. But all we know is that write() failed.
We should probably say something more generic like:

  die_errno("unable to write to '%s'");

or similar.

> diff --git a/t/helper/test-print-larger-than-ssize.c b/t/helper/test-print-larger-than-ssize.c
> new file mode 100644
> index 0000000000..83472a32f1
> --- /dev/null
> +++ b/t/helper/test-print-larger-than-ssize.c
> @@ -0,0 +1,11 @@
> +#include "test-tool.h"
> +#include "cache.h"
> +
> +int cmd__print_larger_than_ssize(int argc, const char **argv)
> +{
> +	size_t large = ~0;
> +
> +	large = ~(large & ~(large >> 1)) + 1;
> +	printf("%" PRIuMAX "\n", (uintmax_t) large);
> +	return 0;
> +}

I think this might be nicer as part of "git version --build-options".
Either as a byte-size as I showed in [1], or directly showing this
value.

[1] https://public-inbox.org/git/20171129032632.GC32345@sigill.intra.peff.net/

> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 87066ced62..edcfe5df63 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -25,6 +25,7 @@ static struct test_cmd cmds[] = {
>  	{ "mktemp", cmd__mktemp },
>  	{ "online-cpus", cmd__online_cpus },
>  	{ "path-utils", cmd__path_utils },
> +        { "print-larger-than-ssize", cmd__print_larger_than_ssize },

Indent with spaces?

> diff --git a/t/t5560-http-backend-noserver.sh b/t/t5560-http-backend-noserver.sh
> index 9fafcf1945..8c212393b4 100755
> --- a/t/t5560-http-backend-noserver.sh
> +++ b/t/t5560-http-backend-noserver.sh
> @@ -71,4 +71,17 @@ test_expect_success 'http-backend blocks bad PATH_INFO' '
>  	expect_aliased 1 //domain/data.txt
>  '
>  
> +test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
> +	NOT_FIT_IN_SSIZE=$("$GIT_BUILD_DIR/t/helper/test-tool" print-larger-than-ssize) &&

We put helpers in the PATH, so this could just be "test-tool
print-larger-than-ssize" (though I still prefer the --build-options
variant).

> +	env \
> +		CONTENT_TYPE=application/x-git-upload-pack-request \
> +		QUERY_STRING=/repo.git/git-upload-pack \
> +		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
> +		GIT_HTTP_EXPORT_ALL=TRUE \
> +		REQUEST_METHOD=POST \
> +		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
> +		git http-backend </dev/zero >/dev/null 2>err &&
> +	grep -q "fatal:.*CONTENT_LENGTH" err

I'm not sure if these messages should be marked for translation. If so,
you'd want test_i18ngrep here.

We also generally avoid "-q" to grep. If the script is in non-verbose
mode it will go to /dev/null anyway, and in verbose mode it's useful to
see (possibly ditto for the /dev/null redirection of stdout above, but I
think that might actually spew a binary packfile if the test fails,
which we'd rather avoid).

> diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
> new file mode 100755
> index 0000000000..6b0c005db0
> --- /dev/null
> +++ b/t/t5562-http-backend-content-length.sh
> @@ -0,0 +1,155 @@
> +#!/bin/sh
> +
> +test_description='test git-http-backend respects CONTENT_LENGTH'
> +. ./test-lib.sh

Why is the too-large CONTENT_LENGTH test in another file? I'd have
thought it would go well here, based on the description.

> +verify_http_result() {
> +	# sometimes there is fatal error buit the result is still 200
> +	if grep 'fatal:' act.err
> +	then
> +		return 1
> +	fi
> +
> +	if ! grep "Status" act.out >act
> +	then
> +		printf "Status: 200 OK\r\n" >act
> +	fi
> +	printf "Status: $1\r\n" >exp &&
> +	test_cmp exp act
> +}

200 with a fatal error sounds non-ideal. But I think it's unavoidable in
some cases where we see write failures, etc.

> +test_http_env() {
> +	handler_type="$1"
> +	shift
> +	env \
> +		CONTENT_TYPE="application/x-git-$handler_type-pack-request" \
> +		QUERY_STRING="/repo.git/git-$handler_type-pack" \
> +		PATH_TRANSLATED="$PWD/.git/git-$handler_type-pack" \
> +		GIT_HTTP_EXPORT_ALL=TRUE \
> +		REQUEST_METHOD=POST \
> +		"$@"
> +}

I think this env (and the earlier one) are not strictly necessary, as
you could just use shell one-shot variables. But I'm OK with them as an
abundance of caution, since in theory a caller could use a shell
function rather than a real command here (in which case one-shot
variables do the wrong thing).

> +test_expect_success 'setup repository' '
> +	test_commit c0 &&
> +	test_commit c1
> +'
> +
> +hash_head=$(git rev-parse HEAD)
> +hash_prev=$(git rev-parse HEAD~1)

We generally prefer to have all commands, even ones we don't expect to
fail, inside test_expect blocks (e.g., with a "setup" description).

> +cat >fetch_body <<EOF
> +0032want $hash_head
> +00000032have $hash_prev
> +0009done
> +EOF

This depends on the size of the hash. That's always 40 for now, but is
something that may change soon.

We already have a packetize() helper; could we use it here?

(Looking at the definition of that helper, it's actually kind of
expensive in terms of number of processes. We could perhaps convert it
to perl and do it all in a single process, but that's orthogonal to your
series).

> +gzip -k fetch_body

We don't unconditionally rely on gzip elsewhere. The test blocks using
it (and the ones that depend on them) should be marked with the GZIP
prerequisite.

> +head -c -10 <fetch_body.gz >fetch_body.gz.trunc
> +
> +head -c -10 <fetch_body >fetch_body.trunc

We can into portability problems with "head -c", but I think they were
mostly with different buffering behavior (i.e., reading more than 10
bytes). And that would be OK in this setting, since nobody is going to
read the rest of the input after us.

So it's probably OK, but we could use "test_copy_bytes 10" here if it
isn't.

> +touch empty_body

We usually prefer ">empty_body" to using "touch".

> +test_expect_success 'fetch plain truncated' '
> +	test_http_env upload \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl fetch_body.trunc git http-backend >act.out 2>act.err &&
> +	test_must_fail verify_http_result "200 OK"
> +'

Usually test_must_fail on a checking function like this is a sign that
the check is not as robust as we'd like. If the function checks two
things "A && B", then checking test_must_fail will only let us know
"!A || !B", but you probably want to check both.

The usual solution is for verify_http_result to take an optional "!" in
the first parameter and invert its sense. Or to just split it into two
separate functions.

(We'd also generally not use test_must_fail with a non-git command, and
just use a simple "! verify_http_result"; that would apply equally if
gets split into two commands).

> +test_expect_success 'push plain' '
> +	git config http.receivepack true &&

This will persist after the test finishes. Try:

  test_config http.receivepack true

which will clean up after the test finishes. Alternatively, since I
think you'd want this whole script to run with http.receivepack set,
this could be part of the repository setup in the earlier steps (and
then _don't_ use test_config, because the whole point is for it to
persist).

> +	test_http_env receive \
> +		"$TEST_DIRECTORY"/t5562/invoke-with-content-length.pl push_body git http-backend >act.out 2>act.err &&
> +	verify_http_result "200 OK" &&
> +	git rev-parse newbranch >act.head &&
> +	echo "$hash_next" >exp.head &&
> +	test_cmp act.head exp.head &&
> +	git branch -D newbranch
> +'

Should this "git branch -D" go into a "test_when_finished" block closer
to when it is created?

> +# write data
> +my $pid = open(my $out, "|-", @command);
> +defined syswrite($out, $body_data) or die "Cannot write data: $!";

I assume perl's syswrite() has the usual write() pitfalls, like
sometimes returning without writing all of the bytes. Could this just
be:

  print $out $body_date;

?

> +sleep 1; # is interrupted by SIGCHLD
> +if (!$exited) {
> +        close($out);
> +        die "Command did not exit after reading whole body";
> +}

A sleep like this is a recipe for having the test fail when the system
is under heavy load and it takes the sub-process more than a second to
return (and the SIGCHLD to get delivered).

Normally I'd suggest wait() or pause(), but I think the intent is to
sleep because in the failure case we'd never see the signal, and just
hang? If so, then perhaps we should give a much higher sleep, like 60
seconds. That will mean the test eventually does report failure, but
should be much less likely to cause a false negative. And if we do get
the signal (which we'd usually expect), then we exit immediately.

Also, do we need to protect ourselves against other signals being
delivered? E.g., if I resize my xterm and this process gets SIGWINCH, is
it going to erroneously end the sleep and say "nope, no exited signal"?


My read through the tests was mostly looking for mechanical problems. I
didn't give much though to whether we were getting full coverage, and
now it's my bed-time here. So I'll leave that for later (or somebody
else).

-Peff
