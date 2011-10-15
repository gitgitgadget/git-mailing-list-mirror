From: Matthew Daley <mattjd@gmail.com>
Subject: [PATCH] send-email: Honour SMTP domain when using TLS
Date: Sat, 15 Oct 2011 04:44:52 -0400
Message-ID: <1318668292-13818-1-git-send-email-mattjd@gmail.com>
Cc: Matthew Daley <mattjd@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 10:44:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REzrS-0000Mu-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 10:44:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744Ab1JOIou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 04:44:50 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:40660 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054Ab1JOIot (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 04:44:49 -0400
Received: by pzk36 with SMTP id 36so336556pzk.1
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4KNk9bdn3tikiZdabFUEUJCwtIK2ffvKKGH7bkT8rzA=;
        b=tjTpDOmhgWocSQIWg0a30Do2JpU6vH6Dw3pYw5lfWad/wDXPwbeP1XRvWQ44dYUAaV
         yZRfkKkDIo3JkZRpx6Iuszw6vdgOBJn3PWAryr/53uEMOIWFhE5H5ETewb9oWYlNWKW3
         3zwMATezQRbuNECjkxseMxbAqcN8GSyCmnzKo=
Received: by 10.68.36.106 with SMTP id p10mr22557495pbj.66.1318668289221;
        Sat, 15 Oct 2011 01:44:49 -0700 (PDT)
Received: from morphism.xen.prgmr.com. (morphism.xen.prgmr.com. [71.19.145.114])
        by mx.google.com with ESMTPS id u1sm32169303pbr.9.2011.10.15.01.44.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 01:44:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183648>

git-send-email sends two SMTP EHLOs when using TLS encryption, however
only the first, unencrypted EHLO uses the SMTP domain that can be
optionally specified by the user (--smtp-domain).  This is because the
call to hello() that produces the second, encrypted EHLO does not pass
the SMTP domain as an argument, and hence a default of
'localhost.localdomain' is used instead.

Fix by passing in the SMTP domain in this call.

Signed-off-by: Matthew Daley <mattjd@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 6885dfa..d491db9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1098,7 +1098,7 @@ X-Mailer: git-send-email $gitversion
 					$smtp_encryption = '';
 					# Send EHLO again to receive fresh
 					# supported commands
-					$smtp->hello();
+					$smtp->hello($smtp_domain);
 				} else {
 					die "Server does not support STARTTLS! ".$smtp->message;
 				}
-- 
1.7.2.5
