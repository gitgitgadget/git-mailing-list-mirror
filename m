From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] push: don't push the volatile HEAD with current
Date: Tue, 21 May 2013 23:53:20 +0530
Message-ID: <1369160600-22337-4-git-send-email-artagnon@gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 21 20:25:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UerFR-0008Qz-4h
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 20:25:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538Ab3EUSZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 14:25:13 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36327 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab3EUSZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 14:25:09 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so892972pbb.36
        for <git@vger.kernel.org>; Tue, 21 May 2013 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=29j/4M/UrZ/J+A6n+uInJs45lGQkHrWYbDthKtvoAqo=;
        b=IsIYmeWX/WPsFmadnccOHvgSBp4AeG5b9Wx12clBSxK9ZR+I63NhEMujPr3W0ugidL
         keiKiYkt7MFPdpiV3RsUbau8whydauwXF4ldSuGFLiPAixFxeUeiT4y/kfBjfwHzghWY
         RRFHLZ35gewz5r7/Cwh3Ytbqgt4Kfz30LrQXpLqTzADKIpqu2SX7iTlHvCdYwOY1PCG8
         Z0MTL5CFyjRChi3vgsgds7+A1qQ0C/JMTkEzFwke+N7pIrZ5uQs/VsAB4JbkbJ0yLZN2
         nRj+8Zxso20hOTHRGgbn26kznd4+3guw6Qkaj7vKR5iIhkZHUJ1Y5IZdqPJdE4dO+Kr7
         XZwA==
X-Received: by 10.66.248.228 with SMTP id yp4mr4484912pac.158.1369160708770;
        Tue, 21 May 2013 11:25:08 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.100])
        by mx.google.com with ESMTPSA id l4sm3680889pbo.6.2013.05.21.11.25.06
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 May 2013 11:25:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.7.gc1ff30b
In-Reply-To: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225063>

Since a push does not lock the "HEAD" ref, there is no guarantee that it
will remain the same for the entire operation of the push.  Practically,
this means that with push.default set to current:

  # on branch push-current-head
  $ git push
  # on another terminal
  $ git checkout master
  # return to the first terminal
  # the push tried to push master!

Avoid this confusion by adding the branch that HEAD resolves to as the
refspec to push (as opposed to the literal "HEAD").  With this change,
the output of the push changes subtly from:

  $ git push
  ...
   * [new branch]      HEAD -> push-current-head

to:

  $ git push
  ...
   * [new branch]      push-current-head -> push-current-head

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/push.c b/builtin/push.c
index a79038c..d819487 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -198,7 +198,7 @@ static void setup_default_push_refspecs(struct remote *remote)
 	case PUSH_DEFAULT_CURRENT:
 		if (!branch)
 			die(_(message_detached_head_die), remote->name);
-		add_refspec("HEAD");
+		add_refspec(branch->name);
 		break;
 
 	case PUSH_DEFAULT_NOTHING:
-- 
1.8.3.rc3.7.gc1ff30b
