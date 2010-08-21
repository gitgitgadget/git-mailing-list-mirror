From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 4/4] rev-parse: tests that git rev-parse --verify master@{n}
Date: Sat, 21 Aug 2010 11:43:42 +1000
Message-ID: <1282355022-17795-5-git-send-email-jon.seymour@gmail.com>
References: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Cc: gitster@pobox.com, Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 03:44:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omd8g-0005HQ-BZ
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 03:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289Ab0HUBob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 21:44:31 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55456 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab0HUBo0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 21:44:26 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so1463213pzk.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 18:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=K+FHoPSgKmJdcq2do1FryU9q9G33YE3RkRQsxU9OnfY=;
        b=uk/UAN5+FIqKEAnSCwj4B7YmMB7LyW5Gn38sKXohlhJqHXes0s0OIT5HOf3KuXXF2/
         po1WI17rlGUjuYBD/XCOQxaC4f4lsOTHOnFyXYnvencuVeRq+5Lkac4qw5JbstmSLuyh
         orDJHTAOroO4qAUJe3P4jX/7ZEi7hxA6Ee/Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RVhQSJ5fA78302fJqTkMXwBZ7HTVDbdiKmSljBz5bRxBUqYDlWxGulxKb10USngKJM
         YbY/JrQWdYOLraSCvfLbbEwueC9HrjZi+iIIIf3O0llVUQaUxCNBqXr3Q3QhksGBVFwJ
         B+N8jkG498mhqqiGXSdAPNtWVivAPvGqAJIzc=
Received: by 10.114.38.6 with SMTP id l6mr2414604wal.47.1282355065807;
        Fri, 20 Aug 2010 18:44:25 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id d38sm6038069wam.8.2010.08.20.18.44.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 18:44:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.156.gf148c
In-Reply-To: <AANLkTi=m7+h0nVg+EAmiir-rnrjoBwbpLtztcNNBVxiz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154091>

This commit introduces tests that verify that rev-parse
parses master@{n} correctly for various values of n less
than, equal to and greater than the number of revisions
in the reference log.

In particular, these tests check that rev-parse sets a
non-zero status code and prints a message of the
following form to stderr.

    error: Log for [^ ]* only has [0-9][0-9]* entries.

Also tests that output for failing cases is generated if,
and only if, --verify is not specified.

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
index af721f9..427c67e 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -66,4 +66,13 @@ test_expect_success 'incorrect file in :path and :N:path' '
 	grep "fatal: Path '"'"'disk-only.txt'"'"' exists on disk, but not in the index." error
 '
 
+test_expect_success 'invalid @{n} reference' '
+	test_must_fail git rev-parse master@{99999} >output 2>error &&
+	test "$(cat output)" = "master@{99999}" &&
+	grep "error: Log for [^ ]* only has [0-9][0-9]* entries." error  &&
+	test_must_fail git rev-parse --verify master@{99999} >output 2>error &&
+	test -z "$(cat output)" &&
+	grep "error: Log for [^ ]* only has [0-9][0-9]* entries." error
+'
+
 test_done
-- 
1.7.2.1.156.gf148c
