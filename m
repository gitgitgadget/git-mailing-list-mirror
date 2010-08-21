From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v6 7/9] detached-stash: simplify git stash show
Date: Sat, 21 Aug 2010 14:09:02 +1000
Message-ID: <1282363744-4924-8-git-send-email-jon.seymour@gmail.com>
References: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Cc: j6t@kdbg.org, gitster@pobox.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 21 06:10:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmfPN-0006qB-6V
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 06:10:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373Ab0HUEKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 00:10:06 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59671 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab0HUEKC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 00:10:02 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so1297590pwi.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 21:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=tE3zZ1MBDpOCsTcgXREYy/AhfaEgz2q6ryvlykc4QEA=;
        b=wmh+6BefJRwbrIA+3BlnbpwaAzv5kdQOqeXJkvrceCZcYICJ8V6g/6wI2zdxXNohNv
         B6NOs8HzGKl60qS2Evvg+xDEt0yRzeNcXAqsAIu7h5dd2JGBxKtntuIEm9OC4jhaJBUH
         hmxJSngilQYbPqjQcKi7TeEEhf+ARwZicOBEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=EiQKNvyyEF07YE7+NZgbIxiQzZphwVZvJRfStUTcQj1iL8AOMaPurxh2+zYCmhtoFC
         Ylrze0/4G90EmNZvtEvnk8GXFNgBsZHZFWw3pcLIMHSrMIfL9mTTZTFqB3/CBllf/V7P
         Y7FIDjCNGBfIznj6IoizkXg9HXFfsolfd4eLY=
Received: by 10.142.192.1 with SMTP id p1mr1773887wff.223.1282363802688;
        Fri, 20 Aug 2010 21:10:02 -0700 (PDT)
Received: from localhost.localdomain (124-169-98-91.dyn.iinet.net.au [124.169.98.91])
        by mx.google.com with ESMTPS id z1sm4208931wfd.3.2010.08.20.21.09.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 21:10:01 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.110.g34f32
In-Reply-To: <1282363744-4924-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154104>

This commit refactors git stash show to make use of the assert_stash_like function.

git show now dies if the presented argument is non-stash-like.

Previous behaviour was to tolerate commits that were not even stash-like.

Previously, git stash show would accept stash-like arguments, but
only if there was a stash on the stack.

Now, git stash accepts stash-like arguments always and only fails
if no stash-like argument is specified and there is no stash stack.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index ff1edc9..7ce818b 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -210,19 +210,9 @@ list_stash () {
 }
 
 show_stash () {
-	have_stash || die 'No stash found'
-
-	flags=$(git rev-parse --no-revs --flags "$@")
-	if test -z "$flags"
-	then
-		flags=--stat
-	fi
-
-	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
-	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
-		die "'$*' is not a stash"
+	assert_stash_like "$@"
 
-	git diff $flags $b_commit $w_commit
+	git diff ${FLAGS:---stat} $b_commit $w_commit
 }
 
 #
-- 
1.7.2.1.110.g34f32
