From: Caleb Cushing <xenoterracide@gmail.com>
Subject: [PATCH] mergetool merge/skip/abort
Date: Wed, 21 Jan 2009 09:37:20 -0500
Message-ID: <81bfc67a0901210637j52fa7a55q51b599e9ff16f6dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 21 15:38:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeEG-0004do-Li
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754122AbZAUOh1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 09:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbZAUOh1
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:37:27 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:65114 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648AbZAUOh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:37:26 -0500
Received: by bwz14 with SMTP id 14so12877206bwz.13
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 06:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=ABiSamp4cSnDdV+IfO7JKIbmlDXcGjCcHVM85srL4bY=;
        b=LY8y8fR0M2DVhZNqlo8CBTo83EbzPYcf80rjmlrUZCZexF/dewRYoqZQeSqMR696Po
         gfiYQYxyL0ifku28wSBWODwGmBWAS6UhoN6xq/KlxK7EfDaAeN0kCyLc0U+KeJeBG30l
         q0QIKXefUXKkMn7vasTNBncxZXJ5CfcslPauM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=YMFhWtjZIg9GKEhTr4DYZZ2FOoo08HKF/Hl48Ub6zRAFgjedhmjP2Qjh5j2PH80HhM
         t/U9G8zegFppCWivtEVALADmrM6xjkvf5GszInvbqhe1iEvnl4NXb5q9he0cbdInyqig
         5e51A795PG8iHNxigdyHMM/DILSRY43dassc4=
Received: by 10.223.109.200 with SMTP id k8mr699496fap.44.1232548640475; Wed, 
	21 Jan 2009 06:37:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106610>

There are some files that I can't merge with git, and sometimes you
just want to finish merging later or move on to the next file and come
back later. My patch allows you to quit mergetool without ctrl-c, or
move on to the next file or merge the this one. pretty simple and I
think will be useful for a lot of people.


>From b647762ad179cdaaf9f844671fdf26074563b366 Mon Sep 17 00:00:00 2001
From: Caleb Cushing <xenoterracide@gmail.com>
Date: Tue, 20 Jan 2009 11:33:30 -0500
Subject: [PATCH] mergetool merge/skip/abort
 add functionality to skip merging a file or abort from the merge

---
 git-mergetool.sh |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 00e1337..43d2a9e 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -177,11 +177,27 @@ merge_file () {
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     if "$prompt" = true; then
-       printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
-       read ans
-    fi
+               while true; do
+               printf "Use (m)erge file or (s)skip file, or (a)bort? (%s): " \
+               "$merge_tool"
+               read ans
+               case "$ans" in
+                       [mM]*)
+                       break
+                       ;;
+                       [sS]*)
+                       cleanup_temp_files
+                       return 0
+                       ;;
+                       [aA]*)
+                       cleanup_temp_files
+                       exit 0
+                       ;;
+               esac
+               done
+       fi

-    case "$merge_tool" in
+       case "$merge_tool" in
        kdiff3)
            if base_present ; then
                ("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2
"$MERGED (Local)" --L3 "$MERGED (Remote)" \
--
1.6.1






-- 
Caleb Cushing

http://xenoterracide.blogspot.com
