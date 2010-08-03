From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v2 1/3] stash: It looks like a stash, but doesn't quack like a stash...
Date: Tue,  3 Aug 2010 20:36:13 +1000
Message-ID: <1280831775-30759-2-git-send-email-jon.seymour@gmail.com>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, jon.seymour@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 03 12:38:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgEso-0002aA-Dm
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 12:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab0HCKiA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 06:38:00 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:58488 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755941Ab0HCKh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 06:37:59 -0400
Received: by pwi5 with SMTP id 5so1594935pwi.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 03:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xT/2V7vVanuo2DLeNEA2I+jAk7urBx7c32Eafj20GHM=;
        b=L9icjBjjT2yXSd8aPedjGyNpvvRsKBaB+yHLn959S5+rzxv3b0CAfDsYHTT89QoNLR
         YY1B3unpnH1t/Fa6NWKZXt9AeyOnkHBCXXmAgrERFlOEoFFgdyskfocaCvxGIDq7rkW0
         q/B+lvlcCBInksmcB05Kz+E2qyYX4cW11mi3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sZs1SFKQOg4Gw7lUJhkEsBxn0CdAv/D4uf3mwQD8g0vcItgFMSL23gTLkxoN8+yf3H
         OyIFHGbylzr62QihNK6lSGFhq9gxcg1A1Kl2T+bz0cLHJ6yT9cAJBpq6V97LwyHtCQDr
         M9KV9+b4/+eXSwu84VAYcHg7pQSCEIDIeVqOc=
Received: by 10.142.215.7 with SMTP id n7mr6548480wfg.63.1280831879106;
        Tue, 03 Aug 2010 03:37:59 -0700 (PDT)
Received: from localhost.localdomain (r220-101-137-36.cpe.unwired.net.au [220.101.137.36])
        by mx.google.com with ESMTPS id c24sm13374316wam.19.2010.08.03.03.37.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 03:37:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.111.g8fc90
In-Reply-To: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152501>

In particular, a stash created with git stash create cannot be used as
an argument to git stash branch because of two separate reasons.

1. a pre-condition assumes that there is always a stash on the stack when git stash branch is called,
which is not necessarily true

2. the cleanup code assumes the specified stash is a stash reference, rather than an arbitrary commit.

The test_expect_failure tests in this patch demonstrate these issues.


Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t3903-stash.sh |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 62e208a..4d8b6ad 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -378,4 +378,34 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_failure 'stash branch from arbitrary stash ref when there are no stash references' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
+	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test $(git ls-files --modified | wc -l) -eq 1
+'
+
+test_expect_failure 'stash branch from arbitrary stash ref fails even if there is a stash' '
+	git stash clear && {
+		git branch -D stash-branch || true
+	}
+	test_when_finished "git reset --hard HEAD" &&
+	git reset --hard &&
+	echo foo >> file &&
+	git stash &&
+	echo bar >> file &&
+	git tag stash-tag $(git stash create) &&
+	test_when_finished "git tag -d stash-tag" &&
+	git reset --hard &&
+	git stash branch stash-branch $(git rev-parse stash-tag) &&
+	test_when_finished "git reset --hard HEAD && git checkout master && git branch -D stash-branch" &&
+	test $(git ls-files --modified | wc -l) -eq 1
+'
+
 test_done
-- 
1.7.2.1.111.g8fc90
