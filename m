From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 2 Jun 2011 10:29:34 -0400
Message-ID: <20110602142933.GA32487@sigill.intra.peff.net>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie>
 <BANLkTino5gmfXjeOVih7+LHcMu1usPWAoQ@mail.gmail.com>
 <20110601193126.GC9730@elie>
 <BANLkTinc=9aW_y6s-Zb578QsMawnxFD55Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 16:29:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QS8uM-0002nF-Ha
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 16:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751829Ab1FBO3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2011 10:29:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46556
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956Ab1FBO3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 10:29:37 -0400
Received: (qmail 27760 invoked by uid 107); 2 Jun 2011 14:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 10:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 10:29:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinc=9aW_y6s-Zb578QsMawnxFD55Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174952>

On Thu, Jun 02, 2011 at 06:23:03PM +0530, Ramkumar Ramachandra wrote:

> On a slightly unrelated note, I just found out that the persist_todo
> can't be called twice due to a lockfile API limitation* -- the
> atexit(3) cleanup handler is supposed to have a linked list of
> lockfiles to clean up. When one lockfile is used twice, it becomes a
> circularly linked list, and the entire program hangs at exit time
> since traversing a circularly linked list is never-ending. Couple of
> comments:
> 1. By reading the lockfile implementation, I understand why this
> happens -- can't it be implemented differently to remove this
> limitation? If not, shouldn't this limitation be documented somewhere?

Doesn't lock_file handle multiple locking already via the on_list parameter?

    $ grep -A2 on_list lockfile.c
            if (!lk->on_list) {
                    lk->next = lock_file_list;
                    lock_file_list = lk;
                    lk->on_list = 1;
            }

However, I think you have a bigger problem, which is that you are
allocating the lock_file on the stack in persist_todo and persist_head.
So by the time the atexit() handler is called, this storage has gone
away and you are just reading random data (not to mention that it also
should be zero-initialized before being passed to lock_file).

-Peff
