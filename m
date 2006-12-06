X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Explicitly add the default "git pull" behaviour to .git/config on clone
Date: Wed, 6 Dec 2006 12:07:23 +0000
Message-ID: <200612061207.23437.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 12:07:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 2c00bcabea9a852f
X-UID: 181
X-Length: 1791
Content-Disposition: inline
X-OriginalArrivalTime: 06 Dec 2006 12:09:14.0007 (UTC) FILETIME=[585E2270:01C7192F]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33436>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrvYi-00077q-P7 for gcvg-git@gmane.org; Wed, 06 Dec
 2006 13:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760516AbWLFMH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 07:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760521AbWLFMH3
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 07:07:29 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:59938 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1760516AbWLFMH3 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 07:07:29 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Wed, 6 Dec 2006 12:09:13 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GrvYa-0001Dz-00 for <git@vger.kernel.org>; Wed, 06 Dec
 2006 12:07:24 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Without any specification in the .git/config file, git-pull will execute
"git-pull origin"; which in turn defaults to pull from the first "pull"
definition for the remote, "origin".

This is a difficult set of defaults to track for a new user, and it's
difficult to see what tells git to do this (especially when it is
actually hard-coded behaviour).  To ameliorate this slightly, this patch
explicitly specifies the default behaviour during a clone using the
"branch" section of the config.

For example, a clone of a typical repository would create a .git/config
containing:
  [remote "origin"]
  url = proto://host/repo.git
  fetch = refs/heads/master:refs/remotes/origin/master
  [branch "master"]
  remote = origin
  merge = refs/heads/master

The [branch "master"] section is such that there is no change to the
functionality of git-pull, but that functionality is now explicitly
documented.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This is really to help newbies.  By explicitly documenting the default
behaviour, it makes it clearer what is going on.  It also means no routing
through documentation to find out what config option needs changing.

It's possible that we would want to remove the default behaviour entirely
if there is no "branch" definition in the config.  That would prevent
accidents by users who don't know what pull does fully yet.

 git-clone.sh |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 826fdda..992cb7c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -413,7 +413,9 @@ then
 			rm -f "refs/remotes/$origin/HEAD"
 			git-symbolic-ref "refs/remotes/$origin/HEAD" \
 				"refs/remotes/$origin/$head_points_at"
-		esac
+		esac &&
+		git-repo-config branch."$head_points_at".remote "$origin" &&
+		git-repo-config branch."$head_points_at".merge "refs/heads/$head_points_at"
 	esac
 
 	case "$no_checkout" in
-- 
1.4.4.1.g3ece-dirty
