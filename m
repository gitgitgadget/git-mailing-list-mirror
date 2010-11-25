From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 17/20] rebase: improve detection of rebase in progress
Date: Thu, 25 Nov 2010 20:58:00 +0100
Message-ID: <1290715083-16919-18-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna8-0001kp-P6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753330Ab0KZB6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:31 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58794 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265Ab0KZB60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:26 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so348008vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yq7QE2tzzwFcvTsy5Z7PoMLDJYnXdzeFxl3UbkvP2TM=;
        b=C7xopGaWvE3MW7Dur+k2sAsiRbIAymgSvavWR2pWl2ez8Ox+iWOB2KpPVOFFl6RElA
         suVVUk5DCh6nT6+E4f0VQOKLD7nMoNnNhiYCsnRdrVRxdthtkSbZzm/GFMeVIOIK0fsA
         klUDoDo7rCPRethBvGSlcWijlI67cu90VutKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=my4BtAes0XNYf8P5ZmKNx8I/iWXV8q9Vrx3X0vBnYai4wsyZ8NCYDRxb3VyFilvboz
         /e82dqqbBzXNKhw6j5+KEXM4R4dFUd4XnQHmiLoWTSP87jrEanOF0/JwUXjf5lDYundu
         94RH6cyhS68pWQDfq21UKfeRUaJSxKT8K4ndk=
Received: by 10.220.181.11 with SMTP id bw11mr420517vcb.32.1290736706038;
        Thu, 25 Nov 2010 17:58:26 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:25 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162166>

Detect early on if a rebase is in progress and what kind of rebase it
is. This prepares for further refactoring where plain (am) rebase will
be dispatched to git-rebase--am.sh and merge rebase will be dispatched
to git-rebase--merge.sh.

The idea is to use the same variables whether the type of rebase was
detected from rebase-apply/ or rebase-merge/ directories or from on
the command line options.

Also show a consistent error message independent of the kind of rebase
that was in progress. Also remove the obsolete wording about an being
in the middle of a 'patch application', since that (an existing
"$GIT_DIR"/rebase-apply/applying) aborts 'git rebase' at an earlier
stage.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |   74 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 43cab41..d233da6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -59,16 +59,19 @@ action=
 preserve_merges=
 autosquash=
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+# Non-empty if a rebase was in progress when 'git rebase' was invoked
+in_progress=
+# One of {am, merge, interactive}
+type=
+# One of {"$GIT_DIR"/rebase-apply, "$GIT_DIR"/rebase-merge}
+state_dir=
 
 read_state () {
-	if test -d "$merge_dir"
+	if test "$type" = merge
 	then
-		state_dir="$merge_dir"
 		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
-	else
-		state_dir="$apply_dir"
 	fi &&
 	head_name=$(cat "$state_dir"/head-name) &&
 	onto=$(cat "$state_dir"/onto) &&
@@ -196,6 +199,23 @@ run_pre_rebase_hook () {
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
+if test -d "$apply_dir"
+then
+	type=am
+	state_dir="$apply_dir"
+elif test -d "$merge_dir"
+then
+	if test -f "$merge_dir"/interactive
+	then
+		type=interactive
+		interactive_rebase=explicit
+	else
+		type=merge
+	fi
+	state_dir="$merge_dir"
+fi
+test -n "$type" && in_progress=t
+
 while test $# != 0
 do
 	case "$1" in
@@ -324,37 +344,24 @@ then
 	test -z "$onto" &&
 	test -z "$preserve_merges" ||
 	usage
-	test -d "$apply_dir" -a -z "$interactive_rebase" ||
-	test -d "$merge_dir" || die "No rebase in progress?"
+	test -z "$in_progress" && die "No rebase in progress?"
 else
-	# Make sure we do not have $apply_dir or $merge_dir
-	if test -z "$do_merge"
+	# Make sure we do not have a rebase in progress
+	if test -n "$in_progress"
 	then
-		if mkdir "$apply_dir" 2>/dev/null
-		then
-			rmdir "$apply_dir"
-		else
-			echo >&2 '
-It seems that I cannot create a rebase-apply directory, and
-I wonder if you are in the middle of patch application or another
-rebase.  If that is not the case, please
-	rm -fr '"$apply_dir"'
+		die '
+It seems that there is already a "${state_dir##*/}" directory, and
+I wonder if you are in the middle of another rebase.  If that is the
+case, please try
+	git rebase (--continue | --abort | --skip)
+If that is not the case, please
+	rm -fr '"$state_dir"'
 and run me again.  I am stopping in case you still have something
 valuable there.'
-		exit 1
-		fi
-	else
-		if test -d "$merge_dir"
-		then
-			die "previous rebase directory $merge_dir still exists." \
-				'Try git rebase (--continue | --abort | --skip)'
-		fi
 	fi
 	test $# -eq 0 && test -z "$rebase_root" && usage
 fi
 
-test -f "$merge_dir"/interactive && interactive_rebase=explicit
-
 test -n "$action" && test -n "$interactive_rebase" && run_interactive_rebase
 
 case "$action" in
@@ -415,6 +422,19 @@ abort)
 	;;
 esac
 
+if test -n "$interactive_rebase"
+then
+	type=interactive
+	state_dir="$merge_dir"
+elif test -n "$do_merge"
+then
+	type=merge
+	state_dir="$merge_dir"
+else
+	type=am
+	state_dir="$apply_dir"
+fi
+
 if test -z "$rebase_root"
 then
 	# The upstream head must be given.  Make sure it is valid.
-- 
1.7.3.2.864.gbbb96
