From: Junio C Hamano <junkio@cox.net>
Subject: [RFC] exit code from git fetch
Date: Thu, 16 Mar 2006 22:01:12 -0800
Message-ID: <7vek116253.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Mar 17 07:01:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FK81d-0005U0-NK
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 07:01:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752494AbWCQGBP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 01:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbWCQGBP
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 01:01:15 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14231 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1752494AbWCQGBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 01:01:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060317055934.OEOA20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 17 Mar 2006 00:59:34 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17659>

When "git fetch" fails because the remote unexpectedly rewound
its head and fast-forward check triggers, we issued a warning
but kept going anyway.  This proposed patch makes the command
exit with non-zero status.

I think this is a sensible change and makes it easier to use
from scripts, but it might have other issues.  For example when
you are tracking more than one heads from the remote, and the
first one fast-forwards but the second one doesn't, it updates
the first one and then stops.  If we happen to process the
rewound one first, neither is updated because we stop at the
first one.  I think this particular discrepancy probably is not
worth worrying about, but there may be other more serious
fallouts we need to fix if we did this.

Comments?

---
diff --git a/git-fetch.sh b/git-fetch.sh
index 0346d4a..6835634 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -179,6 +179,7 @@ fast_forward_local () {
 			;;
 		*)
 			echo >&2 "  not updating."
+			exit 1
 			;;
 		esac
 	    }
