From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/6] transport-helper: clarify pushing without refspecs
Date: Wed, 17 Apr 2013 19:05:21 -0500
Message-ID: <1366243524-18202-4-git-send-email-felipe.contreras@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScNN-00079y-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935184Ab3DRAGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:46 -0400
Received: from mail-yh0-f51.google.com ([209.85.213.51]:56051 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935433Ab3DRAGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:45 -0400
Received: by mail-yh0-f51.google.com with SMTP id q67so363182yhf.24
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=FoG0ti+PkPecB5KSi4cqzwzwCjp9Du7Rob7AC4bsyE8=;
        b=D4+P9hJOQhf32uV8s5ep9UDRGygw7w8k/4iBcakeDfIxlShPeKopKwuiwVv6U+1xhq
         hduNDL1VukwuOH/W2kykTusEAYBsbQTzYikrY1fHTG4sOqtwyJ5BcnKjmHmi03g2qqyW
         ItVQgBrGz0VcyouW1iCpS15g/1ZwvtXGc6rO9ijUt8RWdAdrpponRXhz6HSmO5SKrvSw
         RXvXbWrGPAlIlS5BsH0SDdbcbXEuqKBps/ro1zsJeZ83WhP9UUS5mWsFa2/aVyD7gnAO
         cEt+6Jk4tWw81TYaP/Bd5bllsPA5aYwI/q639r73/IUMcFIFWIQO/gWaY3I1r5dDEUVy
         h9mw==
X-Received: by 10.236.200.37 with SMTP id y25mr5682597yhn.110.1366243604433;
        Wed, 17 Apr 2013 17:06:44 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id b78sm13099253yhi.2.2013.04.17.17.06.42
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221590>

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
