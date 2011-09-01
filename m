From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/2] remote: write correct fetch spec when renaming remote 'remote'
Date: Wed, 31 Aug 2011 21:50:42 -0400
Message-ID: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 03:51:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QywQu-0007cJ-Vh
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 03:51:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383Ab1IABvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 21:51:04 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40207 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab1IABvC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 21:51:02 -0400
Received: by vxi9 with SMTP id 9so932863vxi.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Y2XSp6/B2qM6Co9a6fM9yWbbByvZe3X+W4PfVfVM0Zs=;
        b=BERyJieDoNCV8INlnT6y1ghphgMieJgrA9s8aNNuB7d6z6wWw0wI2CW9FMQ1VRphFR
         7baR2r1wYVGXKcPm+AqHLY7RYimGY1l3pJwV6xeopWgCc3zL+SnjMhHYZPaQc5vQ3UeO
         hJrScVnouKjn1k6qeFtA7Il8gXEdzIR6LNMyU=
Received: by 10.52.94.200 with SMTP id de8mr1069246vdb.126.1314841861192;
        Wed, 31 Aug 2011 18:51:01 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id j8sm107956vdv.47.2011.08.31.18.50.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Aug 2011 18:51:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180514>

When renaming a remote whose name is contained in a configured fetch
refspec for that remote, we currently replace the first occurrence of
the remote name in the refspec. This is correct in most cases, but
breaks if the remote name occurs in the fetch refspec before the
expected place. For example, we currently change

[remote "remote"]
	url = git://git.kernel.org/pub/scm/git/git.git
	fetch = +refs/heads/*:refs/remotes/remote/*

into

[remote "origin"]
	url = git://git.kernel.org/pub/scm/git/git.git
	fetch = +refs/heads/*:refs/origins/remote/*

Reduce the risk of changing incorrect sections of the refspec by
requiring the string to be matched to have leading and trailing
slashes, i.e. match "/<name>/" instead of just "<name>".

We could have required even a leading ":refs/remotes/", but that would
mean that we would limit the types of refspecs we could help the user
update.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/remote.c  |   12 ++++++++----
 t/t5505-remote.sh |   20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..c1763ed 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -621,7 +621,8 @@ static int mv(int argc, const char **argv)
 		OPT_END()
 	};
 	struct remote *oldremote, *newremote;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
+		old_remote_context = STRBUF_INIT;
 	struct string_list remote_branches = STRING_LIST_INIT_NODUP;
 	struct rename_info rename;
 	int i;
@@ -659,15 +660,18 @@ static int mv(int argc, const char **argv)
 	strbuf_addf(&buf, "remote.%s.fetch", rename.new);
 	if (git_config_set_multivar(buf.buf, NULL, NULL, 1))
 		return error("Could not remove config section '%s'", buf.buf);
+	strbuf_addf(&old_remote_context, "/%s/", rename.old);
 	for (i = 0; i < oldremote->fetch_refspec_nr; i++) {
 		char *ptr;
 
 		strbuf_reset(&buf2);
 		strbuf_addstr(&buf2, oldremote->fetch_refspec[i]);
-		ptr = strstr(buf2.buf, rename.old);
+		ptr = strstr(buf2.buf, old_remote_context.buf);
 		if (ptr)
-			strbuf_splice(&buf2, ptr-buf2.buf, strlen(rename.old),
-					rename.new, strlen(rename.new));
+			strbuf_splice(&buf2,
+				      ptr-buf2.buf + 1,
+				      strlen(rename.old), rename.new,
+				      strlen(rename.new));
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return error("Could not append '%s'", buf.buf);
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0d0222e..7b6f443 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -631,6 +631,26 @@ test_expect_success 'rename a remote' '
 
 '
 
+test_expect_success 'rename a remote with non-default fetch refspec' '
+
+	git clone one four.one &&
+	(cd four.one &&
+	 git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+	 git remote rename origin upstream &&
+	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/upstream/*")
+
+'
+
+test_expect_success 'rename a remote with name part of fetch spec' '
+
+	git clone one four.two &&
+	(cd four.two &&
+	 git remote rename origin remote &&
+	 git remote rename remote upstream &&
+	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/remotes/upstream/*")
+
+'
+
 cat > remotes_origin << EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
1.7.6.51.g07e0e
