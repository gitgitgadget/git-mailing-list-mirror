From: "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] rsh.c unterminated string
Date: Fri, 23 Sep 2005 16:30:50 -0700
Message-ID: <4334902A.3010905@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060104090106000604000104"
X-From: git-owner@vger.kernel.org Sat Sep 24 01:32:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIx0y-00056D-Hk
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 01:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVIWXbN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 19:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbVIWXbN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 19:31:13 -0400
Received: from terminus.zytor.com ([209.128.68.124]:33996 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751345AbVIWXbL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 19:31:11 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id j8NNUsAv016821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 23 Sep 2005 16:30:55 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.4
X-Spam-Checker-Version: SpamAssassin 3.0.4 (2005-06-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9212>

This is a multi-part message in MIME format.
--------------060104090106000604000104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The change I made to rsh.c would leave the string unterminated under 
certain conditions, which unfortunately always applied!  This patch 
fixes this.  For some reason this never bit on i386 or ppc, but bit me 
on x86-64.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

--------------060104090106000604000104
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Fix situation where the buffer was not properly null-terminated.

---
commit 62f7819792e7152ae0dc241ed2f7e05e10c0d345
tree 865683d54a0c4d7604711d6b74233f79291eb8ac
parent acfadcfb48e34fdc441e9cffbb385fce9693b363
author Peter Anvin <hpa@tazenda.sc.orionmulti.com> Fri, 23 Sep 2005 16:22:33 -0700
committer Peter Anvin <hpa@tazenda.sc.orionmulti.com> Fri, 23 Sep 2005 16:22:33 -0700

 rsh.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rsh.c b/rsh.c
--- a/rsh.c
+++ b/rsh.c
@@ -53,6 +53,7 @@ static int add_to_string(char **ptrp, in
 	char *p = *ptrp;
 	int size = *sizep;
 	int oc;
+	int err = 0;
 
 	if ( quote ) {
 		oc = shell_quote(p, size, str);
@@ -62,15 +63,14 @@ static int add_to_string(char **ptrp, in
 	}
 
 	if ( oc >= size ) {
-		p[size-1] = '\0';
-		*ptrp += size-1;
-		*sizep = 1;
-		return 1;	/* Overflow, string unusable */
+		err = 1;
+		oc = size-1;
 	}
 
 	*ptrp  += oc;
+	**ptrp  = '\0';
 	*sizep -= oc;
-	return 0;
+	return err;
 }
 
 int setup_connection(int *fd_in, int *fd_out, const char *remote_prog, 

--------------060104090106000604000104--
