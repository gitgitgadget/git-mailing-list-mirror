From: David Reiss <dreiss@facebook.com>
Subject: [PATCH 4/4] Eliminate an unnecessary chdir("..")
Date: Mon, 19 May 2008 23:49:34 -0700
Message-ID: <4832747E.7070607@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 20 08:51:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLh8-0000Pf-Kp
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 08:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516AbYETGur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 02:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756755AbYETGur
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 02:50:47 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:37531 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbYETGuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 02:50:46 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4K6oj8H020424
	for <git@vger.kernel.org>; Mon, 19 May 2008 23:50:45 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 19 May 2008 23:47:42 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
X-OriginalArrivalTime: 20 May 2008 06:47:42.0225 (UTC) FILETIME=[66EB1010:01C8BA45]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-20_01:2008-05-20,2008-05-20,2008-05-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0805090000 definitions=main-0805190302
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82467>

In the case where setup_git_directory_gently fails, avoid the last
chdir("..") by moving it after the ceil_offset check.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Johannes originally asked me to squash this, then asked me to keep the
patch minimal.  I'm including it here in case anyone else thinks it should
go in.  It should be harmless because getcwd is not called in the loop,
and any nonlocal exit from the loop is either a "die" or does a chdir
to cwd, which is an absolute path.

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index c14b106..045ca20 100644
--- a/setup.c
+++ b/setup.c
@@ -446,7 +446,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		chdir("..");
 		while (--offset > ceil_offset && cwd[offset] != '/');
 		if (offset <= ceil_offset) {
 			if (nongit_ok) {
@@ -457,6 +456,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			}
 			die("Not a git repository");
 		}
+		chdir("..");
 	}
 
 	inside_git_dir = 0;
-- 
1.5.4
