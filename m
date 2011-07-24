From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 4/5] fast-export: do not export negative refs
Date: Sun, 24 Jul 2011 16:21:21 +0200
Message-ID: <1311517282-24831-5-git-send-email-srabbelier@gmail.com>
References: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jul 24 16:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkzZo-0006Dd-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jul 2011 16:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab1GXOWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jul 2011 10:22:32 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55718 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839Ab1GXOWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2011 10:22:25 -0400
Received: by mail-ww0-f44.google.com with SMTP id 5so3380781wwe.1
        for <git@vger.kernel.org>; Sun, 24 Jul 2011 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=MX1L43B5vdcEnVT7DMVy7hB95vRVmCrN7KChOSW9pUk=;
        b=kZAjPkQd/hQPqMh+ArRaHrZc1325EHurqp/8DUi2h0jx8CcmK48KYFfcNH1Vutg8Gz
         a9A1MpiNwox7JO9CmZKbBeEUapk9jaDq2VQGhVOpDeiYqLole6ioUB15BJEif5eRqvXL
         ljfUfR/OKX/uxIbtjoLTiY/mAy03L5N3oT+Bk=
Received: by 10.216.163.203 with SMTP id a53mr3515419wel.8.1311517344794;
        Sun, 24 Jul 2011 07:22:24 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id fc2sm3526819wbb.35.2011.07.24.07.22.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Jul 2011 07:22:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.385.g91185.dirty
In-Reply-To: <1311517282-24831-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177753>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

When calling `git fast-export master..next` we want to export
refs/heads/next, but not refs/heads/master.

Currently this is not a problem, because negative refs' commits
are never shown. In the next commit this will be changed in order
to make sure that 'master..master' does export master. I.e. even
refs whose commits are not shown are exported.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  We noticed this while trying to come up with a test case for the
  bug we found.

 builtin/fast-export.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 92743c8..628eab0 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -467,7 +467,7 @@ static void get_tags_and_duplicates(struct object_array *pending,
 		struct commit *commit = commit;
 		char *full_name;
 
-		if (dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
+		if ((e->flags & UNINTERESTING) || dwim_ref(e->name, strlen(e->name), sha1, &full_name) != 1)
 			continue;
 
 		switch (e->item->type) {
-- 
1.7.6.385.g91185.dirty
