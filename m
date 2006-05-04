From: "Robin Rosenberg (list subscriber)" 
	<robin.rosenberg.lists@dewire.com>
Subject: Bad error message
Date: Fri, 5 May 2006 01:57:26 +0200
Organization: Dewire
Message-ID: <200605041957.26194.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 05 01:58:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbniJ-00034Q-9g
	for gcvg-git@gmane.org; Fri, 05 May 2006 01:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWEDX60 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 19:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWEDX60
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 19:58:26 -0400
Received: from [83.140.172.130] ([83.140.172.130]:31245 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751485AbWEDX60
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 19:58:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 59282802A9C
	for <git@vger.kernel.org>; Fri,  5 May 2006 01:57:36 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27823-02 for <git@vger.kernel.org>; Fri,  5 May 2006 01:57:36 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id BE12680019B
	for <git@vger.kernel.org>; Fri,  5 May 2006 01:57:33 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19586>

Hi, 

While playing with git I got the following "impossible" error message:

$ git commit --amend
fatal: Ref HEAD is at 3cec3036287d6b24f7ad7f724f8bb9d4032fb1a3 but expected 
3cec3036287d6b24f7ad7f724f8bb9d4032fb1a3

Since impossible things happen rarely, I was somewhat puzzled and it turned 
out not to be so impossible after all, but a rather typical C bug. Since I 
fixed my working directory using git-reset, I'm not sure how to verify the 
code (suggestions welcome), but I'm not sure if that's important since the 
code being replaced by  this patch probably wasn't tested either. :/

Maybe someone could explain what might have been wrong with my work space (git
status turned up nothing wrong or missing).

-- robin

--- git-1.3.1.orig/update-ref.c 2006-04-25 08:07:54.000000000 +0200
+++ git-1.3.1/update-ref.c      2006-05-04 16:30:04.000000000 +0200
@@ -43,8 +43,13 @@
                die("No such ref: %s", refname);

        if (oldval) {
-               if (memcmp(currsha1, oldsha1, 20))
-                       die("Ref %s is at %s but expected %s", refname, sha1_to_hex(currsha1), sha1_to_hex(oldsha1));
+               if (memcmp(currsha1, oldsha1, 20)) {
+                       char sha1str1[41];
+                       char sha1str2[41];
+                       strcpy(sha1str1, sha1_to_hex(currsha1));
+                       strcpy(sha1str2, sha1_to_hex(oldsha1));
+                       die("Ref %s is at %s but expected %s", refname, sha1str1, sha1str2);
+               }
                /* Nothing to do? */
                if (!memcmp(oldsha1, sha1, 20))
                        exit(0);
