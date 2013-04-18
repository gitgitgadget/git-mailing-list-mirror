From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/6] transport-helper: warn when refspec is not used
Date: Wed, 17 Apr 2013 19:05:22 -0500
Message-ID: <1366243524-18202-5-git-send-email-felipe.contreras@gmail.com>
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
	id 1UScNN-00079y-LZ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935496Ab3DRAGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:49 -0400
Received: from mail-gh0-f170.google.com ([209.85.160.170]:64997 "EHLO
	mail-gh0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935433Ab3DRAGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:48 -0400
Received: by mail-gh0-f170.google.com with SMTP id z2so278428ghb.15
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0m9QuZKLt0LnWx7I4i8u5cFE6ar3hr0hXs9ulnWX1/I=;
        b=wdVGtsh8QHrMVXZXvSYP26vriKObpGPQwbBzcgteBNgHYGDBaVnf7OGawmmYljP04K
         rj26AjcTnf7ju+zCmNg3jX+UR7o5LAisWmzaaPhhk4+O5t3oq+b4USUTHz5lsPIfasQo
         WxzqjyhE+wr2EKPW69+v4Nbc5vv6U2nnnepFubWH09wVLd3cN9oog8zR465eV4secR7m
         F3xx2OBKc/ExdFKKq3L9q8mR6KUqnIT+v0/kjCws+2L0Gke4i9Bisdu0ApnHiLuK0y4/
         zIvFI2ytw3fqJTzlk2VMyir+i4VEsw+fsrH0/uvaeYX7I5joQuyJeaGXbWQNPWszjx2k
         BYyw==
X-Received: by 10.236.123.135 with SMTP id v7mr5799202yhh.100.1366243607352;
        Wed, 17 Apr 2013 17:06:47 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id i47sm13076365yha.8.2013.04.17.17.06.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221591>

For the modes that need it. In the future we should probably error out,
instead of providing half-assed support.

The reason we want to do this is because if it's not present, the remote
helper might be updating refs/heads/*, or refs/remotes/origin/*,
directly, and in the process fetch will get confused trying to update
refs that are already updated, or older than what they should be. We
shouldn't be messing with the rest of git.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 6 ++++--
 transport-helper.c        | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 3eeb309..1bb7529 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -100,14 +100,16 @@ test_expect_failure 'push new branch with old:new refspec' '
 
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
-	git clone "testgit::${PWD}/server" local2 &&
+	git clone "testgit::${PWD}/server" local2 2> error &&
+	grep "This remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
 test_expect_success 'pulling without refspecs' '
 	(cd local2 &&
 	git reset --hard &&
-	GIT_REMOTE_TESTGIT_REFSPEC="" git pull) &&
+	GIT_REMOTE_TESTGIT_REFSPEC="" git pull 2> ../error) &&
+	grep "This remote helper should implement refspec capability" error &&
 	compare_refs local2 HEAD server HEAD
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index 4d98567..573eaf7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -215,6 +215,8 @@ static struct child_process *get_helper(struct transport *transport)
 			free((char *)refspecs[i]);
 		}
 		free(refspecs);
+	} else if (data->import || data->bidi_import || data->export) {
+		warning("This remote helper should implement refspec capability.");
 	}
 	strbuf_release(&buf);
 	if (debug)
-- 
1.8.2.1.679.g509521a
