From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename git-config-set to git-repo-config
Date: Thu, 24 Nov 2005 13:24:58 -0800
Message-ID: <7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 22:26:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfOac-0005DK-DY
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 22:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656AbVKXVZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 16:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932658AbVKXVZF
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 16:25:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45998 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932656AbVKXVZC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 16:25:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124212421.KLCE6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 16:24:21 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12716>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Well, there are differences:

Thanks; I took yours (big thanks to Tony for teaching us how
great topic branches are -- I can just blow my "hold/repoconfig"
branch which had only one patch away, apply yours to "master"
and merge with other topics), with one minor adjustment.

> - I did not adjust the length of the "=====" line in the dox,

In "make doc", asciidoc barfs if they do not match, so I
adjusted this.

> Well, I don't use Emacs any longer, since it was such a hassle to install 
> it on every machine. I still like it, though.

I do not encourge use of Emacs to others; I was using it as an
excuse for not debugging nor testing it personally myself ;-).

> As for git-mv: looks like we need a "git-perl-setup.perl", right?

Depends on what that git-$lang-setup.$lang does, but I am not
quite sure.  Currently, using git-sh-setup implies you run only
from toplevel, with fairly convoluted logic.

I was looking at git-sh-setup does for the last couple of days;
and it is really hard to decide what the best approach is to
make various pieces subdirectory safe.

Currently git C-level tools works like this:

 - Natively, they work only from the project toplevel.  Period.

 - GIT_DIR defaults to ".git".  GIT_OBJECT_DIRECTORY defaults
   to "$GIT_DIR/objects".

 - If GIT_DIR environment variable does not exist, tools that
   use setup_git_directory() try to find a directory that has a
   subdirectory that looks like a valid GIT_DIR, and chdir() to
   that directory.  They remember the relative path from the new
   cwd() to the original.  If you started from a subdirectory,
   they work at the toplevel, but know where it came from
   e.g. "Documentation/howto/".

   The users of setup_git_directory() are responsible for
   prepending that relative path to user supplied repository
   relative pathnames.  Two functions, prefix_path() and
   get_pathspec(), are supplied to help this process.

   If GIT_DIR environment variable exists, setup_git_directory()
   does not do any ".git/" discovery (there is no point doing so
   because the user told us where it is).  HOWEVER, as a side
   effect of having GIT_DIR, they cannot know where their
   current directory is relative to the project toplevel.  IOW,
   they require to be started at the project toplevel if GIT_DIR
   environment variable exists, and I think this behaviour is
   the only one that makes sense [*1*].

 - The ones that use enter_repo() takes user supplied path,
   chdir() to it and sets GIT_DIR=. environment.  They work in
   naked repository without associated working tree so this is a
   sane behaviour.

 - The ones that use neither assume that they are at the project
   toplevel if they need to access working tree.

Among the scripts, the ones that do _not_ use git-sh-setup but
can work in subdirectories work this way:

 - Do not do project toplevel discovery, do not do chdir.

 - Use only tools that use setup_git_directory().

 - If an access to ".git" is needed, find out where it is by
   running "git-rev-parse --git-dir", but _do_ _not_ export it
   as GIT_DIR; otherwise the tools that use
   setup_git_directory() would not work as expected.

 - They do _not_ work from subdirectory if the user has GIT_DIR
   environment set [*2*].

The ones that do use git-sh-setup can use GIT_DIR shell variable
given by git-sh-setup, but git-sh-setup does _not_ export it
(very important).  If GIT_DIR environment was given by the user,
the commands would not work from subdirectory because many
C-level tools they use have setup_git_directory() internally as
mentioned before.  Otherwise, GIT_DIR is set to .git by this
script, which means these commands can run from the toplevel
only.


[Footnote]

*1* This is because GIT_DIR can point at totally out-of-tree.
Your working tree can live in tmpfs filesystem and GIT_DIR on
safer location.  You may lose uncommitted changes in exchange
for etter filesystem performance this way.

We _could_ special case when GIT_DIR is set to "/some/path/.git"
and "/some/path/" is (grand)*parent directory of the current
directory (e.g. /some/path/Documentation/howto), and do the
usual chdir() + prefix, but I suspect this leads to more
confusion not less.  The rules when things work and do not in
subdirectories become too complex.

*2* This cannot be helped; see *1* above.
