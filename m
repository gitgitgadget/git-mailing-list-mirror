From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: fix occasional test failure in kill_p4d
Date: Wed, 29 Apr 2015 22:26:09 +0100
Message-ID: <1430342769-20521-2-git-send-email-luke@diamand.org>
References: <1430342769-20521-1-git-send-email-luke@diamand.org>
Cc: Junio C Hamano <gitster@pobox.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:26:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZVQ-0004Wb-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbbD2V0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:26:51 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33120 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbD2V0t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:26:49 -0400
Received: by pacwv17 with SMTP id wv17so39076691pac.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2015 14:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=risHa2sibRcNPtKvHkgXRJ5cozMlt1bkcpa87Wy1Jy4=;
        b=fuaUQ39xoPOiX8kRmmqHub35o7DcwK2pLNPfpERiA29gELUsigfeNWWnsX1tQwnG+g
         zMlz8lJJ9dQgR9AWBD72oPXogKMAz17VhDZGZokdlnppS9iX4lcD8iq3Otz0Yk5vgpIR
         0iosOY2oqoAOFhgam9AW9b85i9JNpflhTM5Vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=risHa2sibRcNPtKvHkgXRJ5cozMlt1bkcpa87Wy1Jy4=;
        b=HnmCw8crcDwpj/AxchDrdS+osoZY4hZN9/FyxfYYrjP1rRjh8LxctfeL8ubsskbym9
         RVzK2aOP/D3rajAtrqGyVWVCRR6SsydyyU2kq+59s3ShtTpig293narP3z3yW0r1O7t+
         0KkRg48ofbmRP/yUlL3E+Ex5I0uVYhpHHd8Ejz4/9qUsU/HJ7aSqcsBBEX6WkFrfB75v
         exH5si3VivzEAmNfnDCL5wpAn7Mgxt3CWoQcQFSyYt29X3zu5nPX8eDAkOISCncU32HX
         HXLFjc9Eer/I1fyaP9ELemZRxjNNWqSpcXe4ZUBGe90ZRGrD4QkHywe7SGKZKT/6zCNC
         VIYg==
X-Gm-Message-State: ALoCoQme9F6XPfQ0j2OUcHB1kwTppGI1t8bP0ASiGc/FSyxW+UWLt2BYBmXCpgAQb3d+Qf1dhctU
X-Received: by 10.68.116.132 with SMTP id jw4mr1844003pbb.107.1430342808438;
        Wed, 29 Apr 2015 14:26:48 -0700 (PDT)
Received: from ethel.cable.virginmedia.net (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id h12sm123299pdk.77.2015.04.29.14.26.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Apr 2015 14:26:47 -0700 (PDT)
X-Mailer: git-send-email 2.3.4.48.g223ab37
In-Reply-To: <1430342769-20521-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268009>

The kill_p4d test function used in the test harness fails
occasionally, especially if running many of the git-p4 tests
in parallel.

It looks like p4d is sensitive to being shutdown ungracefully,
so to work around this, use 'p4 admin stop' rather than kill,
and start p4d with journalling turned off. This seems to be much
more reliable.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/lib-git-p4.sh | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index 5aa8adc..3885381 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -69,7 +69,8 @@ start_p4d() {
 	(
 		cd "$db" &&
 		{
-			p4d -q -p $P4DPORT &
+			# disable journalling: it makes shutdown unreliable
+			p4d -J off -q -p $P4DPORT &
 			echo $! >"$pidfile"
 		}
 	) &&
@@ -122,15 +123,15 @@ p4_add_user() {
 }
 
 kill_p4d() {
-	pid=$(cat "$pidfile")
-	# it had better exist for the first kill
-	kill $pid &&
-	for i in 1 2 3 4 5 ; do
-		kill $pid >/dev/null 2>&1 || break
+	# graceful shutdown
+	p4 admin stop &&
+	for i in 1 2 3 4 5
+	do
+		p4 info >/dev/null 2>&1 || break
 		sleep 1
 	done &&
 	# complain if it would not die
-	test_must_fail kill $pid >/dev/null 2>&1 &&
+	test_must_fail p4 info 2>&1 >/dev/null &&
 	rm -rf "$db" "$cli" "$pidfile"
 }
 
-- 
2.3.4.48.g223ab37
