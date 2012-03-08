From: Dominique Quatravaux <domq@google.com>
Subject: [PATCHv2 1/2] rebase -i: optimize the creation of the todo file
Date: Thu,  8 Mar 2012 14:52:56 +0100
Message-ID: <1331214777-9455-1-git-send-email-domq@google.com>
Cc: Dominique Quatravaux <domq@google.com>
To: git@vger.kernel.org, Thomas Rast <trast@inf.ethz.ch>,
	Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:54:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dnc-0001HC-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753217Ab2CHNy2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:54:28 -0500
Received: from mail-gy0-f202.google.com ([209.85.160.202]:58774 "EHLO
	mail-gy0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab2CHNy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 08:54:27 -0500
Received: by ghbz15 with SMTP id z15so54803ghb.1
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=c7eXVZAHdMEGPNEdXE1KI10myBsdi5bx1N6KdVp5Tj8=;
        b=HV1rfWHrNhrqjbuBxLth28dpPZnSPsU0UQahsTFAYa5EbYADji3N9UvqUPgnTT70DR
         TmEB71R+aQjA3iXaPYNjHKoa/USGLfx8kkI0nJMD4f0LKvhIxh49CENKqkwQPn71L998
         WQaE9/TrUAn5ZQNK5WIuKmaZVCcvb6UHg/wWzR/Xy7UbB1MwRjXyi/b/3ycOo+1C+FL1
         a8uoej2Ug8vTjHVjMS0UdcbJhStPhVht+IJO2PN9L2mBNJn44+OdMom5Hol9jebSlK5h
         /C8Hu6tmWBLqVWBAODPFfFUp8XmscwAZNI4lYGdb0AtujzkIjbJqaoCgVnB2NepFeDKa
         PYPQ==
Received: by 10.101.133.40 with SMTP id k40mr720333ann.17.1331214866952;
        Thu, 08 Mar 2012 05:54:26 -0800 (PST)
Received: by 10.101.133.40 with SMTP id k40mr720319ann.17.1331214866844;
        Thu, 08 Mar 2012 05:54:26 -0800 (PST)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id e44si1072158yhk.0.2012.03.08.05.54.26
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Thu, 08 Mar 2012 05:54:26 -0800 (PST)
Received: from alliance-maui.zrh.corp.google.com (alliance-maui.zrh.corp.google.com [172.28.204.12])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id AD8AA100052;
	Thu,  8 Mar 2012 05:54:26 -0800 (PST)
Received: by alliance-maui.zrh.corp.google.com (Postfix, from userid 71297)
	id 8E06E60714; Thu,  8 Mar 2012 14:54:25 +0100 (CET)
X-Mailer: git-send-email 1.7.7.3
X-Gm-Message-State: ALoCoQlmc/Rh+M81btRaUqOS7wK/5hC/mJGHzu0j29YvCTemJW8PYrYNmqXRc2lptekx3+77gI8z5Xlu7PV2+3bvwjbrLFpRQ4JWQmkWsENyn0B/MO7oXbsog/11mteVl5j3lQ7phnbYOvzq1/r816SxFkkhrnOi9njrbBk00bCO5Qqzk5IeJro=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192603>

Instead of obtaining short SHA1's from "git rev-list" and hitting the repository
once more with "git rev-parse" for the full-size SHA1's, obtain both short and
long SHA1's from "git log" at once.
---
 git-rebase--interactive.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5812222..e408e94 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -774,17 +774,16 @@ else
 	revisions=$onto...$orig_head
 	shortrevisions=$shorthead
 fi
-git rev-list $merges_option --pretty=oneline --abbrev-commit \
+git rev-list $merges_option --format="%m%H %h %s" --abbrev-commit \
 	--abbrev=7 --reverse --left-right --topo-order \
 	$revisions | \
 	sed -n "s/^>//p" |
-while read -r shortsha1 rest
+while read -r sha1 shortsha1 rest
 do
 	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "pick $shortsha1 $rest" >> "$todo"
 	else
-		sha1=$(git rev-parse $shortsha1)
 		if test -z "$rebase_root"
 		then
 			preserve=t
-- 
1.7.7.3
