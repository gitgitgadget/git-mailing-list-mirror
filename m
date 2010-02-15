From: Jeff King <peff@peff.net>
Subject: Re: Walking commits from the first
Date: Mon, 15 Feb 2010 03:06:46 -0500
Message-ID: <20100215080646.GD5347@coredump.intra.peff.net>
References: <e72faaa81002142037g7f5f518erb9fefbb239124bc5@mail.gmail.com>
 <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:06:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngvyj-00054h-9R
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 09:06:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755352Ab0BOIGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 03:06:43 -0500
Received: from peff.net ([208.65.91.99]:34857 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755266Ab0BOIGm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 03:06:42 -0500
Received: (qmail 15463 invoked by uid 107); 15 Feb 2010 08:06:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 03:06:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 03:06:46 -0500
Content-Disposition: inline
In-Reply-To: <e72faaa81002142039h5531a19y354d24e595295bb1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139997>

On Mon, Feb 15, 2010 at 10:09:02AM +0530, Pavan Kumar Sunkara wrote:

>  When you clone a big git repository and would like to read and
> understand the source code, you need to checkout and read every commit
> right from the first commit. As per my knowledge, there is no command
> (even with flags) to checkout the first commit of the repository.
> 
> If there is some command, please put it in user's manual

In most repositories, you can do this:

  git checkout `git rev-list --reverse HEAD | head -n 1`

but...

> I know that every git commit is a vertice in a DAG which has it's edge
> pointed to it's parent. So, walking from the latest commits to old
> commits is easy but the reverse is not.
> I would like to know if there is any problem if we make the walking
> bidirectional. What i mean is, when a new commit is created, create an
> edge not only from it to it's parent but also from it's parent to it.
> Also, have something for the first commit of the repo which can be
> referred as INIT (similiar to HEAD)

It is not as simple as that, for two reasons.

For walking backwards, you can take multiple paths from merge commits
(which have multiple parents). So there may actually be several "first
commits" if unrelated lines of development were merged together. For
example, in git.git:

  $ git log --format='%h %p' |
    grep ' $'
  16d6b8a
  cb07fc2
  161332a
  1db95b0
  2744b23
  e83c516

There are six root commits. You can see what they are by piping the
above into "tr -d ' ' | git log --no-walk --stdin".

For your "--next" suggestion, it is even worse. There may be an infinite
number of commits that point to a given commit as the parent. So there
is no such thing as "what came next from X". You can only ask
"leading up to some commit Y which is a descendant of X, what was the
commit that came after X". But while there are a finite number of
answers, there is not necessarily just one. If two branches diverged at
X and then remerged before Y, they are both equally "next".

-Peff
