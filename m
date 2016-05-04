From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 15:09:35 -0400
Message-ID: <20160504190935.GC21259@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
 <20160504074559.GA3077@sigill.intra.peff.net>
 <20160504080047.GA2436@sigill.intra.peff.net>
 <xmqqzis5hdek.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 21:09:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2B4-00089V-QK
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:09:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541AbcEDTJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:09:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:34112 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750825AbcEDTJi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:09:38 -0400
Received: (qmail 29763 invoked by uid 102); 4 May 2016 19:09:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:09:37 -0400
Received: (qmail 12966 invoked by uid 107); 4 May 2016 19:09:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:09:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 15:09:35 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzis5hdek.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293570>

On Wed, May 04, 2016 at 11:43:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/git-submodule.sh b/git-submodule.sh
> > index 3a40d4b..c9d53e1 100755
> > --- a/git-submodule.sh
> > +++ b/git-submodule.sh
> > @@ -197,9 +197,9 @@ isnumber()
> >  # of the settings from GIT_CONFIG_PARAMETERS.
> >  sanitize_submodule_env()
> >  {
> > -	sanitized_config=$(git submodule--helper sanitize-config)
> > +	save_config=$GIT_CONFIG_PARAMETERS
> >  	clear_local_git_env
> > -	GIT_CONFIG_PARAMETERS=$sanitized_config
> > +	GIT_CONFIG_PARAMETERS=$save_config
> >  	export GIT_CONFIG_PARAMETERS
> >  }
> 
> This does "clear the obviously per-repository stuff, but add back in
> anything that came from -c".  If it is easy to do "add anything that
> came from -c, and then clear the obviously per-repository stuff", we
> don't even have to say "exporting core.worktree down may hurt; do
> not do it then", which may be the best of both worlds?

It's not easy at this level. clear_local_git_env() is just clearing
whole variables like $GIT_WORK_TREE. But if you say "-c core.worktree",
that is still live in $GIT_CONFIG_PARAMETERS, and gets fed to
sub-processes on each invocation. Nobody ever removes individual content
from $GIT_CONFIG_PARAMETERS once something is in it.

> Or have we decided that even sharing core.worktree may have a valid
> use case and it is better not to filter them?

I do not personally consider it a valid use case. The sentiment just
seemed to be that it was better to make the rule simple and easy to
explain ("everything gets passed through; if it hurts, don't do it")
than to keep sanitizing.

If you want "pass through everything except core.worktree", then that is
the blacklist approach (which is easy to do if we scrap this patch and
just teak submodule_config_ok() from a whitelist into a blacklist).

-Peff
