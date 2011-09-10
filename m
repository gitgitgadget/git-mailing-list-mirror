From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 4/2] remote: only update remote-tracking branch if updating refspec
Date: Sat, 10 Sep 2011 15:39:23 -0400
Message-ID: <1315683563-11416-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <7vr53rx9r6.fsf@alter.siamese.dyndns.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 21:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2TP3-0003DQ-Md
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 21:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933882Ab1IJTjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 15:39:32 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:63764 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933848Ab1IJTjc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 15:39:32 -0400
Received: by qyk30 with SMTP id 30so908832qyk.19
        for <git@vger.kernel.org>; Sat, 10 Sep 2011 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=zgcN/A7rR2iKGPtwEj8WuXx/8sGFuBtbpmbEV1IkRbk=;
        b=R6BUwV88GyTnMknIsWwcVqkeM/jeN6C0knB5ROoTShyTVUnRnmYs82lcTwQYVR49eT
         bhMQ6BuBAz3SxubA1vOWYke9AZ7GnDOQFBSnWutktGSnr3SWdXTT7CZtCtzlNoox9zbI
         PqRecdeNeR/G4qE/rw2Qj2uNLEa57uyxsz1nc=
Received: by 10.229.24.132 with SMTP id v4mr511427qcb.193.1315683571240;
        Sat, 10 Sep 2011 12:39:31 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca. [24.37.77.94])
        by mx.google.com with ESMTPS id z1sm3220901qao.1.2011.09.10.12.39.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 10 Sep 2011 12:39:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.rc0.317.gd0afe
In-Reply-To: <7vr53rx9r6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181159>

'git remote rename' will only update the remote's fetch refspec if it
looks like a default one. If the remote has no default fetch refspec,
as in

[remote "origin"]
    url = git://git.kernel.org/pub/scm/git/git.git
    fetch = +refs/heads/*:refs/remotes/upstream/*

we would not update the fetch refspec and even if there is a ref
called "refs/remotes/origin/master", we should not rename it, since it
was not created by fetching from the remote.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Some questions on style:

1. Should I wrap the statement in "else" block in braces when "then"
   block has braces? I couldn't find anything conclusive by looking at
   existing code.

2. Is it ok (as I did) to return from the function prematurely even
   though it is not an error case? This will of course make the
   function more brittle when it comes to adding code at the end of
   it. Would you prefer to invert the condition and put the remainder
   of the function inside the "then" block? Or even to extract the
   code into a new function?

 builtin/remote.c  |   10 +++++++---
 t/t5505-remote.sh |    3 ++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 61326cb..b25dfb4 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -625,7 +625,7 @@ static int mv(int argc, const char **argv)
 		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
-	int i;
+	int i, refspec_updated = 0;
 
 	if (argc != 3)
 		usage_with_options(builtin_remote_rename_usage, options);
@@ -667,12 +667,13 @@ static int mv(int argc, const char **argv)
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
 		ptr = strstr(buf2.buf, old_remote_context.buf);
-		if (ptr)
+		if (ptr) {
+			refspec_updated = 1;
 			strbuf_splice(&buf2,
 				      ptr-buf2.buf + strlen(":refs/remotes/"),
 				      strlen(rename.old), rename.new,
 				      strlen(rename.new));
-		else
+		} else
 			warning("Not updating non-default fetch respec\n"
 				"\t%s\n"
 				"\tPlease update the configuration manually if necessary.",
@@ -695,6 +696,9 @@ static int mv(int argc, const char **argv)
 		}
 	}
 
+	if (!refspec_updated)
+		return 0;
+
 	/*
 	 * First remove symrefs, then rename the rest, finally create
 	 * the new symrefs.
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 15186c8..e8af615 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -637,7 +637,8 @@ test_expect_success 'rename does not update a non-default fetch refspec' '
 	(cd four.one &&
 	 git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
 	 git remote rename origin upstream &&
-	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*")
+	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*" &&
+	 git rev-parse -q origin/master)
 
 '
 
-- 
1.7.7.rc0.317.gd0afe
