From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Fri, 28 Aug 2009 15:05:31 -0400
Message-ID: <20090828190531.GB11488@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:05:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6lZ-0001XX-8P
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZH1TFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbZH1TFb
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:05:31 -0400
Received: from peff.net ([208.65.91.99]:52646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752055AbZH1TFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:05:31 -0400
Received: (qmail 7236 invoked by uid 107); 28 Aug 2009 19:05:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 15:05:42 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 15:05:31 -0400
Content-Disposition: inline
In-Reply-To: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127332>

On Fri, Aug 28, 2009 at 01:02:23PM +0200, Yann Dirson wrote:

> $ echo foo > bar
> $ git add -N bar
> $ ./git --exec-path=$PWD stash save
> bar: not added yet
> fatal: git-write-tree: error building trees
> Cannot save the current index state
> 
> Maybe it would require some magic in git-stash to detect/save/restore that
> particular state, or "just" to cause "add -N" to insert an empty file
> instead ?

Yes, there needs to be some magic in git-stash to handle this. There are
actually two calls to write-tree: one to save the index and one to save
the working tree. I think the working tree one should be OK, because we
"git add -u" right beforehand, which means "intent-to-add" files will
be saved properly.

For the index case, we unfortunately cannot represent the situation in
the index using a tree, which means we cannot have a stash that doesn't
lose information. So we have to choose either dropping those index
entries, inserting them as blank files, or inserting them with
working-tree contents.

When you apply the stash, if they were:

  - dropped, then you may be surprised to find that those files are now
    untracked

  - inserted as working-tree content, then you may not realize that you
    had not _actually_ added that content to the index earlier, and just
    commit it

  - inserted as blank files, then you may be a bit surprised by the fact
    that it looks like you added a blank version, but at least you will
    still see a diff against the working tree file, alerting you to the
    fact that maybe they weren't entirely ready for commit.

So I think of the three, the last one is the least surprising. The other
option is to die and force the user to resolve the issue, which is what
we do now. It does actually tell you the problem "bar: not added yet",
though we could perhaps improve on that message a bit. I think that
would require a new 'ls-files' flag to list intent-to-add files.

-Peff
