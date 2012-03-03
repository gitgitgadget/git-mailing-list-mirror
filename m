From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH 1/5] gitweb: Jump do DONE_REQUEST not DONE_GITWEB on error
Date: Sat,  3 Mar 2012 18:56:59 +0100
Message-ID: <1330797423-22926-2-git-send-email-jnareb@gmail.com>
References: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 03 18:57:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3tCw-00031I-Ve
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 18:57:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab2CCR5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 12:57:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36648 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab2CCR5M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 12:57:12 -0500
Received: by eaaq12 with SMTP id q12so945740eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 09:57:10 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.28.16 as permitted sender) client-ip=10.14.28.16;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.28.16 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.28.16])
        by 10.14.28.16 with SMTP id f16mr8367483eea.121.1330797430910 (num_hops = 1);
        Sat, 03 Mar 2012 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wze+cOEDANb50ChNrnHpmzVh8mBVEWLfsI1ia72/gDE=;
        b=rZYXp30SyY5NXZMEgBItcnJTMB1JekL1+OBNyjQM5FRcwZO/h32noFXeTxm4vTT3cA
         TDP7fdbKgLZqPKueqst7r6h63E7HhHjPn6ulsQOti4b+TEQrMlYm0BRKHLzzk7o1W8M6
         cdF06F2sJV3KyMnXSzY8DoIBX5BNACUqDv/iGDqDx55PcjmN3fnQ5HnMYjDgPQldVATh
         7fPiGQa2wXZ0PlJGEuz/XugiHpkCuATvOXg26lVzBfYNIPZqafpquel/xL72skODd59u
         VyG0JnBBJPE2FuDlFVutGf6F6JrftXaGINR4hC2e5vetoMEMqBQ42R7SXSAZ+ZuEnUal
         JSFQ==
Received: by 10.14.28.16 with SMTP id f16mr6404380eea.121.1330797430854;
        Sat, 03 Mar 2012 09:57:10 -0800 (PST)
Received: from localhost.localdomain (abwo91.neoplus.adsl.tpnet.pl. [83.8.238.91])
        by mx.google.com with ESMTPS id s48sm36973616eem.0.2012.03.03.09.57.10
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 09:57:10 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <1330797423-22926-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192125>

On error (die_error()), instead of ending gitweb process by non-local
jump to DONE_GITWEB label at the end of requests loop in run()
subroutine, just end current request by jumping to DONE_REQUESt at the
end of run_request() subroutine.

This change should improve truly persistent deployment methods,
currently only FastCGI but in the future also PSGI, as an error page
would no longer require reloading whole persistent environment, just
end request.

This would allow to create new deployment mechanisms (for example
PSGI) based on run_request() and not on run().

Note that DONE_REQUEST label is removed because it is no longer used,
and it wouldn't work correctly for PSGI anyway.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Without this we could not write to_psgi_app() in patch 3/5.

This patch has its value independently on PSGI support, though if it
is to be accepted standalone, the commit message would have to be
slighlty edited, so that the last two paragraphs of it read:

 "This would allow to create new deployment mechanisms based on
  run_request() and not on run().

  DONE_REQUEST label is removed because it is no longer used."

 gitweb/gitweb.perl |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index e2e6a73..2cca2cd 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1195,6 +1195,10 @@ sub run_request {
 	configure_gitweb_features();
 
 	dispatch();
+
+
+ DONE_REQUEST:
+	1;
 }
 
 our $is_last_request = sub { 1 };
@@ -1252,9 +1256,6 @@ sub run {
 
 		last REQUEST if ($is_last_request->());
 	}
-
- DONE_GITWEB:
-	1;
 }
 
 run();
@@ -4195,7 +4196,7 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_GITWEB
+	goto DONE_REQUEST
 		unless ($opts{'-error_handler'});
 }
 
-- 
1.7.9
