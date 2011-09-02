From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCHv2 2/2] remote: "rename o foo" should not rename ref "origin/bar"
Date: Thu,  1 Sep 2011 20:50:34 -0400
Message-ID: <1314924634-12235-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 02 02:51:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzHyK-0006KI-El
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 02:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab1IBAu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 20:50:57 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40625 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747Ab1IBAu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 20:50:56 -0400
Received: by vxi9 with SMTP id 9so1734618vxi.19
        for <git@vger.kernel.org>; Thu, 01 Sep 2011 17:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5Y4vo7BNE0XXT1YZVIqjad97SrwtC43q0VD9PqnxG/8=;
        b=kh/cGJ2/jEgzWnREDElEUfJsVH52/HWtVuzL5wesw9mdQw5i56f4VgHTuFbKXSemcW
         ecd8NZaVJO+T2qd54SThJsVbMGV0nuv7ANWg/lOavenFkstaNsoebFeD9bnc1Bv0OVOm
         KddkW7BGEngkDpcUnuXMxrG9Qh2/N1oiYQBL4=
Received: by 10.52.173.101 with SMTP id bj5mr476351vdc.387.1314924654220;
        Thu, 01 Sep 2011 17:50:54 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id a10sm533608vdk.7.2011.09.01.17.50.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Sep 2011 17:50:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <1314924634-12235-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180589>

When renaming a remote called 'o' using 'git remote rename o foo', git
should also rename any remote-tracking branches for the remote. This
does happen, but any remote-tracking branches starting with
'refs/remotes/o', such as 'refs/remotes/origin/bar', will also be
renamed (to 'refs/remotes/foorigin/bar' in this case).

Fix it by simply matching one more character, up to the slash
following the remote name.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
No changes since v1.

 builtin/remote.c  |    2 +-
 t/t5505-remote.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6d08738..0df6ab0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -570,7 +570,7 @@ static int read_remote_branches(const char *refname,
 	unsigned char orig_sha1[20];
 	const char *symref;
 
-	strbuf_addf(&buf, "refs/remotes/%s", rename->old);
+	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (!prefixcmp(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref(refname, orig_sha1, 1, &flag);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 36c807c..15186c8 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -651,6 +651,16 @@ test_expect_success 'rename a remote with name part of fetch spec' '
 
 '
 
+test_expect_success 'rename a remote with name prefix of other remote' '
+
+	git clone one four.three &&
+	(cd four.three &&
+	 git remote add o git://example.com/repo.git &&
+	 git remote rename o upstream &&
+	 test "$(git rev-parse origin/master)" = "$(git rev-parse master)")
+
+'
+
 cat > remotes_origin << EOF
 URL: $(pwd)/one
 Push: refs/heads/master:refs/heads/upstream
-- 
1.7.6.51.g07e0e
