From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] push: make push.default = current use resolved HEAD
Date: Thu, 30 May 2013 00:51:51 +0530
Message-ID: <1369855311-23367-4-git-send-email-artagnon@gmail.com>
References: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 29 21:23:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhlyF-0002LA-Qp
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 21:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966292Ab3E2TXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 15:23:30 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57885 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966275Ab3E2TX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 15:23:26 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so8072159pde.18
        for <git@vger.kernel.org>; Wed, 29 May 2013 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=5AtnGQePGfVt6uV8Qf23flNk2fJhCIMSGQKXf0Cy9ZQ=;
        b=J3lC/Gda7bYCAPFotBQ3QvycHW4DuB6LTq6eAUgoW5Qnss1zVxOQyOOunM6+35+aJ5
         UaFTCD6T3GIdEoJgSD8a08yxIntL51JxYlTjQ+b7Tpa8kkwHMGL5dMNWlJGGYi0kYY1+
         Z/k29HnsAp4kiKdt75awMKJJS5XlaxdIsVdnljXGozsvGYxEhfQHaMaFPNRQ4mruenS3
         VL1RNaKOl3MznEIe1aVaZO7XHpa0hCS1ItosvL2xZdrmavQuv/UYxAwkC714sO737GZg
         wdeZzgptBoTIlsyMlF37KE7H9jfY6e7sfUzAQWb1QTBVz63Xmg5SwFZBxJIYq8sn3/uz
         WfJQ==
X-Received: by 10.68.194.202 with SMTP id hy10mr4353355pbc.44.1369855405779;
        Wed, 29 May 2013 12:23:25 -0700 (PDT)
Received: from localhost.localdomain ([122.164.41.150])
        by mx.google.com with ESMTPSA id xu10sm41059620pab.3.2013.05.29.12.23.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 May 2013 12:23:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.12.gbd56588
In-Reply-To: <1369855311-23367-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225871>

With this change, the output of the push (with push.default set to
current) changes subtly from:

  $ git push
  ...
   * [new branch]      HEAD -> push-current-head

to:

  $ git push
  ...
   * [new branch]      push-current-head -> push-current-head

This patch was written with a different motivation. There is a problem
unique to push.default = current:

  # on branch push-current-head
  $ git push
  # on another terminal
  $ git checkout master
  # return to the first terminal
  # the push tried to push master!

This happens because the 'git checkout' on the second terminal races
with the 'git push' on the first terminal.  Although this patch does not
solve the core problem (there is still no guarantee that 'git push' on
the first terminal will resolve HEAD before 'git checkout' changes HEAD
on the second), it works in practice.

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
1.8.3.12.gbd56588
