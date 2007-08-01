From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/9] work-tree clean ups
Date: Wed, 1 Aug 2007 01:28:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708010058130.14781@racer.site>
References: <Pine.LNX.4.64.0707300016470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org, matled@gmx.net
X-From: git-owner@vger.kernel.org Wed Aug 01 02:28:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG25B-0004xk-Uw
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 02:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754103AbXHAA2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jul 2007 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbXHAA2z
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 20:28:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:39656 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753815AbXHAA2y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 20:28:54 -0400
Received: (qmail invoked by alias); 01 Aug 2007 00:28:52 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp003) with SMTP; 01 Aug 2007 02:28:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ml7UPc9GMJwuQCSJ9hE20c1ptLCSv27X4P/+Oks
	V4kl8h7zk7sGQi
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707300016470.14781@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54384>

Hi,

so this is yet another revision of the work-tree clean ups (sorry to all 
those who grow tired of it; I feel with you: I am tired of it, too).

Junio rightfully pointed out that the tests do not succeed after each 
single step of the series.

Alas, after thinking about it for quite some time, I do not think there is 
any way around squashing all the earlier steps 4,6--9 into one step.

There is not really much that can be done about step 6/9: if we are in a 
work tree: that does not mean that we are _not_ in the git_dir.  (And no, 
this does not break git-clean, as a work tree is a work tree is a work 
tree.  If the user was stupid enough to specify the same directory as 
GIT_DIR and GIT_WORK_TREE, then that is _her_ problem.  Git is a powerful 
tool, and you can harm yourself with it.  Tough.)

Patch 7/9 is needed, because the old logic in git-init was wrong, and only 
hidden by the fact that the work-tree logic was implemented wrongly to 
begin with.

Patches 8 and 9/9 only updated the tests to ensure a sane logic, instead 
of an unsane one.  So they are needed, too.

Note: if you are in a bare repository (a repository which either says 
"core.bare = false" in the config, or which is a direct ancestor 
directory, i.e. ../[...]/.. of the current working directory) there will 
_not_ be an automatic working directory assignment.  You will be operating 
_without_ any work tree, unless you specify one.

I somehow feel that core.bare = true weighs more than core.worktree = 
/some/thing, and therefore I implemented it that way, but hey, if enough 
people disagree, then I'll change it.

Maybe I should add two comments?

Namely that setup_git_directory_gently() does _not_ check the config if 
the repository version is right, and where the working directory is, and 
if the repository is bare.  setup_git_directory() does...

And that setup_git_directory_gently() _does_ try to be smart about 
get_git_work_tree(), is_inside_git_dir() and is_inside_work_tree() by 
assigning their return values, and only if core.bare or core.worktree (or 
--work-tree=<something> or GIT_WORK_TREE) are set, get_git_work_tree() and 
is_inside_work_tree() are reset to recalculate what is happening...  
(actually, that is not completely true: if we _know_ that GIT_WORK_TREE is 
set, or --work-tree=<something> which is almost the same, we will defer 
the calculation until one of the functions get_git_work_tree() and 
is_inside_work_tree() is called.)

IMHO we should (probably after 1.5.3) change setup_git_directory_gently() 
to call check_repository_format() in every return path, so that we 
ascertain that the current repository is recent enough.  Because that 
function now checks also if the repo is bare, and if it has a worktree 
set, in addition to ensuring a valid repository.

In hindsight, I should have separated the "check .git/, then ./, and if no 
git_dir was found, continue with the parent directory" into a separate 
patch, but frankly, I am sick and tired of the work-tree series.  It was 
not done right in the first place, and it used hard-to-understand code to 
hide the fact.

Ciao,
Dscho

P.S.: After reading my patch to the tests, I have to disagree strongly 
with my notion that _not_ cleaning up the tests to use some sane syntax 
would make them clearer.  Nevertheless, I think I'll let them stand as an 
example how _not_ to write tests.
