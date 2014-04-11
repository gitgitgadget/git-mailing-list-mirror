From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Fri, 11 Apr 2014 19:30:02 +0200
Message-ID: <vpq4n1zg4f9.fsf@anie.imag.fr>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c>
	<0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c>
	<vpqsipkmeum.fsf@anie.imag.fr>
	<D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 19:33:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYfKS-00012m-Cp
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 19:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbaDKRdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 13:33:23 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35458 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751011AbaDKRdV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 13:33:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s3BHU0Bn004184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 11 Apr 2014 19:30:00 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s3BHU20w006151;
	Fri, 11 Apr 2014 19:30:02 +0200
In-Reply-To: <D2BF8546-87B4-431A-B86D-6EFAF205279C@gmail.com> (Kyle J. McKay's
	message of "Fri, 11 Apr 2014 07:29:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 11 Apr 2014 19:30:01 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s3BHU0Bn004184
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397842202.97686@ujBM8oXWWvRVULxLjvQU7w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246114>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> There are already nested functions with file inclusion between both
> levels of nesting in git-rebase--interactive.sh and git-rebase--
> merge.sh now, so it's not introducing anything new.

OK, so it's less serious than I thought. But still, we're introducing a
function with 3 levels of nesting, split accross files, in an area where
we know that at least one shell is buggy ...

>> IOW, why not move the whole run_specific_rebase_internal function to
>> git-rebase--$type?
>
> So what change are you proposing exactly?

Something along the lines of this:

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index df46f4c..4f7b22d 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,6 +4,8 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+run_specific_rebase_infile() {
+
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" \
@@ -75,3 +77,4 @@ then
 fi
 
 move_to_original_branch
+}
[ Same patch for other git-rebase--*.sh variants]
index 76f7f71..1a150bd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -186,7 +186,7 @@ run_specific_rebase_internal () {
 	# run_specific_rebase_internal has the file inclusion as a
 	# last statement, so POSIX and FreeBSD's return will do the
 	# same thing.
-	. git-rebase--$type
+	run_specific_rebase_infile
 }
 
 run_specific_rebase () {
@@ -438,6 +438,8 @@ else
 	state_dir="$apply_dir"
 fi
 
+. git-rebase--$type
+
 if test -z "$rebase_root"
 then
 	case "$#" in

I minimized patch size, so it would obviously need a reidentation, and
would require some cleanup so that run_specific_rebase_internal is
merged back into run_specific_rebase (a bit like your PATCH 2).

I find the result simpler, just using the basic pattern "use '. file' to
import a set of functions, and then use these functions".

The real patch is a bit more tricky though, because we need to run the
". git-rebase--$type" after computing type properly. A patch passing the
tests but requiring cleanup is given below.

> To make the kind of change I think you're proposing would be somewhat
> more invasive than the proposed patch.  Each of the git-rebase--$type
> scripts would have to be modified not to do anything other than define
> functions

That's almost what your patch does already: move everything into a
function, and call it. Except, I'd put the function call outside the
file inclusion.



diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index df46f4c..4f7b22d 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -4,6 +4,8 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
+run_specific_rebase_infile() {
+
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" \
@@ -75,3 +77,4 @@ then
 fi
 
 move_to_original_branch
+}
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6046778..5dfbf14 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -820,6 +820,7 @@ add_exec_commands () {
 	mv "$1.new" "$1"
 }
 
+run_specific_rebase_infile() {
 case "$action" in
 continue)
 	# do we have anything to commit?
@@ -1055,3 +1056,4 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $orig_head
 do_rest
+}
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index d84f412..907aa46 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -99,6 +99,7 @@ finish_rb_merge () {
 	say All done.
 }
 
+run_specific_rebase_infile () {
 case "$action" in
 continue)
 	read_state
@@ -149,3 +150,4 @@ do
 done
 
 finish_rb_merge
+}
diff --git a/git-rebase.sh b/git-rebase.sh
index 76f7f71..63e0e68 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -186,7 +186,7 @@ run_specific_rebase_internal () {
 	# run_specific_rebase_internal has the file inclusion as a
 	# last statement, so POSIX and FreeBSD's return will do the
 	# same thing.
-	. git-rebase--$type
+	run_specific_rebase_infile
 }
 
 run_specific_rebase () {
@@ -366,6 +366,29 @@ then
 	die "$(gettext "The --edit-todo action can only be used during interactive rebase.")"
 fi
 
+if test -n "$rebase_root" && test -z "$onto"
+then
+	test -z "$interactive_rebase" && interactive_rebase=implied
+fi
+
+if test -z "$in_progress"
+then
+	if test -n "$interactive_rebase"
+	then
+		type=interactive
+		state_dir="$merge_dir"
+	elif test -n "$do_merge"
+	then
+		type=merge
+		state_dir="$merge_dir"
+	else
+		type=am
+		state_dir="$apply_dir"
+	fi
+fi
+
+. git-rebase--$type
+
 case "$action" in
 continue)
 	# Sanity check
@@ -420,24 +443,6 @@ and run me again.  I am stopping in case you still have something
 valuable there.')"
 fi
 
-if test -n "$rebase_root" && test -z "$onto"
-then
-	test -z "$interactive_rebase" && interactive_rebase=implied
-fi
-
-if test -n "$interactive_rebase"
-then
-	type=interactive
-	state_dir="$merge_dir"
-elif test -n "$do_merge"
-then
-	type=merge
-	state_dir="$merge_dir"
-else
-	type=am
-	state_dir="$apply_dir"
-fi
-
 if test -z "$rebase_root"
 then
 	case "$#" in


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
