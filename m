From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 3/6] transport-helper: clarify pushing without refspecs
Date: Wed, 17 Apr 2013 23:14:30 -0500
Message-ID: <1366258473-12841-4-git-send-email-felipe.contreras@gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:16:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGM-00024p-W7
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:15:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab3DREP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:15:56 -0400
Received: from mail-ye0-f171.google.com ([209.85.213.171]:51337 "EHLO
	mail-ye0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab3DREPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:15:54 -0400
Received: by mail-ye0-f171.google.com with SMTP id r10so384098yen.30
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FoG0ti+PkPecB5KSi4cqzwzwCjp9Du7Rob7AC4bsyE8=;
        b=Sbd+DoQdMS5eHeiMsnVzBcsQfySWudWOhubxj8EwbrDaR2UH/hxBvDfbQbhxPFvBWf
         MxyRoB9i/mZ2YSB8AyLTTnV7pqk3doPGhqLIXaJ4w/Ehc50my8t4Ax/0hjGdmulzB0Sk
         4az25PmGfpyb5EDUnR0yZMbj2IH4JYWVOQ0ylBg2LW9M6mdpwTf2yMYWNEP8MUOMXl97
         8EZ21e7zOhGGXbExU7KW/YFrPHI51mnelwlK21g+tgWb1TgFsvSv0TVQ7OLPVoAKGM3R
         UH/011uYFYTxoN5oR4HkPH3Z4aNmoyaAb5JC8RkRzmCMk3Th5Cxo1bWBqVoBhxRgkaMi
         RTHg==
X-Received: by 10.236.37.40 with SMTP id x28mr6380363yha.127.1366258553734;
        Wed, 17 Apr 2013 21:15:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u43sm5505411yhi.9.2013.04.17.21.15.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:15:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221604>

This has never worked, since it's inception the code simply skips all
the refs, essentially telling fast-export to do nothing.

Let's at least tell the user what's going on.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/gitremote-helpers.txt | 4 ++--
 t/t5801-remote-helpers.sh           | 6 +++---
 transport-helper.c                  | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index ba7240c..4d26e37 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -162,8 +162,8 @@ Miscellaneous capabilities
 	For remote helpers that implement 'import' or 'export', this capability
 	allows the refs to be constrained to a private namespace, instead of
 	writing to refs/heads or refs/remotes directly.
-	It is recommended that all importers providing the 'import' or 'export'
-	capabilities use this.
+	It is recommended that all importers providing the 'import'
+	capability use this. It's mandatory for 'export'.
 +
 A helper advertising the capability
 `refspec refs/heads/*:refs/svn/origin/branches/*`
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index cd1873c..3eeb309 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -111,13 +111,13 @@ test_expect_success 'pulling without refspecs' '
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pushing without refspecs' '
+test_expect_success 'pushing without refspecs' '
 	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
 	git commit -a -m ten &&
-	GIT_REMOTE_TESTGIT_REFSPEC="" git push) &&
-	compare_refs local2 HEAD server HEAD
+	GIT_REMOTE_TESTGIT_REFSPEC="" test_must_fail git push 2> ../error) &&
+	grep "remote-helper doesn.t support push; refspec needed" error
 '
 
 test_expect_success 'pulling without marks' '
diff --git a/transport-helper.c b/transport-helper.c
index cea787c..4d98567 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -785,6 +785,9 @@ static int push_refs_with_export(struct transport *transport,
 	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
 	struct strbuf buf = STRBUF_INIT;
 
+	if (!data->refspecs)
+		die("remote-helper doesn't support push; refspec needed");
+
 	helper = get_helper(transport);
 
 	write_constant(helper->in, "export\n");
@@ -795,8 +798,6 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
-		if (!data->refspecs)
-			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
-- 
1.8.2.1.679.g509521a
