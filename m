From: Dan Loewenherz <daniel.loewenherz@yale.edu>
Subject: [PATCH] Convert to use quiet option when available
Date: Wed, 22 Apr 2009 21:46:02 -0400
Message-ID: <6f5a4e780904221846t3f783eacx4677c26c537f1fa4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Apr 23 03:50:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwo4v-00011X-AP
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 03:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552AbZDWBqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 21:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbZDWBqU
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 21:46:20 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:53086 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbZDWBqT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 21:46:19 -0400
Received: by ewy24 with SMTP id 24so284721ewy.37
        for <git@vger.kernel.org>; Wed, 22 Apr 2009 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=H7w1A2S4EKTiLxHReFd2yVfrGQ6+sq8qHjY3d4SchR0=;
        b=a4SsHkvVOkmDP9UzM98twmKVN2W7g+/CJJ2mtE6WrBRCLEbvfy0dK6YZkuEGhcV6Xa
         EkfKCa+ObilLju0mY2gvx6ZBhrpDECeEgRMYIO886nvlMBslghVFO4ZAmfuQWvpQLLmh
         kxNU/l4VLERRckZnzFzTDeaZL0C5aGLTIeLXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type:content-transfer-encoding;
        b=pHxWGhjBVnaT55TS2GqMUwgzRWeOKgB5CJXiww1kdcGo4Wl1d0jTCvQCh9fy1HYR5d
         oNyBhOoinIctwCYWqtSxMD9+KyMW4S0dl+suJAYqO84ktOJp1SAyzklL1NyKp80BtYBv
         FM7qjUfwAO/llSjFCl2qFLGJvCh8JnaNWBm6Q=
Received: by 10.210.92.8 with SMTP id p8mr447231ebb.23.1240451177550; Wed, 22 
	Apr 2009 18:46:17 -0700 (PDT)
X-Google-Sender-Auth: 7c61b7a395b94ed0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117283>

A minor fix that eliminates usage of "2>/dev/null" when --quiet or
-q has already been implemented.

Signed-off-by: Dan Loewenherz <daniel.loewenherz@yale.edu>
---
 git-filter-branch.sh |    2 +-
 git-merge-resolve.sh |    4 ++--
 git-parse-remote.sh  |    2 +-
 git-pull.sh          |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index b90d3df..37e044d 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -430,7 +430,7 @@ if [ "$filter_tag_name" ]; then
 		if [ "$type" = "tag" ]; then
 			# Dereference to a commit
 			sha1t="$sha1"
-			sha1="$(git rev-parse "$sha1"^{commit} 2>/dev/null)" || continue
+			sha1="$(git rev-parse -q "$sha1"^{commit})" || continue
 		fi

 		[ -f "../map/$sha1" ] || continue
diff --git a/git-merge-resolve.sh b/git-merge-resolve.sh
index 93bcfc2..c9da747 100755
--- a/git-merge-resolve.sh
+++ b/git-merge-resolve.sh
@@ -37,10 +37,10 @@ then
 	exit 2
 fi

-git update-index --refresh 2>/dev/null
+git update-index -q --refresh
 git read-tree -u -m --aggressive $bases $head $remotes || exit 2
 echo "Trying simple merge."
-if result_tree=$(git write-tree  2>/dev/null)
+if result_tree=$(git write-tree 2>/dev/null)
 then
 	exit 0
 else
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..a296719 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -2,7 +2,7 @@

 # git-ls-remote could be called from outside a git managed repository;
 # this would fail in that case and would issue an error message.
-GIT_DIR=$(git rev-parse --git-dir 2>/dev/null) || :;
+GIT_DIR=$(git rev-parse -q --git-dir) || :;

 get_data_source () {
 	case "$1" in
diff --git a/git-pull.sh b/git-pull.sh
index 8c75027..3526153 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -147,7 +147,7 @@ then
 	echo >&2 "Warning: fetch updated the current branch head."
 	echo >&2 "Warning: fast forwarding your working tree from"
 	echo >&2 "Warning: commit $orig_head."
-	git update-index --refresh 2>/dev/null
+	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
 		die 'Cannot fast-forward your working tree.
 After making sure that you saved anything precious from
-- 
1.6.3.rc1.34.g0be9b.dirty
