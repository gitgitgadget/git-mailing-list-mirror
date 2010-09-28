From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 2/2] stash: fix git stash branch regression when branch creation fails
Date: Tue, 28 Sep 2010 23:19:52 +1000
Message-ID: <1285679992-7638-3-git-send-email-jon.seymour@gmail.com>
References: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Cc: tla@land.ru, tom@dbservice.com, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 28 15:18:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0a4T-0006AJ-Lb
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 15:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754766Ab0I1NRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 09:17:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:53297 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631Ab0I1NRt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 09:17:49 -0400
Received: by pwi1 with SMTP id 1so292712pwi.19
        for <git@vger.kernel.org>; Tue, 28 Sep 2010 06:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=PBdIFN0peQZRO2rHIxHeIRpjoFUY3rF4+DPStKMgUOM=;
        b=gZGIacGyk//RUlqL/azuQ8vYFviazaBoLn3aiKdtORAgbf3VmmmkdEw8QCqZm+u+C2
         phcG0LT7CFvzsSCVWfodokQ8HGnIWGj03mE7vSkCp/1ERncLII6HxSPHnOJP98Aw7lff
         3aUAgtamOctAufRcN116M7WYxx8UEF2OyfoXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uGcjTfyp10GsvrEOEEqRHNyO0W0TyUiAqA2/iP4/MHz8aWRYI2tQeRFqF4dwK738m2
         0wk+db7KnGX2x2QrJPHJ1IL+MQEWs2NHfz/APY93w6jnVR0G7oPjHpzQ9nltrUjdBPb6
         ICNn6+pvsuoBKfKrzTWijsdsF64klsv7gJfKE=
Received: by 10.142.199.18 with SMTP id w18mr7756832wff.336.1285679869172;
        Tue, 28 Sep 2010 06:17:49 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-77.dyn.iinet.net.au [203.158.55.77])
        by mx.google.com with ESMTPS id o16sm8820470wfh.19.2010.09.28.06.17.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 06:17:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.5.g7cfb7
In-Reply-To: <1285673120-43354-1-git-send-email-tom@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157420>

Tomas Carnecky reported a regression in the behaviour
of git stash branch, when the branch creation fails.

This patch fixes that regression by restoring the
pre-condition for dropping that previously existed.

This patch assumes Tomas Carnecky's patch has already been applied.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh     |    6 +++---
 t/t3903-stash.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 23a9ab5..5fb1245 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -432,9 +432,9 @@ apply_to_branch () {
 	assert_stash_like "$@"
 
 	git checkout -b $branch $REV^ &&
-	apply_stash "$@"
-
-	test -z "$IS_STASH_REF" || drop_stash "$@"
+	apply_stash "$@" && {
+		test -z "$IS_STASH_REF" || drop_stash "$@"
+	}
 }
 
 PARSE_CACHE='--not-parsed'
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0f6b2e4..336e244 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -545,7 +545,7 @@ test_expect_success 'invalid ref of the form stash@{n}, n >= N' '
 	git stash drop
 '
 
-test_expect_failure 'stash branch should not drop the stash if the branch exists' '
+test_expect_success 'stash branch should not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo > file &&
 	git add file &&
-- 
1.7.3.4.g787b.dirty
