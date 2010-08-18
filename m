From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 3/8] detached-stash: simplify stash_drop
Date: Wed, 18 Aug 2010 23:09:35 +1000
Message-ID: <1282136980-25793-4-git-send-email-jon.seymour@gmail.com>
References: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:10:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OliPm-0001G7-3B
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927Ab0HRNKd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:10:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:40726 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752906Ab0HRNKc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:10:32 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so205454pxi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IKRoC6rEx2xl04NJdTUk5WiVI403ttEDso9zMU7miuQ=;
        b=TynbSImW8B+ckbRhuTdJF1MsSgzj2Qty2GB/eLDuzNlGz7isvrWLNK4UAVjV4iJ3lJ
         SThZLH/jaBK0451EZnZUlsD/aiVAp/V8dlurn4/LdAQQZCAwTf8i6nasakvPPkkzUcN7
         FpvvyXOiNExk7Gn2naiOKlmvfpUwKE3SZVT+4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=hJg02PD33fsuY1j5KQIrRv8IqK5VXbUNk1+p41rem5jPfIgNOgUUdToDwdLFNHXeaH
         v8p3eCyB5cmsU9mtj13cX/wowyl1J0mRpTNgIbIyQWIRMbWyPSMcy9Rd0VVlpzniJ0op
         NXM4+ywMtl8rHPccla2OZAhXYW90FLW71ypJY=
Received: by 10.142.179.15 with SMTP id b15mr7053558wff.163.1282137031206;
        Wed, 18 Aug 2010 06:10:31 -0700 (PDT)
Received: from localhost.localdomain ([120.16.55.229])
        by mx.google.com with ESMTPS id w31sm303253wfd.20.2010.08.18.06.10.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:10:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.95.g4fabf
In-Reply-To: <1282136980-25793-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153838>

Previously, git stash drop would fail noisily while executing git reflog
delete if the specified revision was not a stash reference.

Now, git stash drop fails with an error message which more precisely
indicates the reason for failure.

Furthermore, git stash drop will now fail with a non-zero status code
if stash@{n} specifies a stash log entry that does not actually exist.

This change in behaviour is achieved by delegating argument parsing
to the common parse_flags_and_rev() function (via a call to
assert_stash_ref).

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   31 +++----------------------------
 1 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ba68f1e..750f360 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -424,35 +424,10 @@ apply_stash () {
 }
 
 drop_stash () {
-	have_stash || die 'No stash entries to drop'
+	assert_stash_ref "$@"
 
-	while test $# != 0
-	do
-		case "$1" in
-		-q|--quiet)
-			GIT_QUIET=t
-			;;
-		*)
-			break
-			;;
-		esac
-		shift
-	done
-
-	if test $# = 0
-	then
-		set x "$ref_stash@{0}"
-		shift
-	fi
-	# Verify supplied argument looks like a stash entry
-	s=$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
-		die "$*: not a valid stashed state"
-
-	git reflog delete --updateref --rewrite "$@" &&
-		say "Dropped $* ($s)" || die "$*: Could not drop stash entry"
+	git reflog delete --updateref --rewrite "${REV}" &&
+		say "Dropped ${REV} ($s)" || die "${REV}: Could not drop stash entry"
 
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_stash
-- 
1.7.2.1.95.g4fabf
