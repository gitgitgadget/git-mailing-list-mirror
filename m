From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 07/19] rebase -i: log the replay of root commits
Date: Fri, 1 Aug 2014 20:04:05 -0400
Message-ID: <20140802000405.GB20040@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <7389745946359e0d9d8c6f1e8f2ebc78033132e6.1406589435.git.bafain@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:04:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDMo7-0002MJ-6a
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 02:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbaHBAEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 20:04:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:44551 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbaHBAEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 20:04:12 -0400
Received: (qmail 18634 invoked by uid 102); 2 Aug 2014 00:04:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Aug 2014 19:04:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Aug 2014 20:04:05 -0400
Content-Disposition: inline
In-Reply-To: <7389745946359e0d9d8c6f1e8f2ebc78033132e6.1406589435.git.bafain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254686>

On Tue, Jul 29, 2014 at 01:18:07AM +0200, Fabian Ruch wrote:

> The command line used to recreate root commits specifies the option
> `-q` which suppresses the commit summary message. However,
> git-rebase--interactive tends to tell the user about the commits it
> creates in the final history, if she wishes (cf. command line option
> `--verbose`). The code parts handling non-root commits and squash
> commits all output commit summary messages. Do not make the replay of
> root commits an exception. Remove the option to make the report of
> the rebased history complete.
> 
> It is OK that the commit summary is still suppressed when git-commit
> is used to initialize the authorship of the sentinel commit because
> this additional commit is an implementation detail hidden from the
> final history. The removed `-q` option was probably introduced as a
> copy-and-paste error stemming from that part of the root commit
> handling code.

I'm confused. This implies that we should be seeing summaries for other
commits, but not root commits, and this patch is bring them into
harmony.  But if I have a repo like this:

  git init -q repo &&
  cd repo &&
  for i in one two; do
    echo $i >file &&
    git add file &&
    git commit -q -m $i
  done

then using stock git gives me this:

  $ GIT_EDITOR=true git rebase -i --root 2>&1 | perl -pe 's/\r/\\r\n/g'
  Rebasing (1/2)\r
  Rebasing (2/2)\r
  Successfully rebased and updated refs/heads/master.

but with your patch, I get:

  $ GIT_EDITOR=true git.compile rebase -i --root 2>&1 | perl -pe 's/\r/\\r\n/g'
  Rebasing (1/2)\r
  [detached HEAD 60834b3] one
   Date: Fri Aug 1 20:00:05 2014 -0400
   1 file changed, 1 insertion(+)
   create mode 100644 file
  Rebasing (2/2)\r
  Successfully rebased and updated refs/heads/master.

Am I misunderstanding the purpose of the patch?

-Peff
