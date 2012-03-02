From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH v2] tests: fix spurious error when run directly with Solaris /usr/xpg4/bin/sh
Date: Fri,  2 Mar 2012 19:48:36 +0100
Message-ID: <f2243a179ce49eed668341a6c0e3a452bf7ae79f.1330713761.git.stefano.lattarini@gmail.com>
References: <7vd38uetls.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 19:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3XXH-0004Mi-51
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 19:48:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965103Ab2CBSsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 13:48:53 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46799 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758748Ab2CBSsw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 13:48:52 -0500
Received: by eekc41 with SMTP id c41so730693eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 10:48:51 -0800 (PST)
Received-SPF: pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.120.74 as permitted sender) client-ip=10.14.120.74;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of stefano.lattarini@gmail.com designates 10.14.120.74 as permitted sender) smtp.mail=stefano.lattarini@gmail.com; dkim=pass header.i=stefano.lattarini@gmail.com
Received: from mr.google.com ([10.14.120.74])
        by 10.14.120.74 with SMTP id o50mr6742440eeh.18.1330714131515 (num_hops = 1);
        Fri, 02 Mar 2012 10:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=eLbqd6jGNrn+YsxTK+X7snn9khMxlyOmNwG67oHmgJc=;
        b=bJgsOEgKtKjChYkqDIiqduHRXjK2qhN1WbEUEyJFsY+XTUQ3Xi2r9gaJK0wCQBnDCN
         q1PhX5+dBelhT7LEmdT6KpGjhNHjCWX5EulXDRdo1H+V3gICsjeXb3Oxq/WnRt0Q5FFc
         mdoa9m4GgctYTmk8NtKWZ6oUuO677Gbq8/OUZyjsbg1wfGvDAWvjVH5MJcASd5Zt/t1N
         EgHSGeuJx0sphPzGaeGPXX41vFxI4vZqwxFtlrg3slbxcIxhV4RTgWeHhM4PXQWhOmMX
         iCN78aMY5+YgosOc44AiegwNZgkDhp6rLwkbdJED43Q2yYHbCOphecT8DvARfUdgUTvu
         RNYg==
Received: by 10.14.120.74 with SMTP id o50mr5180157eeh.18.1330714131417;
        Fri, 02 Mar 2012 10:48:51 -0800 (PST)
Received: from localhost.localdomain (host100-93-dynamic.7-79-r.retail.telecomitalia.it. [79.7.93.100])
        by mx.google.com with ESMTPS id u11sm23389250eeb.1.2012.03.02.10.48.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 10:48:50 -0800 (PST)
X-Mailer: git-send-email 1.7.9
In-Reply-To: <7vd38uetls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192059>

If any test script is run directly with Solaris 10 /usr/xpg4/bin/sh or
/bin/ksh, it fails spuriously with a message like:

  t0000-basic.sh[31]: unset: bad argument count

This happens because those shells bail out when encountering a call to
"unset" with no arguments, and such unset call could take place in
'test-lib.sh'.  Fix that issue, and add a proper comment to ensure we
don't regress in this respect.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---

 Changes from the previous version: add a proper "Signed-off-by" line,
 which I had forgotten in the previous version.  Sorry for the confusion.

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
