From: Andy Parkins <andyparkins@gmail.com>
Subject: [RFC/PATCH 1/2] Add a useful return value to git-check-attr
Date: Tue, 17 Apr 2007 10:10:48 +0100
Message-ID: <200704171010.49168.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 17 11:11:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdjiI-0002SH-Gq
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 11:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992AbXDQJK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 05:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904AbXDQJK5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 05:10:57 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:63195 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752992AbXDQJK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 05:10:56 -0400
Received: by ug-out-1314.google.com with SMTP id 44so118116uga
        for <git@vger.kernel.org>; Tue, 17 Apr 2007 02:10:55 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=e+WOUjQAybALoWL7Jy+TXimF4YukZBZvmjJhDOwbP0iQZk5iXSxDM35AiwDR+fI/YwYDIKtUEJl3dmjX6kvoXky71FAVxYih6UK363fYO0D81GhYrW0vWAncflLTUVN7yabESzF1Clfe++xS4kaqXKZob+QAdm96VwMEVxfQa1I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Gv7RxP1+RIzTNW3AesFlFpVe5jNqZ9A/Ww+S7OyJJ7lKyakFLs4y4ujAuXiP38EJfSoJEuIifnV2151gc1r5pa+WddkWy99ognk9O78UlQehne0r5wJHMVWtqhL8DBvOkScF70poJ5MKcUy5g28Xl2zN2fn31Y6xSa115Wlq+Ik=
Received: by 10.82.160.2 with SMTP id i2mr3450803bue.1176801055095;
        Tue, 17 Apr 2007 02:10:55 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b30sm1773151ika.2007.04.17.02.10.52;
        Tue, 17 Apr 2007 02:10:52 -0700 (PDT)
X-TUID: 6c0e0fb04ccb9f9d
X-UID: 301
X-Length: 1354
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44743>

git-check-attr previously always returned success.  With this patch it
returns success when the requested attribute is found for all supplied
paths.

This lets you check in a script whether a file has an attribute:

 $ git-check-attr attribute -- file && echo "file has attribute"

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
This is handy in itself, but I added it to support the tests in the
next patch.

 builtin-check-attr.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 47b0721..b51c2ae 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -9,6 +9,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
 	struct git_attr_check *check;
 	int cnt, i, doubledash;
+	int allset = 1;
 
 	doubledash = -1;
 	for (i = 1; doubledash < 0 && i < argc; i++) {
@@ -43,7 +44,9 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			       (check[j].isset < 0) ? "unspecified" :
 			       (check[j].isset == 0) ? "unset" :
 			       "set");
+			if( check[j].isset <= 0 )
+				allset = 0;
 		}
 	}
-	return 0;
+	return !allset;
 }
-- 
1.5.1.1.821.g88bdb
