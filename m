From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t5531: further "matching" fixups
Date: Fri, 10 Jan 2014 23:22:47 -0500
Message-ID: <20140111042246.GA19556@sigill.intra.peff.net>
References: <20140108093338.GA15659@sigill.intra.peff.net>
 <20140108093531.GD15720@sigill.intra.peff.net>
 <20140108102707.GA23145@sigill.intra.peff.net>
 <20140108104756.GA32078@sigill.intra.peff.net>
 <xmqqzjn376n0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 11 05:22:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1q61-00062z-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jan 2014 05:22:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbaAKEWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 23:22:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:58783 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751572AbaAKEWt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 23:22:49 -0500
Received: (qmail 715 invoked by uid 102); 11 Jan 2014 04:22:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Jan 2014 22:22:49 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Jan 2014 23:22:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjn376n0.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240327>

On Fri, Jan 10, 2014 at 03:34:59PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... but the
> > failing test is actually somewhat broken in 'next' already.
> 
> Hmph, in what way?  I haven't seen t5531 breakage on 'next', with or
> without your series...

The test still passes, but it is not testing the right thing anymore.

On 'next', run t5531. Test 6 is "push fails when commit on
multiple branches if one branch has no remote" and ends with:

  test_must_fail git push --recurse-submodules=check ../pub.git

But the output ends with:

  warning: push.default is unset; its implicit value has changed in
  Git 2.0 from 'matching' to 'simple'. To squelch this message
  [...]

  fatal: The current branch branch2 has no upstream branch.
  To push the current branch and set the remote as upstream, use

      git push --set-upstream ../pub.git branch2

When not merged with b2ed944 (push: switch default from "matching" to
"simple"), or with my patch to set push.default=matching explicitly, the
output is:

  The following submodule paths contain changes that can
  not be found on any remote:
    gar/bage

  Please try

          git push --recurse-submodules=on-demand

  or cd to the path and use

          git push

  to push them to a remote.

  fatal: Aborting.

which is what the test is actually trying to check. So the push fails,
as we expect, but not for the right reason.

My other series for @{publish} had a bug that caused the push to
succeed. So that series was buggy (and I posted the fix already), but we
only noticed it because this test was not working (it should not care
about upstream/triangular config at all, but it accidentally did).

Does that clarify the situation?

-Peff
