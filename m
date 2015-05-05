From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: fix funny-sounding error message
Date: Tue, 5 May 2015 19:06:30 -0400
Message-ID: <20150505230630.GC18817@peff.net>
References: <1430536360-21901-1-git-send-email-alexhenrie24@gmail.com>
 <xmqq8ud5usi6.fsf@gitster.dls.corp.google.com>
 <CAMMLpeTYhLwGmy11uGzZAVugQPO6qN6F6pxZ6BiUZKeKnir+zw@mail.gmail.com>
 <xmqqvbg6d6v3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Henrie <alexhenrie24@gmail.com>, pclouds@gmail.com,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 06 01:06:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YplvC-000540-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 06 May 2015 01:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbbEEXGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 19:06:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:54559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750744AbbEEXGd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 19:06:33 -0400
Received: (qmail 2860 invoked by uid 102); 5 May 2015 23:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 18:06:33 -0500
Received: (qmail 12406 invoked by uid 107); 5 May 2015 23:07:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 05 May 2015 19:07:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 May 2015 19:06:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvbg6d6v3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268432>

On Tue, May 05, 2015 at 02:58:24PM -0700, Junio C Hamano wrote:

> I think this "branch is NULL" condition is when an earlier call to
> branch_get() returned a NULL, and _one_ way to make that happen is
> to detach the HEAD.  There may be others, but I didn't check.

FWIW, since I have just been looking through the branch code,
branch_get() should only return NULL when:

  1. We passed NULL or "HEAD" to it (i.e., we asked for the current branch). If
     you ask for a branch by name, you will always get a non-NULL return,
     even if that branch does not exist.

  2. There is no current branch (i.e., a detached HEAD).

I think the "no such branch" error message here:

               if (!branch) {
                        if (!argc || !strcmp(argv[0], "HEAD"))
                                die(_("could not unset upstream of HEAD when "
                                      "it does not point to any branch."));
			die(_("no such branch '%s'"), argv[0]);
	       }

cannot actually be triggered (and I double-checked that the test suite
does not trigger it by replacing it with "exit(141)", which should cause
even test_must_fail to complain).

-Peff
