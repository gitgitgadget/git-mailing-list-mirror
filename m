From: Kenny Root <kroot@google.com>
Subject: [PATCH] Remove restriction on notes ref base
Date: Mon,  1 Nov 2010 17:16:43 -0700
Message-ID: <1288657003-17802-1-git-send-email-kroot@google.com>
Cc: Kenny Root <kroot@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 02 01:16:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PD4YX-0000Dl-BN
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 01:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab0KBAQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Nov 2010 20:16:48 -0400
Received: from smtp-out.google.com ([74.125.121.35]:55626 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab0KBAQr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 20:16:47 -0400
Received: from kpbe12.cbf.corp.google.com (kpbe12.cbf.corp.google.com [172.25.105.76])
	by smtp-out.google.com with ESMTP id oA20Gjlk021375
	for <git@vger.kernel.org>; Mon, 1 Nov 2010 17:16:45 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1288657006; bh=5cUEzVrliSXqdCe/Qnd1WClrvIE=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=bzCDLYnXU2xbphN2ko8+SYAHxn+htVDGHNcu/mL6C2G21fD2+GwKnhHTMIXl0LMjD
	 +CSq5pmktveUMU27ioJZg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=from:to:cc:subject:date:message-id:x-mailer;
	b=eYVYk2d9S1xKsGo9zboEsh47wnIrGyWu+P2OsCvuykWdv/vtSDxyoMdO/xg7W6bM7
	KnkzXf4gY/sg0pJcBGgnA==
Received: from kroot.mtv.corp.google.com (kroot.mtv.corp.google.com [172.18.103.3])
	by kpbe12.cbf.corp.google.com with ESMTP id oA20GhXt015285;
	Mon, 1 Nov 2010 17:16:44 -0700
X-Mailer: git-send-email 1.7.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160503>

Git notes were restricted to refs/notes/* in the command line utilities,
but setting things like GIT_NOTES_REF to something outside of that
structure would work.

This removes the restrictions on the git notes command line interface.

Signed-off-by: Kenny Root <kroot@google.com>
---
 builtin/notes.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 6d07aac..9acce7b 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -343,11 +343,7 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
 	} else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
 		/* note that a refs/ prefix is implied in the
 		 * underlying for_each_glob_ref */
-		if (!prefixcmp(v, "refs/notes/"))
-			string_list_add_refs_by_glob(c->refs, v);
-		else
-			warning("Refusing to rewrite notes in %s"
-				" (outside of refs/notes/)", v);
+		string_list_add_refs_by_glob(c->refs, v);
 		return 0;
 	}
 
@@ -473,9 +469,6 @@ static struct notes_tree *init_notes_check(const char *subcommand)
 	init_notes(NULL, NULL, NULL, 0);
 	t = &default_notes_tree;
 
-	if (prefixcmp(t->ref, "refs/notes/"))
-		die("Refusing to %s notes in %s (outside of refs/notes/)",
-		    subcommand, t->ref);
 	return t;
 }
 
@@ -844,7 +837,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 
 	if (override_notes_ref) {
 		struct strbuf sb = STRBUF_INIT;
-		if (!prefixcmp(override_notes_ref, "refs/notes/"))
+		if (!prefixcmp(override_notes_ref, "refs/"))
 			/* we're happy */;
 		else if (!prefixcmp(override_notes_ref, "notes/"))
 			strbuf_addstr(&sb, "refs/");
-- 
1.7.3.1
