From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn show-ignore is excrutiatingly slow
Date: Thu, 29 Oct 2009 23:39:36 -0700
Message-ID: <20091030063936.GA13527@dcvr.yhbt.net>
References: <20091028174307.GA5691@atlantic.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git mailing list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 07:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3l9D-0006Cw-TM
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 07:39:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756073AbZJ3Gjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 02:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756052AbZJ3Gjd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 02:39:33 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:50134 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZJ3Gjd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 02:39:33 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id AAA161F790;
	Fri, 30 Oct 2009 06:39:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091028174307.GA5691@atlantic.linksys.moosehall>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131675>

Adam Spiers <git@adamspiers.org> wrote:
> Mail-Followup-To: git mailing list <git@vger.kernel.org>

Hi Adam, MFT is frowned upon here.

> Something is badly wrong here ...
> 
> $ cd $svn_wd
> $ time svn propget -R svn:ignore >/dev/null
> svn propget -R svn:ignore > /dev/null  0.28s user 0.20s system 98% cpu 0.490 total
> $ cd $git_wd
> $ time git svn show-ignore > show-ignore.out
> git svn show-ignore > show-ignore.out  20.52s user 33.69s system 1% cpu 1:23:42.17 total
> 
> That's 10,000 times slower for what is effectively the same source
> tree!  Admittedly the svn propget was a "warm" run and took longer the
> first time around, but even so there are several orders of magnitude
> difference.

It's the difference between reading locally vs remotely.  git svn always
looks at the remote repository for this information.  In your example,
svn was looking at the working copy where it already has that
information in an easily accessible form.

Try running svn against your repository URL instead for a comparison:

  time svn propget -R svn:ignore $SVN_URL >/dev/null

> I had a quick look at the code and it seemed to be doing the svn tree
> recursion itself via Git::SVN::prop_walk(), which might explain why.
> However I did not have time to dig deeper, so would welcome any ideas.

It would be possible to reconstruct the information given untouched
copies of unhandled.log inside $GIT_DIR/svn/**.  On the other hand, it
does require running through the history of the project and I don't
think it's worth it for an operation that should be rarely needed.  I
designed the output of "git svn show-ignore" be stored in
$GIT_DIR/info/exclude

-- 
Eric Wong
