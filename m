From: Jeff King <peff@peff.net>
Subject: Re: git submodule should honor "-c credential.helper" command line
 argument
Date: Fri, 19 Feb 2016 02:46:33 -0500
Message-ID: <20160219074633.GA780@sigill.intra.peff.net>
References: <56B0E3AA.30804@syntevo.com>
 <20160203042554.GA21179@sigill.intra.peff.net>
 <CA+P7+xpGTvbyLOKQ=DHFBLOuVNN8WocraaZQhFD36oDiFrY+sA@mail.gmail.com>
 <CA+P7+xr4gQFPsUiuqSzMsUJP6_W8FnXBwX1Xes=XjksuTs=+hQ@mail.gmail.com>
 <56B74B17.4040304@syntevo.com>
 <CA+P7+xpFmZBUwq1h9Xhi7xKYfAyvcouBiV5ujHxuGJQJTMHXZw@mail.gmail.com>
 <CA+P7+xpHNHVSJnVg3HwiBjWxRdSpLXCsm3GpWst=BNyhLMVd5A@mail.gmail.com>
 <20160219043019.GA14764@sigill.intra.peff.net>
 <CA+P7+xr9dLOyaVky1jvXm7MkF0JUqs5SadrTdr4o83baMp397A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marc Strapetz <marc.strapetz@syntevo.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Git mailing list <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 08:46:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWflw-0005Bl-PH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 08:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbcBSHqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 02:46:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:45110 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750708AbcBSHqg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 02:46:36 -0500
Received: (qmail 10399 invoked by uid 102); 19 Feb 2016 07:46:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 02:46:36 -0500
Received: (qmail 24885 invoked by uid 107); 19 Feb 2016 07:46:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 02:46:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 02:46:33 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xr9dLOyaVky1jvXm7MkF0JUqs5SadrTdr4o83baMp397A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286664>

On Thu, Feb 18, 2016 at 11:29:09PM -0800, Jacob Keller wrote:

> I would prefer to either.. blacklist stuff like core.worktree, or
> whitelist a bunch of stuff that makes sense. In this case though, I
> would prefer to have an explicit test of credential.helper, but I
> don't know if any of our tests actually have a solid test case for
> "credential.helper was used in a clone. There may not be test
> infrastructure for this though, so your test might work well enough.

To trigger a credential fetch in actual use, you have to clone over
http. See the credential tests in t5550, for example.

> As for how to whitelist config to share with the submodule I am really
> not 100% sure, since we just clear GIT_CONFIG_PARAMETERS, and I think
> we'd need a specialized variant of clear_local_git_env_vars specific
> to submodule then.

Yeah, you'll have to parse, which is pretty painful. In C, you'd do
something like:

  int submodule_config_ok(const char *var)
  {
	if (starts_with(var, "credential."))
		return 1;
	return 0;
  }

  int filter_submodule_config(const char *var, const char *value, void *data)
  {
	struct strbuf *out = data;
	if (submodule_config_ok(var)) {
		if (out->len)
			strbuf_addch(out, ' ');
		/* these actually probably need quoted all as * one string */
		sq_quote_buf(out, var);
		sq_quote_buf(out, "=");
		sq_quote_buf(out, value);
	}
	return 0;
  }

and then call it like:

  struct strbuf filtered_config = STRBUF_INIT;
  git_config_from_parameters(filter_submodule_config, &filtered_config);
  argv_array_pushf(&child_process.env, "%s=%s",
                   CONFIG_DATA_ENVIRONMENT, filtered_config.buf);

but right now git-submodule.sh is all in shell. You'd probably need a
special helper from git-submodule--helper, though it might simply make
sense to put this off until the submodule code is fully ported to C.

-Peff
