From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 4/9] detached-stash: simplify stash_drop
Date: Sat, 21 Aug 2010 14:08:59 +1000
Message-ID: <1282363744-4924-5-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:09:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfP1-0006is-2Y
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325Ab0HUEJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:09:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59671 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751168Ab0HUEJu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:09:50 -0400
Received: by pwi7 with SMTP id 7so1297590pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=B1+mes7O6sKH+7lrv9JL1YVwHKznct4GVIuuBha6CVo=;
        b=wZNRqIy+U04dUaFvxSSOKeDYJEh/t2dsswHL06F5vLvj9zLUriEZRRavCtL6s6ECcH
         17uzH3/cCuTTVJCQahteZ3l9r/uqPggFGr8g3DEWhU8AYPshacrme+M/VOrxnmBpegHY
         BtLLzeZx+xN4he2rMNaYN6S/qUGGdnRHRhRNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Iv6QW0eUg64+pZPunonLOjE5DwCC4G5MdBAsV1TXIszSCD1NqRnzhptxPKTIVL8ei8
         Qk7BQI15Da3m0Xlz3VkQsITCwzmZJVIfFnif5yyyJ554ESF7pMc5ueWy7Xee/OAsKYLE
         zKTd/l5Aj/HyB6Jaa6ziG4RzjYpsvSvCThFn4=
Received: by 10.143.9.19 with SMTP id m19mr1738799wfi.335.1282363789324;
        Fri, 20 Aug 2010 21:09:49 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:09:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154102>

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
1.7.2.1.110.g34f32
