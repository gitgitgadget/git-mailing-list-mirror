From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] tests: fix spurious error when run directly with Solaris /usr/xpg4/bin/sh
Date: Fri,  2 Mar 2012 11:33:53 +0100
Message-ID: <f3294212cbaf9bc0d6446d2cdf13619d0317b9e4.1330684369.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 11:34:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3PoQ-0001CN-4F
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 11:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757137Ab2CBKeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 05:34:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:64989 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab2CBKeC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 05:34:02 -0500
Received: by eekc41 with SMTP id c41so561914eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 02:34:01 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.204.70 as permitted sender) client-ip=10.14.204.70;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.204.70 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.14.204.70])
        by 10.14.204.70 with SMTP id g46mr5465987eeo.117.1330684441769 (num_hops = 1);
        Fri, 02 Mar 2012 02:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=acVW9GIxlDSY2y9eQDR0J9XXT5E9i1856NUKfdlNtqY=;
        b=LxuNa87Dp/R8CH7dwVU+dv8eM3Qhg+5Knw2ODh3FJJyw7Cw198Z163yDCPgorsNNc2
         9Pu2EBQF8a7DLRuSz4hRHvKcLaKWwhUFMpjA8GtT0xgfGj/Xreeb2ZAqz1gsimwTtoUc
         uqNGaz9KebKeUFb/SppzWxAi5N2VjqWaqWfy6dVqfdxQiBsrCUEZo2+qaLyIHDSec2wL
         gnVpRswISxpqkjzVKaC+dtmUvAiQjE4WOs/6B0QaaqQUSsGIag11bO7DoNgAgq+mQ5ly
         3VKh/ACeB7/dFYGCWBQGIcP6gBxmUgoz1p/Fv0e7OJ6moe3qj/RVJINFqi9Xb8qqIcU8
         B5jQ==
Received: by 10.14.204.70 with SMTP id g46mr4201958eeo.117.1330684441707;
        Fri, 02 Mar 2012 02:34:01 -0800 (PST)
Received: from localhost.localdomain (host25-99-dynamic.20-79-r.retail.telecomitalia.it. [79.20.99.25])
        by mx.google.com with ESMTPS id i10sm18788343eea.8.2012.03.02.02.33.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 02:34:00 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192021>

If any test script is run directly with Solaris 10 /usr/xpg4/bin/sh or
/bin/ksh, it fails spuriously with a message like:

  t0000-basic.sh[31]: unset: bad argument count

This happens because those shells bail out when encountering a call to
"unset" with no arguments, and such unset call could take place in
'test-lib.sh'.  Fix that issue, and add a proper comment to ensure we
don't regress in this respect.
---
 t/test-lib.sh |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a089a18..c0d04c4 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -42,10 +42,11 @@ TZ=UTC
 TERM=dumb
 export LANG LC_ALL PAGER TERM TZ
 EDITOR=:
-unset VISUAL
-unset EMAIL
-unset LANGUAGE
-unset $(perl -e '
+# A call to "unset" with no arguments causes at least Solaris 10
+# /usr/xpg4/bin/sh and /bin/ksh to bail out.  So keep the unsets
+# deriving from the command substitution clustered with the other
+# ones.
+unset VISUAL EMAIL LANGUAGE $(perl -e '
 	my @env = keys %ENV;
 	my $ok = join("|", qw(
 		TRACE
-- 
1.7.9
