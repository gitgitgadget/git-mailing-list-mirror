From: Ryan Anderson <ryan@michonline.com>
Subject: Re: git 1.4.0 usability problem
Date: Tue, 20 Jun 2006 02:16:23 -0700
Message-ID: <20060620091622.GP25520@h4x0r5.com>
References: <449557B6.1080907@garzik.org> <7vbqsqdru0.fsf@assigned-by-dhcp.cox.net> <4495DB3B.10403@garzik.org> <7v4pyhdel5.fsf@assigned-by-dhcp.cox.net> <4497B39E.2050205@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 20 11:16:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FscLc-0001eH-RA
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 11:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030197AbWFTJQd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 05:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965225AbWFTJQd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 05:16:33 -0400
Received: from h4x0r5.com ([70.85.31.202]:13835 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S965085AbWFTJQc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 05:16:32 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FscLP-0007pI-MM; Tue, 20 Jun 2006 02:16:23 -0700
To: Jeff Garzik <jeff@garzik.org>
Content-Disposition: inline
In-Reply-To: <4497B39E.2050205@garzik.org>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22184>

On Tue, Jun 20, 2006 at 04:36:46AM -0400, Jeff Garzik wrote:
> Here's a real world example of the 1.4.0 change breaking a merge:
> 
> ("netdev-2.6" == local clone of kernel.org/...jgarzik/netdev-2.6.git)
> [jgarzik@pretzel netdev-2.6]$ git branch
>   ALL
>   e100-sbit
> * master
>   upstream
>   upstream-linus
> 
> [jgarzik@pretzel netdev-2.6]$ git pull /spare/repo/linux-2.6
> Generating pack...
> Done counting 3427 objects.
> Result has 2510 objects.
> Deltifying 2510 objects.
>  100% (2510/2510) done
> Unpacking 2510 objects
> Total 2510, written 2510 (delta 2024), reused 0 (delta 0)
>  100% (2510/2510) done
> Updating from 427abfa28afedffadfca9dd8b067eb6d36bac53f to 
> 25f42b6af09e34c3f92107b36b5aa6edc2fdba2f
> fatal: Untracked working tree file 'drivers/net/myri10ge/Makefile' would 
> be overwritten by merge.
> 
> EXPLANATION:
> 
> * drivers/net/myri10ge/Makefile exists in latest Linus kernel tree, 
> stored locally in /spare/repo/linux-2.6.
> * drivers/net/myri10ge/Makefile exists in netdev-2.6#upstream and 
> netdev-2.6#upstream-linus branches.
> * drivers/net/myri10ge/Makefile does not exist in current branch, 
> netdev-2.6#master.

If that is the case, how did it get into the directory, then?

I suspect the history we're missing is this:

git checkout upstream
...
git checkout -f master

If you have a clean tree, there's not really a reason to use -f.  It
actively hurts you by confusing git as to what state your directory is
in. (If you don't have a clean tree, well, using -f will orphan new
files that Git knows about, and overwrite the changes on ones it does,
so it's still rather inconsistent, and probably not at all what you
intend.)

Instead of using "git checkout -f" to abandon any WIP, try something
like this:

	git branch throw-away HEAD
	git checkout throw-away
	git commit -a -m "throw away"
	git checkout $1
	git branch -D throw-away


i.e:
$ sed -i -e 's/PHONY/YNOHP/g' Makefile
$ git branch throw-away HEAD
$ git checkout throw-away
$ git diff |diffstat
 Makefile |   60 ++++++++++++++++++++++++++++++------------------------------
$ git commit -a -m "throw-away"
$ git checkout master
$ git branch -d throw-away
The branch 'throw-away' is not a strict subset of your current HEAD.
If you are sure you want to delete it, run 'git branch -D throw-away'.
$ git branch -D throw-away
Deleted branch throw-away.
$ git diff | diffstat
0 files changed
$ git branch throw-away HEAD
$ cp Makefile Makefile-ryan
$ git add Makefile-ryan 
$ git checkout throw-away
$ git diff | diffstat
 0 files changed
$ git status
# On branch refs/heads/throw-away
#
# Updated but not checked in:
#   (will commit)
#
#	new file: Makefile-ryan
#
$ git commit -a -m "throw-away"
$ git checkout master
$ git status
nothing to commit

Note that using plain "checkout" should be noticeably faster, too.





-- 

Ryan Anderson
  sometimes Pug Majere
