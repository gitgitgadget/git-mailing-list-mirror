Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2C62018A
	for <e@80x24.org>; Tue, 28 Jun 2016 20:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbcF1UuF (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 16:50:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37242 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752165AbcF1UuE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 16:50:04 -0400
Received: (qmail 3286 invoked by uid 102); 28 Jun 2016 20:50:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 16:50:03 -0400
Received: (qmail 12256 invoked by uid 107); 28 Jun 2016 20:50:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Jun 2016 16:50:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Jun 2016 16:49:59 -0400
Date:	Tue, 28 Jun 2016 16:49:59 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	sschuberth@gmail.com
Subject: Re: [PATCH v2 2/2] config: add conditional include
Message-ID: <20160628204959.GB21002@sigill.intra.peff.net>
References: <20160626070617.30211-1-pclouds@gmail.com>
 <20160628172641.26381-1-pclouds@gmail.com>
 <20160628172641.26381-3-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160628172641.26381-3-pclouds@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 28, 2016 at 07:26:41PM +0200, Nguyễn Thái Ngọc Duy wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 58673cf..c8ad0bf 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -91,6 +91,46 @@ found at the location of the include directive. If the value of the
>  relative to the configuration file in which the include directive was
>  found.  See below for examples.
>  
> +Included files can be grouped into subsections where subsectino name
> +is the condition when the files are included. The condition starts
> +with an condition type string, followed by a colon and a pattern.

s/subsectino/subsection/
s/an condition/a condition/

I think the first sentence may parse more easily as:

  Included files can be grouped into subsections, where the subsection
  name is a condition that must be met for the files to be included.

I wonder if it would make more sense to refer to "condition type string"
as a "condition keyword" or something.

I think we should probably also claim only that the bit to the right of
the colon is keyword-specific data. For some conditions it will not be a
glob, and may not even be a pattern at all. And then each keyword can
describe its syntax (we may end up wanting to factor out the particular
set of rules, but I think that can wait until we have a second keyword
that uses them).

> +Only "gitdir" type is supported, where files are included if
> +`$GIT_DIR` matches the specified pattern. For example,

Maybe start this as a list like:

    The currently supported keywords are:

    `gitdir`::
    ...

to make it clear that the "only" is potentially temporary. We should
probably also document that unknown keywords are always treated as
false.

> + * If the pattern starts with `~/`, `~` will be substitued with the
> +   environment variable `HOME`.

s/substitued/substituted/

> + * If the pattern starts with `./`, it is replaced with the directory
> +   where the current config file is. For example if the config file

Perhaps replace "directory where the current config file is" with
"directory containing the current config file". Also, perhaps "config
file that contains the include directive" is more descriptive than
"current" (we use similar language when describing relative include
paths).

> +static int prepare_include_condition_pattern(struct strbuf *pat)
> +{
> +	struct strbuf path = STRBUF_INIT;
> +	int prefix = 0;
> +
> +	/* TODO: maybe support ~user/ too */
> +	if (pat->buf[0] == '~' && is_dir_sep(pat->buf[1])) {
> +		const char *home = getenv("HOME");
> +
> +		if (!home)
> +			return error(_("$HOME is not defined"));
> +
> +		strbuf_add_absolute_path(&path, home);
> +		strbuf_splice(pat, 0, 1, path.buf, path.len);
> +		prefix = path.len + 1 /*slash*/;

Why did you drop expand_user_path() here?

I guess it's to do with knowing the length of the prefix portion? I'm
not sure I understand why the prefix is necessary. I thought the goal
was to construct a wildmatch pattern that could be used against
get_git_dir().

> +static int include_condition_is_true(const char *cond, int cond_len)
> +{
> +	const char *value;
> +	size_t value_len;
> +
> +	/* no condition (i.e., "include.path") is always true */
> +	if (!cond)
> +		return 1;
> +
> +	if (skip_prefix_mem(cond, cond_len, "gitdir:", &value, &value_len)) {

It's not wrong to use extra variables, but it's safe to feed the
originals, like:

  if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))

The variables are guaranteed to be untouched if we didn't match (so your
error() below is fine).

-Peff
