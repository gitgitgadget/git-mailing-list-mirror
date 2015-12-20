From: larsxschneider@gmail.com
Subject: [PATCH v1 1/2] git-p4: kill p4d watchdog on cleanup
Date: Sun, 20 Dec 2015 17:44:28 +0100
Message-ID: <1450629869-49522-2-git-send-email-larsxschneider@gmail.com>
References: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, sunshine@sunshineco.com,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 17:44:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aAh67-0007la-9h
	for gcvg-git-2@plane.gmane.org; Sun, 20 Dec 2015 17:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456AbbLTQof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2015 11:44:35 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34174 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933230AbbLTQoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2015 11:44:34 -0500
Received: by mail-wm0-f68.google.com with SMTP id l126so8347411wml.1
        for <git@vger.kernel.org>; Sun, 20 Dec 2015 08:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eckmrAHSlUzDnEHspJjp1d9YfcXmsrmswQZ4jc0CQQM=;
        b=0MHJN7LJ5uPytPsdTStBKx3wGTvvy7IAzNkSNyQYQaG5kalhJZdjL9TJg7yLe0JntK
         QcQW06+9x/gj4p9rqcYwXtO9WCdx804CubtpywAH9ERNi9nAaF1sEmS/XtVs/UzlidF9
         DPGJ1ExC66RU4iIMZ6PCSxcRRhkC2HtElXB4TYmOnc4SpddvpkCcND8R4bGsJNI/U7N1
         qrHe1anUcRnIjCA4Dp+FpK+PcriLWIbm6pU7nT9JQUHUW2jVLcUeSsvCVCjYVrty0VIP
         WYf0EB43vYS8m9tHiwO8NdDHZZ0Jz7WkcfC3keaBwjRFJChjgV2FXiTycQk7jMW0CVpo
         F24w==
X-Received: by 10.194.86.71 with SMTP id n7mr9571933wjz.107.1450629873522;
        Sun, 20 Dec 2015 08:44:33 -0800 (PST)
Received: from slxBook3.fritz.box (p508BA24E.dip0.t-ipconnect.de. [80.139.162.78])
        by smtp.gmail.com with ESMTPSA id g127sm16057280wmf.24.2015.12.20.08.44.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Dec 2015 08:44:32 -0800 (PST)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1450629869-49522-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282773>

From: Lars Schneider <larsxschneider@gmail.com>

If failing tests are executed with the "immediate" flag then "kill_p4d"
is not called and consequently the watchdog process, which is supposed
to detect a hanging p4d, is not killed. Kill the watchdog always in the
"on exit" cleanup trap.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/lib-git-p4.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index f9ae1d7..30bf7ae 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -76,6 +76,7 @@ pidfile="$TRASH_DIRECTORY/p4d.pid"

 # Sometimes "prove" seems to hang on exit because p4d is still running
 cleanup() {
+	kill -9 $watchdog_pid 2>/dev/null
 	if test -f "$pidfile"
 	then
 		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
--
2.5.1
