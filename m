From: Fabian Ruch <bafain@gmail.com>
Subject: [RFC 2/3] rebase -i: Reschedule tasks that failed before the index
 was touched
Date: Tue, 27 May 2014 00:19:22 +0200
Message-ID: <5383BDEA.9070908@gmail.com>
References: <533C913C.20106@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 27 00:19:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp3Ey-0001Ia-Br
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 00:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752760AbaEZWT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 18:19:28 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:33349 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaEZWT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 18:19:26 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so5947295lan.23
        for <git@vger.kernel.org>; Mon, 26 May 2014 15:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gVSeDDvdl/yMxNkfAxuSgLpUGk3w90UsYidC5DshjEg=;
        b=nR/LKKN1czl81rCk+0t8s0HUjeQCyFQExCTjNfa7rlbw/GrtJsfH8N0dF1FJrkU/9c
         J5WxZDAjLFsfOSdSMDCfo1P+NrbXEh+i8uCnDEeF/7rotae6f4gI+l3bBfTeYPKDXso8
         ZXfFEqGAnZCf/dU1/5ganPRe9hjfGnH5LPYj/Cj8s8/QvtVAqWZjN2ENb9S/sIn+HsCR
         zfVSh337e1Rt4SpWSC5lIUwwINikgGauAbij7835CqoAqIvqZdkZOfnm0v1TveG87+/R
         eRwQDM0rrvhcEyqMNvVZXE0mGpWiR5gSuUgpqCR7zr1xEtrn9pxcLwTUgC6H9EvzP919
         wPhw==
X-Received: by 10.112.217.10 with SMTP id ou10mr18612351lbc.20.1401142765224;
        Mon, 26 May 2014 15:19:25 -0700 (PDT)
Received: from client.googlemail.com (dhcp-185073.eduroam.chalmers.se. [129.16.185.73])
        by mx.google.com with ESMTPSA id qx6sm13253485lbb.23.2014.05.26.15.19.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 26 May 2014 15:19:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <533C913C.20106@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250126>

When `rebase--interactive` processes a task, it removes the item from
the todo list and appends it to another list of executed tasks. If a
`pick` (this includes `squash` and `fixup`) fails before the index has
recorded the changes, take the corresponding item and put it on the todo
list again. Otherwise, the changes introduced by the scheduled commit
would be lost.

That kind of decision is possible since the `cherry-pick` command
signals why it failed to apply the changes of the given commit. Either
the changes are recorded in the index using a conflict (return value 1)
and `rebase` does not continue until they are resolved or the changes
are not recorded in the index (return value neither 0 nor 1) and
`rebase` has to try again with the same task.

Reported-by: Phil Hord <hordp@cisco.com>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
 git-rebase--interactive.sh | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 9e1dd1e..bba4f3a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -132,6 +132,16 @@ mark_action_done () {
 	fi
 }
 
+# Put the last action marked done at the beginning of the todo list
+# again. If there has not been an action marked done yet, the list of
+# items on the todo list is left unchanged.
+reschedule_last_action () {
+	tail -n 1 "$done" | cat - "$todo" >"$todo".new
+	sed -e \$d <"$done" >"$done".new
+	mv -f "$todo".new "$todo"
+	mv -f "$done".new "$done"
+}
+
 append_todo_help () {
 	git stripspace --comment-lines >>"$todo" <<\EOF
 
@@ -470,11 +480,15 @@ do_pick () {
 			   --no-post-rewrite -n -q -C $1 &&
 			pick_one -n $1 &&
 			git commit --allow-empty --allow-empty-message \
-				   --amend --no-post-rewrite -n -q -C $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+				   --amend --no-post-rewrite -n -q -C $1
 	else
-		pick_one $1 ||
-			die_with_patch $1 "Could not apply $1... $2"
+		pick_one $1
+	fi
+	ret=$?
+	if test $ret -ne 0
+	then
+		test $ret -ne 1 && reschedule_last_action
+		die_with_patch $1 "Could not apply $1... $2"
 	fi
 }
 
@@ -533,8 +547,11 @@ do_next () {
 		author_script_content=$(get_author_ident_from_commit HEAD)
 		echo "$author_script_content" > "$author_script"
 		eval "$author_script_content"
-		if ! pick_one -n $sha1
+		pick_one -n $sha1
+		ret=$?
+		if test $ret -ne 0
 		then
+			test $ret -ne 1 && reschedule_last_action
 			git rev-parse --verify HEAD >"$amend"
 			die_failed_squash $sha1 "$rest"
 		fi
-- 
1.9.3
