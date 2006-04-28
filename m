From: Junio C Hamano <junkio@cox.net>
Subject: Re: fatal: git-write-tree: not able to write tree
Date: Fri, 28 Apr 2006 02:01:55 -0700
Message-ID: <7v7j5adqf0.fsf@assigned-by-dhcp.cox.net>
References: <CFF307C98FEABE47A452B27C06B85BB64A432C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 11:02:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZOrT-0001pz-SI
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 11:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWD1JB5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Apr 2006 05:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965201AbWD1JB5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 05:01:57 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:64758 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965195AbWD1JB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Apr 2006 05:01:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060428090155.UGWC21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 28 Apr 2006 05:01:55 -0400
To: "Brown, Len" <len.brown@intel.com>
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB64A432C@hdsmsx411.amr.corp.intel.com>
	(Len Brown's message of "Fri, 28 Apr 2006 04:43:00 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19272>

"Brown, Len" <len.brown@intel.com> writes about the command "git
am -3 --resolved", after hand merging _but_ without update-index
to actually mark the paths that have been resolved, results in
"write-tree" failure.

> I'm okay with git being conservative and not doing the update-index
> for me.  Perhaps the thing to do here is to make the failure message
> more useful?
>
> "fatal: git-write-tree: not able to write tree"
>
> everything after "fatal" here is effectively a string
> of random characters to the hapless user.

That's very true.  Perhaps something like this?

-- >8 --
git-am --resolved: more usable error message.

After doing the hard work of hand resolving the conflicts in the
working tree, if the user forgets to run update-index to mark
the paths that have been resolved, the command gave an
unfriendly "fatal: git-write-tree: not able to write tree" error
message.  Catch the situation early and give more meaningful
message and suggestion.

Noticed and suggested by Len Brown.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/git-am.sh b/git-am.sh
index eab4aa8..872145b 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -376,6 +376,13 @@ do
 			echo "No changes - did you forget update-index?"
 			stop_here $this
 		fi
+		unmerged=$(git-ls-files -u)
+		if test -n "$unmerged"
+		then
+			echo "You still have unmerged paths in your index"
+			echo "did you forget update-index?"
+			stop_here $this
+		fi
 		apply_status=0
 		;;
 	esac
