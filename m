From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/2] remote: "rename o foo" should not rename ref "origin/bar"
Date: Wed, 31 Aug 2011 21:50:43 -0400
Message-ID: <1314841843-19868-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 01 03:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QywR1-0007eD-Gm
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 03:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757416Ab1IABvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 21:51:10 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:40207 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757388Ab1IABvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 21:51:09 -0400
Received: by mail-vx0-f174.google.com with SMTP id 9so932863vxi.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 18:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IH8sVGDO3TJIurcLDePefQIWBuZq0Lh6dMtXwmFdQck=;
        b=Ua5r+xBsgY2zjR1mf6L0ozkO+8ij0ZSeNTs8/zW9EpqArWXdr0N2tnADSETOdx3uhL
         XBSW1Plf8khL0ewBUtEmr8KideYhrdTqg+QPBUEJjLV0+GbOj2CQMxTXNbl55+xukGLN
         Y9rAXKIul70Y2Oag9EQ3oh0xB6xcn8ABaNgv4=
Received: by 10.52.28.80 with SMTP id z16mr1009121vdg.75.1314841868674;
        Wed, 31 Aug 2011 18:51:08 -0700 (PDT)
Received: from localhost.localdomain (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id j8sm107956vdv.47.2011.08.31.18.51.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 31 Aug 2011 18:51:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
In-Reply-To: <1314841843-19868-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180515>

When renaming a remote called 'o' using 'git remote rename o foo', git
should also rename any remote-tracking branches for the remote. This
does happen, but any remote-tracking branches starting with
'refs/remotes/o', such as 'refs/remotes/origin/bar', will also be
renamed (to 'refs/remotes/foorigin/bar' in this case).

Fix it by simply matching one more character, up to the slash
following the remote name.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 builtin/remote.c  |    2 +-
 t/t5505-remote.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c1763ed..127cff4 100644
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
index 7b6f443..57b584c 100755
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
