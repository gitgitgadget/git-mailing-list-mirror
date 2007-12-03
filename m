From: Jeff King <peff@peff.net>
Subject: Re: Incorrect git-blame result if I use full path to file
Date: Sun, 2 Dec 2007 21:27:29 -0500
Message-ID: <20071203022729.GD8322@coredump.intra.peff.net>
References: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:27:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz12J-0000oJ-IP
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbXLCC1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXLCC1c
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:27:32 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2877 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbXLCC1c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:27:32 -0500
Received: (qmail 25428 invoked by uid 111); 3 Dec 2007 02:27:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 21:27:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 21:27:29 -0500
Content-Disposition: inline
In-Reply-To: <3665a1a00712021652tbdfe9d1tdc4575d225bfed36@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66846>

On Sun, Dec 02, 2007 at 04:52:36PM -0800, Anatol Pomozov wrote:

> I just start learning git and I found a bug (but sorry if the
> functionality I am trying to blame as a bug not actually bug and it
> was made by intention)

Some of both, I think. :)

> It is exaclty what we expect. But lets try full path for master.txt
> $pwd
> /personal/sources/learn/gitea/repo
> $git blame /personal/sources/learn/gitea/repo/master.txt
> ^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 1) On master
> ^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 2) On master
> ^69bce74 (Anatol Pomozov 2007-12-02 16:44:07 -0800 3) On master

We talk about many git commands taking "files" or "paths" but really
they are git "pathspecs", meaning a path specifier that is relative to
the repository root, and which is generally used for limiting the parts
of the history we are looking at.

So I think what is happening is that git-blame is looking for content
from /personal/sources/..., which of course as a git pathspec doesn't
match any of the files. So everything ends up being blamed on
'^69bce74' (which really means "beyond where we started looking"). But
of course it still finds the content to try blaming in the first place,
because in that instance it treats /personal/sources/... as a file to be
opened.

IOW, it's not intended for users to use absolute paths in this way.
However, the results for git-blame are obviously quite confusing. It
might be worth fixing, but I suspect there are many more such traps
waiting in other commands. I wonder if it would make sense to reject
pathspecs starting with '/' entirely, which would at least give us a
saner error message (and I can't think of a time when such a pathspec
would be useful)? Even more useful would be to convert
/path/to/repo/file to 'file' internally.

-Peff
