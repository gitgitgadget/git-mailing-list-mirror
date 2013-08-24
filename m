From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] t3404: rebase -i: demonstrate short SHA-1 collision
Date: Fri, 23 Aug 2013 20:10:41 -0400
Message-ID: <1377303042-50868-3-git-send-email-sunshine@sunshineco.com>
References: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 24 02:11:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Rc-0007ZG-KX
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 02:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301Ab3HXALA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 20:11:00 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:61972 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048Ab3HXAK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 20:10:57 -0400
Received: by mail-ie0-f180.google.com with SMTP id x14so1829591ief.25
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 17:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rdflHk0ekvMWN2pJ5VTL1/CjK4iBgMjzO45pWpZvTFo=;
        b=L5lkxZvs7m2mXVpiT/Eo2hQXpuqh5XryJ1bOZA4uyIk+V+6X39WMFbobeDWiyLKOE9
         kxgIO6i+gGDhTmMjN6CS/LQlmFea8HPAPGPINRz6B0q9O+67k7hvSm7X6DOsvkoAoFu3
         KJ8/2UD9v1iNHGelZBS/L43EqfuLflTtvFGYxb8OIe/L/dZ2USCwg9nUVl/nl8uK5FtK
         r5IQ3AZ4P0bDUxukX43n3yTGXBCkjO69OE79kXjq8BYWf5csW4hP6SqbabOfQsTEBCRo
         cU/H49uNltaD1yULQZqAo/5UdVzRJjc3gElwyDR+sNCp0zQCqlbDGZS28h/+b5o9BOzt
         IErg==
X-Received: by 10.50.40.6 with SMTP id t6mr3401328igk.32.1377303057224;
        Fri, 23 Aug 2013 17:10:57 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id k6sm1068749igx.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 17:10:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.557.g34b3a2e
In-Reply-To: <1377303042-50868-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232853>

The 'todo' sheet for interactive rebase shows abbreviated SHA-1's and
then performs its operations upon those shortened values. This can lead
to an abort if the SHA-1 of a reworded or edited commit is no longer
unique within the abbreviated SHA-1 space and a subsequent SHA-1 in the
todo list has the same abbreviated value.

For example:

  edit f00dfad first
  pick badbeef second

If, after editing, the new SHA-1 of "first" also has prefix badbeef,
then the subsequent 'pick badbeef second' will fail since badbeef is no
longer a unique SHA-1 abbreviation:

  error: short SHA1 badbeef is ambiguous.
  fatal: Needed a single revision
  Invalid commit name: badbeef

Demonstrate this problem with a couple of specially crafted commits
which initially have distinct abbreviated SHA-1's, but for which the
abbreviated SHA-1's collide after a simple rewording of the first
commit's message.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f857161..64a02a0 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1037,4 +1037,28 @@ test_expect_success 'rebase -i with --strategy and -X' '
 	test $(cat file1) = Z
 '
 
+test_expect_success 'short SHA-1 setup' '
+	test_when_finished "git checkout master" &&
+	git checkout --orphan collide &&
+	git rm -rf . &&
+	(
+	unset test_tick &&
+	test_commit collide1 collide &&
+	test_commit --notick collide2 collide &&
+	test_commit --notick collide3 collide
+	)
+'
+
+test_expect_failure 'short SHA-1 collide' '
+	test_when_finished "reset_rebase && git checkout master" &&
+	git checkout collide &&
+	(
+	unset test_tick &&
+	test_tick &&
+	set_fake_editor &&
+	FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
+	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
+	)
+'
+
 test_done
-- 
1.8.4.557.g34b3a2e
