From: Jeff King <peff@peff.net>
Subject: Re: Test "t/t7502-commit.sh" failed
Date: Thu, 26 Jul 2012 09:03:49 -0400
Message-ID: <20120726130348.GA965@sigill.intra.peff.net>
References: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 15:04:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuNjW-0008VA-Rj
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752444Ab2GZND5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:03:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34677 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752343Ab2GZND5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 09:03:57 -0400
Received: (qmail 5736 invoked by uid 107); 26 Jul 2012 13:03:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Jul 2012 09:03:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jul 2012 09:03:49 -0400
Content-Disposition: inline
In-Reply-To: <CANYiYbHbMw1HpvoCr4yBbWF=Q9Hoc1Zsq3-WoTrx4aQg7R0e4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202261>

On Thu, Jul 26, 2012 at 02:27:52PM +0800, Jiang Xin wrote:

> Test "t/t7502-commit.sh" failed. I guess it's commit
> v1.7.9.7-1-gf20f387 which breaks it.
> 
>     $ git log -1 --oneline --stat v1.7.9.7-1-gf20f387
>     f20f commit: check committer identity more strictly
>      builtin/commit.c | 2 +-
>      1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Result of t/t7502-commit.sh:
> 
> not ok - 21 committer is automatic
> #
> #
> #               echo >>negative &&
> #               (
> #                       sane_unset GIT_COMMITTER_EMAIL &&
> #                       sane_unset GIT_COMMITTER_NAME &&
> #                       # must fail because there is no change
> #                       test_must_fail git commit -e -m "sample"
> #               ) &&
> #               head -n 8 .git/COMMIT_EDITMSG | \
> #               sed "s/^# Committer: .*/# Committer:/" >actual
> #               test_i18ncmp expect actual
> #

Hmm. It doesn't fail here, but that is probably because I have my name
set properly in /etc/passwd. I think the test is bogus, though. From the
results you report:

> Contents of file expect:
> 
>     sample
> 
>     # Please enter the commit message for your changes. Lines starting
>     # with '#' will be ignored, and an empty message aborts the commit.
>     #
>     # Author:    A U Thor <author@example.com>
>     # Committer:
>     #
> 
> Contents of file actual:
> 
>     sample

The test is expecting us to write out the commit template for the user
to edit. But the whole point of f20f387 is to fail early, before we ask
the user to edit the template. So the test is trying to check that we
wrote _something_ into the Committer field, even though that something
would not necessarily be used to make the commit object (because the
code path for the commit object is going to be much stricter).

I am not sure that the test is really all that useful. The point seems
to be that we fall back to some kind of system-based ident, but that is
not portable. On some systems we can, and on some we can't, depending on
things like how /etc/passwd and the hostname are configured.

I'll see if I can make it more robust, but I think the right solution
may simply be to rip out the test.

-Peff
