From: Junio C Hamano <junkio@pobox.com>
Subject: gitk from subdirectory
Date: Thu, 30 Aug 2007 21:29:31 -0700
Message-ID: <7vabs85ntg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 06:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQy8W-0007NO-WE
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 06:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXHaE3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 00:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbXHaE3d
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 00:29:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:65188 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750993AbXHaE3c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 00:29:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070831042932.DZQP5837.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Fri, 31 Aug 2007 00:29:32 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id iUVY1X0021gtr5g0000000; Fri, 31 Aug 2007 00:29:32 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57110>

Since commit cdaee5db165ba8bae8d3b524950e61666fc36a84 (gitk:
Improve handling of -- and ambiguous arguments), running gitk
from a subdirectory limits the displayed history with the
current directory as the path limiter, because it always passes
the "--" to the underlying git-rev-list.

One obvious side effect of this is if you create a new directory
and cd to it, gitk will not show anything because no commit in
the history has touched the path you are currently in.

I am wondering if this was intended behaviour change.  I think
it makes sense to want an easy way to say "what changed stuff in
the directory I am in?" because presumably you are there because
you are interested in stuff in there.  But if you hard code "--"
it is not easy to disable that and get the global log.

You always can say "gitk -- ." to limit commits to the current
directory, so it might have been just an oversight.  In which
case, the attached patch may be needed to restore the old
behaviour.

Signed-off-by: Junio C Hamano <junkio@pobox.com>
---
 gitk |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..b95b313 100755
--- a/gitk
+++ b/gitk
@@ -92,8 +92,13 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
+	if {[llength $viewfiles($view)] == 0} {
+	    set rlpaths {}
+	} else {
+	    set rlpaths [list "--" $viewfiles($view)]
+	}
 	set fd [open [concat | git log -z --pretty=raw $order --parents \
-			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
+			 --boundary $viewargs($view) $rlpaths] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
 	exit 1
