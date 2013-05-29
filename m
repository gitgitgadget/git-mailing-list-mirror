From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/3] push: factor out the detached HEAD error message
Date: Thu, 30 May 2013 00:51:49 +0530
Message-ID: <1369855311-23367-2-git-send-email-artagnon@gmail.com>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 21:23:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlyE-0002LA-NT
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966270Ab3E2TXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:23:24 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:58310 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966254Ab3E2TXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:23:21 -0400
Received: by mail-pd0-f170.google.com with SMTP id x10so9209969pdj.15
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=P8FpLV0Mfb/vi7KzVXA3riI5hokyb8fCmHSI/kvdQ3o=;
        b=aZpAASVYid87bu69xQuKRCL7P7qtWt0T/lqls1kBTfOMcDPhT6sGrCBbtThQ7xsKHm
         kcZI5zOfvQpVt4wXspEqRaJWK8ysDcXRyIiJZDJFimjF3US22Fmt9b4AFjqf13E2AV4S
         c2TbL2QzHo4Jk6Yi9rbzD6KTKn3TtEtyQIm9MvwXHySuuHgda48CFUJmT9zXmTkiI5jP
         0xN2y4dXap7Vbvuz+aLRWrtAazoU+uZaMf+LIE7o+9AHMXpUA6EPMFt3gOgFHK8pIlUd
         /cPrDinJ9X0C3xooEUJUVkODN4gcw7dXWIpmX1XO9Sd+LcQXKGJSr0RF7Pbp3jciHjhT
         HjWw==
X-Received: by 10.66.163.99 with SMTP id yh3mr3055236pab.22.1369855401165;
        Wed, 29 May 2013 12:23:21 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.150])
        by mx.google.com with ESMTPSA id xu10sm41059620pab.3.2013.05.29.12.23.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 12:23:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.12.gbd56588
In-Reply-To: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225872>

With push.default set to upstream or simple, and a detached HEAD, git
push prints the following error:

  $ git push
  fatal: You are not currently on a branch.
  To push the history leading to the current (detached HEAD)
  state now, use

    git push ram HEAD:<name-of-remote-branch>

This error is not unique to upstream or simple: current cannot push with
a detached HEAD either.  So, factor out the error string in preparation
for using it in current.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 909c34d..ef3aa97 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -113,17 +113,19 @@ static NORETURN int die_push_simple(struct branch *branch, struct remote *remote
 	    remote->name, branch->name, advice_maybe);
 }
 
+static const char message_detached_head_die[] =
+	N_("You are not currently on a branch.\n"
+	   "To push the history leading to the current (detached HEAD)\n"
+	   "state now, use\n"
+	   "\n"
+	   "    git push %s HEAD:<name-of-remote-branch>\n");
+
 static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
-		die(_("You are not currently on a branch.\n"
-		    "To push the history leading to the current (detached HEAD)\n"
-		    "state now, use\n"
-		    "\n"
-		    "    git push %s HEAD:<name-of-remote-branch>\n"),
-		    remote->name);
+		die(_(message_detached_head_die), remote->name);
 	if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 		die(_("The current branch %s has no upstream branch.\n"
 		    "To push the current branch and set the remote as upstream, use\n"
-- 
1.8.3.12.gbd56588
