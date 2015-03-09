From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2] t7510: do not fail when gpg warns about insecure memory
Date: Mon,  9 Mar 2015 13:03:01 -0700
Message-ID: <b822f2716d8bdfcb6576ad0dc502af5@74d39fa044aa309eaea14b9f57fe79c>
References: <2652cb72a82d4ca4be3ea90bafd263e@74d39fa044aa309eaea14b9f57fe79c> <CAPig+cQXJgZJAoyQVYg3CNNzd70eA=ttdL7=g6wabtBkWBijeQ@mail.gmail.com> <20150308220424.GD4245@vauxhall.crustytoothpaste.net> <CAPig+cTj_z0xpDmnSvb-S_wEbwzdcFsGwUkFdGWgcJhwZpfMFQ@mail.gmail.com> <20150309012214.GE4245@vauxhall.crustytoothpaste.net> <E72F95BF-BE00-433E-9D05-0DDF1CACCCC1@gmail.com> <54FD6C22.4020808@drmicha.warpmail.net>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:03:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YV3tU-0007J0-8U
	for gcvg-git-2@plane.gmane.org; Mon, 09 Mar 2015 21:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbbCIUDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2015 16:03:12 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:43300 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314AbbCIUDK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2015 16:03:10 -0400
Received: by pablj1 with SMTP id lj1so65944626pab.10
        for <git@vger.kernel.org>; Mon, 09 Mar 2015 13:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l4D224ZFk+StmR7xRjSEyOUc4WALjDCnztmOZ8kQOy4=;
        b=tTqtMprs4HRizXCplMfF+sbTkGuhrl8H0hERs9IQQj+KPT5OWnyf1T+mvdmxPKbvRA
         vNtq/82LZ41neSoP4ewXHYj01h+tpxkjB5QVhae4NdJlE2ZOgQX7Vk+HButTNSwWdsZ3
         nBmJV/BWvtXAxR/MctTSGb8Ph9Vn1LsEw14GRQKzq9d1qlJcOZxnYpVTJlGYzxdK4Lr8
         pRqWldcLr/bkw2Dm951Mbm6SyThJwN9NUGsi7FtWeyk+qtWZWHdvc9j1JmFc0GGHu1rA
         CzbNVtf3gGgmV7YSX3MJeEBCsL/2xw0njh3PnDjCciXIpc2U0H6x8BNqeLRV3TscYh9C
         f98w==
X-Received: by 10.66.101.35 with SMTP id fd3mr58294492pab.50.1425931390134;
        Mon, 09 Mar 2015 13:03:10 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id qn14sm20654538pab.33.2015.03.09.13.03.08
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Mar 2015 13:03:09 -0700 (PDT)
In-Reply-To: <54FD6C22.4020808@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265191>

Depending on how gpg was built, it may issue the following
message to stderr when run:

  Warning: using insecure memory!

When the test is collecting gpg output it is therefore not
enough to just match on a "gpg: " prefix it must also match
on a "Warning: " prefix wherever it needs to match lines
that have been produced by gpg.

Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

How about this patch instead.  It just treats "Warning:" lines as gpg  
output and the test still passes when "Warning: using insecure memory"  
shows up.

-Kyle

 t/t7510-signed-commit.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 474dab38..3cef18cf 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -86,8 +86,8 @@ test_expect_success GPG 'show signed commit with signature' '
 	git show -s --show-signature initial >show &&
 	git verify-commit -v initial >verify.1 2>verify.2 &&
 	git cat-file commit initial >cat &&
-	grep -v "gpg: " show >show.commit &&
-	grep "gpg: " show >show.gpg &&
+	grep -v -e "gpg: " -e "Warning: " show >show.commit &&
+	grep -e "gpg: " -e "Warning: " show >show.gpg &&
 	grep -v "^ " cat | grep -v "^gpgsig " >cat.commit &&
 	test_cmp show.commit commit &&
 	test_cmp show.gpg verify.2 &&
---
