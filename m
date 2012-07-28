From: "Michael G. Schwern" <schwern@pobox.com>
Subject: [PATCH 1/8] SVN 1.7 will truncate "not-a%40{0}" to just "not-a".
Date: Sat, 28 Jul 2012 02:47:45 -0700
Message-ID: <1343468872-72133-2-git-send-email-schwern@pobox.com>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Cc: robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	normalperson@yhbt.net, jrnieder@gmail.com, schwern@pobox.com
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 11:49:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv3dt-0005QI-Uc
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 11:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab2G1Jst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 05:48:49 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42332 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab2G1JsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 05:48:05 -0400
Received: by pbbrp8 with SMTP id rp8so6503059pbb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3qd8IGXtXYjd+Qwg03VPcN744G+7izEcMByocy2Uhmg=;
        b=m4rq4IKRRnCXaa/aT5PVoRjkyvP5UehKEvMTfmFf+GefWEgxeovieiQYCwsQWmgJcl
         lyBVJnUaY3PoTKQLtPMURxz7EPAmlg/YQmB456Q+TjnvY/A97asVAt4WQ9MWwl3DCGpE
         myCWbWWUgzb35YwbrVo8dvIoP+PlRAVV57PBpcoDlQ2fuolPOuS8z21ACSutwvJbFpnf
         1fROpVA8UR60iknfW5g4U7Mu15BkIoGmxF0oxZDudfYLZGXs1RUGh6AA6P73NTtGHQZU
         kawU7vZxP9+RrA/zKDJJqTzWVIxiHi3+nSAhmwuU4aPInZWixILpauUx+FO/oafpx3So
         gV5A==
Received: by 10.68.200.98 with SMTP id jr2mr20145536pbc.81.1343468884748;
        Sat, 28 Jul 2012 02:48:04 -0700 (PDT)
Received: from windhund.local.net (c-71-236-173-173.hsd1.or.comcast.net. [71.236.173.173])
        by mx.google.com with ESMTPS id nv6sm3692274pbc.42.2012.07.28.02.48.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 02:48:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1343468872-72133-1-git-send-email-schwern@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202421>

From: "Michael G. Schwern" <schwern@pobox.com>

Rather than guess what SVN is going to do for each version, make the test use
the branch name that was actually created.
---
 t/t9118-git-svn-funky-branch-names.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t9118-git-svn-funky-branch-names.sh b/t/t9118-git-svn-funky-branch-names.sh
index 63fc982..193d3ca 100755
--- a/t/t9118-git-svn-funky-branch-names.sh
+++ b/t/t9118-git-svn-funky-branch-names.sh
@@ -32,6 +32,11 @@ test_expect_success 'setup svnrepo' '
 	start_httpd
 	'
 
+# SVN 1.7 will truncate "not-a%40{0]" to just "not-a".
+# Look at what SVN wound up naming the branch and use that.
+# Be sure to escape the @ if it shows up.
+non_reflog=`svn_cmd ls "$svnrepo/pr ject/branches" | grep not-a | sed 's/\///' | sed 's/@/%40/'`
+
 test_expect_success 'test clone with funky branch names' '
 	git svn clone -s "$svnrepo/pr ject" project &&
 	(
@@ -42,7 +47,7 @@ test_expect_success 'test clone with funky branch names' '
 		git rev-parse "refs/remotes/%2Eleading_dot" &&
 		git rev-parse "refs/remotes/trailing_dot%2E" &&
 		git rev-parse "refs/remotes/trailing_dotlock%2Elock" &&
-		git rev-parse "refs/remotes/not-a%40{0}reflog"
+		git rev-parse "refs/remotes/$non_reflog"
 	)
 	'
 
-- 
1.7.11.3
