From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] hooks/post-receive-email: do not truncate messages at a '.' line
Date: Thu, 17 Jul 2014 12:26:29 -0700
Message-ID: <53b2ad7801889b49f04cb0ae7b0b37b@74d39fa044aa309eaea14b9f57fe79c>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 21:26:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7rKB-00018r-6Y
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 21:26:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbaGQT0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 15:26:35 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:64057 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477AbaGQT0e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 15:26:34 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so3415340pab.14
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=1306/yGY/7FDoCMdeXosoerwYwSigQ+PZiMXwklqzp4=;
        b=HQL1aGE6rWvKaKQp/CMJrwf+yRdHRFgiMYWwi97Ra3kJL1/qNwHTFgNAnADymYX4Dn
         QOzYQ9vJsXxzkKZLzSiyQjmVwFN7DoILkHUyGgm6kp+VNq1xxKl2pkTK75nBIhMevtdE
         Yh7WBEKdR1PrIzuQGhG69Q8rViURE4+e55D4HxPfP4IGXL+1L5b6Hjdm9ehVRHF7AOYM
         iQHTvKLVoANmY+qVwInwc0amJfOTcA0+D+7QEDcqX8/6lxKFHfQ6M02lo7Xf7jMQnBpi
         DOGQOSa16Car5ow75xW1gale7ZbTQCGViWxzKe5iFOG7CgS6uxJt8IPALOLGHwdiZCU1
         GAzQ==
X-Received: by 10.66.66.225 with SMTP id i1mr39939641pat.0.1405625194347;
        Thu, 17 Jul 2014 12:26:34 -0700 (PDT)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ey10sm4387173pdb.50.2014.07.17.12.26.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 12:26:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253774>

When sendmail is reading an incoming message, by default it will
terminate it if it reads a dot on a line by itself.

The post-receive-email script can generate such a line if the
message in a tag object contains a dot ('.') on a line by itself.

There are two options to turn off this behavior, -i and -oi which
are equivalent.

The choice of which to use is based on the observation that -i
appears to be the more commonly used option for this and that all
current sendmail-compatible programs appear to accept both.

Therefore add the -i option to the invocations of /usr/sbin/sendmail
to avoid prematurely terminating the input message at the occurence
of a dot ('.') on a line by itself.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

BTW, what is the status of post-receive-email?

I find it quite useful for a minimal server that only needs Git
binaries and a POSIX shell.

The only real issue with it I'm aware of is that if multiple
branch heads are updated in a single push and two or more
contain the same new revison(s), those revision(s) will be
incorrectly omitted from the emails sent out.

I have a patch to correct that, but it's not quite as simple
as this patch and would need more review, so I don't really
want to send it out and waste folks' time if there's no interest
in picking up updates to contrib/hooks/post-receive-email.

 contrib/hooks/post-receive-email | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 8747b843..6207be60 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -704,9 +704,9 @@ limit_lines()
 send_mail()
 {
 	if [ -n "$envelopesender" ]; then
-		/usr/sbin/sendmail -t -f "$envelopesender"
+		/usr/sbin/sendmail -i -t -f "$envelopesender"
 	else
-		/usr/sbin/sendmail -t
+		/usr/sbin/sendmail -i -t
 	fi
 }
 
-- 
1.8.5
