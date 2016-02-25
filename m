From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] git: submodule honor -c credential.* from command line
Date: Wed, 24 Feb 2016 20:41:49 -0500
Message-ID: <20160225014149.GA31616@sigill.intra.peff.net>
References: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 02:41:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYkwJ-0008S8-2y
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 02:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870AbcBYBlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 20:41:53 -0500
Received: from cloud.peff.net ([50.56.180.127]:48678 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbcBYBlx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 20:41:53 -0500
Received: (qmail 4708 invoked by uid 102); 25 Feb 2016 01:41:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 20:41:52 -0500
Received: (qmail 13720 invoked by uid 107); 25 Feb 2016 01:42:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 20:42:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 20:41:49 -0500
Content-Disposition: inline
In-Reply-To: <1456358352-28939-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287300>

On Wed, Feb 24, 2016 at 03:59:12PM -0800, Jacob Keller wrote:

> +int sanitize_submodule_config(const char *var, const char *value, void *data)
> +{
> +	struct strbuf quoted = STRBUF_INIT;
> +	struct strbuf *out = data;
> +
> +	if (submodule_config_ok(var)) {
> +		if (out->len)
> +			strbuf_addch(out, ' ');
> +
> +		/* combined all the values before we quote them */
> +		strbuf_addstr(&quoted, var);
> +		strbuf_addch(&quoted, '=');
> +		strbuf_addstr(&quoted, value);
> +
> +		/* safely quote them for shell use */
> +		sq_quote_buf(out, quoted.buf);
> +	}
> +	return 0;
> +}

This leaks "quoted", doesn't it?

I was confused by the "combine all the values" comment. We just have
_one_ config key/value here, right (I had thought originally that you
were putting multiple keys into a single sq-quoted string, which would be
wrong)?

I agree with Eric, though, that you could just drop the comment
entirely.

> +static int module_sanitize_config(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf sanitized_config = STRBUF_INIT;
> +
> +	struct option module_sanitize_config_options[] = {
> +		OPT_END()
> +	};
> +
> +	const char *const git_submodule_helper_usage[] = {
> +		N_("git submodule--helper sanitize-config"),
> +		NULL
> +	};
> +
> +	argc = parse_options(argc, argv, prefix, module_sanitize_config_options,
> +			     git_submodule_helper_usage, 0);
> +
> +	git_config_from_parameters(sanitize_submodule_config, &sanitized_config);
> +	if (sanitized_config.len)
> +		printf("%s\n", sanitized_config.buf);
> +
> +	return 0;
> +}

The empty option list looked funny to me for a minute, but I guess you
use it to complain about:

  git submodule--helper sanitize-config --foo

Should we also warn about:

  git submodule--helper sanitize-config foo

I think you could catch both with just:

  if (argc > 1)
	usage(...);

(though I do not mind the empty option list staying in that case, as it
provides the necessary boilerplate for later).

> +# Sanitize the local git environment for use within a submodule. We
> +# can't simply use clear_local_git_env since we want to preserve some
> +# of the settings from GIT_CONFIG_PARAMETERS.
> +sanitize_local_git_env()
> +{
> +	local sanitized_config = $(git submodule--helper sanitize-config)
> +	clear_local_git_env
> +	GIT_CONFIG_PARAMETERS=$sanitized_config
> +}

Do we need to export GIT_CONFIG_PARAMETERS? I guess not; if it is
already exported, we don't need, and if it isn't, then by definition
$sanitized_config will be empty.

The name of this function isn't very descriptive (it's easy to see what
it does from the implementation, but in the callers, it's unclear what
the difference between "clear" and "sanitize" is). Should it maybe be
"sanitize_submodule_env" or something to make it clear that this is
about passing through things for child submodules?

Probably not that big a deal as its local to this script

> diff --git a/t/t7412-submodule--helper.sh b/t/t7412-submodule--helper.sh
> new file mode 100755
> index 000000000000..376f58afe967
> --- /dev/null
> +++ b/t/t7412-submodule--helper.sh

In the long run I think we want to kill off submodule--helper, as it's
just an implementation detail until git-submodule is all in C. I do not
mind these tests in the meantime, as they can act as unit tests. But it
would be nice to also (or instead, if you like) test the actual
user-visible effects. Otherwise, once git-submodule turns into C, these
behaviors are likely to end up completely untested (and it's during that
conversion that you you're most likely to run into regressions!).

-Peff
