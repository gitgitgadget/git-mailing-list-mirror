From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sun, 18 Mar 2007 22:18:36 +0100
Message-ID: <20070318211836.GA12456@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net> <20070317143452.GA21140@moooo.ath.cx> <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 18 22:18:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT2m4-0004iv-82
	for gcvg-git@gmane.org; Sun, 18 Mar 2007 22:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933140AbXCRVSn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 17:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753274AbXCRVSm
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 17:18:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:43875 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752819AbXCRVSm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 17:18:42 -0400
Received: (qmail invoked by alias); 18 Mar 2007 21:18:40 -0000
X-Provags-ID: V01U2FsdGVkX18gpAh8T4AgwGVLyQqw8KxFKV66kGclEWTTV1J64i
	MsMCjDWl7TcdRr
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vr6rnlyzt.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42522>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> >  * is_bare_repository() in general
> 
> There is a bit of chicken and egg involved in is_bare, because
> we need to find out where GIT_DIR is in order to find where to
> read GIT_DIR/config from, and only after reading the file we
> would know if the user explicitly told us the repository is
> bare, and setup_gently does not want to cd-up if the repository
> is bare (i.e. there is no "top" to move to).

How about changing setup_git_directory_gently to do the following:

Find the git directory ($GIT_DIR, .git in parent directories and "."
at last).

Read configuration for core.bare and core.worktree.  If core.bare is
not specified do the old guessing.

if core.bare = true:
    Set GIT_DIR if it isn't set yet and stop (don't change the
    directory).

if core.bare = false:
    GIT_DIR specified:
        use GIT_WORK_TREE, core.worktree or "." as working tree
    found repository as .git directory:
        use the parent directory of the .git directory as working tree
    found repository in ".":
        use "." as working tree

    if cwd is below the working tree:
        change to working tree
        inside_work_tree = 1
        return prefix
    if cwd is outside of the working tree:
        inside_work_tree = 0
        return NULL
