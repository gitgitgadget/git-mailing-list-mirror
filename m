From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: [PATCH] [submodule] Remove duplicate call to set_rev_name
Date: Mon, 17 Jun 2013 11:55:36 +0200
Message-ID: <1371462936-9672-1-git-send-email-iveqy@iveqy.com>
Cc: git@vger.kernel.org, gitster@pobox.com
To: iveqy@iveqy.com
X-From: git-owner@vger.kernel.org Mon Jun 17 11:52:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoW72-0004P6-Jt
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 11:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508Ab3FQJwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 05:52:18 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:44612 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab3FQJwR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 05:52:17 -0400
Received: by mail-la0-f48.google.com with SMTP id lx15so2194362lab.7
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 02:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=OOnznWxoAAmwj2H8UEhU6JTGrHBRwjg2oPdunLdcofQ=;
        b=zzclPWI0VaJhTzzKkd2twRrZmXhgA9ue7lz+JGCXixA05XiC8mADlV8alAFWwYwSqm
         aV/5WKJ0Dy9IPwTv7JtdiZKMVgLnW618bsQP1yAIQzG3sZFuZTvpFPWors5pRXtOtgeG
         JJzN03tjFQ1ggZpP596FtKql0jR5j4ew5efHB4bmGYikmLO+MvHSPsKhJPIGQU96Vnvu
         Iqkt53C1nTdSo3G6avYU2ecxgCPBkN0cKp3C0MIVw+vlZ7/OVgB7SnVwua9QZq76Eu37
         7Ytas6MB9TfIpORtoXqpeLllXkyXDGZbbZHXGE34Uykj6MUmMMs5/BBgl4yQ22kYdU7G
         R8lw==
X-Received: by 10.152.5.197 with SMTP id u5mr6317656lau.59.1371462735029;
        Mon, 17 Jun 2013 02:52:15 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id w9sm5121839lbk.7.2013.06.17.02.52.14
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Jun 2013 02:52:14 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UoWA0-0002WY-OY; Mon, 17 Jun 2013 11:55:40 +0200
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228059>

set_rev_name is a possible expensive operation. If a submodule has
changes in it, set_rev_name was called twice.

Solution is to move set_rev_name so it's only called once, no matter the
codepath taken.

Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
---
 git-submodule.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..75feaf1 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1129,16 +1129,16 @@ cmd_status()
 			say "-$sha1 $displaypath"
 			continue;
 		fi
-		set_name_rev "$sm_path" "$sha1"
 		if git diff-files --ignore-submodules=dirty --quiet -- "$sm_path"
 		then
+			set_name_rev "$sm_path" "$sha1"
 			say " $sha1 $displaypath$revname"
 		else
 			if test -z "$cached"
 			then
 				sha1=$(clear_local_git_env; cd "$sm_path" && git rev-parse --verify HEAD)
-				set_name_rev "$sm_path" "$sha1"
 			fi
+			set_name_rev "$sm_path" "$sha1"
 			say "+$sha1 $displaypath$revname"
 		fi
 
-- 
1.8.0
