From: Jeff King <peff@peff.net>
Subject: Re: [BUG] bare repository detection does not work with aliases
Date: Fri, 8 Mar 2013 01:37:56 -0500
Message-ID: <20130308063756.GA29242@sigill.intra.peff.net>
References: <CAHREChhuX82ibNEDQnQUeS9TEeyMFGpuNhyXzt1Pn-Tt2BVOQA@mail.gmail.com>
 <20130308054824.GA24429@sigill.intra.peff.net>
 <94c531c1-57a0-4464-9f30-3c63f0c1a056@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 07:38:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDqwj-00066q-GV
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 07:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940Ab3CHGh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 01:37:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40670 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869Ab3CHGh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 01:37:59 -0500
Received: (qmail 13989 invoked by uid 107); 8 Mar 2013 06:39:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 01:39:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 01:37:56 -0500
Content-Disposition: inline
In-Reply-To: <94c531c1-57a0-4464-9f30-3c63f0c1a056@email.android.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217640>

On Thu, Mar 07, 2013 at 10:27:04PM -0800, Junio C Hamano wrote:

> The $GIT_BARE idea sounds very sensible to me.

Unfortunately, it is not quite as simple as that. I just wrote up the
patch, and it turns out that we are foiled by how core.bare is treated.
If it is true, the repo is definitely bare. If it is false, that is only
a hint for us.

So we cannot just look at is_bare_repository() after setup_git_directory
runs. Because we are not "definitely bare", only "maybe bare", it
returns false. We just happen not to have a work tree. We could do
something like:

  if (is_bare_repository_cfg || !work_tree)
          setenv("GIT_BARE", "1", 1);

which I think would work, but feels kind of wrong. We are bare in this
instance, but somebody setting GIT_WORK_TREE in a sub-process would
want to become unbare, presumably, but our variable would override them.

Just looking through all of the code paths, I am getting a little
nervous that I would not cover all the bases for such a $GIT_BARE to
work (e.g., doing GIT_BARE=0 would not do I would expect as a user,
because of the historical way we treat core.bare=false).

So rather than introduce something like $GIT_BARE which is going to
bring about all new kinds of corner cases, I think I'd rather just pass
along a $GIT_NO_IMPLICIT_WORK_TREE variable, which is much more direct
for solving this problem, and is less likely to end up having bugs of
its own.

-Peff
