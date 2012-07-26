From: Jeff King <peff@peff.net>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 13:12:56 -0400
Message-ID: <20120726171256.GC13942@sigill.intra.peff.net>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
 <20120726130348.GA965@sigill.intra.peff.net>
 <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:13:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRcX-00042K-6M
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab2GZRM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:12:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:37380 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641Ab2GZRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:12:58 -0400
Received: (qmail 9595 invoked by uid 107); 26 Jul 2012 17:13:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 13:13:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 13:12:56 -0400
Content-Disposition: inline
In-Reply-To: <7vtxwu8orw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202279>

On Thu, Jul 26, 2012 at 09:34:27AM -0700, Junio C Hamano wrote:

> >> not ok - 21 committer is automatic
> [...]
> > I am not sure that the test is really all that useful. The point seems
> > to be that we fall back to some kind of system-based ident, but that is
> > not portable.
> 
> I think the point is to make sure that the "# Committer:" line is
> given to the reader to remind that we took the codepath that comes
> up with a committer ident by using untrustworthy heuristics.  You
> are correct that the usefulness of the value of system-based ident
> varies between systems (that is why it is stripped out with sed),
> though.

Ah, right. I was led astray by the crappy test title. When viewed with
the test immediately prior (which checks that "Author:" is shown in the
template), it makes more sense.

> You earlier gave a reason why f20f387 (commit: check committer identity
> more strictly, 2012-07-23) does not have a test for it; I think the
> same reason applies why this test is unworkable.

Right. You can check this only when "git var GIT_COMMITTER_IDENT" works,
and you can check the f20f387 behavior only when it does _not_ work. So
we could do something like:

  (sane_unset GIT_COMMITTER_NAME &&
   sane_unset GIT_COMMITTER_EMAIL &&
   git var GIT_COMMITTER_IDENT >/dev/null) &&
  test_set_prereq AUTOIDENT ||
  test_set_prereq NOAUTOIDENT

  test_expect_success AUTOIDENT \
    'mention auto ident in commit template'
    '...'

  test_expect_success NOAUTOIDENT \
    'git rejects bogus ident before starting editor'
    '...'

But it is somewhat unsatisfying to only get random test coverage
depending on how your system happens to be configured. I guess we
somewhat have that already with the case-insensitivity tests.

Do we want to go that route, or just drop this test completely?

> A related tangent; all the test vectors in this script seems to be
> too wide, and we probably would want to narrow them for what each
> test wants to see.  For example, the test in question only wants to
> see "# Committer: <some system based ident>" and it does not matter
> if the template was rewritten in future versions of Git so that it
> does not begin with "# Please enter...".  Similarly, the one
> previous only wants to see "# Author: <different from committer>".

Agreed. They should probably just i18ngrep for "^# Committer: " or
similar.

-Peff
