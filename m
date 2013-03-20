From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Add posibility to preload stat information.
Date: Wed, 20 Mar 2013 12:48:06 -0400
Message-ID: <20130320164806.GA10752@sigill.intra.peff.net>
References: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: spearce@spearce.org, git@vger.kernel.org, pclouds@gmail.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 17:48:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMBs-000132-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 17:48:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753605Ab3CTQsN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 12:48:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60216 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab3CTQsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 12:48:13 -0400
Received: (qmail 9272 invoked by uid 107); 20 Mar 2013 16:49:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 12:49:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 12:48:06 -0400
Content-Disposition: inline
In-Reply-To: <1363781732-11396-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218617>

On Wed, Mar 20, 2013 at 01:15:32PM +0100, Fredrik Gustafsson wrote:

> When entering a git working dir, optionally run a forked process that
> stat all files in the whole workdir and therefore loads stat information
> to RAM which will speedup things like git status and so on.
> 
> The feature is optional and by default it's off.

Kind of gross, but I guess it is useful to some people.

> +__git_recursive_stat ()
> +{
> +	if test ! -e /tmp/gitbash.lock
> +	then
> +		touch /tmp/gitbash.lock

This is a tmp-race security hole. E.g., do:

  ln -s /etc/nologin /tmp/gitbash.lock

as a user; when root runs __git_recursive_stat, it will create
/etc/nologin. It's not quite as bad as some other holes, because we only
"touch" the file, not overwrite its contents, but you can see that it's
possible to do some mischief.

Should this maybe just be ~/.gitbash.lock or something?

> +		cd $(git rev-parse --show-toplevel)
> +		find . | xargs stat 2&> /dev/null

The "stat" utility is not portable. But why not use git to do the
reading? Then you can get the benefit of core.preloadindex, and you will
not recurse into untracked directories that are ignored (i.e.,
ones that git would not go into anyway).

So maybe just run "git status >/dev/null"?

-Peff
