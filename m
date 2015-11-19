From: larsxschneider@gmail.com
Subject: [PATCH v6 5/6] git-p4: add trap to kill p4d on test exit
Date: Thu, 19 Nov 2015 09:58:10 +0100
Message-ID: <1447923491-15330-6-git-send-email-larsxschneider@gmail.com>
References: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 19 09:58:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzL3N-0002hI-Im
	for gcvg-git-2@plane.gmane.org; Thu, 19 Nov 2015 09:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757804AbbKSI6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2015 03:58:48 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33673 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757321AbbKSI6q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2015 03:58:46 -0500
Received: by wmec201 with SMTP id c201so14494050wme.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2015 00:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F/AGYB/4wTtF29NRfgJZsfEXxbNTZuSQoGextmLq0/g=;
        b=L1ak0hJ6r2G1TsQpEt3gfrnqFaTHJEFRrr+go0Yj8ZKvA++ZfD6W0NSG1YWpP6jSbY
         PIdl3CgaYFNrYT7nStya2pn3qobOiwUeinCYp+J2FsaiXUF9/CljSrsfmYu4TXfx0qon
         iy+Dp0lTyDIFfbmTDbl4RmN5i/mXMGXW3XZ5AAWElcpKxdcRhWJKEshqOCUVHB6/6+LW
         B7/5SQiGk4t1GtmuFoEPBbdgGveYm/EALJJntItd8yUe/3G/UdImZc/F1jrToqztgQmX
         XQvR+8wAD7X7cxfwc6A8AE/HiQU2+vfhI4nZUpOEelBCpqJdD+gumbMGuWl+jVILB+kK
         fveg==
X-Received: by 10.194.89.135 with SMTP id bo7mr6735839wjb.147.1447923525500;
        Thu, 19 Nov 2015 00:58:45 -0800 (PST)
Received: from slxBook3.fritz.box (p5DDB77F3.dip0.t-ipconnect.de. [93.219.119.243])
        by smtp.gmail.com with ESMTPSA id m64sm7237965wmf.14.2015.11.19.00.58.44
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Nov 2015 00:58:45 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1447923491-15330-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281470>

From: Lars Schneider <larsxschneider@gmail.com>

Sometimes the "prove" test runner hangs on test exit because p4d is
still running. Add a trap to always kill "p4d" on test exit.

You can reproduce the problem by commenting "P4D_TIMEOUT" in
"lib-git-p4.sh" and running "prove ./t9800-git-p4-basic.sh".

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index acd5578..f9ae1d7 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -74,6 +74,15 @@ cli="$TRASH_DIRECTORY/cli"
 git="$TRASH_DIRECTORY/git"
 pidfile="$TRASH_DIRECTORY/p4d.pid"

+# Sometimes "prove" seems to hang on exit because p4d is still running
+cleanup() {
+	if test -f "$pidfile"
+	then
+		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
+	fi
+}
+trap cleanup EXIT
+
 # git p4 submit generates a temp file, which will
 # not get cleaned up if the submission fails.  Don't
 # clutter up /tmp on the test machine.
--
2.5.1
