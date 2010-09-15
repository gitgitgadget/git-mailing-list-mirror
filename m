From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] mergetool-lib: add a three-way diff view for vim/gvim
Date: Tue, 14 Sep 2010 21:21:43 -0500
Message-ID: <1284517303-17244-2-git-send-email-dpmcgee@gmail.com>
References: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	David Aguilar <davvid@gmail.com>,
	Charles Bailey <charles@hashpling.org>,
	Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 15 04:22:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovhdj-000201-BA
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 04:22:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254Ab0IOCWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 22:22:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34048 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab0IOCWD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 22:22:03 -0400
Received: by mail-iw0-f174.google.com with SMTP id 5so6597696iwn.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 19:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OrZwc0jgL3ZS3z1mjN9y9ptjodJkEtSDfMtiJrfOtFk=;
        b=t7CddGoHHMH5nHp0zEc7KP5em0iBI1zHEWRs4hHfmqXxWpbTEYoFltQLQ8izMMK+ZY
         a3D3xf3tNnFUp89yhee5uerqXtbN7KdKgQYKf8/dSkI8P2JJa8JNKB4dBjP2Q7fWXBpb
         fWtdVELNHqCDAoxbSMSx1KCJG2eYyEQapZ9tY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CxAFdyvyx091GIUT93w1VzXAap5rsDmNZ5b0qmZD1JBgMYSXCUiPk7VH9mrN0+2Hw1
         Zv9Gb8KPh+G8kim6mEaajKaSqgzmSUwwm9VcyuXc7KyBt1nUy696BZLcL/7idiADmTCL
         kaDSAP5uTii8KozLhZ4ICmGakQnCKkUMatyBI=
Received: by 10.231.35.202 with SMTP id q10mr859068ibd.138.1284517323225;
        Tue, 14 Sep 2010 19:22:03 -0700 (PDT)
Received: from localhost ([99.140.187.0])
        by mx.google.com with ESMTPS id g31sm681758ibh.16.2010.09.14.19.22.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 19:22:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1284517303-17244-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156222>

When the base version is available, use a three-way, four panel view by
default. This shows the (local, base, remote) revisions up top and the
merged result by itself in the lower pane. All revisions will still scroll
together by default, and the cursor still defaults to the merged result edit
pane.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---

Vim was one of the few diff commands to not support a three-way merge showing
the base revision, so this is a stab at resolving that shortfall. The biggest
objection I can see to this is making the interface a bit more cumbersome and
bloated.

An example screenshot of what this produces:
http://www.toofishes.net/media/extra/vim_three_way.png

-Dan

 git-mergetool--lib.sh |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index f9a51ba..b84ac58 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -172,8 +172,13 @@ run_merge_tool () {
 	vimdiff|gvimdiff)
 		if merge_mode; then
 			touch "$BACKUP"
-			"$merge_tool_path" -f -d -c "wincmd l" \
-				"$LOCAL" "$MERGED" "$REMOTE"
+			if $base_present; then
+				"$merge_tool_path" -f -d -c "wincmd J" \
+					"$MERGED" "$LOCAL" "$BASE" "$REMOTE"
+			else
+				"$merge_tool_path" -f -d -c "wincmd l" \
+					"$LOCAL" "$MERGED" "$REMOTE"
+			fi
 			check_unchanged
 		else
 			"$merge_tool_path" -f -d -c "wincmd l" \
-- 
1.7.2.3
