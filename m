Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83108C10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5734A20752
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 13:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgCQN3p (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:29:45 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:39831 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgCQN3p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 09:29:45 -0400
Received: from localhost.localdomain (unknown [103.227.96.249])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 53F7D240011;
        Tue, 17 Mar 2020 13:29:34 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2 1/2] git-gui: reduce Tcl version requirement from 8.6 to 8.5
Date:   Tue, 17 Mar 2020 18:59:20 +0530
Message-Id: <20200317132921.7222-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.26.0.rc1.11.g30e9940356
In-Reply-To: <20200317132921.7222-1-me@yadavpratyush.com>
References: <20200314224159.14174-1-me@yadavpratyush.com>
 <20200317132921.7222-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On some MacOS distributions like High Sierra, Tcl 8.5 is shipped by
default. This makes git-gui error out at startup because of the version
mismatch.

The only part that requires Tcl 8.6 is SimpleChord, which depends on
TclOO. So, don't use it and use our homegrown class.tcl instead.

This means some slight syntax changes. Since class.tcl doesn't have an
"unknown" method like TclOO does, we can't just call '$note', but have
to use '$note activate' instead. The constructor now needs a proper
namespace qualifier. Update the documentation to reflect the new syntax.

As of now, the only part of git-gui that needs Tcl 8.5 is a call to
'apply' in lib/index.tcl::lambda. Keep using it until someone shows up
shouting that their OS ships with 8.4 only. Then we would have to look
into implementing it in pure Tcl.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh    |  4 ++--
 lib/chord.tcl | 54 ++++++++++++++++++++++++---------------------------
 lib/index.tcl | 10 ++++++----
 3 files changed, 33 insertions(+), 35 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f41ed2e..027e093 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -30,8 +30,8 @@ along with this program; if not, see <http://www.gnu.org/licenses/>.}]
 ##
 ## Tcl/Tk sanity check
 
-if {[catch {package require Tcl 8.6} err]
- || [catch {package require Tk  8.6} err]
+if {[catch {package require Tcl 8.5} err]
+ || [catch {package require Tk  8.5} err]
 } {
 	catch {wm withdraw .}
 	tk_messageBox \
diff --git a/lib/chord.tcl b/lib/chord.tcl
index 275a6cd..7de7cba 100644
--- a/lib/chord.tcl
+++ b/lib/chord.tcl
@@ -27,7 +27,7 @@
 #   # Turn off the UI while running a couple of async operations.
 #   lock_ui
 #
-#   set chord [SimpleChord new {
+#   set chord [SimpleChord::new {
 #     unlock_ui
 #     # Note: $notice here is not referenced in the calling scope
 #     if {$notice} { info_popup $notice }
@@ -37,9 +37,9 @@
 #   # all operations have been initiated.
 #   set common_note [$chord add_note]
 #
-#   # Pass notes as 'after' callbacks to other operations
-#   async_operation $args [$chord add_note]
-#   other_async_operation $args [$chord add_note]
+#   # Activate notes in 'after' callbacks to other operations
+#   set newnote [$chord add_note]
+#   async_operation $args [list $newnote activate]
 #
 #   # Communicate with the chord body
 #   if {$condition} {
@@ -48,7 +48,7 @@
 #   }
 #
 #   # Activate the common note, making the chord eligible to complete
-#   $common_note
+#   $common_note activate
 #
 # At this point, the chord will complete at some unknown point in the future.
 # The common note might have been the first note activated, or the async
@@ -60,18 +60,21 @@
 #   Represents a procedure that conceptually has multiple entrypoints that must
 #   all be called before the procedure executes. Each entrypoint is called a
 #   "note". The chord is only "completed" when all the notes are "activated".
-oo::class create SimpleChord {
-	variable notes body is_completed
+class SimpleChord {
+	field notes
+	field body
+	field is_completed
 
 	# Constructor:
-	#   set chord [SimpleChord new {body}]
+	#   set chord [SimpleChord::new {body}]
 	#     Creates a new chord object with the specified body script. The
 	#     body script is evaluated at most once, when a note is activated
 	#     and the chord has no other non-activated notes.
-	constructor {body} {
+	constructor new {i_body} {
 		set notes [list]
-		my eval [list set body $body]
+		set body $i_body
 		set is_completed 0
+		return $this
 	}
 
 	# Method:
@@ -80,7 +83,7 @@ oo::class create SimpleChord {
 	#     the chord body will be evaluated. This can be used to set variable
 	#     values for the chord body to use.
 	method eval {script} {
-		namespace eval [self] $script
+		namespace eval [namespace qualifiers $this] $script
 	}
 
 	# Method:
@@ -92,7 +95,7 @@ oo::class create SimpleChord {
 	method add_note {} {
 		if {$is_completed} { error "Cannot add a note to a completed chord" }
 
-		set note [ChordNote new [self]]
+		set note [ChordNote::new $this]
 
 		lappend notes $note
 
@@ -108,8 +111,8 @@ oo::class create SimpleChord {
 
 			set is_completed 1
 
-			namespace eval [self] $body
-			namespace delete [self]
+			namespace eval [namespace qualifiers $this] $body
+			delete_this
 		}
 	}
 }
@@ -119,15 +122,17 @@ oo::class create SimpleChord {
 #   final note of the chord is activated (this can be any note in the chord,
 #   with all other notes already previously activated in any order), the chord's
 #   body is evaluated.
-oo::class create ChordNote {
-	variable chord is_activated
+class ChordNote {
+	field chord
+	field is_activated
 
 	# Constructor:
 	#   Instances of ChordNote are created internally by calling add_note on
 	#   SimpleChord objects.
-	constructor {chord} {
-		my eval set chord $chord
+	constructor new {c} {
+		set chord $c
 		set is_activated 0
+		return $this
 	}
 
 	# Method:
@@ -138,20 +143,11 @@ oo::class create ChordNote {
 	}
 
 	# Method:
-	#   $note
+	#   $note activate
 	#     Activates the note, if it has not already been activated, and
 	#     completes the chord if there are no other notes awaiting
 	#     activation. Subsequent calls will have no further effect.
-	#
-	# NB: In TclOO, if an object is invoked like a method without supplying
-	#     any method name, then this internal method `unknown` is what
-	#     actually runs (with no parameters). It is used in the ChordNote
-	#     class for the purpose of allowing the note object to be called as
-	#     a function (see example above). (The `unknown` method can also be
-	#     used to support dynamic dispatch, but must take parameters to
-	#     identify the "unknown" method to be invoked. In this form, this
-	#     proc serves only to make instances behave directly like methods.)
-	method unknown {} {
+	method activate {} {
 		if {!$is_activated} {
 			set is_activated 1
 			$chord notify_note_activation
diff --git a/lib/index.tcl b/lib/index.tcl
index 1254145..1fc5b42 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -436,7 +436,7 @@ proc revert_helper {txt paths} {
 	#
 	# The asynchronous operations are each indicated below by a comment
 	# before the code block that starts the async operation.
-	set after_chord [SimpleChord new {
+	set after_chord [SimpleChord::new {
 		if {[string trim $err] != ""} {
 			rescan_on_error $err
 		} else {
@@ -522,10 +522,11 @@ proc revert_helper {txt paths} {
 			]
 
 		if {$reply == 1} {
+			set note [$after_chord add_note]
 			checkout_index \
 				$txt \
 				$path_list \
-				[$after_chord add_note] \
+				[list $note activate] \
 				$capture_error
 		}
 	}
@@ -567,14 +568,15 @@ proc revert_helper {txt paths} {
 		if {$reply == 1} {
 			$after_chord eval { set should_reshow_diff 1 }
 
-			delete_files $untracked_list [$after_chord add_note]
+			set note [$after_chord add_note]
+			delete_files $untracked_list [list $note activate]
 		}
 	}
 
 	# Activate the common note. If no other notes were created, this
 	# completes the chord. If other notes were created, then this common
 	# note prevents a race condition where the chord might complete early.
-	$after_common_note
+	$after_common_note activate
 }
 
 # Delete all of the specified files, performing deletion in batches to allow the
-- 
2.26.0.rc1.11.g30e9940356

