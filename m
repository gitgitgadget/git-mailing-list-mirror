From: Tair Sabirgaliev <tair.sabirgaliev@bee.kz>
Subject: [PATCH] gitk: workaround Tcl/Tk Cmd-TAB behavior on OSX
Date: Thu, 11 Apr 2013 01:02:48 +0600
Message-ID: <5165B758.4070308@bee.kz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 10 21:02:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0IM-0003Qu-Be
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759532Ab3DJTCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:02:54 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:53636 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759112Ab3DJTCx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:02:53 -0400
Received: by mail-we0-f170.google.com with SMTP id z2so641925wey.29
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bee.kz; s=beekz;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding;
        bh=HTN1nem7/a978i9Tufy30MmXoy4yolNz6AbMFIMrSJ8=;
        b=JmOy2I9hDie6dTpPNbWJ1appEMhW6DlGRDZczWJGK1meyoSQtEWYblaVeMbFkUKQ8+
         NgxSXLledTXbnpYgJDKSZnC0yusxNMYTFIvdVS/JN5jhPoqls3f9kwshk6Tm2zqvhBI8
         14Ih/+Rc+Y3A7V7gXGP+qdnka5riCfu/bWYZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:content-type:content-transfer-encoding:x-gm-message-state;
        bh=HTN1nem7/a978i9Tufy30MmXoy4yolNz6AbMFIMrSJ8=;
        b=LW0z6aQAPVolI5YqkFn8tGrZdd2tf5q8uXDfXZXyQwjmlvxQuUaMbqA6jE0qlFYxw7
         kWCe2LOLqQvuJvI4iHc8lgHKuiEhs+zRTfDv/A8kPA5K4HtExuccdK2h53LBXD6iDLdz
         2EwyxG5nrlzoDnCgGR7XHpMsFOVbdzTQ8ARAaN7XnYm2TuPaVVlmPESiEDC33BxpQkly
         +MSbvzs5sNJS7LWer+BF9pEJNckZRO0Aop3NFv3G5QfZuMLAn/5BsPU8WQ1nCQ73Cz4O
         lql0YpmNYMifXSA3goWZ+cXhfxXIthtpK/mgqPFnNLmYd8gK62UDYyyMrC3TW1Icthkf
         gzpQ==
X-Received: by 10.180.82.68 with SMTP id g4mr5448411wiy.26.1365620571714;
        Wed, 10 Apr 2013 12:02:51 -0700 (PDT)
Received: from Tairs-MacBook-Pro.local ([2.135.63.167])
        by mx.google.com with ESMTPS id n2sm33495373wiy.6.2013.04.10.12.02.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 12:02:51 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-Gm-Message-State: ALoCoQm2sufjLUZl699O2SrpsMQNzG0BLZ58vrRc0iE8cX2l8dH7xMspMWhc+QUdxguAi1sUkMX+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220724>

On OSX Tcl/Tk application windows are created behind all
the applications down the stack of windows. This is very
annoying, because once a gitk window appears, it's the
downmost window and switching to it is pain.

The patch is trivial: if we are on OSX, emulate Cmd-Shift-TAB
key event, so that the gitk application window is brought
from bottom to top.

Signed-off-by: Tair Sabirgaliev <tair.sabirgaliev@gmail.com>
---
  gitk | 13 +++++++++++++
  1 file changed, 13 insertions(+)

diff --git a/gitk b/gitk
index 572f73f..60a87fc 100755
--- a/gitk
+++ b/gitk
@@ -11687,6 +11687,19 @@ if {[catch {package require Tk 8.4} err]} {
      exit 1
  }
  +# On OSX workaround the Tcl/Tk windows going down the stack of Cmd-TAB
+if {[tk windowingsystem] eq "aqua"} {
+    exec osascript -e {
+        tell application "System Events"
+            key down command
+            key down shift
+            keystroke tab
+            key up shift
+            key up command
+        end tell    +    }
+}
+
  # Unset GIT_TRACE var if set
  if { [info exists ::env(GIT_TRACE)] } {
      unset ::env(GIT_TRACE)
-- 
1.8.2
