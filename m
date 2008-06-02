From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn pulling down duplicate revisions
Date: Mon, 2 Jun 2008 03:42:25 -0700
Message-ID: <20080602104225.GA8401@untitled>
References: <1AD7D1A1-EC3B-450D-A648-04ADB8180E46@sb.org> <20080602050050.GC9904@hand.yhbt.net> <5FB2F28F-4C9A-422E-BF7D-B271471154F9@sb.org> <20080602054034.GA8366@untitled> <0E759330-1A0A-489D-ADA3-B71A49951227@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jun 02 12:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K37VW-00058b-GL
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758729AbYFBKm3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758721AbYFBKm2
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:42:28 -0400
Received: from hand.yhbt.net ([66.150.188.102]:57822 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758705AbYFBKm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:42:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id C56817DC026;
	Mon,  2 Jun 2008 03:42:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0E759330-1A0A-489D-ADA3-B71A49951227@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83511>

Kevin Ballard <kevin@sb.org> wrote:
> On Jun 1, 2008, at 10:40 PM, Eric Wong wrote:
> 
> >Kevin Ballard <kevin@sb.org> wrote:
> >>On Jun 1, 2008, at 10:00 PM, Eric Wong wrote:
> >>
> >>>Kevin Ballard <kevin@sb.org> wrote:
> >>>>I started a git-svn clone on a large svn repository, and I noticed
> >>>>that for various branches, it kept pulling down the exact same
> >>>>revisions (starting at r1). In other words, if I had 4 branches  
> >>>>that
> >>>>shared common history, their common history all got pulled down 4
> >>>>times. I double-checked, and the created commit objects were
> >>>>identical.
> >>>>
> >>>>Why was git-svn pulling down the same revisions over and over, when
> >>>>it
> >>>>already knows it has a commit object for those revisions?
> >>>
> >>>Can you give me an example if a repository and command-line you used
> >>>that does this?   Did you use 'git svn clone -s' or did you manually
> >>>specify the branch locations in the repo?
> >>>
> >>>It could even be a lack of read permissions to the repository root
> >>>that would cause things like this.
> >>
> >>The repository is, unfortunately, a private repo so I can't share it.
> >>I used `git svn clone -s` to clone it. I have the SVN perl bindings
> >>v1.4.4 (according to git svn --version).
> >>
> >>I definitely have read permissions to the repo root. If I specify to
> >>only fetch -r 12000:HEAD (there's 14000-odd revisions), it doesn't
> >>pull down any duplicates, but when I let it start from the root, it
> >>pulls down hundreds of duplicates for multiple branches.
> >
> >Can you at least send me the 'svn log -v' output for that repo?
> >Feel free to leave out the actual log messages and munge the path
> >names if you can't expose that information.
> 
> I'll have to do it tomorrow when I'm at the office. How much log info  
> do you need? I can let it run until I see duplicate revisions (it's  
> pretty obvious, it starts over again from r1).

I'll need the revisions where branches were created from
the common ancestor (presumably trunk) and some revisions
before it.

For debugging problems with restricted repositories, it may be worth it
to create a repository skeleton cloning tool that just reads the output
of 'svn log --xml -v' and recreates a new SVN repository with:

  * all log messages stripped

  * all new files are created with just a random string in them (to
    throw off rename detection on the git side)
    (except symlinks, see below)

  * all path components tokenized and each token replaced with
    a dictionary value.  Something like:

    @tmp = map { $tok{$_} ||= ++$i; $tok{$_} } split(/\//, $old_path);
    $new_path = join('/', @tmp);

    This way all copy history can be preserved

  * all modified files will just get a random byte appended to them

  * all committer names replaced with a dictionary value (similar to
    what is done to path components).


-- 
Eric Wong
