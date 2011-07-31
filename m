From: Jeff King <peff@peff.net>
Subject: Re: Unusual behavior from git describe
Date: Sun, 31 Jul 2011 00:20:55 -0600
Message-ID: <20110731062055.GB14384@sigill.intra.peff.net>
References: <CA+jCPNcOe_dd6fsHDvWtoXEQE+xyd=aaSbfjpjQ8UfyFnvXTfg@mail.gmail.com>
 <CAGdFq_hYiBoqNmNtBKBqNN4XLLKwxDMHJfAUwdHB_iCcya=DOQ@mail.gmail.com>
 <CA+jCPNfwwhM8R-bB_VnwpaijSMf3BNydH35SqZt3dRb-P1AOmg@mail.gmail.com>
 <CAGdFq_imU3_=E1LK-AG33Tj70iOJBTmt2_qdUKVHL9DVW2yJRQ@mail.gmail.com>
 <CA+jCPNfsQ2oqDzTpJL4ck0vNBJnfXwb+aaSrzStrs55kq+CTHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 08:22:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnPPx-0000i0-HB
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 08:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410Ab1GaGVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 02:21:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49151
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751783Ab1GaGU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 02:20:59 -0400
Received: (qmail 6344 invoked by uid 107); 31 Jul 2011 06:21:30 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 31 Jul 2011 02:21:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jul 2011 00:20:55 -0600
Content-Disposition: inline
In-Reply-To: <CA+jCPNfsQ2oqDzTpJL4ck0vNBJnfXwb+aaSrzStrs55kq+CTHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178230>

On Sat, Jul 30, 2011 at 12:23:30PM -0400, Allan Caffee wrote:

> On Sat, Jul 30, 2011 at 9:32 AM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > Does it perhaps touch some of the tracked files? That way it would
> > make sense git at first thinks it's dirty (since the lstat info
> > changed), but then 'git status' will actually check the contents of
> > the file and notice that they're equal? Just guessing here though.
> 
> Sounds like you're on the right track.  git diff-index reveals that
> the index is stale
> [...]
> It looks like this was caused by setuptools hardlinking files into a
> temp directory and then deleting the links, as demonstrated by:

Yeah, that would modify the file's ctime, which is part of what git uses
to check whether its stat-cache is fresh.

The problem is that we call the diff-index plumbing to determine the
dirty state, but it expects the index to have been refreshed already.
Describe is probably porcelain-ish enough that it should be doing the
refresh for the user and writing the result out (at least if the --dirty
flag is passed, as otherwise it doesn't care), just as porcelains like
"diff" and "status" do.

> I've tried adding a call to refresh_index() in describe.c but it
> doesn't seem to have any effect on the results. (Patch below.)  Any
> idea what the proper fix is for this?

You call refresh_index, but you never actually load the index in the
first place. So nothing gets refreshed. If you add a call to read_cache
just beforehand, it works as you expect.

However, if describe is going to the trouble to refresh the index, it
should probably actually write out the result. In that case, you would
want to emulate what cmd_status does in builtin/commit.c, which writes
out the new index via update_index_if_able.

-Peff
