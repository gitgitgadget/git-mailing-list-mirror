From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Sat, 13 Feb 2016 12:44:50 -0500
Message-ID: <20160213174449.GH30144@sigill.intra.peff.net>
References: <1455373456-64691-1-git-send-email-larsxschneider@gmail.com>
 <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Sat Feb 13 18:45:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUeGF-0004oQ-Ta
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 18:45:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbcBMRox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2016 12:44:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:41575 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750879AbcBMRow (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 12:44:52 -0500
Received: (qmail 10151 invoked by uid 102); 13 Feb 2016 17:44:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:44:52 -0500
Received: (qmail 27106 invoked by uid 107); 13 Feb 2016 17:44:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 12:44:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 12:44:50 -0500
Content-Disposition: inline
In-Reply-To: <1455373456-64691-4-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286121>

On Sat, Feb 13, 2016 at 03:24:16PM +0100, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> If config values are queried using 'git config' (e.g. via --get,
> --get-all, --get-regexp, or --list flag) then it is sometimes hard to
> find the configuration file where the values were defined.
> 
> Teach 'git config' the '--show-origin' option to print the source
> configuration file for every printed value.

Thanks, I think this version fixes the correctness issues I mentioned
earlier. I do still have nits to pick (of course :) ), that we may or
may not want to deal with.

> +static void show_config_origin(struct strbuf *buf)
> +{
> +	const char term = end_null ? '\0' : '\t';
> +	const char *type;
> +	const char *name;
> +
> +	current_config_type_name(&type, &name);

This double out-parameter feels like a clunky interface.

I was tempted to suggest that we simply make the "struct config_source"
available to builtin/config.c (which is already pretty intimate with the
rest of the config code), and then it can pick out what it wants. But
there _is_ some logic in the function to convert the NULL "cf" into
"cmdline".

Perhaps it would be simpler to just have two accessor functions, and do:

  strbuf_addstr(buf, current_config_type());
  ...
  strbuf_addstr(buf, current_config_name());

I admit it is a pretty minor point, though.

>  static int show_all_config(const char *key_, const char *value_, void *cb)
>  {
> +	if (show_origin) {
> +       struct strbuf buf = STRBUF_INIT;
> +       show_config_origin(&buf);
> +       fwrite(buf.buf, 1, buf.len, stdout);
> +       strbuf_release(&buf);
> +	}

The indentation is funky here.

The use of fwrite() to catch the embedded NULs is subtle enough that it
might be worth a comment.

It also made me wonder how format_config() handles this. It looks like
we send the result eventually to fwrite() there, so it all works (and it
does _not_ have the comment I mentioned :) ).

> +test_expect_success '--show-origin' '
> +	>.git/config &&
> +	>"$HOME"/.gitconfig &&
> +	INCLUDE_DIR="$HOME/include" &&
> +	mkdir -p "$INCLUDE_DIR" &&
> +	cat >"$INCLUDE_DIR"/absolute.include <<-EOF &&
> +		[user]
> +			absolute = include
> +	EOF
> +	cat >"$INCLUDE_DIR"/relative.include <<-EOF &&
> +		[user]
> +			relative = include
> +	EOF
> +	test_config_global user.global "true" &&
> +	test_config_global user.override "global" &&
> +	test_config_global include.path "$INCLUDE_DIR"/absolute.include &&
> +	test_config include.path ../include/relative.include &&
> +	test_config user.local "true" &&
> +	test_config user.override "local" &&
> +
> +	cat >expect <<-EOF &&
> +		file:$HOME/.gitconfig	user.global=true
> +		file:$HOME/.gitconfig	user.override=global
> +		file:$HOME/.gitconfig	include.path=$INCLUDE_DIR/absolute.include
> +		file:$INCLUDE_DIR/absolute.include	user.absolute=include
> +		file:.git/config	include.path=../include/relative.include
> +		file:.git/../include/relative.include	user.relative=include
> +		file:.git/config	user.local=true
> +		file:.git/config	user.override=local
> +		cmdline:	user.cmdline=true
> +	EOF
> +	git -c user.cmdline=true config --list --show-origin >output &&
> +	test_cmp expect output &&
> +
> +	cat >expect <<-EOF &&
> +		file:$HOME/.gitconfigQuser.global
> +		trueQfile:$HOME/.gitconfigQuser.override
> +		globalQfile:$HOME/.gitconfigQinclude.path
> +		$INCLUDE_DIR/absolute.includeQfile:$INCLUDE_DIR/absolute.includeQuser.absolute
> +		includeQfile:.git/configQinclude.path
> +		../include/relative.includeQfile:.git/../include/relative.includeQuser.relative
> +		includeQfile:.git/configQuser.local
> +		trueQfile:.git/configQuser.override
> +		localQcmdline:Quser.cmdline
> +		trueQ
> +	EOF

I see you split this up more, but there's still quite a bit going on in
this one block. IMHO, it would be more customary in our tests to put the
setup into one test_expect_success block, then each of these
expect-run-cmp blocks into their own test_expect_success.

It does mean that the setup mutates the global test state for further
tests (and you should stop using test_config_*, which clean up at the
end of the block), but I think that's the right thing here. The point of
test_config is "flip on this switch just for a moment, so we can test
its effect without hurting further tests". But these are config tests in
the first place, and it is OK for them to show a progression of
mutations of the config (you'll note that like the other tests in this
script, you are clearing out .git/config in the first place).

-Peff
