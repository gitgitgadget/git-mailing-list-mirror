From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] diff: introduce diff.submodule configuration variable
Date: Tue, 13 Nov 2012 00:33:36 -0500
Message-ID: <20121113053336.GA10995@sigill.intra.peff.net>
References: <1352653146-3932-1-git-send-email-artagnon@gmail.com>
 <1352653146-3932-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:33:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY98F-00020T-2b
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 06:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069Ab2KMFdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 00:33:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45571 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751722Ab2KMFdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 00:33:41 -0500
Received: (qmail 19786 invoked by uid 107); 13 Nov 2012 05:34:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Nov 2012 00:34:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2012 00:33:36 -0500
Content-Disposition: inline
In-Reply-To: <1352653146-3932-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209576>

On Sun, Nov 11, 2012 at 10:29:05PM +0530, Ramkumar Ramachandra wrote:

> +static int parse_submodule_params(struct diff_options *options, const char *value,
> +				struct strbuf *errmsg)
> +{
> +	if (!strcmp(value, "log"))
> +		DIFF_OPT_SET(options, SUBMODULE_LOG);
> +	else if (!strcmp(value, "short"))
> +		DIFF_OPT_CLR(options, SUBMODULE_LOG);
> +	else {
> +		strbuf_addf(errmsg, _("'%s'"), value);
> +		return 1;
> +	}
> +	return 0;
> +}

I think "-1" would be the more normal error return.

> @@ -223,6 +238,15 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "diff.submodule")) {

Shouldn't this be in git_diff_ui_config so it does not affect scripts
calling plumbing?

> +		struct strbuf errmsg = STRBUF_INIT;
> +		if (parse_submodule_params(&default_diff_options, value, &errmsg))
> +			warning(_("Unknown value for 'diff.submodule' config variable: %s"),
> +				errmsg.buf);
> +		strbuf_release(&errmsg);
> +		return 0;
> +	}

Hmm. This strbuf error handling strikes me as very clunky, considering
that it does not pass any useful information out of the parse function
(it always just adds '$value' to the error string).  Wouldn't it be
simpler to just have parse_submodule_params return -1, and then let the
caller warn or generate an error as appropriate?

-Peff
