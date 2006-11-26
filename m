X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 12:10:52 +0000
Message-ID: <200611261210.52154.andyparkins@gmail.com>
References: <ekbnr6$naq$2@sea.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 12:14:02 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=hRHRkWjpPQwIkTeUSNLLFLqIaxVKUEpn3wsJV1B9z+PkbrhcX8nusjpC+RwQZw++hTIKMIpDJx2ORvCsoZH2nS6+ufB0NPCOxrZszXrUwRm7nEMgecV3+biclM8HqzXG6ibT9GqPR04SG35N/F/2aNigcqDzlr+mtSRcfo3e5Bg=
In-Reply-To: <ekbnr6$naq$2@sea.gmane.org>
X-TUID: 2b9199289c9be3f5
X-UID: 173
X-Length: 1855
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32342>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoItI-0007Hw-F4 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 13:13:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935345AbWKZMNj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 07:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935346AbWKZMNj
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 07:13:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:33219 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935345AbWKZMNi
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 07:13:38 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1851558nfa for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 04:13:37 -0800 (PST)
Received: by 10.78.127.3 with SMTP id z3mr12207648huc.1164543216683; Sun, 26
 Nov 2006 04:13:36 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 37sm19468131hub.2006.11.26.04.13.36; Sun, 26 Nov
 2006 04:13:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Rather than use a separate config .git/remotes/ for remote shortcuts, this
patch adds the analagous definitions to .git/config using git-repo-config
calls.

For example what was previously .git/remotes/origin
  URL: proto://host/path
  Pull: refs/heads/master:refs/heads/origin
Is now added to .git/config as
  [remote "origin"]
  url = proto://host/path
  fetch = refs/heads/master:refs/heads/origin

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
You're absolutely correct; fixed.  This patch replaces the previous (again).

 git-clone.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9ed4135..7e5dc0f 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -373,9 +373,8 @@ then
 		*)	origin_track="$remote_top/$origin"
 			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
 		esac &&
-		echo >"$GIT_DIR/remotes/$origin" \
-		"URL: $repo
-Pull: refs/heads/$head_points_at:$origin_track" &&
+		git-repo-config remote."$origin".url "$repo" &&
+		git-repo-config remote."$origin".fetch "refs/heads/$head_points_at:$origin_track" ^$ &&
 		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
 		while read dotslref
 		do
@@ -389,8 +388,8 @@ Pull: refs/heads/$head_points_at:$origin_track" &&
 			then
 				continue
 			fi
-			echo "Pull: refs/heads/${name}:$remote_top/${name}"
-		done >>"$GIT_DIR/remotes/$origin" &&
+			git-repo-config remote."$origin".fetch "refs/heads/${name}:$remote_top/${name}" ^$
+		done &&
 		case "$use_separate_remote" in
 		t)
 			rm -f "refs/remotes/$origin/HEAD"
-- 
1.4.4.1.g9fd7
