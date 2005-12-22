From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] whatchanged: customize diff-tree output
Date: Wed, 21 Dec 2005 22:21:59 -0800
Message-ID: <7vvexhr6rc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 07:22:16 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpJqB-0006gY-JY
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 07:22:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429AbVLVGWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 01:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932437AbVLVGWK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 01:22:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56225 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932429AbVLVGWH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 01:22:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222062109.RJAI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Dec 2005 01:21:09 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512212336230.18908@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 21 Dec 2005 23:37:00 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13933>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The output is much nicer on standard 80 columns. If you want the old
> behaviour, you can still do
>
> 	git-whatchanged --abbrev=40
>
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

You already know I am in favor of this; it was the motivation
behind --abbrev.  With an 80-column terminal, especially with
the hardcoded LESS=-S switch, the default diff-raw output was
unusable.

How about doing something like this patch first, and then decide
what the default should be?

I would recommend "--pretty -r --name-status -M" as the default.
But I am not particularly interested in imposing my preference
over that of Linus to the end users.

-- >8 --
This allows the configuration item whatchanged.difftree to
control the output from git-whatchanged command.  For example:

	[whatchanged]
        	difftree = --pretty=fuller --name-status -M

does rename detection, shows the commit header in "fuller"
format and lists modified pathnames with the kind of change
instead of the default hash pairs.

Not having the configuration item is the same as the original
output format (--pretty -r).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
diff --git a/git-whatchanged.sh b/git-whatchanged.sh
index b170f74..b651b3f 100755
--- a/git-whatchanged.sh
+++ b/git-whatchanged.sh
@@ -4,9 +4,15 @@ USAGE='[-p] [--max-count=<n>] [<since>..
 SUBDIRECTORY_OK='Yes'
 . git-sh-setup
 
+diff_tree_flags=$(git-rev-parse --sq --no-revs --flags "$@")
+test -z "$diff_tree_flags" &&
+	diff_tree_flags=$(git-repo-config --get whatchanged.difftree)
+test -z "$diff_tree_flags" &&
+	diff_tree_flags='' # NEW DEFAULT HERE
+
 rev_list_args=$(git-rev-parse --sq --default HEAD --revs-only "$@") &&
-diff_tree_args=$(git-rev-parse --sq --no-revs "$@") &&
+diff_tree_args=$(git-rev-parse --sq --no-revs --no-flags "$@") &&
 
 eval "git-rev-list $rev_list_args" |
-eval "git-diff-tree --stdin --pretty -r $diff_tree_args" |
+eval "git-diff-tree --stdin --pretty -r $diff_tree_flags $diff_tree_args" |
 LESS="$LESS -S" ${PAGER:-less}
