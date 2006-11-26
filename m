X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Use new .git/config for storing "origin" shortcut repository
Date: Sun, 26 Nov 2006 09:35:43 +0000
Message-ID: <200611260935.43762.andyparkins@gmail.com>
References: <7vvel2va9d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 26 Nov 2006 09:39:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=GiCi8/UMgGiBrh2BsfhUJanl1eUd4imPGnjHQ792uAP9k5kuz+aju3pW8kQT/QlrIVcLQ/TgAdGuGSivqYf/xRtFuguWO5tGWZO0wao2sJoy1IYhy0YsPRCG9G9W8xEEFVGNx8rp6emTU8k9Mv1i8bg/QhD/WRtZbQbOvlnVLU4=
In-Reply-To: <7vvel2va9d.fsf@assigned-by-dhcp.cox.net>
X-TUID: 2aa432dc2e0b4c48
X-UID: 172
X-Length: 1884
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32338>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoGU5-0001Xr-DC for gcvg-git@gmane.org; Sun, 26 Nov
 2006 10:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935293AbWKZJjW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 04:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935295AbWKZJjW
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 04:39:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:50114 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935293AbWKZJjV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 04:39:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1815112nfa for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 01:39:20 -0800 (PST)
Received: by 10.78.160.2 with SMTP id i2mr12121527hue.1164533959831; Sun, 26
 Nov 2006 01:39:19 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id 30sm19259860hub.2006.11.26.01.38.28; Sun, 26 Nov
 2006 01:38:28 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Rather than use a separate config .git/remotes/ for remote shortcuts, this
patch adds the analogous definitions to .git/config using git-repo-config
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
Oops; you're absolutely right.  I'd not realised that it was the add operation
that needed the special syntax rather than the replace.

 git-clone.sh |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 9ed4135..19a5a63 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -373,9 +373,8 @@ then
 		*)	origin_track="$remote_top/$origin"
 			git-update-ref "refs/heads/$origin" "$head_sha1" ;;
 		esac &&
-		echo >"$GIT_DIR/remotes/$origin" \
-		"URL: $repo
-Pull: refs/heads/$head_points_at:$origin_track" &&
+		git-repo-config remote."$origin".url "$repo" ^$ &&
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
+			git-repo-config remote."$origin".fetch "refs/heads/${name}:$remote_top/${name} ^$"
+		done &&
 		case "$use_separate_remote" in
 		t)
 			rm -f "refs/remotes/$origin/HEAD"
-- 
1.4.4.1.g9fd7
