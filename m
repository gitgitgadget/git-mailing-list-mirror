From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/4] git-gui: handle config booleans without value
Date: Fri, 14 Oct 2011 10:14:49 +0200
Message-ID: <94b050c4cf7ae8df8d79112e13613244ebff4037.1318579823.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 10:15:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REcv2-0007d8-3H
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 10:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924Ab1JNIO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 04:14:58 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53845 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab1JNIO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 04:14:56 -0400
Received: by bkbzt4 with SMTP id zt4so2512825bkb.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 01:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=gPmo8trtnWXZ4JY1QqyC55jkcyC4022c+JpQTzSlXIA=;
        b=mN09v3Y0wlklj+KJWnCTizencT1xzHMC0d1jKWIB9EgUGM16Mva+jcPCHpnHfuY5OQ
         OPoos2SB4cnnJ3bstgK9eJKDvHZo6W0iqKj2sDM0GM/w6LjOUzbI5KE0qOHn1J6kqY5R
         8H3b1r3BvHyxRfzk8Sp+v2hMM9NVLPRsNDGh4=
Received: by 10.204.130.153 with SMTP id t25mr5873947bks.11.1318580094939;
        Fri, 14 Oct 2011 01:14:54 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id d17sm7462116bkq.11.2011.10.14.01.14.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Oct 2011 01:14:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183553>

When git interprets a config variable without a value as bool it is considered
as true. But git-gui doesn't so until yet.

The value for boolean configs are also case-insensitive.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f897160..d687871 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -299,7 +299,9 @@ proc is_config_true {name} {
 	global repo_config
 	if {[catch {set v $repo_config($name)}]} {
 		return 0
-	} elseif {$v eq {true} || $v eq {1} || $v eq {yes}} {
+	}
+	set v [string tolower $v]
+	if {$v eq {} || $v eq {true} || $v eq {1} || $v eq {yes} || $v eq {on}} {
 		return 1
 	} else {
 		return 0
@@ -310,7 +312,9 @@ proc is_config_false {name} {
 	global repo_config
 	if {[catch {set v $repo_config($name)}]} {
 		return 0
-	} elseif {$v eq {false} || $v eq {0} || $v eq {no}} {
+	}
+	set v [string tolower $v]
+	if {$v eq {false} || $v eq {0} || $v eq {no} || $v eq {off}} {
 		return 1
 	} else {
 		return 0
@@ -1060,6 +1064,10 @@ git-version proc _parse_config {arr_name args} {
 				} else {
 					set arr($name) $value
 				}
+			} elseif {[regexp {^([^\n]+)$} $line line name]} {
+				# no value given, but interpreting them as
+				# boolean will be handled as true
+				set arr($name) {}
 			}
 		}
 	}
@@ -1075,6 +1083,10 @@ git-version proc _parse_config {arr_name args} {
 					} else {
 						set arr($name) $value
 					}
+				} elseif {[regexp {^([^=]+)$} $line line name]} {
+					# no value given, but interpreting them as
+					# boolean will be handled as true
+					set arr($name) {}
 				}
 			}
 			close $fd_rc
-- 
1.7.6.789.gb4599
