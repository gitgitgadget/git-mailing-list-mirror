From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] git-svn: Avoid spurious errors when rewriteRoot is used.
Date: Fri, 9 Oct 2009 11:01:04 +0400
Organization: HOME
Message-ID: <200910091101.04116.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Oct 09 09:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9Vy-0001y6-BP
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 09:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933015AbZJIHC2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 03:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933022AbZJIHC2
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 03:02:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:33725 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932999AbZJIHC1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 03:02:27 -0400
Received: by fg-out-1718.google.com with SMTP id 22so211622fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 00:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=ZBpJk5OgpcvFf0Vxar/kCie/2s1rRtW5rXK1wj6JG5k=;
        b=LEQffRz/Oq82099AD23QplEie4tqjr83VfMYKs7gOj0+tfwoXQa94nlb2Rr/IxqECG
         p7hm4Y0Bgz3z+mc5PqWZVDuGpglQ2nWo7QKUUY/Ec8d7gUjg9dlkufhRhDJkOflerq1F
         spNhb0EXN7CCjx+/YHOPtzIBwEuyldNrFa9UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=iePYaARAErmT4mc385e07958pXaRuZUuwlIoWnoR5B+A4KRDBloMvD49VqO1/XOJE3
         W/6xWwBqkxW14POWzFXtHryrafGlYcDs84bfukHttugGPrEK5dxkFSPz+8hjdQvYrDbX
         sZE4jeaoopxZMWal1hp29vyDRGjjb2ST+JAyw=
Received: by 10.86.227.27 with SMTP id z27mr2035955fgg.66.1255071639620;
        Fri, 09 Oct 2009 00:00:39 -0700 (PDT)
Received: from keydesk.localnet ([92.255.85.78])
        by mx.google.com with ESMTPS id l12sm1466945fgb.16.2009.10.09.00.00.38
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 00:00:39 -0700 (PDT)
User-Agent: KMail/1.12.1 (Linux/2.6.30.8-64.fc11.i586; KDE/4.3.1; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129748>

After doing a rebase, git-svn checks that the SVN URL
is what it expects. However, it does not account for
rewriteRoot, which is a legitimate way for the URL
to change. This produces a lot of spurious errors.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-svn.perl |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index e0ec258..e9030ff 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -603,8 +603,12 @@ sub cmd_dcommit {
 					  "\nBefore dcommitting";
 				}
 				if ($url_ ne $expect_url) {
-					fatal "URL mismatch after rebase: ",
-					      "$url_ != $expect_url";
+					if ($url_ eq $gs->metadata_url) {
+						print "Accepting rewritten URL: $url_\n";
+					} else {
+						fatal "URL mismatch after rebase: ",
+						      "$url_ != $expect_url";
+					}
 				}
 				if ($uuid_ ne $uuid) {
 					fatal "uuid mismatch after rebase: ",
-- 
1.6.3.2.13.g94af7
