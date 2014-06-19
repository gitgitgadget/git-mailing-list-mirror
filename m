From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] gitk: catch mkdtemp errors
Date: Wed, 18 Jun 2014 19:53:14 -0700
Message-ID: <1403146394-9589-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 04:53:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxSTY-0006Bd-Hy
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 04:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210AbaFSCxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 22:53:16 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33207 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895AbaFSCxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 22:53:16 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so1390279pad.14
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 19:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=LKwVDEim7LQn1VgA4DG6xHAxIbiYGIA4fxnB8hQ2yqU=;
        b=CntTq6C9c+UsJRvzvMwt9C/zhQLufA4LZLCxjOK5V+ejQxcCTmvpV0ZS/4HT/qynVH
         gZnQi4mKg7Mj0FcJLmlD08ypikn7fQBlWub5cooF8bhpA9f7/jIyLiqnVx2getNPhEjY
         uPpAVcr15YYHnuUbLAnBQS9aZ9ViRqjB+SVgCntx8GuA5yn2gRXKmMzga3qy+wwskWtD
         voicT7AYLdbW+fBBlDJkTFqpV+kaevMc6TvvQz6OLgkx60r+gFrrxkDE0LnmqklE2NBq
         X1Yk/irfIX9W9PANYJapCc3HEfRO+6Lzfwhsppa0w2A8l0spQddSm9IPCLynIWLZaEyp
         JgVw==
X-Received: by 10.66.102.102 with SMTP id fn6mr2275443pab.6.1403146395616;
        Wed, 18 Jun 2014 19:53:15 -0700 (PDT)
Received: from lustrous.local.com (w.disneyanimation.com. [198.187.190.241])
        by mx.google.com with ESMTPSA id pw4sm5767793pbc.61.2014.06.18.19.53.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 18 Jun 2014 19:53:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.257.g75cc6c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252085>

105b5d3fbb1c00bb0aeaf9d3e0fbe26a7b1993fc introduced a dependency
on mkdtemp, which is not available on Windows.

Use the original temporary directory behavior when mkdtemp fails.
This makes the code use mkdtemp when available and gracefully
fallback to the existing behavior when it is not available.

Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: David Aguilar <davvid@gmail.com>
---
 gitk | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index 41e5071..9237830 100755
--- a/gitk
+++ b/gitk
@@ -3504,7 +3504,9 @@ proc gitknewtmpdir {} {
 	    set tmpdir $gitdir
 	}
 	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
-	set gitktmpdir [exec mktemp -d $gitktmpformat]
+	if {[catch {set gitktmpdir [exec mktemp -d $gitktmpformat]}]} {
+	    set gitktmpdir [file join $gitdir [format ".gitk-tmp.%s" [pid]]]
+	}
 	if {[catch {file mkdir $gitktmpdir} err]} {
 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
 	    unset gitktmpdir
-- 
2.0.0.257.g75cc6c6
