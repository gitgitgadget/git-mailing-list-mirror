From: David Reiss <dreiss@facebook.com>
Subject: [PATCH] Prevent git blame from segfaulting on a missing author name
Date: Tue, 22 Dec 2009 10:51:41 -0800
Message-ID: <4B31153D.4@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:51:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN9pn-0002J9-F2
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 19:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZLVSvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 13:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbZLVSvr
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 13:51:47 -0500
Received: from mailout-snc1.facebook.com ([69.63.179.25]:58660 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751858AbZLVSvq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 13:51:46 -0500
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.15] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id nBMIpNQs029664
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 10:51:23 -0800
Received: from [172.24.132.94] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.105) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 22 Dec
 2009 10:51:44 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-12-22_09:2009-12-12,2009-12-22,2009-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0908210000 definitions=main-0912220154
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135594>

The author name should never be missing in a valid commit, but
git shouldn't segfault no matter what is in the object database.
(Most of the C code was written by Junio.)

Signed-off-by: David Reiss <dreiss@facebook.com>
---
 builtin-blame.c  |   13 ++++++++++---
 t/t8003-blame.sh |   13 +++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index d4e25a5..14830a3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -1305,6 +1305,7 @@ static void get_ac_line(const char *inbuf, const char *what,
 	error_out:
 		/* Ugh */
 		*tz = "(unknown)";
+		strcpy(person, *tz);
 		strcpy(mail, *tz);
 		*time = 0;
 		return;
@@ -1314,20 +1315,26 @@ static void get_ac_line(const char *inbuf, const char *what,
 	tmp = person;
 	tmp += len;
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp == person)
+		goto error_out;
 	*tz = tmp+1;
 	tzlen = (person+len)-(tmp+1);
 
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp == person)
+		goto error_out;
 	*time = strtoul(tmp, NULL, 10);
 	timepos = tmp;
 
 	*tmp = 0;
-	while (*tmp != ' ')
+	while (person < tmp && *tmp != ' ')
 		tmp--;
+	if (tmp <= person)
+		return;
 	mailpos = tmp + 1;
 	*tmp = 0;
 	maillen = timepos - tmp;
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index 13c25f1..ad834f2 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -144,4 +144,17 @@ test_expect_success 'blame path that used to be a directory' '
 	git blame HEAD^.. -- path
 '
 
+test_expect_success 'blame to a commit with no author name' '
+  TREE=`git rev-parse HEAD:`
+  cat >badcommit <<EOF
+tree $TREE
+author <noname> 1234567890 +0000
+committer David Reiss <dreiss@facebook.com> 1234567890 +0000
+
+some message
+EOF
+  COMMIT=`git hash-object -t commit -w badcommit`
+  git --no-pager blame $COMMIT -- uno >/dev/null
+'
+
 test_done
-- 
1.6.3.3
