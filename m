From: Jeff King <peff@peff.net>
Subject: Re: Git diff-file bug?
Date: Fri, 28 Sep 2012 16:23:30 -0400
Message-ID: <20120928202330.GA5770@sigill.intra.peff.net>
References: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Batchelor <scott.batchelor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:53:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THiUh-0007hT-Fh
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 23:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945995Ab2I1Vwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 17:52:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33857 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032063Ab2I1UXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 16:23:33 -0400
Received: (qmail 20656 invoked by uid 107); 28 Sep 2012 20:24:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Sep 2012 16:24:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2012 16:23:30 -0400
Content-Disposition: inline
In-Reply-To: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206612>

On Fri, Sep 28, 2012 at 07:55:10PM +0100, Scott Batchelor wrote:

> I'm fairly new to git and am witnessing some strange behavior with git
> that I suspect may be a bug. Can anyone set my mind at rest.

It's not a bug.

> Every so often (I've not quite figured out the exact set of
> circumstances yet)  "git diff-files" shows that every file in my repo
> is modified, when I expect none to be.

Diff-files only looks at the cached sha1 in the index. It will not
re-read the file to update its index entry if its stat information
appears out of date. So what is happening is that another program[1] is
updating the timestamp or other information about each file, but not the
content. Diff-files does not re-read the content to find out there is in
fact no change.

If you are using plumbing like diff-files, you are expected to run "git
update-index --refresh" yourself first. The reasoning is that for
performance reasons, a script that issues many git commands would only
want to pay the price to refresh the index once, at the beginning of the
script.

If you use the "git diff" porcelain, it will automatically refresh the
index for you.

> If I type "git status" (which shows what I expect - no files modified)
> and then "git diff-files" again, git now shows that no files have been
> modified (which is what I expect). It's like "git status" is resetting
> something that "git diff-files" uses.

Exactly. "git status" automatically refreshes the index, and the result
is saved.

> I'm trying to figure out what the problem with "git diff-files" is
> because gitk uses it under the hood, and I think that gitk is
> reporting  erroneous changes (which are also reset by performing a
> "git status" in the repo) in the "patch" files list.

gitk should probably be calling "update-index --refresh" on startup. If
it already is, then it may be that whatever is updating the files is
doing it while gitk is running.

-Peff

[1] Usually stat updates are caused by another program. But we have had
    cases where unusual filesystems yielded inconsistent results from
    stat().
