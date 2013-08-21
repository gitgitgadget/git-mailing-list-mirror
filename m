From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 3/3] t3404: simplify short SHA-1 collision test
Date: Wed, 21 Aug 2013 15:12:58 -0400
Message-ID: <1377112378-45511-4-git-send-email-sunshine@sunshineco.com>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 21:13:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCDqT-0004k4-NI
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542Ab3HUTNU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:13:20 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:45393 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752477Ab3HUTNT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:13:19 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so1649990oag.24
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sm3Y/Y9AcPm6yrma6U+f/T+PKp66vA7e6vafc2dkq/c=;
        b=B3sPlIVcl5pOgssbmvwI9eArz3L/EvW+OODLaugbR6XfvX6Xb8VBgXQJd3uaG9u7SW
         j+Cs9a3OUrVVHp795ks7Di2kznRN7MRzQkevJ646QQR/5KIBE2BAw6PEY+1Yu8jIrkQq
         wt4T1k1oy59edhK7Z4HwkY8hvSMadYu4OjtwfYWR4MD1mr138uKBzLTIpFGif2d1+X/O
         0qYxS78BEXz4a9c6nUF/engi08lj8xygkFaXndU8rd0+56StDOV2aZasbIvYPtV94Lnz
         Nb6wHrhFqn6m54lp9yG/f1vN/DGsmP+OpTJMJ3khNq+upqulDkZFAjGKCUDGYOMNSYsh
         dXjg==
X-Received: by 10.60.79.5 with SMTP id f5mr6168522oex.59.1377112397904;
        Wed, 21 Aug 2013 12:13:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm12357303obi.3.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 21 Aug 2013 12:13:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.499.gfb33910
In-Reply-To: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232720>

The short SHA-1 collision test employs two "magic" values in commit
messages to trigger an "ambiguous SHA-1 error" during 'rebase -i' -- one
for 'collide3' during setup, and one for 'collide2' at rebase time --
even though the collision can just as easily be triggered by a single
magic value at rebase time only. The setup-time 'collide3' magic value
serves no purpose [1], but can easily mislead readers into thinking that
it is somehow significant even though it is not. Drop this unneeded bit
of magic.

As a side-effect, this also simplifies the setup-time "test_commit
collide3" invocation, making it easier to read.

[1]: The magic value on 'collide3' gave it a short SHA-1 prefix of
"badbeef" which could be spotted easily in verbose output during
development of the test, but is otherwise not meaningful or helpful.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 7d15c7a..50e22b1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1058,7 +1058,7 @@ test_expect_success 'short SHA-1 setup' '
 	unset test_tick &&
 	test_commit collide1 collide &&
 	test_commit --notick collide2 collide &&
-	test_commit --notick "collide3 115158b5" collide collide3 collide3
+	test_commit --notick collide3 collide
 	)
 '
 
@@ -1069,7 +1069,7 @@ test_expect_success 'short SHA-1 collide' '
 	unset test_tick &&
 	test_tick &&
 	set_fake_editor &&
-	FAKE_COMMIT_MESSAGE="collide2 815200e" \
+	FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
 	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
 	)
 '
-- 
1.8.4.rc4.499.gfb33910
