From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-gui: more issues with diff parsing
Date: Fri, 12 Sep 2008 08:23:45 -0700
Message-ID: <20080912152345.GE22960@spearce.org>
References: <200809091030.04507.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAW4-0008Fd-Ks
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647AbYILPXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753346AbYILPXr
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:23:47 -0400
Received: from george.spearce.org ([209.20.77.23]:47198 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYILPXq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:23:46 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E92373835C; Fri, 12 Sep 2008 15:23:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809091030.04507.barra_cuda@katamail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95737>

Michele Ballabio <barra_cuda@katamail.com> wrote:
> The patch
> 	git-gui: Fix diff parsing for lines starting with "--" or "++"
> seems to have introduced some glitches. With this sequence:

Oy.
 
> git init
> touch g
> git add g
> git commit -m"g is a file"
> rm g
> echo "vvvv" > file
> ln -s file g
> git add g file
> git gui
> 
> Now clicking on "g" in the staged changes, git-gui gives this line:
> 	error: Unhandled 2 way diff marker: {d}

The diff is weird:

  $ git-diff-index --cached -p --no-color -U5 d6e02aa06c91c711d98ae06e6e69c5de5841a5e5 -- g
  diff --git a/g b/g
  deleted file mode 100644
  index e69de29..1a010b1
  diff --git a/g b/g
  new file mode 120000
  index e69de29..1a010b1
  --- /dev/null
  +++ b/g
  @@ -0,0 +1 @@
  +file
  \ No newline at end of file

Notice how we get two diffs for the same file?  That's why git-gui
is choking on this particular change.  It expected only one diff
for the path it gave to Git.  It got two back.  In cases like this
we may not be able to support line or hunk application as the patch
is really two different patches against that path.  :-|

> The following patch seems to fix this particular issue, but I don't think
> it's the right fix...

I don't think that is the right fix, but the one that I just tried to
write to do clear_diff when we see the second diff --git line didn't
work either.  Plus we probably need to disable the hunk apply code.

I'll look at it again when I can get more time.

-- 
Shawn.
