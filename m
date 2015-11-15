From: larsxschneider@gmail.com
Subject: [PATCH v5 5/6] git-p4: add trap to kill p4d on test exit
Date: Sun, 15 Nov 2015 14:08:39 +0100
Message-ID: <1447592920-89228-6-git-send-email-larsxschneider@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Cc: sunshine@sunshineco.com, gitster@pobox.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 14:09:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zxx3p-00033m-5t
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 14:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbbKONJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 08:09:23 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38260 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbbKONIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 08:08:48 -0500
Received: by wmec201 with SMTP id c201so86181251wme.1
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 05:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zbT6xR95ItwMVT6VZsmHGpS0dxh0AgUq++kWqnoWrA0=;
        b=CKlUZt2ax+Z6UsWuT5Ow8PE6rEue7BOYRp8a2c8nduoC0fN0VykcvRe2nUxL7VjpOF
         IyYu9f3pdy0JIWDBe6GRoJIshQ+CQbl/6RQXTbEAENzGBZ9ZU6fyrJGxz298eBk6e6aF
         CN60FjK09pyksHXa4Lw7Ae3dl7em+WmDxHpmw6O/sjLQEZ4VLiqTYzvdVNhuKSL4GCrM
         yJQdHDPXfqke6+Z8l/Wvab4EVHd3PJ5NiFiZ/cplHT9Kfz0qc8gylvokUQS4D24kjumF
         Ps4x7K5JnW9zZ0yo5MXCkbWhUu3CcaMKy35yPQ0ILfzRmjos3DNcycd438vccjBC+Ttn
         plnw==
X-Received: by 10.194.201.202 with SMTP id kc10mr37555951wjc.84.1447592927513;
        Sun, 15 Nov 2015 05:08:47 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB712F.dip0.t-ipconnect.de. [93.219.113.47])
        by smtp.gmail.com with ESMTPSA id t2sm13472567wme.0.2015.11.15.05.08.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 15 Nov 2015 05:08:47 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281319>

From: Lars Schneider <larsxschneider@gmail.com>

Sometimes the "prove" test runner hangs on test exit because p4d is
still running. Add a trap to always kill "p4d" on test exit.

You can reproduce the problem by commenting "P4D_TIMEOUT" in
"lib-git-p4.sh" and running "prove ./t9800-git-p4-basic.sh".
---
 t/lib-git-p4.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index f2a009c..f9c68d4 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -65,6 +65,12 @@ cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"
 
+# Sometimes "prove" seems to hang on exit because p4d is still running
+cleanup() {
+	kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
+}
+trap cleanup EXIT
+
 # git p4 submit generates a temp file, which will
 # not get cleaned up if the submission fails.  Don't
 # clutter up /tmp on the test machine.
-- 
2.5.1
