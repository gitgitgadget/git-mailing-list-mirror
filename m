From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2] add: ignore only ignored files
Date: Fri, 21 Nov 2014 17:08:19 +0100
Message-ID: <b4834f562679d7ccad683463edc61db5ea962d8d.1416585536.git.git@drmicha.warpmail.net>
References: <546F5CC7.8060904@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 21 17:08:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xrql3-0002op-VJ
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 17:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755612AbaKUQIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2014 11:08:22 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:32870 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755442AbaKUQIV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Nov 2014 11:08:21 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 27955208BB
	for <git@vger.kernel.org>; Fri, 21 Nov 2014 11:08:21 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 21 Nov 2014 11:08:21 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:from:to:cc:subject:date
	:message-id:in-reply-to:references; s=smtpout; bh=z6C7lAIA1J0vFj
	eKYRsNJLG2+QY=; b=qTl2U24uiK9cPVUe+fmijGuyTq5yUoInmHLEgD/QVcHJnN
	NvEmNaBWCy8ooaajPbl231r7GaW+for3eYEOrC7jlvoUzX8KRGvP85BSMWPxAKpo
	3LUzL0mxaTKbxNWVOSsNw/Y1qTsNvXo7cCzBwwxI6UAG2a8S4dV/561DwUyVE=
X-Sasl-enc: MnIXIGocz3qT9m6wYXDduwFl4itWNY5fIu+DIgDyBXs5 1416586100
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id B4422C0000A;
	Fri, 21 Nov 2014 11:08:20 -0500 (EST)
X-Mailer: git-send-email 2.2.0.rc2.293.gc05a35d
In-Reply-To: <546F5CC7.8060904@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git add foo bar" adds neither foo nor bar when bar is ignored, but dies
to let the user recheck their command invocation. This becomes less
helpful when "git add foo.*" is subject to shell expansion and some of
the expanded files are ignored.

"git add --ignore-errors" is supposed to ignore errors when indexing
some files and adds the others. It does ignore errors from actual
indexing attempts, but does not ignore the error "file is ignored" as
outlined above. This is unexpected.

Change "git add foo bar" to add foo when bar is ignored, but issue
a warning and return a failure code as before the change.

That is, in the case of trying to add ignored files we now act the same
way (with or without "--ignore-errors") in which we act for more
severe indexing errors when "--ignore-errors" is specified.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
As discussed, we change behavior even without the option.
I.a.w.: We declare "add ignored file" as a minor error compared
to an actual indexing error.

My sincere thanks go out to Jeff without whom I could not possibly
have come up with a patch like this :)

 builtin/add.c  | 2 +-
 t/t3700-add.sh | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ae6d3e2..1074e32 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -284,7 +284,7 @@ static int add_files(struct dir_struct *dir, int flags)
 		for (i = 0; i < dir->ignored_nr; i++)
 			fprintf(stderr, "%s\n", dir->ignored[i]->name);
 		fprintf(stderr, _("Use -f if you really want to add them.\n"));
-		die(_("no files added"));
+		exit_status = 1;
 	}
 
 	for (i = 0; i < dir->nr; i++)
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index fe274e2..f7ff1f5 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -91,6 +91,13 @@ test_expect_success 'error out when attempting to add ignored ones without -f' '
 	! (git ls-files | grep "\\.ig")
 '
 
+test_expect_success 'error out when attempting to add ignored ones but add others' '
+	touch a.if &&
+	test_must_fail git add a.?? &&
+	! (git ls-files | grep "\\.ig") &&
+	(git ls-files | grep a.if)
+'
+
 test_expect_success 'add ignored ones with -f' '
 	git add -f a.?? &&
 	git ls-files --error-unmatch a.ig
@@ -311,7 +318,6 @@ cat >expect.err <<\EOF
 The following paths are ignored by one of your .gitignore files:
 ignored-file
 Use -f if you really want to add them.
-fatal: no files added
 EOF
 cat >expect.out <<\EOF
 add 'track-this'
-- 
2.2.0.rc2.293.gc05a35d
