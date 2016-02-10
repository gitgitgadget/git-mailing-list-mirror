From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: add '--sources' option to print the source of
 a config value
Date: Wed, 10 Feb 2016 07:54:30 -0500
Message-ID: <20160210125429.GA8078@sigill.intra.peff.net>
References: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, sschuberth@gmail.com
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Wed Feb 10 13:54:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTUI3-0005Hs-F1
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 13:54:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbcBJMyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 07:54:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:39695 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751014AbcBJMye (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 07:54:34 -0500
Received: (qmail 26078 invoked by uid 102); 10 Feb 2016 12:54:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 07:54:34 -0500
Received: (qmail 27377 invoked by uid 107); 10 Feb 2016 12:54:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Feb 2016 07:54:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Feb 2016 07:54:30 -0500
Content-Disposition: inline
In-Reply-To: <1455099198-11515-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285898>

On Wed, Feb 10, 2016 at 11:13:18AM +0100, larsxschneider@gmail.com wrote:

> diff to v1:
> 
> * add documention
> * produce a consistent (tab-delimited) format that can be parsed
> * adhere declaration-after-statement style
> * prefix every source line with the source type (file, stdin, blob, cmd)
> * add relative path test case
> * add blob ref test case
> * add "git config --local" test case (Note: I think I found a bug there that I
>   plan to fix/investigate in a seperate patch. Is it ok to leave the TODO?)
> * add a test case to check funny character escapes (file name with tabs)
> 
> Sebastian suggested "--show-origin" as a better option name over "--sources".
> I still believe "--sources" might be slightly better as I fear that users could
> somehow related "origin" to "remote" kind of configs. However, I am happy to
> change that if a majority prefers "--show-origin".

Thanks, this is getting closer, but I still have a few comments.

> @@ -194,6 +194,11 @@ See also <<FILES>>.
>  	Output only the names of config variables for `--list` or
>  	`--get-regexp`.
> 
> +--sources::
> +	Augment the output of all queried config options with the
> +	source type (file, stdin, blob, cmd) and the actual source
> +	(config file path, ref, or blob id if applicable).

I think something like "cmdline" might be more descriptive than "cmd".
Technically such options could also come from the environment (as "-c"
is really just a shorthand for modifying the environment), but I don't
think we actually advertise that.

> +/* output to either fp or buf; only one should be non-NULL */
> +static void show_config_source(struct strbuf *buf, FILE *fp)
> +{
> +	char term = '\t';
> +	char *prefix;
> +	const char *fn = current_config_filename();

A minor nit, but I think our discussion has shown that this function
does not strictly return filenames. We might just want s/filename/name/.

But moreover...

> +	if (end_null)
> +		term = '\0';
> +
> +	if (fn) {
> +		if (given_config_source.use_stdin)
> +			prefix = "stdin";
> +		else if (given_config_source.blob)
> +			prefix = "blob";
> +		else
> +			prefix = "file";
> +	} else {
> +		fn = "";
> +		prefix = "cmd";
> +	}

I don't think this is quite right. "fn" represents the current file we
happen to be parsing, but given_config_source is where we _started_. So
here's a fairly pathological example that shows the distinction:

  echo "[include]path=/home/peff/.gitconfig" |
  git config --sources --includes --file - user.name

which produces:

  stdin   /home/peff/.gitconfig   Jeff King

So I think we really need to record this source information in the
config_source of config.c and feed it back via current_config_filename(),
whose name grows even more inaccurate. :)

> +	if (fp)
> +		fprintf(fp, "%s", prefix);
> +	else {
> +		strbuf_addstr(buf, prefix);
> +	}
> +
> +	if (fp)
> +		fputc(term, fp);
> +	else
> +		strbuf_addch(buf, term);

So the format here is like:

  file\t<filename>\t<value...>
  blob\t<blob>\t<value...>
  stdin\t\t<value...>
  cmd\t\t<value...>

where two of the prefixes have nothing in the second slot. I expected
something more like:

  file:<filename>\t</value...>
  blob:<blob>\t<value...>
  stdin\t<value...>
  cmd\t<value...>

with a single delimited slot for the source, which can then be broken
down further if desired.  I can't think of any reason to prefer one over
the other rather than personal preference, though. They can both be
parsed unambiguously.

> +
> +	is_query_action = actions & (
> +		ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST
> +	);
> +
> +	if (show_sources && !is_query_action) {
> +		error("--sources is only applicable to --list or --get-* actions");
> +		usage_with_options(builtin_config_usage, builtin_config_options);
> +	}

This means that "git config --sources --get-colorbool" will tell the
user that --sources is only applicable to --get-* actions, which is what
they said. I wonder if we should simply enumerate the cases where it
works.

I also wonder if "is_query_action" is worth the separate variable, since
it is no longer quite accurate (it is really "query actions that support
--sources", and I would not want somebody coming along later to treat it
as "any query action").

> @@ -1078,7 +1078,7 @@ static int do_config_from_file(config_fn_t fn,
> 
>  static int git_config_from_stdin(config_fn_t fn, void *data)
>  {
> -	return do_config_from_file(fn, "<stdin>", NULL, stdin, data);
> +	return do_config_from_file(fn, "", NULL, stdin, data);
>  }

I think this is a regression for the other uses of the name "name"
field. Before your patch:

  $ echo '[broken' | git config --list --file -
  fatal: bad config file line 1 in <stdin>

And after it just says:

  fatal: bad config file line 1 in 

This should be fixed for free along with the source stuff I mentioned
above, though.

> +	# TODO:
> +	# The locally included config value is not printed below. I think
> +	# this is a bug.
> +	# "file	.git/../include/relative.include	user.relative=include"
> +	#
> +	cat >expect <<-EOF &&
> +		file	.git/config	include.path=../include/relative.include
> +		file	.git/config	user.local=true
> +		file	.git/config	user.override=local
> +		EOF
> +	git config --local --list --sources >output &&
> +	test_cmp expect output &&

This is behaving as expected. By default "--include" is off when reading
a specific config file (triggered by your "--local"), and on when
generically reading all config.

> +	cat >expect <<-EOF &&
> +		file	$HOME/.gitconfig	user.global true
> +		file	.git/config	user.local true
> +	EOF
> +	git config --sources --get-regexp "user\.[g|l].*" >output &&
> +	test_cmp expect output &&
> +
> +	cat >expect <<-EOF &&
> +		file	.git/config	local
> +	EOF
> +	git config --sources user.override >output &&
> +	test_cmp expect output &&

There are quite a lot of separate things tested here all in a single
test_expect_success. If you break each of these out into their own
test_expect_success blocks, it is much easier for somebody to diagnose a
failing test. They immediately know _which_ block failed, and if you
have written a description, then they know what the test was trying to
do.

> +	cat >expect <<-EOF &&
> +		file	"file\\\twith\\\ttabs.conf"	user.custom=true
> +	EOF

If you escape the here-doc marker, it turns off interpolation, and you
can avoid the extra layer of backslash quoting. Like:

        cat >expect <<-\EOF
		file	"file\twith\ttabs.conf"	user.custom = true
	EOF

In fact, we generally prefer to use non-interpolated here-docs unless
you actually intend to expand anything. It's one less thing for a reader
of the code to have to worry about.

-Peff
