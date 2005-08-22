From: Jeff Carr <jcarr@linuxmachines.com>
Subject: suggestion: store the URL somewhere in .git/
Date: Mon, 22 Aug 2005 13:08:40 -0700
Message-ID: <430A30C8.3080908@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 22 22:08:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7IZG-0004OD-HX
	for gcvg-git@gmane.org; Mon, 22 Aug 2005 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbVHVUGd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbVHVUGd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 16:06:33 -0400
Received: from [64.71.148.162] ([64.71.148.162]:13213 "EHLO
	mail.linuxmachines.com") by vger.kernel.org with ESMTP
	id S1750767AbVHVUGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 16:06:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.linuxmachines.com (Postfix) with ESMTP id E7C616E7E5
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 13:08:38 -0700 (PDT)
Received: from mail.linuxmachines.com ([127.0.0.1])
	by localhost (giant [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27233-06 for <git@vger.kernel.org>;
	Mon, 22 Aug 2005 13:08:38 -0700 (PDT)
Received: from [192.168.36.10] (x.packeteer.com [12.104.153.15])
	by mail.linuxmachines.com (Postfix) with ESMTP id 4FB716E7B7
	for <git@vger.kernel.org>; Mon, 22 Aug 2005 13:08:38 -0700 (PDT)
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-Enigmail-Version: 0.91.0.0
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at example.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It would be nice if the URL could be stored somewhere in .git/ This
makes it a lot easier to update repositories because you don't always
have to go and track down where you got it in the first place. Something
like this perhaps:

~$ cat .git/location
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/
~$ git-pull-script

Then something like below could be added to handle that easy enough.

Jeff


--- git-pull-script.orig	2005-07-31 22:23:50.000000000 -0700
+++ git-pull-script	2005-08-22 13:01:22.000000000 -0700
@@ -4,13 +4,24 @@
 # cogito.]
 #

+LOCATION="$@"
+
+if [ ! $LOCATION ]
+then
+	if [ -f .git/location ]
+	then
+		LOCATION=`cat .git/location`
+	fi
+fi
+
 . git-sh-setup-script || die "Not a git archive"
-. git-parse-remote "$@"
+. git-parse-remote "$LOCATION"
 merge_name="$_remote_name"

-git-fetch-script "$@" || exit 1
+git-fetch-script "$LOCATION" || exit 1

 git-resolve-script \
 	"$(cat "$GIT_DIR"/HEAD)" \
 	"$(cat "$GIT_DIR"/FETCH_HEAD)" \
 	"Merge $merge_name"
+
