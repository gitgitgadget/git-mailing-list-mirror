From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 12:16:53 -0400
Message-ID: <20111011161652.GA15629@sigill.intra.peff.net>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 18:17:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDf0m-0007UZ-Eu
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 18:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab1JKQQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 12:16:56 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57587
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755158Ab1JKQQz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 12:16:55 -0400
Received: (qmail 2774 invoked by uid 107); 11 Oct 2011 16:16:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Oct 2011 12:16:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Oct 2011 12:16:53 -0400
Content-Disposition: inline
In-Reply-To: <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183304>

On Thu, Sep 15, 2011 at 11:10:40PM +0200, Michael Haggerty wrote:

> While resolving references, if a reference is found that is in an
> unrecognized format, emit a warning (and then fail, as before).
> Wouldn't *you* want to know?

Not necessarily. :)

I noticed this today, and bisected it to this patch:

  $ git.v1.7.7 show config
  fatal: ambiguous argument 'config': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

  $ git.mh.check-ref-format-3 show config
  warning: reference in .git/config is formatted incorrectly
  warning: reference in .git/config is formatted incorrectly
  fatal: ambiguous argument 'config': unknown revision or path not in the working tree.
  Use '--' to separate paths from revisions

which is arguably not a big deal, as we eventually report failure
anyway. But it's even worse with:

  $ git branch config v1.7.7
  $ git show --oneline config
  warning: reference in .git/config is formatted incorrectly
  703f05a Git 1.7.7

As you probably guessed, this is due to the ref resolution rules first
looking directly in .git for refs, which catches things like "HEAD" and
fully-qualified refs like "refs/heads/foo".

Which means we have been considering ".git/config" as a possible ref for
a long time, which is arguably wrong. Your patch only makes it more
obvious that this is the case.

I wonder if the right solution is for us to be more picky about what can
be found in $GIT_DIR. Maybe matching all-uppercase, or starting with
"refs/", which I think would match existing convention?

-Peff
