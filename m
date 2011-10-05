From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 2/5] Learn to handle gitfiles in enter_repo
Date: Wed, 05 Oct 2011 09:31:26 -0400
Message-ID: <4E8C5C2E.50309@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:36:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBReV-0000rp-07
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934728Ab1JENgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 09:36:45 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:37279 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934670Ab1JENgo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2209; q=dns/txt;
  s=iport; t=1317821804; x=1319031404;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=he/nVeBxHoHx2sN+RH5Ymy5OOybPutN/VIhjO1u/DM8=;
  b=IJZRw3sqjCYZ5UuSHLm7BsDc0Xjc3oIWi5gLCBgdJeF5gGoJLdpL0Evb
   LqCogTnmBgLr1dTicUPJCDIwY3JfwaxqNASKFWQ81Iv3P3LvgQDxWUNeY
   M2TpDMTTnG8xweNF/MagCm2GWZQHQRJDdY/f9jctI1RQadvW5Xk0uDBTw
   M=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIVcjE6tJV2d/2dsb2JhbABCqBGBBYFsAWY8NAJMAQwBBQIBAR6gOgGeDIcpBJNthSeDNokD
X-IronPort-AV: E=Sophos;i="4.68,491,1312156800"; 
   d="scan'208";a="26189165"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-2.cisco.com with ESMTP; 05 Oct 2011 13:36:44 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-6.cisco.com (8.14.3/8.14.3) with ESMTP id p95Dahe7012138;
	Wed, 5 Oct 2011 13:36:43 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-Enigmail-Version: 1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182842>

The enter_repo() function is used to navigate into a .git
directory.  It knows how to find standard alternatives (DWIM) but
it doesn't handle gitfiles created by git init --separate-git-dir.
This means that git-fetch and others do not work with repositories
using the separate-git-dir mechanism.

Teach enter_repo() to deal with the gitfile mechanism by resolving
the path to the redirected path and continuing tests on that path
instead of the found file.

Signed-off-by: Phil Hord <hordp@cisco.com>

---

Not sure how to resolve this for the 'strict' case.

The actual path followed may be different than the version spelled
out on the input path because of resolved symlinks and whatnot.
This function normally returns the unmolested "original" path
that was validated.  In case of a gitfile, I think that means
we should return the url resolved from the gitfile contents.

But should we?

The returned path is only used in git-daemon where it gets
further checks for path restrictions.

A. If we return the gitfile-resolved path, this may cause these
   path restrictions to fail since the path gets canonicalized
   when the gitfile is created by git.

B. If we do not return the gitfile-resolved path, this can create
   a security-hole by allowing remote users to access files they
   would otherwise have been restricted from.  In effect it creates
   an alternate symlink mechanism of which the administator might
   not be aware.


diff --git a/path.c b/path.c
index f3d96aa..46ba326 100644
--- a/path.c
+++ b/path.c
@@ -295,6 +295,7 @@ const char *enter_repo(const char *path, int strict)
 		static const char *suffix[] = {
 			".git/.git", "/.git", ".git", "", NULL,
 		};
+		const char *gitfile;
 		int len = strlen(path);
 		int i;
 		while ((1 < len) && (path[len-1] == '/'))
@@ -330,7 +331,12 @@ const char *enter_repo(const char *path, int strict)
 				break;
 			}
 		}
-		if (!suffix[i] || chdir(used_path))
+		if (!suffix[i])
+			return NULL;
+		gitfile = read_gitfile(used_path) ;
+		if (gitfile)
+			strcpy(used_path, gitfile);
+		if (chdir(used_path))
 			return NULL;
 		path = validated_path;
 	}
-- 
1.7.7.505.ga09f6
