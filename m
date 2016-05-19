From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] config: return configset value for current_config_
 functions
Date: Wed, 18 May 2016 20:08:21 -0400
Message-ID: <20160519000821.GA22543@sigill.intra.peff.net>
References: <20160518223712.GA18317@sigill.intra.peff.net>
 <20160518224323.GD22443@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:08:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3BW3-0002nG-AK
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 02:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752011AbcESAI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 20:08:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:41599 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751941AbcESAIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 20:08:25 -0400
Received: (qmail 4832 invoked by uid 102); 19 May 2016 00:08:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 20:08:24 -0400
Received: (qmail 28052 invoked by uid 107); 19 May 2016 00:08:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 20:08:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 20:08:21 -0400
Content-Disposition: inline
In-Reply-To: <20160518224323.GD22443@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295029>

On Wed, May 18, 2016 at 06:43:23PM -0400, Jeff King wrote:

>  cache.h                |  1 +
>  config.c               | 51 +++++++++++++++++++++++++++++++++++++++++---------
>  t/helper/test-config.c | 20 ++++++++++++++++++++
>  t/t1308-config-set.sh  | 23 +++++++++++++++++++++++
> [...]
> +test_expect_success 'iteration shows correct origins' '
> +	echo "[alias]test-config = !test-config" >.gitconfig &&
> [...]
> +	git -c foo.bar=from-cmdline test-config iterate >actual &&

While writing and testing this, I got bit by e6e7530 (test helpers: move
test-* to t/helper/ subdirectory, 2016-04-13). I had an old test-config
binary leftover in the root of my repository, and the new one was
correctly built in t/helper/. Running "test-config" is fine, but inside
the git alias, it sticks the repository root at the front of $PATH
(because it's the exec-path). And so it ran the old version of
test-config, which did not understand my new "iterate" option.

Now I'll admit what I'm doing here is pretty funny (running test-* from
an alias). I'm doing it because I want to see how the program operates
with the "-c" config, and it's nicer to spell it as a user would,
instead of munging $GIT_CONFIG_PARAMETERS directly.

So I'm not sure if it's worth working around or not. The single tree
state produced by this commit is fine, but it does behave badly if
there's leftover cruft from a pre-e6e7530 build. A more robust version
would look more like:

  sq=\' ;# to ease quoting later
  ...
  GIT_CONFIG_PARAMETERS=${sq}foo.bar=from-cmdline${sq} test-config ...

Which is ugly, but it's probably worth it to avoid the flakiness.

The other option is to somehow make bin-wrappers more robust. E.g., it
would be nice if we didn't actually point into the repository root
directly, but rather somehow linked all of the git-* entries that
_would_ be installed into the exec-path into a fake exec-path (or
alternatively, actually build them directly into that fake exec-path).

That's a much bigger change, though. Given how unlikely the sequence of
steps in my test is, maybe it's better to just work around it in this
one case.

-Peff
