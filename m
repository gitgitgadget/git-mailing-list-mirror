From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Show branch information in short output of git status
Date: Wed, 5 May 2010 01:06:40 -0400
Message-ID: <20100505050640.GC8779@coredump.intra.peff.net>
References: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Knittl <knittl89@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 05 07:06:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Wor-0007MZ-2r
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 07:06:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab0EEFGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 01:06:44 -0400
Received: from peff.net ([208.65.91.99]:52672 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752518Ab0EEFGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 01:06:44 -0400
Received: (qmail 19805 invoked by uid 107); 5 May 2010 05:06:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 05 May 2010 01:06:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 05 May 2010 01:06:40 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikM3B-9wFBuUzwpP2j9FpT34p9yysX-oLg5hZRj@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146372>

On Sun, May 02, 2010 at 11:13:41AM +0200, Knittl wrote:

> This patch adds a first line in the output of `git status -s`, showing
> which branch the user is currently on, and in case of tracking branches
> the number of commits on each branch.

I don't generally use "git status -s", so I don't have a strong opinion,
but should this perhaps be optional?  I imagine people using it fall
into one of two categories:

  1. They want to waste less vertical screen real estate than "git
     status" does.

  2. They prefer to see files in a single list with status marked,
     rather than in separate lists based on status.

Your patch will probably annoy people in group (1) unless they have some
way to turn it off.

A few other comments on the patch itself:

> +	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "## ");

I thought the doubled '##' looked funny at first, but the more I look at
it, I think lining it up with the filenames looks good.

> +	if(!s->branch) return;

Style nits. This should be:

  if (!s->branch)
          return;

> +	branch = branch_get(s->branch + 11);
> +	if (!stat_tracking_info(branch, &num_ours, &num_theirs)) {
> +
> +		if(s->is_initial) {
> +			color_fprintf(s->fp,
> +				color(WT_STATUS_HEADER, s),
> +				"Initial commit ... ");
> +		}
> +		color_fprintf_ln(s->fp, branch_color,
> +			"%s", branch_name);
> +		return;
> +	}

Why do we only mention it as an initial commit if there is no tracking?
We get if it is an initial commit and no tracking:

  ## Initial commit ... master

but if there is a tracking branch setup, we get no "Initial commit" at
all. And the use of "..." is confusing, as it usually implies symmetric
difference, which doesn't really make sense here.

> +	base = branch->merge[0]->dst;
> +	base = shorten_unambiguous_ref(base, 0);
> +	color_fprintf_ln(s->fp, branch_color,
> +			"%s (%d) ... %s (%d)",
> +			branch_name, num_ours,
> +			base, num_theirs);
> +}

Here we get:

  ## master (1) ... origin/master (1)

which kind of makes sense. The "..." implies symmetric difference. But
in other spots, like "git fetch" and "git push" output, we usually try
to make it cut-and-pastable in case one wants to view the actual
history. So maybe something like:

  ## master...origin/master [ahead 1, behind 1]

The latter matches how "git branch -v" prints it. I dunno. I guess this
is just bikeshedding really, so maybe others will chime in with
suggestions and you can pick the one you like best.

-Peff
