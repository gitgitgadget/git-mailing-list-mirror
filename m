From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] am: handle stray $dotest directory case
Date: Thu, 13 Jun 2013 19:47:11 +0530
Message-ID: <1371133031-28049-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 13 16:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Un8J9-0006AG-A8
	for gcvg-git-2@plane.gmane.org; Thu, 13 Jun 2013 16:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab3FMOPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jun 2013 10:15:19 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:44401 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640Ab3FMOPR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jun 2013 10:15:17 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so10460069pbb.36
        for <git@vger.kernel.org>; Thu, 13 Jun 2013 07:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=S4IKY7HITEjY3Uky0s3JmXgyvcZt3n2V9Tz9Rr8Ds98=;
        b=ELJ07SIWgTEomUKHBMr1bI8rb3xO+pLLDgdsqKNRyDEVz33srPnxMrz/jDhMknStYK
         dZQecaXkBHAYeFgyrbIcbG165zfKed0Qf737WEMiu15We/P9IlRnkiOYvIUmVgWJgUwb
         VVEzdlYzhAYwhgPNgfEyq+LfXvHMWroxLq4u4khjwBfep7E+UXsLfF3KsttqHRl787Cs
         5Bkpkur4prYVbBMuC+BxPIGRnQ9hduEB0mlrtRCv5zZ/2FcVP1qhsdws9GRCLIR9aY3r
         n3x6VEuuanEJ6QwmFbwJzwd7vGHanrPGTgeHNKkAWsmiCHGUh3DqBhSGm2c5uhtgmp40
         MJZw==
X-Received: by 10.66.250.225 with SMTP id zf1mr3034185pac.39.1371132916784;
        Thu, 13 Jun 2013 07:15:16 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPSA id kv2sm23536776pbc.28.2013.06.13.07.15.14
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Jun 2013 07:15:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1.379.ged35616
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227738>

The following bug has been observed since rr/rebase-autostash:

  $ git am  # no input file
  ^C
  $ git am --abort
  Resolve operation not in progress, we are not resuming.

This happens because the following test fails:

  test -d "$dotest" && test -f "$dotest/last" && test -f "$dotest/next"

and am precludes the possibility of a stray $dotest directory
existing (when $dotest/{last,next} are not present).

Fix the bug by checking for a stray $dotest directory explicitly and
removing it on --abort.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/git-am.sh b/git-am.sh
index 1cf3d1d..f46a123 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -506,6 +506,11 @@ then
 	esac
 	rm -f "$dotest/dirtyindex"
 else
+	# Possible stray $dotest directory
+	if test -d "$dotest" && test t = "$abort"; then
+		clean_abort
+	fi
+
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" = "" ||
 		die "$(gettext "Resolve operation not in progress, we are not resuming.")"
-- 
1.8.3.1.379.ged35616
