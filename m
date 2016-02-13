From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Sat, 13 Feb 2016 13:15:29 -0500
Message-ID: <20160213181529.GB9516@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
 <20160213174449.GH30144@sigill.intra.peff.net>
 <20160213180412.GA9516@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 19:15:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUejK-0008O6-04
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 19:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbcBMSPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 13:15:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:41595 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751182AbcBMSPc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 13:15:32 -0500
Received: (qmail 11603 invoked by uid 102); 13 Feb 2016 18:15:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:15:31 -0500
Received: (qmail 27230 invoked by uid 107); 13 Feb 2016 18:15:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:15:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 13:15:29 -0500
Content-Disposition: inline
In-Reply-To: <20160213180412.GA9516@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286123>

On Sat, Feb 13, 2016 at 01:04:12PM -0500, Jeff King wrote:

> On Sat, Feb 13, 2016 at 12:44:49PM -0500, Jeff King wrote:
> 
> > > +test_expect_success '--show-origin' '
> > [...]
> > I see you split this up more, but there's still quite a bit going on in
> > this one block. IMHO, it would be more customary in our tests to put the
> > setup into one test_expect_success block, then each of these
> > expect-run-cmp blocks into their own test_expect_success.
> 
> Here's a squashable patch that shows what I mean.

And here are a few comments on the changes...

> -test_expect_success '--show-origin' '
> -	>.git/config &&
> -	>"$HOME"/.gitconfig &&
> +test_expect_success 'set up --show-origin tests' '
>  	INCLUDE_DIR="$HOME/include" &&
>  	mkdir -p "$INCLUDE_DIR" &&
> -	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
> +	cat >"$INCLUDE_DIR"/absolute.include <<-\EOF &&
>  		[user]
>  			absolute = include
>  	EOF
> -	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
> +	cat >"$INCLUDE_DIR"/relative.include <<-\EOF &&
>  		[user]
>  			relative = include
>  	EOF
> -	test_config_global user.global "true" &&
> -	test_config_global user.override "global" &&
> -	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
> -	test_config include.path ../include/relative.include &&
> -	test_config user.local "true" &&
> -	test_config user.override "local" &&
> +	cat >"$HOME"/.gitconfig <<-EOF &&
> +		[user]
> +			global = true
> +			override = global
> +		[include]
> +			path = "$INCLUDE_DIR/absolute.include"
> +	EOF
> +	cat >.git/config <<-\EOF
> +		[include]
> +			path = ../include/relative.include
> +		[user]
> +			local = true
> +			override = local
> +	EOF

I preserved your ordering here (as the later "--list" tests care). But
it might be worth ordering both files the same way, so that a reader
does not wonder if it is significant (and just update the --list
output expectation later).

> @@ -1253,25 +1263,32 @@ test_expect_success '--show-origin' '
>  		localQcmdline:Quser.cmdline
>  		trueQ
>  	EOF
> -	git -c user.cmdline=true config --null --list --show-origin | nul_to_q >output &&
> +	git -c user.cmdline=true config --null --list --show-origin >output.raw &&
> +	nul_to_q <output.raw >output &&

We usually try to avoid putting git on the left-hand side of a pipe,
because it hides the exit code, and we want to make sure git does not
fail. I won't be surprised if you copied the style from elsewhere in the
script, though, as this is an old one and we were not always consistent.

>  	echo >>output &&
> -	test_cmp expect output &&
> +	test_cmp expect output

This "echo" might be worth a comment. I think we are just adding the
extra newline that the here-doc insists on, but that --null output would
not include.

Overall, I find the "--show-origin --null" output pretty weird to read.
We use a newline to split the config key/value, a NUL between config
entries, but now also a NUL between the filename and the rest of the
config entry.

That makes parsing pretty weird, as you cannot just use something like

  git config --show-origin --list --null | perl -0ne ...

to process entries; every other entry you get will be a filename. But at
the same time, we do not go all out and say "there is a NUL between each
field", because the key/value separator is a newline in this case, and
the reader has to parse that separately after splitting on NULs.

But I think it's too late to do anything about it now. The weirdness is
really the mixed NUL/newline thing, and you are not introducing that.

> -CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
> -cat >"$CUSTOM_CONFIG_FILE" <<-\EOF &&
> -	[user]
> -		custom = true
> -EOF
> +test_expect_success 'set up custom config file' '
> +	CUSTOM_CONFIG_FILE="file\twith\ttabs.conf" &&
> +	cat >"$CUSTOM_CONFIG_FILE" <<-\EOF
> +		[user]
> +			custom = true
> +	EOF
> +'

Everything, even mundane setup, should generally go in a test_expect
block. That means we'll notice unexpected failures, and any output will
follow the usual "--verbose" rules.

Arguably this setup could just go into the initial setup block.

Also, you may not that the filename does _not_ actually have tabs in it,
because the shell does not expand "\t". It does have backslashes in it,
though, which is enough to trigger our C-style quoting.

So the test isn't wrong, but the filename is misleading. If you really
want tabs, you'd have to do:

  CUSTOM_CONFIG_FILE="$(printf "file\twith\ttabs.conf")

or similar.

>  test_expect_success '--show-origin escape special file name characters' '
>  	cat >expect <<-\EOF &&
> @@ -1302,8 +1321,6 @@ test_expect_success '--show-origin stdin' '
>  '
>  
>  test_expect_success '--show-origin stdin with file include' '
> -	INCLUDE_DIR="$HOME/include" &&
> -	mkdir -p "$INCLUDE_DIR" &&
>  	cat >"$INCLUDE_DIR"/stdin.include <<-EOF &&
>  		[user]
>  			stdin = include

Here we can assume that the setup block succeeded (if it didn't, all of
the tests are screwed anyway, so you'd want to fix that first).

-Peff
