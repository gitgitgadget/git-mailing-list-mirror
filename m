From: Jochen Roemling <jochen@roemling.net>
Subject: [COGITO PATCH] Allow file list for cg-add through stdin
Date: Sun, 29 May 2005 19:40:26 +0200
Message-ID: <4299FE8A.1060207@roemling.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun May 29 19:45:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcRqC-0002n5-PO
	for gcvg-git@gmane.org; Sun, 29 May 2005 19:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVE2RrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 May 2005 13:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVE2RrH
	(ORCPT <rfc822;git-outgoing>); Sun, 29 May 2005 13:47:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:3577 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261363AbVE2Rq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 May 2005 13:46:57 -0400
Received: from p54AAFF39.dip.t-dialin.net [84.170.255.57] (helo=[10.3.24.50])
	by mrelayeu.kundenserver.de with ESMTP (Nemesis),
	id 0ML25U-1DcRlx0L9V-0001tP; Sun, 29 May 2005 19:40:25 +0200
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:35bace2e8eeec41a1b9500b782c09cc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

|Hello,

how is the preferred way to add a whole new directory to a 
git-repository using cogito?
Currently cg-add expects all new files on the command line.
The following patch allows to feed files through stdin, which allows to do

    find mynewdir -type f | cg-add -

What about a functionality to specify a directory on the command line 
and all files are
recursively added?

Signed-off-by: Jochen Roemling <jochen@roemling.net>

--- a/cg-add      2005-05-29 19:27:17.000000000 +0200
+++ b/cg-add      2005-05-29 19:32:42.000000000 +0200
@@ -10,12 +10,24 @@

 [ "$1" ] || die "usage: cg-add FILE..."

-for file in "$@"; do
-       if [ -f "$file" ] || [ -h "$file" ]; then
-               echo "Adding file $file"
-       else
-               die "$file does not exist"
-       fi
-done
+if [ "$1" == '-' ]; then
+       set $@ ""
+       while read file; do
+               if [ -f "$file" ] || [ -h "$file" ]; then
+                       echo "Adding file $file"
+                       set $@ "$file"
+               else
+                       die "$file does not exist"
+               fi
+       done
+else
+       for file in "$@"; do
+               if [ -f "$file" ] || [ -h "$file" ]; then
+                       echo "Adding file $file"
+               else
+                       die "$file does not exist"
+               fi
+       done
+fi

 git-update-cache --add -- "$@"

|
