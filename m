From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2 v2] git-gui: "Stage Line": Treat independent changes in adjacent lines better
Date: Thu, 17 Jul 2008 15:21:51 +0200
Message-ID: <1216300911-5170-1-git-send-email-johannes.sixt@telecom.at>
References: <20080716003503.GA24339@spearce.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 15:49:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJTqR-0006Ao-RE
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 15:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243AbYGQNrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 09:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756476AbYGQNrd
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 09:47:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22611 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755750AbYGQNrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 09:47:32 -0400
X-Greylist: delayed 1536 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Jul 2008 09:47:31 EDT
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1KJTQd-0007FN-Ln; Thu, 17 Jul 2008 15:21:52 +0200
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7151F6B7; Thu, 17 Jul 2008 15:21:51 +0200 (CEST)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id 60E7FFA46; Thu, 17 Jul 2008 15:21:51 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.1.275.g0a3e0f
In-Reply-To: <20080716003503.GA24339@spearce.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88851>

Assume that we want to commit these states:

  Old state == HEAD    Intermediate state   New state
  --------------------------------------------------------
  context before       context before       context before
  old 1                new 1                new 1
  old 2                old 2                new 2
  context after        context after        context after

that is, want to commit two changes in this order:

  1. transform "old 1" into "new 1"
  2. transform "old 2" into "new 2"

[This discussion and this patch is about this very case and one other case
as outlined below; any other intermediate states that one could imagine are
not affected by this patch.]

Now assume further, that we have not staged and commited anything, but we
have already changed the working file to the new state. Then we will see
this hunk in the "Unstaged Changes":

  @@ -1,4 +1,4 @@
   context before
  -old 1
  -old 2
  +new 1
  +new 2
   context after

The obvious way to stage the intermediate state is to apply "Stage This
Line" to "-old 1" and "+new 1". Unfortunately, this resulted in this
intermediate state:

  context before
  old 2
  new 1
  context after

which is not what we wanted. In fact, it was impossible to stage the
intermediate state using "Stage Line". The crux was that if a "+" line was
staged, then the "-" lines were converted to context lines and arranged
*before* the "+" line in the forged hunk that we fed to 'git apply'.

With this patch we now treat "+" lines that are staged differently. In
particular, the "-" lines before the "+" block are moved *after* the
staged "+" line. Now it is possible to get the correct intermediate state
by staging "-old 1" and "+new 1". Problem solved.

But there is a catch.

Noticing that we didn't get the right intermediate state by staging
"-old 1" and "+new 1", we could have had the idea to stage the complete
hunk and to *unstage* "-old 2" and "+new 2". But... the result is the same.
The reason is that there is the exact symmetric problem with unstaging the
last "-" and "+" line that are in adjacent blocks of "-" and "+" lines.

This patch does *not* change the way in which "-" lines are *unstaged*.

Why? Because if we did (i.e. move "+" lines before the "-" line after
converting them to context lines), then it would be impossible to stage
this intermediate state:

  context before
  old 1
  new 2
  context after

that is, it would be impossible to stage the two independet changes in the
opposite order.

Let's look at this case a bit further: The obvious way to get this
intermediate state would be to apply "Stage This Line" to "-old 2" and
"+new 2". Before this patch, this worked as expected. With this patch, it
does not work as expected, but it can still be achieved by first staging
the entire hunk, then *unstaging* "-old 1" and "+new 1".

In summary, this patch makes a common case possible, at the expense that
a less common case is made more complicated for the user.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

  The patch is unmodified, but I hope the commit message is clearer.

  -- Hannes

 lib/diff.tcl |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index ee7f391..77990c5 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -411,6 +411,53 @@ proc apply_line {x y} {
 	set hh [lindex [split $hh ,] 0]
 	set hln [lindex [split $hh -] 1]
 
+	# There is a special situation to take care of. Consider this hunk:
+	#
+	#    @@ -10,4 +10,4 @@
+	#     context before
+	#    -old 1
+	#    -old 2
+	#    +new 1
+	#    +new 2
+	#     context after
+	#
+	# We used to keep the context lines in the order they appear in the
+	# hunk. But then it is not possible to correctly stage only
+	# "-old 1" and "+new 1" - it would result in this staged text:
+	#
+	#    context before
+	#    old 2
+	#    new 1
+	#    context after
+	#
+	# (By symmetry it is not possible to *un*stage "old 2" and "new 2".)
+	#
+	# We resolve the problem by introducing an asymmetry, namely, when
+	# a "+" line is *staged*, it is moved in front of the context lines
+	# that are generated from the "-" lines that are immediately before
+	# the "+" block. That is, we construct this patch:
+	#
+	#    @@ -10,4 +10,5 @@
+	#     context before
+	#    +new 1
+	#     old 1
+	#     old 2
+	#     context after
+	#
+	# But we do *not* treat "-" lines that are *un*staged in a special
+	# way.
+	#
+	# With this asymmetry it is possible to stage the change
+	# "old 1" -> "new 1" directly, and to stage the change
+	# "old 2" -> "new 2" by first staging the entire hunk and
+	# then unstaging the change "old 1" -> "new 1".
+
+	# This is non-empty if and only if we are _staging_ changes;
+	# then it accumulates the consecutive "-" lines (after converting
+	# them to context lines) in order to be moved after the "+" change
+	# line.
+	set pre_context {}
+
 	set n 0
 	set i_l [$ui_diff index "$i_l + 1 lines"]
 	set patch {}
@@ -422,19 +469,27 @@ proc apply_line {x y} {
 		    [$ui_diff compare $the_l < $next_l]} {
 			# the line to stage/unstage
 			set ln [$ui_diff get $i_l $next_l]
-			set patch "$patch$ln"
 			if {$c1 eq {-}} {
 				set n [expr $n+1]
+				set patch "$patch$pre_context$ln"
+			} else {
+				set patch "$patch$ln$pre_context"
 			}
+			set pre_context {}
 		} elseif {$c1 ne {-} && $c1 ne {+}} {
 			# context line
 			set ln [$ui_diff get $i_l $next_l]
-			set patch "$patch$ln"
+			set patch "$patch$pre_context$ln"
 			set n [expr $n+1]
+			set pre_context {}
 		} elseif {$c1 eq $to_context} {
 			# turn change line into context line
 			set ln [$ui_diff get "$i_l + 1 chars" $next_l]
-			set patch "$patch $ln"
+			if {$c1 eq {-}} {
+				set pre_context "$pre_context $ln"
+			} else {
+				set patch "$patch $ln"
+			}
 			set n [expr $n+1]
 		}
 		set i_l $next_l
-- 
1.5.6.1.275.g0a3e0f
