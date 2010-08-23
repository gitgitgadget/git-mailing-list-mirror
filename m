From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 2/2] rev-parse: tests git rev-parse --verify master@{n}, for various n
Date: Tue, 24 Aug 2010 09:11:43 +1000
Message-ID: <1282605103-8320-3-git-send-email-jon.seymour@gmail.com>
References: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 01:12:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OngBo-0005PX-0a
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 01:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0HWXMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 19:12:05 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56519 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab0HWXME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 19:12:04 -0400
Received: by pvg2 with SMTP id 2so2456628pvg.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 16:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ejE69Thw6Jm8DdzvlyU1hg6Dbj8DDDkAB+lPbLI2aTE=;
        b=cdau+JfYDw+aRGq/nkpIgQXCrwXHD9xGtYE7n9Njalv75n+kI77U7/yYZS9gGKCibY
         Ch+81SK7Mh+g9nbFVvpqMR2YVVa9WZTjjMny40I418yJA82sxJ+ZivnJNAwRrIgl7+Ix
         9SHRCge+CyaQXBK8L7kRBXydrRWgBTlGn0jUU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=jHTLhqI4TDjPmLMmvIsQd2oebXe/DR9GkXiXAQHOxdrPMtGdp8D78ms9x/6/a/nzY+
         z1ulbVMgQ+SmHosFo9040ZyqjtrEI+7E9o4KNEB96OIhA45cjYLjKL7eOqHldl5Xulob
         HlNTN7iUNbGo9qmIcfhq06wiuww4AiTkh1z+E=
Received: by 10.142.106.17 with SMTP id e17mr2736730wfc.305.1282605123790;
        Mon, 23 Aug 2010 16:12:03 -0700 (PDT)
Received: from localhost.localdomain (124-169-135-9.dyn.iinet.net.au [124.169.135.9])
        by mx.google.com with ESMTPS id v13sm9081625wfv.5.2010.08.23.16.12.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 16:12:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.99.geab11
In-Reply-To: <7vr5hp1e6i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154272>

This commit introduces tests that verify that rev-parse
parses master@{n} correctly for various values of n less
than, equal to and greater than the number of revisions
in the reference log.

In particular, these tests check that rev-parse exits with a
non-zero status code and prints a message of the
following form to stderr.

    fatal: Log for [^ ]* only has [0-9][0-9]* entries.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t1503-rev-parse-verify.sh    |   11 +++++++++++
 t/t1506-rev-parse-diagnosis.sh |    9 +++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/t/t1503-rev-parse-verify.sh b/t/t1503-rev-parse-verify.sh
index cc65394..61092f7 100755
--- a/t/t1503-rev-parse-verify.sh
+++ b/t/t1503-rev-parse-verify.sh
@@ -104,4 +104,15 @@ test_expect_success 'use --default' '
 	test_must_fail git rev-parse --verify --default bar
 '
 
+test_expect_success 'master@{n} for various n' '
+	N=$(git reflog | wc -l) &&
+	Nm1=$((N-1)) &&
+	Np1=$((N+1)) &&
+	git rev-parse --verify master@{0} &&
+	git rev-parse --verify master@{1} &&
+	git rev-parse --verify master@{$Nm1} &&
+	test_must_fail "git rev-parse --verify master@{$N}" &&
+	test_must_fail "git rev-parse --verify master@{$Np1}"
+'
+
 test_done
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index af721f9..0eeeb0e 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -66,4 +66,13 @@ test_expect_success 'incorrect file in :path and :N:path' '
 	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
 '
 
+test_expect_success 'invalid @{n} reference' '
+	test_must_fail git rev-parse master@{99999} >output 2>error &&
+	test -z "$(cat output)" &&
+	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error  &&
+	test_must_fail git rev-parse --verify master@{99999} >output 2>error &&
+	test -z "$(cat output)" &&
+	grep "fatal: Log for [^ ]* only has [0-9][0-9]* entries." error
+'
+
 test_done
-- 
1.7.2.1.99.geab11
