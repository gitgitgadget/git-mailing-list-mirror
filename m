From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: Allow commit editing
Date: Wed, 24 Aug 2011 23:14:20 -0400
Message-ID: <20110825031420.GB3465@sigill.intra.peff.net>
References: <87obzlwpx0.fsf@steelpick.2x.cz>
 <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, paulus@samba.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Thu Aug 25 05:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwQOk-0000FZ-5G
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 05:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab1HYDOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 23:14:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42287
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab1HYDOW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 23:14:22 -0400
Received: (qmail 10604 invoked by uid 107); 25 Aug 2011 03:15:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Aug 2011 23:15:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2011 23:14:20 -0400
Content-Disposition: inline
In-Reply-To: <1313756753-26498-1-git-send-email-sojka@os.inf.tu-dresden.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180059>

On Fri, Aug 19, 2011 at 02:25:53PM +0200, Michal Sojka wrote:

> +    if {[exec git branch -r --contains=$rowmenuid] ne {}} {
> +	if {![confirm_popup [mc "The commit you are going to edit appears in at least one\
> +				 remote branch. It is a bad idea to change a branch that is\
> +				 possibly used by other people. See git-rebase(1) for details.\n\n\
> +				 Do you want to continue?"]]} return }

We frown on using porcelain like "git branch" here, because it was not
meant to be scriptable (i.e., its behavior may change in future
releases).

As I mentioned elsewhere, I think you really want to see whether the
commit is referenced by any other ref, not just branches; if it is, then
the rebase is potentially problematic. You can do that with something
like:

  us=`git symbolic-ref HEAD`
  git for-each-ref --format='%(refname)' |
  while read ref; do
    test "$ref" = $us" && continue
    echo "^$ref"
  done |
  git rev-list HEAD --stdin

That will give a list of commits found only on HEAD and nowhere else
(i.e., those which are safe to rebase). If your commit is among them,
then it's safe.

Speaking of which, notice that I used HEAD here. What happens with your
patch if I do:

  $ git checkout foo
  $ gitk bar

and select a commit to edit that is not in "foo"?

-Peff
