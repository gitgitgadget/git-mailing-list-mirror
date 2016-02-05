From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Fri, 5 Feb 2016 06:20:01 -0500
Message-ID: <20160205112001.GA13397@sigill.intra.peff.net>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 05 12:20:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aReRM-0004Uw-LY
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 12:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbcBELUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 06:20:36 -0500
Received: from cloud.peff.net ([50.56.180.127]:38065 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751315AbcBELUE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 06:20:04 -0500
Received: (qmail 3724 invoked by uid 102); 5 Feb 2016 11:20:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 06:20:04 -0500
Received: (qmail 13177 invoked by uid 107); 5 Feb 2016 11:20:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 06:20:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 06:20:01 -0500
Content-Disposition: inline
In-Reply-To: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285568>

On Fri, Feb 05, 2016 at 09:42:30AM +0100, larsxschneider@gmail.com wrote:

> @@ -538,6 +569,17 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		error("--name-only is only applicable to --list or --get-regexp");
>  		usage_with_options(builtin_config_usage, builtin_config_options);
>  	}
> +
> +	const int is_query_action = actions & (
> +		ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST|
> +		ACTION_GET_COLOR|ACTION_GET_COLORBOOL|ACTION_GET_URLMATCH
> +	);
> +
> +	if (show_sources && !is_query_action) {
> +		error("--sources is only applicable to --list or --get-* actions");
> +		usage_with_options(builtin_config_usage, builtin_config_options);
> +	}

Hmm. I had originally envisioned this only being used with "--list", but
I guess it makes sense to say "--sources --get" to show where the value
for a particular option is coming from.

The plural "sources" is a little funny there, though, as we list only
the "last one wins" final value, not all of them (for that, you can use
"--sources --get-all", which seems handy). I think it would be
sufficient for the documentation to make this clear (speaking of which,
this patch needs documentation...).

Also, I don't think the feature works with --get-color, --get-colorbool,
or --get-urlmatch (which don't do their output in quite the same way).
I think it would be fine to simply disallow --sources with those options
rather than worry about making it work.

> +/* output to either fp or buf; only one should be non-NULL */
> +static void show_config_source(struct strbuf *buf, FILE *fp)
> +{
> +	const char *fn = current_config_filename();
> +	if (!fn)
> +		return;

I'm not sure returning here is the best idea. We won't have a config
filename if we are reading from "-c", but if we return early from this
function, it parses differently than every other line. E.g., with your
patch, if I do:

  git config -c foo.bar=true config --sources --list

I'll get:

  /home/peff/.gitconfig <tab> user.name=Jeff King
  /home/peff/.gitconfig <tab> user.email=peff@peff.net
  ...etc...
  foo.bar=true

If somebody is parsing this as a tab-delimited list, then instead of the
source field for that line being empty, it is missing (and it looks like
"foo.bar=true" is the source file). I think it would be more friendly to
consumers of the output to have a blank (i.e., set "fn" to the empty
string and continue in the function).

> +
> +	char term = '\t';

This declaration comes after the "if" above, but git style doesn't allow
declaration-after-statement (to support ancient compilers).

> +test_expect_success '--sources' '
> +	>.git/config &&
> +	>"$HOME"/.gitconfig &&
> +	INCLUDE_DIR="$HOME/include" &&
> +	mkdir -p "$INCLUDE_DIR" &&
> +	cat >"$INCLUDE_DIR"/include.conf <<-EOF &&
> +		[user]
> +			include = true
> +	EOF
> +	cat >"$HOME"/file.conf <<-EOF &&
> +		[user]
> +			custom = true
> +	EOF
> +	test_config_global user.global "true" &&
> +	test_config_global user.override "global" &&
> +	test_config_global include.path "$INCLUDE_DIR"/include.conf &&

Here you include the file by its absolute path. I wondered what would
happen if we used a relative path. E.g.:

  git config include.path=foo
  git config -f .git/foo included.config=true
  git config --sources --list

which shows it as ".git/foo", because we resolved it by manipulating the
relative path ".git/config". Whereas including it from ~/.gitconfig will
show the absolute path, because we use the absolute path to get to
~/.gitconfig in the first place.

I think that's all sane. I don't know if it's worth noting it in the
documentation or not.

> +	cat >expect <<-EOF &&
> +		$HOME/.gitconfig	user.global=true
> +		$HOME/.gitconfig	user.override=global
> +		$HOME/.gitconfig	include.path=$INCLUDE_DIR/include.conf
> +		$INCLUDE_DIR/include.conf	user.include=true
> +		.git/config	user.local=true
> +		.git/config	user.override=local
> +		user.cmdline=true
> +	EOF

If the filename has funny characters (e.g., a literal tab), it will be
quoted here (but not in the --null output below). Worth including in the
test?

> +	cat >expect <<-EOF &&
> +		.git/config	local
> +	EOF
> +	git config --sources user.override >output &&
> +	test_cmp expect output &&

Good thoroughness in checking the override case.

> +	cat >expect <<-EOF &&
> +		a9d9f9e555b5c6f07cbe09d3f06fe3df11e09c08	user.custom=true
> +	EOF
> +	blob=$(git hash-object -w "$HOME"/file.conf) &&
> +	git config --blob=$blob --sources --list >output &&
> +	test_cmp expect output

This one was unexpected to me, but I think it makes sense. The option is
"--sources" and not "--source-filenames", after all. It's probably worth
mentioning in the documentation.

I think we also use the original name given, so if there was ref
resolution, you would see the ref name. Might be worth testing that.

-Peff
