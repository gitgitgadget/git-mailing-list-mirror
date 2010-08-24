From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 3/3] rev-parse: tests git rev-parse --verify master@{n}, for various n
Date: Tue, 24 Aug 2010 14:52:44 +1000
Message-ID: <1282625564-12752-4-git-send-email-jon.seymour@gmail.com>
References: <20100824001454.GB17406@burratino>
Cc: gitster@pobox.com, jrnieder@gmail.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 24 06:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnlVv-00051F-3n
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 06:53:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0HXExZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 00:53:25 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:56976 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357Ab0HXExY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 00:53:24 -0400
Received: by pvg2 with SMTP id 2so2528330pvg.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 21:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=odlRFx3320yBJzvSBiTV9GTMoxw/hRQEmp5XAed27Vs=;
        b=maaFdwf/OrkIlIQJlbPAR1+VBVP+Y0siWaH5YVS+uMdt6k4otD4fiag6BjRIk0Yqf5
         6oAWohX05+ME8InvmSo24ym1J8GA/T0SGt549JdJGeYdklHxH1iWDuHki305dsZ5aqch
         9GrSYF3jh3FoBOVdxtiveONDI6e9jpEpd2ZOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AI6KSIHBCKxfP2jK3X//co7pvJDAAMfR7qhJn5tNDS4KInD/0Zf/buSyXQBHsWo4ix
         sgOccVYWskXd2V/1MyL54bIkHKFn7ogLk9lyVQo1iGJdCnmnGqBi5XxXtEI8lEJqwpr2
         iVmeU2m+MyGvfCmn2xCxTZ41ppbIkXd/qOutE=
Received: by 10.142.245.12 with SMTP id s12mr5206246wfh.311.1282625604330;
        Mon, 23 Aug 2010 21:53:24 -0700 (PDT)
Received: from localhost.localdomain ([120.16.94.110])
        by mx.google.com with ESMTPS id n2sm9394805wfl.1.2010.08.23.21.53.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 21:53:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.100.gceecd
In-Reply-To: <20100824001454.GB17406@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154287>

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
1.7.2.1.100.gceecd
