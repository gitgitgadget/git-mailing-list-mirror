From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCHv2 1/2] remote: write correct fetch spec when renaming remote 'remote'
Date: Thu,  1 Sep 2011 20:50:33 -0400
Message-ID: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 02:50:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzHyC-0006I6-4i
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 02:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808Ab1IBAuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 20:50:51 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57165 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799Ab1IBAuu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 20:50:50 -0400
Received: by vws1 with SMTP id 1so1852215vws.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=mPY8/dX2Fp/6LDmTox7Qq42NsvRjoHDmwCyUsQw4AW4=;
        b=w57Wrh6rjmWQdadAEk0YanI6uhZyQF1Q/j6rOXZZ6dy5SqGNy8sGfTefS5xNEpY5/Q
         fciWcaEd+LgoJwy0vNchE1l0c30BLE4nJ1u8+zJGsZW79s8GOd3nzRPodniEVJiiWYE7
         BbbC+/n+pEtN0J41id1fDrhwtj/LRHQtglILs=
Received: by 10.52.89.99 with SMTP id bn3mr477566vdb.343.1314924649565;
        Thu, 01 Sep 2011 17:50:49 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id a10sm533608vdk.7.2011.09.01.17.50.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 17:50:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180588>

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
matching the entire ":refs/remotes/<name>/" instead of just "<name>".

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Now matches more strictly, namely on ":/refs/remotes/$OLD/".

 builtin/remote.c  |   12 ++++++++----
 t/t5505-remote.sh |   20 ++++++++++++++++++++
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index f2a9c26..6d08738 100644
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
+	strbuf_addf(&old_remote_context, ":refs/remotes/%s/", rename.old);
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
+				      ptr-buf2.buf + strlen(":refs/remotes/"),
+				      strlen(rename.old), rename.new,
+				      strlen(rename.new));
 		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
 			return error("Could not append '%s'", buf.buf);
 	}
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 0d0222e..36c807c 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -631,6 +631,26 @@ test_expect_success 'rename a remote' '
 
 '
 
+test_expect_success 'rename does not update a non-default fetch refspec' '
+
+	git clone one four.one &&
+	(cd four.one &&
+	 git config remote.origin.fetch +refs/heads/*:refs/heads/origin/* &&
+	 git remote rename origin upstream &&
+	 test "$(git config remote.upstream.fetch)" = "+refs/heads/*:refs/heads/origin/*")
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
