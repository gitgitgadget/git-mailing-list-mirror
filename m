From: Jeff King <peff@peff.net>
Subject: Re: syntax error in git-rebase while running t34* tests
Date: Tue, 10 May 2016 17:07:10 -0400
Message-ID: <20160510210709.GD19958@sigill.intra.peff.net>
References: <CALR6jEiF9Ooi1f0O3KG0wYmN0KRWBQTNarXx79-wBD2E-8q2jA@mail.gmail.com>
 <xmqq60ulpw1s.fsf@gitster.mtv.corp.google.com>
 <20160510204758.GB19958@sigill.intra.peff.net>
 <xmqqy47hmy6z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0EsC-00017N-5B
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 23:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525AbcEJVHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 17:07:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:37280 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750951AbcEJVHN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 17:07:13 -0400
Received: (qmail 29141 invoked by uid 102); 10 May 2016 21:07:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 17:07:12 -0400
Received: (qmail 1562 invoked by uid 107); 10 May 2016 21:07:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 May 2016 17:07:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2016 17:07:10 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy47hmy6z.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294193>

On Tue, May 10, 2016 at 01:53:56PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it is clear why it works. If $strategy_opts is empty, then the
> > code we generate looks like:
> >
> >   for strategy_opt in
> >   do
> >           ...
> >   done
> 
> Ah, of course.  Thanks.

Here it is as a patch and commit message.

-- >8 --
Subject: [PATCH] rebase--interactive: avoid empty list in shell for-loop

The $strategy_opts variable contains a space-separated list
of strategy options, each individually shell-quoted. To loop
over each, we "unwrap" them by doing an eval like:

  eval '
    for opt in '"$strategy_opts"'
    do
       ...
    done
  '

Note the quoting that means we expand $strategy_opts inline
in the code to be evaluated (which is the right thing
because we want the IFS-split and de-quoting). If the
variable is empty, however, we ask the shell to eval the
following code:

  for opt in
  do
     ...
  done

without anything between "in" and "do".  Most modern shells
are happy to treat that like a noop, but reportedly ksh88 on
AIX considers it a syntax error. So let's catch the case
that the variable is empty and skip the eval altogether
(since we know the loop would be a noop anyway).

Reported-by: Armin Kunaschik <megabreit@googlemail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 git-rebase--interactive.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9ea3075..1c6dfb6 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -82,6 +82,7 @@ rewritten_pending="$state_dir"/rewritten-pending
 cr=$(printf "\015")
 
 strategy_args=${strategy:+--strategy=$strategy}
+test -n "$strategy_opts" &&
 eval '
 	for strategy_opt in '"$strategy_opts"'
 	do
-- 
2.8.2.660.ge43c418
