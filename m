Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B5A43152
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 20:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722283797; cv=none; b=HIxJ6dj5PzZ2hIibpMGjNKYkSyc00OF1q/+N965jrDhK7ltIz+CfhySpDCbNeZEqH2reVqIj7rWg+wkqjYZAp5EAvBZms9pcLUmFZjpSClu2qOnZ8u1uq+KTyQzdaW5O6xOEP9toYf8JhLpELgiSH9NvN1cUYpCjY6s13eB/nI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722283797; c=relaxed/simple;
	bh=SMH/wjJdkKqqoXhP2lWenI2cXLnVEX6OydYP1oSDfvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atPQr9Z7utFMGCDn8RJKLG6Y8fj0j34NakvfpMzTJcZGaO9zC9LJl/RrJ3a1dFA+Y/4Jq3l1piuD3jUHUHhzmmX/Vavghz3XUxsI7a6C/PYMSsIk+RdYbZ+1mPUIg44mRpSNWbygrBapS7v+ym9YTjqQpulokDmjD9lyjYc2p0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23207 invoked by uid 109); 29 Jul 2024 20:09:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Jul 2024 20:09:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4287 invoked by uid 111); 29 Jul 2024 20:09:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Jul 2024 16:09:55 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Jul 2024 16:09:53 -0400
From: Jeff King <peff@peff.net>
To: Ryan Hendrickson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ryan Hendrickson <ryan.hendrickson@alum.mit.edu>
Subject: Re: [PATCH v2] http: do not ignore proxy path
Message-ID: <20240729200953.GB23714@coredump.intra.peff.net>
References: <pull.1767.git.1722009170590.gitgitgadget@gmail.com>
 <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1767.v2.git.1722062682858.gitgitgadget@gmail.com>

On Sat, Jul 27, 2024 at 06:44:42AM +0000, Ryan Hendrickson via GitGitGadget wrote:

>     Re earlier discussion about regressions, it turns out that curl has only
>     supported this syntax since 2022 [https://curl.se/ch/7.84.0.html].
>     Earlier versions of curl, if provided an http_proxy that contained a
>     path, would also ignore it. curl didn't seem to consider this a breaking
>     change when the feature was introduced
>     [https://github.com/curl/curl/pull/8668], though; is that a valid
>     argument for Git not to lose sleep over it either?

IMHO it is probably OK. The path did not do anything before then, so why
would anybody pass it?

Looking into the curl support, I did notice two things:

  - unix sockets are only supported for socks proxies. Is it meaningful
    to have a path on an http proxy? I don't think so (there is no place
    to send it in the "GET" line). But perhaps we should limit the new
    code only to socks.

  - curl says you should put "localhost" in the host field for this,
    though obviously it is not otherwise used. Should we likewise
    require that to kick in the code?

> @@ -1265,7 +1266,24 @@ static CURL *get_curl_handle(void)
>  		if (!proxy_auth.host)
>  			die("Invalid proxy URL '%s'", curl_http_proxy);
>  
> -		curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
> +		strbuf_addstr(&proxy, proxy_auth.host);
> +		if (proxy_auth.path) {

There's one gotcha here I wondered about: we usually throw away the path
element, unless credential.useHTTPPath is set. That only happens after
we load the per-credential config, though, via credential_apply_config(),
which in turn is triggered by a call to credential_fill(), etc.

I think this is OK here, since we have just called credential_from_url()
ourselves, and the earliest credential_fill() we'd hit is from
init_curl_proxy_auth(), which is called right after the code you're
touching.

> +			int path_is_supported = 0;
> +			/* curl_version_info was added in curl 7.10 */
> +#if LIBCURL_VERSION_NUM >= 0x070a00
> +			curl_version_info_data *ver = curl_version_info(CURLVERSION_NOW);
> +			path_is_supported = ver->version_num >= 0x075400;
> +#endif

We've been trying to keep our curl version #ifdefs in git-curl-compat.h,
with human-readable names. But in this case, I think we can ditch it
entirely, as we require curl 7.21.3 or later already.

This will be the first time we check curl_version_info() instead of a
build-time option. I think that makes sense here. Most features require
extra information at build-time (e.g., CURLOPT_* constants), but in this
case it is purely a check on the runtime behavior.

We perhaps could get away with just letting an older curl quietly ignore
the path field, but what you have here is probably a bit friendlier for
users.

> diff --git a/t/socks5-proxy-server/src/socks5.pl b/t/socks5-proxy-server/src/socks5.pl
> new file mode 100755
> index 00000000000..3ef66a1a287
> --- /dev/null
> +++ b/t/socks5-proxy-server/src/socks5.pl

This is a lot more code than I was hoping for. There are definitely
parts of it we don't care about (e.g, threading, handling multiple
connections at once) that could be pared down a bit. I don't think we
particularly care about auth either (we just want to make sure we talk
to the unix-socket proxy at all).

What if we switched to socks4, which drops all of the auth bits and
supports only IPs, not hostnames (that came in socks4a). This is the
shortest I could come up with (only lightly tested):

-- >8 --
use strict;
use IO::Select;
use IO::Socket::UNIX;
use IO::Socket::INET;

my $path = shift;

unlink($path);
my $server = IO::Socket::UNIX->new(Listen => 1, Local => $path)
	or die "unable to listen on $path: $!";

$| = 1;
print "ready to rumble\n";

while (my $client = $server->accept()) {
	sysread $client, my $buf, 8;
	my ($version, $cmd, $port, $ip) = unpack 'CCnN', $buf;
	next unless $version == 4; # socks4
	next unless $cmd == 1; # TCP stream connection

	# skip NUL-terminated id
	while (sysread $client, my $char, 1) {
		last unless ord($char);
	}

	# version(0), reply(5a == granted), port (ignored), ip (ignored)
	syswrite $client, "\x00\x5a\x00\x00\x00\x00\x00\x00";

	my $remote = IO::Socket::INET->new(PeerHost => $ip, PeerPort => $port)
		or die "unable to connect to $ip/$port: $!";

	my $io = IO::Select->new($client, $remote);
	while ($io->count) {
		for my $fh ($io->can_read(0)) {
			for my $pair ([$client, $remote], [$remote, $client]) {
				my ($from, $to) = @$pair;
				next unless $fh == $from;

				my $r = sysread $from, my $buf, 1024;
				if (!defined $r || $r <= 0) {
					$io->remove($from);
					next;
				}
				syswrite $to, $buf;
			}
		}
	}
}
-- >8 --

That's still more than I'd like, but quite a bit smaller. I dunno.
Probably the one you found is more battle-tested, but I really think we
have pretty simple requirements.

> diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
> index bb35b87071d..bafaa31adf8 100755
> --- a/t/t5564-http-proxy.sh
> +++ b/t/t5564-http-proxy.sh
> @@ -39,4 +39,22 @@ test_expect_success 'clone can prompt for proxy password' '
>  	expect_askpass pass proxuser
>  '
>  
> +start_socks() {
> +	# The %30 tests that the correct amount of percent-encoding is applied
> +	# to the proxy string passed to curl.
> +	"$PERL_PATH" "$TEST_DIRECTORY/socks5-proxy-server/src/socks5.pl" \
> +		"$TRASH_DIRECTORY/%30.sock" proxuser proxpass &
> +	socks_pid=$!
> +}
> +
> +test_lazy_prereq LIBCURL_7_84 'expr x$(curl-config --vernum) \>= x075400'

This is the first time we'd be relying on curl-config in the test suite.
I suspect it would _usually_ work, but I'd worry about a few things:

  1. The Makefile allows for a different path for $(CURL_CONFIG), or
     even skipping it entirely by setting $(CURLDIR).

  2. We'd usually build and test in the same environment, but not
     necessarily. In particular, I know Windows uses separate CI jobs
     for this, and I'm not sure if curl-config will be around in the
     test jobs.

I can see two paths forward:

  a. There's been recent discussion about adding an option for Git to
     report the run-time curl version. That doesn't exist yet, though
     "git version --build-options" will report the build-time version.
     That might be good enough for the purposes of testing a build.

  b. Write the test such that it expects the request to work _or_ we see
     the "version too old" failure.

> +test_expect_success PERL,LIBCURL_7_84 'clone via Unix socket' '

I'm not sure if this PERL prereq is sufficient. We also need to know
that we can make unix sockets. Probably we need to actually run the
socks proxy and make sure it gets to the "starting..." line before
accepting that it works. Which also gets us to...

> +	start_socks &&
> +	test_when_finished "rm -rf clone && kill $socks_pid" &&
> +	test_config_global http.proxy "socks5://proxuser:proxpass@localhost$PWD/%2530.sock" &&
> +	GIT_TRACE_CURL=$PWD/trace git clone "$HTTPD_URL/smart/repo.git" clone &&

This is racy. We started the proxy in the background, but we don't know
that it's ready to accept connections by the time we run "git clone". My
first few runs all failed, but putting a "sleep 1" in between fixed it
(which obviously is not a real fix, but just a debugging aid).

If you usually see success, try running the test script with "--stress"
to create extra load, and you should see failures.

The usual trick here is to start the process in the background, and then
in the foreground wait for some "I'm ready" output, which involves ugly
tricks with fifos. There's prior art in lib-git-daemon.sh (though it's a
little more complicated there, because we want to relay its stderr, too,
but with a script under our control we can just put the ready message on
stdout).

So coupled with the prereq fix that I mentioned above, you might be able
to do something like (totally untested):

  start_socks_proxy () {
	mkfifo socks_output &&
	{
		perl proxy.pl ... >socks_output &
		socks_pid=$!
	} &&
	read line <socks_output &&
	test "$line" = "Starting..."
  }

  test_expect_success 'try to start socks proxy' '
	if start_socks_proxy
	then
		test_seq_prereq SOCKS_PROXY
	fi
  '

  test_expect_success SOCKS_PROXY 'clone via unix socket' '
	...
  '

-Peff
