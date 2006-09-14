From: Junio C Hamano <junkio@cox.net>
Subject: Re: nightly tarballs of git
Date: Thu, 14 Sep 2006 12:15:03 -0700
Message-ID: <7v1wqe45vs.fsf@assigned-by-dhcp.cox.net>
References: <20060914172754.GF8013@us.ibm.com>
	<20060914175116.GB22279@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nishanth Aravamudan <nacc@us.ibm.com>
X-From: git-owner@vger.kernel.org Thu Sep 14 21:15:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNwg1-0003vZ-T5
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 21:15:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbWINTPG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 15:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWINTPF
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 15:15:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25253 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750775AbWINTPE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 15:15:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060914191503.EJZX6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 14 Sep 2006 15:15:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NKEs1V00C1kojtg0000000
	Thu, 14 Sep 2006 15:14:53 -0400
To: Dave Jones <davej@redhat.com>
In-Reply-To: <20060914175116.GB22279@redhat.com> (Dave Jones's message of
	"Thu, 14 Sep 2006 13:51:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27028>

Dave Jones <davej@redhat.com> writes:

> On Thu, Sep 14, 2006 at 10:27:54AM -0700, Nishanth Aravamudan wrote:
>  > Hi Dave,
>  > 
>  > For simplicities sake when I was running Debian Sarge on a server here,
>  > I was using your nightly tarballs of git to build a fresh up-to-date
>  > version on a regular basis. I noticed though, that the tarballs result
>  > in gits with a version of 1.3.GIT, while the git repository is at
>  > 1.4.2.1. Is that expected?
>
> No, it isn't. (at least by me).
> What the snapshotting script does when cron runs it is just a 'git pull'
> on a repo that was cloned a while back when I first set up the snapshotting
> script.  I could change it to do a fresh clone each time it runs, but
> that seems somewhat wasteful when most of the time there's nothing new to pull.
>
> gitsters, any ideas what could be going wrong here ?
> The original clone of the repo was just a straight clone of git://git.kernel.org/pub/scm/git/git.git

When the build procesure assigns the version to the generated
git binary, it does these checks and takes the first one:

 - Run "git describe" at the top of the source tree.  If it
   returns some version (not an error message), use it.  This
   case should not apply here since we are talking about a
   tarball of a working tree, and it does not have a repository.

 - See if 'version' file exists at the top of the source tree,
   and uses what is recorded there.  This file is placed in the
   resulting tarball by the "make dist" target of the toplevel
   Makefile.

 - Otherwise use DEF_VER hardcoded in GIT-VERSION-GEN script.
   The 1.4.2 series is shipped with DEF_VER set to v1.4.2.GIT,
   so this does not explain why Nashanth sees "1.3.GIT" (or
   "v1.3.GIT", if the original report did not copy it right).

I just snarfed your snapshot tarball from a few days ago, and I
do not see any version file there (which indicates that it is
not a product of "make dist").  Interestingly enough DEF_VER is
set to v1.3.GIT in GIT-VERSION-GEN.  This line was changed from
v1.3.GIT to v1.4.GIT with commit 41292dd on June 10th and then
updated to v1.4.2.GIT with commit 5a71682 on August 3rd.

So a short conclusion is that the directory you are tarring up
does not have snapshot of my tree.

I would like to understand why.  If an automated 'pull' is
failing, that is somewhat worrysome, because I presume you do
not do any development of your own in your snapshot directory
and in that case everything should fast forward.  Even if 'pull'
failed somehow, if it is not reporting its failure, it is even
more worrysome.
