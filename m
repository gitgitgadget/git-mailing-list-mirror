From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: Introduce --patience config variable
Date: Tue, 6 Mar 2012 06:49:14 -0500
Message-ID: <20120306114914.GB6733@sigill.intra.peff.net>
References: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 12:49:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4stN-0006Ig-FH
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 12:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759127Ab2CFLtR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 06:49:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42060
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759078Ab2CFLtQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 06:49:16 -0500
Received: (qmail 8685 invoked by uid 107); 6 Mar 2012 11:49:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 06 Mar 2012 06:49:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Mar 2012 06:49:14 -0500
Content-Disposition: inline
In-Reply-To: <a87ed689ddfb06601dd639541199fc72d829bdaf.1331031473.git.mprivozn@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192337>

On Tue, Mar 06, 2012 at 11:59:42AM +0100, Michal Privoznik wrote:

> Some users like the patience diff more than the bare diff. However,
> specifying the '--patience' argument every time diff is to be used
> is impractical. Moreover, creating an alias doesn't play with other
> tools nice, e.g. git-show; Therefore we need a configuration variable
> to turn this on/off across whole git tools.

The idea of turning on patience diff via config makes sense to me, and
it is not a problem for plumbing tools to have patience diff on, since
patience diffs are syntactically identical to non-patience diffs. So I
think the intent is good.

A few comments on the patch itself:

> --- a/Documentation/diff-config.txt
> +++ b/Documentation/diff-config.txt
> @@ -86,6 +86,9 @@ diff.mnemonicprefix::
>  diff.noprefix::
>  	If set, 'git diff' does not show any source or destination prefix.
>  
> +diff.patience:
> +    If set, 'git diff' will use patience algorithm.
> +

Should this be a boolean? Or should we actually have a diff.algorithm
option where you specify the algorithm you want (e.g., "diff.algorithm =
patience")? That would free us up later to more easily add new values.

In particular, I am thinking about --minimal. It is mutually exclusive
with --patience, and is simply ignored if you use patience diff.
we perhaps have "diff.algorithm" which can be one of "myers", "minimal"
(which is really myers + the minimal flag), and "patience".

Or I suppose you could think of it as "--minimal" being orthogonal to
the algorithm chosen, and it is simply that "--minimal" does nothing
(currently) with the patience algorithm.

> @@ -3202,6 +3208,9 @@ int diff_setup_done(struct diff_options *options)
>  		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
>  	}
>  
> +    if (diff_patience)
> +		DIFF_XDL_SET(options, PATIENCE_DIFF);
> +
>  	return 0;

Hmm. Usually for a boolean config we would have "-1" mean "not
specified", and otherwise 0/1 for true/false. But in your case, setting
diff.patience to "false" will be the same as not setting it at all. I
think this is probably OK. "false" is the default, so you would only
want to specify it to override an earlier setting, but there is nothing
earlier than config that you could possibly be overriding.

Speaking of overriding, you may want to actually override the config
option from the command line. You probably should also add a
"--no-patience" option, so that one can turn off "diff.patience = true"
for a particular invocation.

-Peff
