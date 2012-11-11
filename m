From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 10/15] remote-testgit: report success after an import
Date: Sun, 11 Nov 2012 14:59:47 +0100
Message-ID: <1352642392-28387-11-git-send-email-felipe.contreras@gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 11 15:01:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXY6F-0007s4-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 15:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859Ab2KKOBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 09:01:09 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62032 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751692Ab2KKOBI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 09:01:08 -0500
Received: by mail-bk0-f46.google.com with SMTP id jk13so2062168bkc.19
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 06:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=LNI0KB4UL/6e9YFaBBUaXC3Ss+niNCqxSF/7yfdt2wA=;
        b=eXA51hlFLggUJ+hJqoxKFtYeXJUL4I0byDTMepxsrED83QWmzCZZaauGTlxQ+95AB8
         C/8buNMKltjWBM2d6ohIAbRoGhkr4kAgRjDrnCpzooE6IsPac3vIpKwBsyO/hEJ17k5T
         wsRrK0rXZ3nMjviPfzSxC8rnlypn3fW4d38QoamLvCMQEhk4IW0YJ6X5ll8t0fa1r65S
         jA/jRcE8xtNMDSEhaRvs57YZ25+oYtunxFsvDvXkhcVeof2jGGiFT7pf0XzPqVQaWhTj
         ZgMTufIysO+2312xTBtRfQAFTgwpavicMN9y11TwbM1TV4i8R3+Ln7rz6WZLrfkYQDvO
         WpEA==
Received: by 10.204.145.217 with SMTP id e25mr2403798bkv.123.1352642467682;
        Sun, 11 Nov 2012 06:01:07 -0800 (PST)
Received: from localhost (ip-109-43-0-127.web.vodafone.de. [109.43.0.127])
        by mx.google.com with ESMTPS id e3sm1490558bks.7.2012.11.11.06.01.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 06:01:06 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209364>

Doesn't make a difference for the tests, but it does for the ones
seeking reference.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/git-remote-testgit b/git-remote-testgit
index 31c7533..698effc 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -59,7 +59,18 @@ while read line; do
 			sed -e "s#refs/heads/#${prefix}/heads/#g"
 		;;
 	export)
+		before=$(git for-each-ref --format='%(refname) %(objectname)')
+
 		git fast-import --{import,export}-marks="$testgitmarks" --quiet
+
+		after=$(git for-each-ref --format='%(refname) %(objectname)')
+
+		# figure out which refs were updated
+		join -e 0 -o '0 1.2 2.2' -a 2 <(echo "$before") <(echo "$after") | while read ref a b; do
+			test $a == $b && continue
+			echo "ok $ref"
+		done
+
 		echo
 		;;
 	'')
-- 
1.8.0
