From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: use mktemp -d to avoid predictable temporary directories
Date: Fri, 13 Jun 2014 14:43:48 -0700
Message-ID: <1402695828-91537-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:43:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZGO-00071B-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbaFMVnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 17:43:53 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64937 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbaFMVnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:43:52 -0400
Received: by mail-pd0-f179.google.com with SMTP id fp1so2509057pdb.38
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 14:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fJz6OEOdeRJCemO02REt/iB8dK1o2HlTCBquwnYlGeM=;
        b=mBYjclMhiPyU5ab/fzsoEc5mAamhFZS32nfk8j151ee9F0srqP0mf5Uo4rtS5zHNGL
         ynacQKdT9P6SW6vQKPZRvqykT6Dw6wjJY3XyVzglsv3Y++BSapl1OxA7lme3UK2R70Bt
         rMSmcrW6YhdFm1/QTFcUlISToD/RNKRfF/RdTp1EOxZtL9F6dPVIM17hQqTXBHMohl2M
         qSaxVVxhisWAZrk2XFFI3LEi66aoPU2RfWl+RQerzEZbn/TzgVv+6E4xK/VkWTjA9ZJE
         AcrZfBZrE8qEm5s+hJkGw6mx307HvEUvKxTAY6v2hiYx3U2KAKSQLlXDEzTN44KzY68M
         RA6A==
X-Received: by 10.66.66.135 with SMTP id f7mr6532038pat.22.1402695831842;
        Fri, 13 Jun 2014 14:43:51 -0700 (PDT)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id qv3sm5317670pbb.87.2014.06.13.14.43.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 14:43:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.257.g75cc6c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251641>

gitk uses a predictable ".gitk-tmp.$PID" pattern when generating
a temporary directory.

Use "mktemp -d .gitk-tmp.XXXXXX" to harden gitk against someone
seeding /tmp with files matching the pid pattern.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This issue was brought up during the first review of the previous patch
back in 2009.

http://thread.gmane.org/gmane.comp.version-control.git/132609/focus=132748

This is really [PATCH 2/2] and should be applied on top of my previous
gitk patch.

 gitk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 82293dd..dd2ff63 100755
--- a/gitk
+++ b/gitk
@@ -3502,7 +3502,8 @@ proc gitknewtmpdir {} {
 	} else {
 	    set tmpdir $gitdir
 	}
-	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
+	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
+	set gitktmpdir [exec mktemp -d $gitktmpformat]
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
2.0.0.257.g75cc6c6
