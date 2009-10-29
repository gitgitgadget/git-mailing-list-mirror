From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] t/gitweb-lib.sh: Split gitweb output into headers and body
Date: Thu, 29 Oct 2009 23:07:41 +0100
Message-ID: <1256854062-25496-2-git-send-email-jnareb@gmail.com>
References: <1256854062-25496-1-git-send-email-jnareb@gmail.com>
Cc: Mark Rada <marada@uwaterloo.ca>, Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 23:07:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3d9u-0006eH-2b
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 23:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755868AbZJ2WHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 18:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755997AbZJ2WHn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 18:07:43 -0400
Received: from mail-bw0-f227.google.com ([209.85.218.227]:53898 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056AbZJ2WHm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 18:07:42 -0400
Received: by bwz27 with SMTP id 27so2871367bwz.21
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0/l9WfXuGQ7eL2OOVLrMqCdg5ayWYJqW5on0o2+qjqc=;
        b=kVd6kTMQsuSZ3rmvDtmgFWHcgvuc66+UbaYtiIIY5O5Qp/TwDZtyFRJ/IN8S87plzT
         TEtDowuAt5I4IByquuzBiyqRB9N2nrAixKAH3D/qvGjeFTs2TGST3VcRkxnFNJQ+g7L1
         NnjdHTGKVf9s19mmjGDNqc4vt952ByyT2u0D4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=G9NJ5FMhdGIEvsmU6/RBOgwlvnjy0DZUdnLdirjvS99mq9Ll0lCMLXHCM1zpjz/OMj
         o8ePqm5PV16auJEGNG/xTy370AhA48yRvVefQ8u5g5+z2baN1kgF3/tVOWtKlKKHHS2K
         i0BbjSG1eL0jQoLVbnmqHLf5ixukzMkhtiIz0=
Received: by 10.204.175.83 with SMTP id w19mr499620bkz.24.1256854066591;
        Thu, 29 Oct 2009 15:07:46 -0700 (PDT)
Received: from localhost.localdomain (abwt44.neoplus.adsl.tpnet.pl [83.8.243.44])
        by mx.google.com with ESMTPS id 16sm44897bwz.7.2009.10.29.15.07.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 Oct 2009 15:07:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9TM7pce025536;
	Thu, 29 Oct 2009 23:07:51 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9TM7pMV025535;
	Thu, 29 Oct 2009 23:07:51 +0100
X-Mailer: git-send-email 1.6.5
In-Reply-To: <1256854062-25496-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131658>

Save HTTP headers into gitweb.headers, and the body of message into
gitweb.body in gitweb_run()

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
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
