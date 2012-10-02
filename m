From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/2] git-gui: Detect full path when parsing arguments
Date: Tue,  2 Oct 2012 12:25:14 -0400
Message-ID: <1349195115-15494-2-git-send-email-andrew.kw.w@gmail.com>
References: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 02 18:25:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ5I0-0007C8-Ni
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 18:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab2JBQZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 12:25:28 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61710 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754984Ab2JBQZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 12:25:28 -0400
Received: by ieak13 with SMTP id k13so15065093iea.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=FNDWaIpOuaYIXgRMwrRaDROQA8vqQOjfOTL+LZwyg7Q=;
        b=op2N9MzEdoGloGycd59Y+Xby3vHKbXnMoAwHi6wet1r5pR9foobvv8zqrsERuSigZ4
         74TueoaL3GJ7gwCBgmLztf+/gZagYFwK/7woQegc/nY6sVtz38bTrrASG2D9eW13u7xX
         CarfUOhqqWgl+vyLg42y3Zk7GdFm04ERx3HHj9KrrwUGzzIFkeR94L2Lv2GCjbgqrMRw
         BEAglOPMuJASTCCBaNirhqDMzJf9tfoAalkGaYcGaqljgIGgkATUzXCbh65KvVHhdbfl
         NdpJHcbMTJhRZR/0hOquKFLmKIpIo6UT6dg9wBYJBE8+3bU91gCBRg6OpBPsRnX5gtky
         fSMw==
Received: by 10.50.45.234 with SMTP id q10mr9400098igm.33.1349195127642;
        Tue, 02 Oct 2012 09:25:27 -0700 (PDT)
Received: from nigel.sohovfx.com ([66.207.196.114])
        by mx.google.com with ESMTPS id d19sm9109210igp.6.2012.10.02.09.25.24
        (version=SSLv3 cipher=OTHER);
        Tue, 02 Oct 2012 09:25:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.1.382.gb0576a6
In-Reply-To: <1349195115-15494-1-git-send-email-andrew.kw.w@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206811>

When running "git-gui blame" from a subfolder (which means prefix is
non-empty), if we pass a full path as argument, the argument parsing
will fail to recognize the argument as a file name, because prefix is
prepended to the argument.

This patch handles that scenario by adding an additional branch that
checks the file name without using the prefix.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-gui.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5d035d5..5d7894b 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3003,10 +3003,19 @@ blame {
 	set jump_spec {}
 	set is_path 0
 	foreach a $argv {
-		if {$is_path || [file exists $_prefix$a]} {
+		if {[file exists $a]} {
+			if {$path ne {}} usage
+			set path [normalize_relpath $a]
+			break
+		} elseif {[file exists $_prefix$a]} {
 			if {$path ne {}} usage
 			set path [normalize_relpath $_prefix$a]
 			break
+		}
+
+		if {$is_path} {
+			if {$path ne {}} usage
+			break
 		} elseif {$a eq {--}} {
 			if {$path ne {}} {
 				if {$head ne {}} usage
-- 
1.7.12.1.382.gb0576a6
