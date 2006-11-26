X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 00:03:30 +0000
Message-ID: <200611260003.31025.andyparkins@gmail.com>
References: <ekafpm@sea.gmane.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 00:06:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=jt/xw2S3uDi8z5e5PMPouJ5g4XEM0kx6VsQDYJdSSbh5Dg6sNeqRnH0OHqHWR8oJPOJEy3lnAAM4py4J7DI50ls1A8jrFIKYoxEbp4oIoiU7RGORwtV5QPEY7EDeGVaxJxTmziJXcv8iZdGK664+jqeqSERHGKFqkwXDmEz1AEY=
In-Reply-To: <ekafpm@sea.gmane.org>
X-TUID: d8c6f004584a2780
X-UID: 170
X-Length: 1871
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32311>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go7XR-0003ii-QJ for gcvg-git@gmane.org; Sun, 26 Nov
 2006 01:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967020AbWKZAGQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 19:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935216AbWKZAGQ
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 19:06:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:27503 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935213AbWKZAGP
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 19:06:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so893416uga for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 16:06:14 -0800 (PST)
Received: by 10.67.117.2 with SMTP id u2mr9584187ugm.1164499573831; Sat, 25
 Nov 2006 16:06:13 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id q1sm12879136uge.2006.11.25.16.06.13; Sat, 25 Nov
 2006 16:06:13 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If .git/remotes/ is now deprecated, then git-clone shouldn't use it.
This patch adds the analogous definitions to .git/config using
git-repo-config calls.

For example what was previously .git/remotes/origin
  URL: proto://host/path
  Pull: refs/heads/master:refs/heads/origin
Is now added to .git/config as
  [remote "origin"]
  url = proto://host/path
  fetch = refs/heads/master:refs/heads/origin

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
I'm not sure if I'm correct in thinking that .git/remotes is deprecated.  If it is,
this patch makes git-clone use .git/config instead.

Personally I like it, I think there should be as small a number of places for 
configuring the repository as possible.


 git-clone.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9ed4135..1057a26 100755
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
+		git-repo-config remote."$origin".fetch "refs/heads/$head_points_at:$origin_track" &&
 		(cd "$GIT_DIR/$remote_top" && find . -type f -print) |
 		while read dotslref
 		do
@@ -389,8 +388,8 @@ Pull: refs/heads/$head_points_at:$origin_track" &&
 			then
 				continue
 			fi
-			echo "Pull: refs/heads/${name}:$remote_top/${name}"
-		done >>"$GIT_DIR/remotes/$origin" &&
+			git-repo-config remote."$origin".fetch "refs/heads/${name}:$remote_top/${name}"
+		done &&
 		case "$use_separate_remote" in
 		t)
 			rm -f "refs/remotes/$origin/HEAD"
-- 
1.4.4.1.gb38c-dirty
