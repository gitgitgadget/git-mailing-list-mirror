From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/3] t/gitweb-lib.sh: Split gitweb output into headers and body
Date: Sat,  7 Nov 2009 16:13:27 +0100
Message-ID: <1257606809-23287-2-git-send-email-jnareb@gmail.com>
References: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 16:14:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6mzK-0000cF-8J
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 16:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102AbZKGPNi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2009 10:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbZKGPNf
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 10:13:35 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:62438 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZKGPNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 10:13:33 -0500
Received: by bwz27 with SMTP id 27so2098719bwz.21
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 07:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=1rSTDNRZU+a4TF4LgiFaVqjN570R8KL1f8KM66b5f0E=;
        b=uv4X8PE7G3avfv/wCo4L7L70nQ8c3lSqZrJ+kbPUTQl5isOjTYNnujKDdFunaKLQG6
         x6dY1hgEThKKTrPRm7O9sC1H+IOZWfw18Q73jjyHo4fQd/3sP+OjCDbZtEHlJM4oi7iq
         dZJ/AgX41A5kmOYXP/Pv8PxAHY/zAWKK1Sut0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cEjdzRuQrV0zanqi0L0qF+2R5ZAbXnOc03yLWBHoEkslVu7246JYM4VxnKsq4lrzNx
         IDzjM4lPxww+sazO5+8UjU8fmrXy2HHOcM5Yl0cueNDGTNUFvPFhIeq1NwlQDtsw2sPD
         fO9aFR2DnxrjEiAv+kmd6ylda11qxpNsSCZp8=
Received: by 10.204.29.22 with SMTP id o22mr3503639bkc.78.1257606817292;
        Sat, 07 Nov 2009 07:13:37 -0800 (PST)
Received: from localhost.localdomain (abuz230.neoplus.adsl.tpnet.pl [83.8.197.230])
        by mx.google.com with ESMTPS id 16sm328132fxm.12.2009.11.07.07.13.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 07:13:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id nA7FDZ1g023322;
	Sat, 7 Nov 2009 16:13:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id nA7FDZkS023321;
	Sat, 7 Nov 2009 16:13:35 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1257606809-23287-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132368>

Save HTTP headers into gitweb.headers, and the body of message into
gitweb.body in gitweb_run()

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version is identical to the one in previous version of this
series.

I hope that this use of sed is portable enough.

Please take into account that HTTP headers part contains at least one
line: HTTP status.

 t/gitweb-lib.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 8452532..32b841d
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,10 +52,14 @@ gitweb_run () {
 	rm -f gitweb.log &&
 	perl -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
+	sed -e   '/^\r$/q' <gitweb.output >gitweb.headers &&
+	sed -e '1,/^\r$/d' <gitweb.output >gitweb.body    &&
 	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
 
 	# gitweb.log is left for debugging
-	# gitweb.output is used to parse http output
+	# gitweb.output is used to parse HTTP output
+	# gitweb.headers contains only HTTP headers
+	# gitweb.body contains body of message, without headers
 }
 
 . ./test-lib.sh
-- 
1.6.5
