From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v5 6/8] detached-stash: simplify git stash show
Date: Wed, 18 Aug 2010 23:48:51 +1000
Message-ID: <1282139333-5150-3-git-send-email-jon.seymour@gmail.com>
References: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 18 15:49:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olj1X-0005IP-Oa
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 15:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab0HRNt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 09:49:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33667 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0HRNtZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 09:49:25 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so11722pwi.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 06:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=M1W2RZ9MNsP3ONSYNA6jnM9zU8yZ0vmKqjNAmybvhTw=;
        b=NGZ/qUqwcc5Bt/xbY2QsJ9ZAdyDdCcqDoJ9bTfipVJvt0m/3ZA3yStbbOyCpF/tYGT
         2vsEhd38NeY/Soa24l4M6QyiIzcupEpfbG1PS6fjvhcD6n6UsOc0KhIG7lgZYeja42ig
         yrKFQS3t2mDbTW5d8IswSX0DcxourX8SVW+48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=swHB3lARCWXdPdIUPmmIpEL3LZ3XHkALdzdnbZCBUhu4RNmqnHhkKZxxGFVIkhQK++
         ocVGnm5NYo3V7wF+ITr+xeL0sRdwuu5jn4Ev9ZAFFDyThr/S0M277zhgjIrORTJzsagH
         if4LJDVWtmFQ6mqhk2qqTC903Zs3yuC/l/9xA=
Received: by 10.114.121.10 with SMTP id t10mr9580858wac.161.1282139365368;
        Wed, 18 Aug 2010 06:49:25 -0700 (PDT)
Received: from localhost.localdomain (203-158-55-26.dyn.iinet.net.au [203.158.55.26])
        by mx.google.com with ESMTPS id s5sm538803wak.12.2010.08.18.06.49.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 06:49:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.88.g3dbe5
In-Reply-To: <1282139333-5150-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153852>

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
1.7.2.1.95.g4fabf
