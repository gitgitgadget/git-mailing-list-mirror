From: Jeff King <peff@peff.net>
Subject: Re: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 12:07:49 -0400
Message-ID: <20090512160749.GA29566@coredump.intra.peff.net>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:08:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3uWO-0002lj-8g
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:08:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbZELQHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 12:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbZELQHu
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:07:50 -0400
Received: from peff.net ([208.65.91.99]:36596 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZELQHu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:07:50 -0400
Received: (qmail 31909 invoked by uid 107); 12 May 2009 16:08:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 May 2009 12:08:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2009 12:07:49 -0400
Content-Disposition: inline
In-Reply-To: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118912>

On Tue, May 12, 2009 at 10:35:30PM +0800, Ping Yin wrote:

> a----b
>  \----c
> 
> Given the graph above, I want to create a commit b1 on top of c, where
> b1 and b have the same content. i.e.
> 
> a----b
>  \----c----b1    ( content(b) == content(b1) )
> 
> If there are no untracked files in the working directory, i can do
> 
> git checkout b
> git reset c
> git add .
> git commit -m "the copy of b"
> 
> Is there any simpler way? And if there are untracked files in the
> working directory, how to do it?

You can just munge the index directly, and skip the working tree
entirely:

  rm .git/index
  git read-tree b
  git commit -m 'the copy of b'

You would probably want to "git checkout -f" afterwards to update the
working tree with what's in the index.

You can also do it without even touching the index by using the commit
plumbing:

  echo 'copy of b' >message
  tree=`git rev-parse b^{tree}`
  commit=`git commit-tree $tree -p c <message`
  git update-ref c $commit

-Peff
