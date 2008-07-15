From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 2/2] git-gui: Allow "Stage Line" to stage adjacent changes independently
Date: Tue, 15 Jul 2008 23:11:01 +0200
Message-ID: <1216156261-9687-2-git-send-email-johannes.sixt@telecom.at>
References: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 15 23:12:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIroc-0006Ff-6V
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:12:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbYGOVLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbYGOVLI
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:11:08 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:54996 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbYGOVLF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:11:05 -0400
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp1.srv.eunet.at (Postfix) with ESMTP id C56EF33D1C;
	Tue, 15 Jul 2008 23:11:01 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.3.323.g1e58
In-Reply-To: <1216156261-9687-1-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88596>

Consider this hunk:

  @@ -10,4 +10,4 @@
   context before
  -old 1
  -old 2
  +new 1
  +new 2
   context after

[Nomenclature: to "stage change 2" means to stage lines "-old 1" and
"+new 1", in any order; likewise for "unstage" and "change 2".]

Previously, we had this situation:

  stage change 1 was not possible
  stage change 2 was possible
  unstage change 1 was possible
  unstage change 2 was not possible

With this change we have this situation:

  stage change 1 is possible
  stage change 2 is not possible
  unstage change 1 is possible
  unstage change 2 is not possible

What's the deal?

Previously, it was impossible to stage change 1 without also staging
change 2; not even by staging the complete hunk and unstaging the unwanted
part.

With this change we can achieve all goals:

  hunk is     want staged   want unstaged   do this
  ----------------------------------------------------------------------
  unstaged    change 1      change 2        stage change 1
  unstaged    change 2      change 1        stage hunk, unstage change 1
  staged      change 1      change 2        unstage hunk, stage change 1
  staged      change 2      change 1        unstage change 1

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
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
1.5.6.3.323.g1e58
