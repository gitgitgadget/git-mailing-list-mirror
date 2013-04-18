From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/6] transport-helper: warn when refspec is not used
Date: Wed, 17 Apr 2013 23:14:31 -0500
Message-ID: <1366258473-12841-5-git-send-email-felipe.contreras@gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGT-0002Bm-FF
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:16:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462Ab3DREP6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:15:58 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:49711 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab3DREP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:15:57 -0400
Received: by mail-yh0-f44.google.com with SMTP id m1so396269yhg.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=0m9QuZKLt0LnWx7I4i8u5cFE6ar3hr0hXs9ulnWX1/I=;
        b=ONOHfiQ9nhIXqVoV66OqIxs6OJ+6Xbx2O0njbgxGC+9TZlKryvaGB1rKLlgGDVNJE/
         kz+UqUJwSnE4SLfvqVUJcNNlTMMEbM1ZUJpU9as+Yq+MUaNeXTwOu3pS+KCkhgiKy0MR
         tMrTd7wpauxEJ3h/j4+Xt0wlrn1qEcy0bf3va/Sbgs7D8F1FxaeYgEOqIX0qak/HH5L2
         0N3EI4W3Sv6LQAatgfj8McaSlKK3gmd+hIZ0OzdhlQ1n4IDIJXqnPXVbduV5RQPGStUN
         WVqjZ3g0ERDdrruy54vRxbspnIR2qnXlllqcJOIKgBEKE7Je89PBJknZXk4x3ctI3FIH
         yyxg==
X-Received: by 10.236.197.196 with SMTP id t44mr6388579yhn.73.1366258556849;
        Wed, 17 Apr 2013 21:15:56 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id c67sm14540369yhh.16.2013.04.17.21.15.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:15:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221606>

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
