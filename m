From: Robert Shearman <robertshearman@gmail.com>
Subject: [PATCH] git-send-email: Fix authenticating on some servers when using TLS.
Date: Wed,  9 Jul 2008 22:39:40 +0100
Message-ID: <1215639580-25040-1-git-send-email-robertshearman@gmail.com>
Cc: Robert Shearman <robertshearman@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 09 23:41:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGhPB-0006em-G5
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 23:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754798AbYGIVjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 17:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYGIVjy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 17:39:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:48434 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754509AbYGIVjx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 17:39:53 -0400
Received: by ug-out-1314.google.com with SMTP id h2so127438ugf.16
        for <git@vger.kernel.org>; Wed, 09 Jul 2008 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=G2yfqpSQabaYbKly8xPyB5LReOlCjvujhlk60IanP6U=;
        b=WA6DSsKFvH8eCPhnjZiLmumhq275diKc74hmMem/VJPFL/Tjf3qUZYNdWFV7OeSgD5
         sg+3kawKrrnl3slgIsFKKY2D9lf99r8tGWfvRqYohk7gASmn5NQvM7WGmlOxsUgysdZy
         HLN2zTe8jOygr4MqosLdMQ+5pdQigv6WbXCao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Mv7D39Viq6ShYrokVIKW1OgCyoqxnH6E0NC0ePh2LtEH30Ip53CZ+lmVu18VTm9+VJ
         VpKfkLOOkM0TWL0GrQnIddvQDSCW7a13/cxqgyBuKK9hMx30SDDtwgCoK0ilAx0Ft/WB
         8K2/VS6Au21mdqkkTxbis0e0+LSs1hvOwibRE=
Received: by 10.125.156.10 with SMTP id i10mr2176304mko.42.1215639591939;
        Wed, 09 Jul 2008 14:39:51 -0700 (PDT)
Received: from localhost.localdomain ( [86.155.123.155])
        by mx.google.com with ESMTPS id y1sm3112622hua.41.2008.07.09.14.39.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jul 2008 14:39:51 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.224.g26efb.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87922>

Send hello after a successful STARTTLS command to refresh the list of extensions. These may be different to what is returned over a clear connection (for example the AUTH command may be accepted over a secure connection, but not over a clear connection).

Furthermore, this behaviour is recommended by RFC 2487 (http://www.ietf.org/rfc/rfc2487.txt).

Signed-off-by: Robert Shearman <robertshearman@gmail.com>
---
 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 3564419..6adb669 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -773,6 +773,9 @@ X-Mailer: git-send-email $gitversion
 					$smtp = Net::SMTP::SSL->start_SSL($smtp)
 						or die "STARTTLS failed! ".$smtp->message;
 					$smtp_encryption = '';
+					# Send EHLO again to receive fresh
+					# supported commands
+					$smtp->hello();
 				} else {
 					die "Server does not support STARTTLS! ".$smtp->message;
 				}
-- 
1.5.6.2.224.g26efb.dirty
