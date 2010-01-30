From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/3] grep: Fix two memory leaks
Date: Sat, 30 Jan 2010 09:42:58 -0600
Message-ID: <1264866178-12048-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 16:43:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbFTi-0001LN-Uj
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 16:43:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751778Ab0A3PnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309Ab0A3PnF
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 10:43:05 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:55691 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248Ab0A3PnE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 10:43:04 -0500
Received: by iwn10 with SMTP id 10so360259iwn.22
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=ARkqGGB0qyOHpDvbeElb7B0jI/C6TzMWQX/GI4VX66I=;
        b=PtaK58G6G/o21ARIjz4NKafLkxkyTUCidWERbYB/jJs1jWaR6ZUDpJlHtMJSi9TGeu
         JikAOBJ/r3XeJSfqdpDdWumYOKwNxHAGFDyu85XphplKtbg1h4Ocnpkmks7RvHNDNtnA
         RH/3/Tmcb3Bsg1a771jBtEqkYh6B/pSjlrGZo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=frhmkhinzRsOCmSUICUIdy7rTopCyb2W0Wi6nPS/UIFFyiQZI/SU6XSzBPZ+neIaUv
         QL06crxixk2hCVwMu6CVDUi10MO21u6RjiNlkNUaHXg+/pu2cJs4GO6l9vn2xBGpnV1i
         ZTV7XVA88QyWdDG0QvKNJN0t5TCwNp/tBeoz8=
Received: by 10.231.169.144 with SMTP id z16mr1868821iby.25.1264866181785;
        Sat, 30 Jan 2010 07:43:01 -0800 (PST)
Received: from localhost (adsl-99-140-180-147.dsl.chcgil.sbcglobal.net [99.140.180.147])
        by mx.google.com with ESMTPS id 23sm3174872iwn.7.2010.01.30.07.43.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 30 Jan 2010 07:43:01 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138477>

We duplicate the grep_opt structure when using grep threads, but didn't
later free either the patterns attached to this new structure or the
structure itself.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
Found these with valgrind.

-Dan

 builtin-grep.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 9bd467c..0ef849c 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -205,6 +205,8 @@ static void *run(void *arg)
 
 		work_done(w);
 	}
+	free_grep_patterns(arg);
+	free(arg);
 
 	return (void*) (intptr_t) hit;
 }
-- 
1.6.6.1
