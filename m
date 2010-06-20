From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Mon, 21 Jun 2010 00:33:12 +0800
Message-ID: <1277051592-4552-4-git-send-email-rctay89@gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 20 18:33:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQNSy-0006zp-Ih
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab0FTQdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 12:33:37 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54611 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab0FTQdd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 12:33:33 -0400
Received: by pvg6 with SMTP id 6so1078798pvg.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 09:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9PO3IY0wN7b2AhQMj7KZevWA5HVOMLo0HCYA8ilN7Ic=;
        b=Y/WHIeJgt/yF5Q3nz6/1y6LidBNVVN3MoirqULvSxfpnylw8w0QuPBKJFEJ295s9Es
         5s/Y9aDsqi4qvP9NaS7nZQvlEF4XEpN03vfp4imJNE9MJXJwUjlTQtKHJ4X3M4q9M79z
         bWtvF0bXlFJsPY78v7V+rAkg+aj3U8B6uUt5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RT1ou9kknoE+s69yDd86NYUgkPyJFGoY1iNDjCjW+by79aJjB1gxTnsLWxMPgGq3Mi
         1yjGtFH6eYZaheM7rVi0y2cI0gn0X6m8knin8BC7QS8SpWk/4i9xjPA8+ztVqN4vIlZL
         aCAP/0z6c6NLSUioCkcgP60MMnCC/pYn75ZMw=
Received: by 10.114.8.18 with SMTP id 18mr2966487wah.51.1277051612610;
        Sun, 20 Jun 2010 09:33:32 -0700 (PDT)
Received: from localhost.localdomain (cm123.zeta152.maxonline.com.sg [116.87.152.123])
        by mx.google.com with ESMTPS id n29sm9634993wae.16.2010.06.20.09.33.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 09:33:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277051592-4552-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149398>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 Documentation/git-checkout.txt |    3 +++
 builtin/checkout.c             |    4 ++--
 t/t2018-checkout-branch.sh     |    6 +++---
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 261dd90..d15d224 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -74,6 +74,9 @@ entries; instead, unmerged entries are ignored.
 -b::
 	Create a new branch named <new_branch> and start it at
 	<start_point>; see linkgit:git-branch[1] for details.
++
+When used with `-f`, the branch is reset; changes in the index or the
+working tree are thrown away too.
 
 -t::
 --track::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 1994be9..962d938 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -511,7 +511,7 @@ static void update_refs_for_switch(struct checkout_opts *opts,
 			}
 		}
 		else
-			create_branch(old->name, opts->new_branch, new->name, 0,
+			create_branch(old->name, opts->new_branch, new->name, opts->force,
 				      opts->new_branch_log, opts->track);
 		new->name = opts->new_branch;
 		setup_branch_path(new);
@@ -858,7 +858,7 @@ no_reference:
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
 			die("git checkout: we do not like '%s' as a branch name.",
 			    opts.new_branch);
-		if (!get_sha1(buf.buf, rev))
+		if (!get_sha1(buf.buf, rev) && !opts.force)
 			die("git checkout: branch %s already exists", opts.new_branch);
 		strbuf_release(&buf);
 	}
diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
index e6c0f8c..9895ff5 100755
--- a/t/t2018-checkout-branch.sh
+++ b/t/t2018-checkout-branch.sh
@@ -63,19 +63,19 @@ test_expect_success 'checkout -b to an existing branch fails' '
 	test_must_fail do_checkout branch2 $HEAD2
 '
 
-test_expect_failure 'checkout -f -b to an existing branch resets branch' '
+test_expect_success 'checkout -f -b to an existing branch resets branch' '
 	git checkout branch1 &&
 
 	do_checkout branch2 "" -f
 '
 
-test_expect_failure 'checkout -f -b to an existing branch resets branch (explicit ref)' '
+test_expect_success 'checkout -f -b to an existing branch resets branch (explicit ref)' '
 	git checkout branch1 &&
 
 	do_checkout branch2 $HEAD1 -f
 '
 
-test_expect_failure 'checkout -f -b to an existing branch resets branch (dirty) ' '
+test_expect_success 'checkout -f -b to an existing branch resets branch (dirty) ' '
 	git checkout branch1 &&
 
 	setup_dirty &&
-- 
1.7.1.513.g4f18
