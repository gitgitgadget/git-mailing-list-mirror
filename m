From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] parse the -L options
Date: Tue, 13 Jul 2010 16:03:14 -0700
Message-ID: <7vbpab2de5.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-5-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYoVc-0007SY-6q
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab0GMXDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:03:23 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151Ab0GMXDW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:03:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C073C3539;
	Tue, 13 Jul 2010 19:03:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U6e7L8R2ZXyVaxKOfFL0ZncjYyk=; b=iJR3af
	KAsaLxTO6XaWixa/s+EXsPstyH07lpttOqBBDqfN3eCKGjN7Up5KUzrl1VCbfZIY
	a5Qe37C11o60lWCeLPNrtx/hPB0xcF1PM7pgma3bAPOrh/5DdtkXki0uyiv8U0Bc
	ZLLFghAPdcdGl7zT3o48JhbaEQPHFcdVhGbgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wEXWAxzAqG7l8NIDdlp9WXPNH+gnQjqc
	st7QjlkN6BmyhxAYqSkdJn56P7ETvhjK1M0jMMf5VOwSXqMKa3g4yYzSaxtDNjcF
	lFfYRusaf1e/kEmPTp3ifVXC33sSMbjDocj8SjVCw+GwdPAn84OAAO4OOeRpApGy
	nmGxgb6wcJs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6951AC3538;
	Tue, 13 Jul 2010 19:03:19 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 730CBC3532; Tue, 13 Jul
 2010 19:03:16 -0400 (EDT)
In-Reply-To: <1278829141-11900-5-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sun\, 11 Jul 2010 14\:18\:53 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D3E752FA-8ED2-11DF-9EF6-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150937>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +static int log_line_range_callback(const struct option *option, const char *arg, int unset)
> +{
> +	struct line_opt_callback_data *data = option->value;
> +	struct diff_line_range *r = *data->range;
> +	struct parse_opt_ctx_t *ctx = data->ctx;

Need a blank line here for readability.

> +	if (!arg)
> +		return -1;
> ...
> @@ -75,6 +118,58 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
>  	 */
>  	if (argc == 2 && !strcmp(argv[1], "-h"))
>  		usage(builtin_log_usage);
> +
> +	parse_options_start(&ctx, argc, argv, prefix, PARSE_OPT_KEEP_DASHDASH |
> +			PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_STOP_AT_NON_OPTION);
> +	for (;;) {
> +		switch (parse_options_step(&ctx, options, log_opt_usage)) {
> +		case PARSE_OPT_HELP:
> +			exit(129);
> +		case PARSE_OPT_DONE:
> +			goto parse_done;
> +		case PARSE_OPT_NON_OPTION:
> +			path = parse_options_current(&ctx);
> +			pathspec = prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
> +			range->spec = alloc_filespec(pathspec);
> +			free((void *)pathspec);
> +			if (range->nr == 0) {
> +				if(range->next) {
> +					die("Path %s need a -L <range> option\n"
> +					"If you want follow the history of the whole file "
> +					"whether to using 'git log' without -L or using "
> +					"'git log -L 1,$ <path>'", range->spec->path);
> +				} else {
> +					parse_options_next(&ctx, 1);
> +					continue;

This loop smells bad.

When "-L n,m" appears on the command line, log_line_range_callback() would
be called and would eat n,m (which is correct), but at that point you
would not just want to be prepared to accept a non-option ("path" in "-L
n,m path"), but actually would want to force the user to give a path, no?
IOW, isn't "git log -L n,m -U20" an error, unless "-U20" is a filename
that the user wants to track?

I somehow suspect that futzing with STOP_AT_NON_OPTION (done in the first
two patches in the series) to parse "-L n,m path" is a misguided design
attempt.  Shouldn't you be instead giving a support for option callback to
take more than one argument to do this?

> +				}
> +			}
> +			struct diff_line_range *r = xmalloc(sizeof(*r));

decl-after-statement, but at this point it may be moot as I am doubting
the higher-level design of this option parser now.
