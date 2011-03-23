From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add: make "add -u/-A" update full tree without pathspec
 (step 2)
Date: Tue, 22 Mar 2011 22:17:56 -0700
Message-ID: <7v7hbqifej.fsf_-_@alter.siamese.dyndns.org>
References: <7vy649vah1.fsf@alter.siamese.dyndns.org>
 <7vtyexv6wl.fsf@alter.siamese.dyndns.org>
 <7vpqplv65o.fsf@alter.siamese.dyndns.org> <vpqlj09a303.fsf@bauges.imag.fr>
 <7vhbaxuyk7.fsf@alter.siamese.dyndns.org>
 <20110321111643.GE16334@sigill.intra.peff.net>
 <7vtyeuiu07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 23 06:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2GSX-0003MM-0M
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 06:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab1CWFSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 01:18:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab1CWFSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 01:18:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EE4020F6;
	Wed, 23 Mar 2011 01:19:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1+TBUcpqwg1fgco0UKE1xD5PK9o=; b=A4ZEyG
	Ca7+BIYXqFGfIN+0ECTcHSLReOwYusQM98jqal71lRIfwoZPgeeTk0zvKQeiJZEO
	9Cv5NmHrYF8v8jUhOLFTGzT87SPZzxeZSs+QKJcoG3QNtRfwen3uqBnEg1ARwlKT
	WyQ0rMyMC3kWcukz74lIg/VLOEcYCXzYTtHZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A+WflVcLEHRRqwFoiDdsQSaWi746tyzv
	Ya4+1mfsb6gLAPNqcDOSnZe0zwVeQmREDgwT6lEF9T8fJa/xvpY4QhanSAhnilcp
	JWgCqarGlerofvlOEXXVUE4JuEa8zJZrY4gRlUr/A8TToNtwfXPTUrsNbG95aUWo
	qFDUUk/qG5w=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0603E20F5;
	Wed, 23 Mar 2011 01:19:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9EF0A20F4; Wed, 23 Mar 2011
 01:19:38 -0400 (EDT)
In-Reply-To: <7vtyeuiu07.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 22 Mar 2011 17:02:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28DA480C-550D-11E0-833E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169797>

Flip the default behaviour when "git add -u/-A" is run without a
pathspec from a subdirectory to tree-wide, and reword the advice
message.

We will need to keep the advice message for a while to help people
who skipped the 1.8.0 boundary.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is how 1.8.0 "flip the default" would look like.

 builtin/add.c         |   20 +++++++++-----------
 t/t2200-add-update.sh |    5 ++---
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 595f5cc..1d76d55 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -365,17 +365,15 @@ static int add_files(struct dir_struct *dir, int flags)
 }
 
 static const char *warn_add_uA_180_migration_msg[] = {
-	"In release 1.8.0, running 'git add -u' (or 'git add -A') from",
-	"a subdirectory without giving any pathspec WILL take effect",
+	"Since release 1.8.0, running 'git add -u' (or 'git add -A')",
+	"from a subdirectory without giving any pathspec takes effect",
 	"on the whole working tree, not just the part under the current",
-	"directory. You can set add.treewideupdate configuration variable",
-	"to 'false' to keep the current behaviour.",
-	"You can set the configuration variable to 'true' to make the",
-	"'git add -u/-A' command without pathspec take effect on the whole",
-	"working tree now. If you do so, you can use '.' at the end of",
-	"the command, e.g. 'git add -u .' when you want to limit the",
-	"operation to the current directory.",
-	"This warning will be issued until you set the configuration variable",
+	"directory. If you want to limit the operation to the current",
+	"directory, please add '.' at the end of the command, like",
+	"'git add -u .'",
+	"Alternatively, you can set add.treewideupdate configuration",
+	"variable to 'false' to keep using the old behaviour.",
+	"This warning will be issued until you set the variable",
 	"to either 'true' or 'false'."
 };
 
@@ -384,7 +382,7 @@ static int warn_180_migration(void)
 	int i;
 	for (i = 0; i < ARRAY_SIZE(warn_add_uA_180_migration_msg); i++)
 		warning("%s", warn_add_uA_180_migration_msg[i]);
-	return 0; /* default to "no" (not tree-wide, i.e. local) */
+	return 1; /* default to "true" (tree-wide, i.e. not local) */
 }
 
 int cmd_add(int argc, const char **argv, const char *prefix)
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 7ac8b70..97478cd 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -81,8 +81,7 @@ test_expect_success 'change gets noticed' '
 '
 
 test_expect_success 'update from a subdirectory without pathspec (no config)' '
-	# This test needs to be updated to expect the whole tree
-	# update after 1.8.0 migration.
+	# This test needs to be adjusted when warning message is removed
 	test_might_fail git config --remove add.treewideupdate &&
 	test_might_fail git reset check dir1 &&
 	echo changed >check &&
@@ -92,7 +91,7 @@ test_expect_success 'update from a subdirectory without pathspec (no config)' '
 		git add -u 2>../expect.warning
 	) &&
 	git diff-files --name-only dir1 check >actual &&
-	echo check >expect &&
+	: >expect &&
 	test_cmp expect actual &&
 	grep warning expect.warning
 '
-- 
1.7.4.1.559.ga7cf60f
