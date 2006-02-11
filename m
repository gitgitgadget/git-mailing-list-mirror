From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 20:14:09 -0800
Message-ID: <7v1wyasfam.fsf@assigned-by-dhcp.cox.net>
References: <43ED0368.7020204@gmail.com>
	<7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com>
	<7vvevmtza4.fsf@assigned-by-dhcp.cox.net> <43ED5F60.1010408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 05:14:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7m9N-0000XH-6S
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 05:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWBKEOM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 23:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWBKEOM
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 23:14:12 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18569 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932225AbWBKEOM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 23:14:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211041417.EBIB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 23:14:17 -0500
To: gitzilla@gmail.com
In-Reply-To: <43ED5F60.1010408@gmail.com> (A. Large Angry's message of "Fri,
	10 Feb 2006 19:52:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15922>

A Large Angry SCM <gitzilla@gmail.com> writes:

> It also breaks a lot of commands not related to making commits;
> git-fetch for one.

git-sh-setup one is easy to fix.  We could say something equally
silly like this instead:

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 1e638e4..157c7e4 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -41,7 +41,11 @@ then
 	: ${GIT_OBJECT_DIRECTORY="$GIT_DIR/objects"}
 
 	# Make sure we are in a valid repository of a vintage we understand.
-	GIT_DIR="$GIT_DIR" git-var GIT_AUTHOR_IDENT >/dev/null || exit
+	GIT_DIR="$GIT_DIR" git repo-config --get core.nosuch >/dev/null
+	if test $? == 128
+	then
+	    exit
+	fi
 else
 	GIT_DIR=$(git-rev-parse --git-dir) || exit
 fi

The only thing that code cares about is to use a relatively
cheap command to examine "$GIT_DIR/config" to make sure that the
respository format version recorded in the file is of old enough
vintage we understand; the command to cause .git/config to be
read does not have to be git-var.

So after nixing that one, the remaining users all look like they
do want something reasonable from the user anyway, so for them
git-var that fails when the user has not fixed the unusable
gecos is a desirable thing.

	git grep -n git-var '*.sh'

shows:

git-am, git-applypatch, git-format-patch::
	use it to add sign-off by the user.

git-commit, git-tag::
	use it to record the user identity.

git-pull::
	this uses git-var-l which is unfortunate.  We should
	be able to use git-repo-config instead.  Patches
	welcome.
