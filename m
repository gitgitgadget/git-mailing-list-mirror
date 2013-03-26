From: Jeff King <peff@peff.net>
Subject: [DONOTAPPLY PATCH 1/3] environment: set GIT_WORK_TREE when we figure
 out work tree
Date: Tue, 26 Mar 2013 16:11:40 -0400
Message-ID: <20130326201140.GA22522@sigill.intra.peff.net>
References: <20130326200851.GA22080@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 21:12:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKaE9-0004go-Kr
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 21:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760167Ab3CZULp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 16:11:45 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40629 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754266Ab3CZULp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 16:11:45 -0400
Received: (qmail 7154 invoked by uid 107); 26 Mar 2013 20:13:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Mar 2013 16:13:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Mar 2013 16:11:40 -0400
Content-Disposition: inline
In-Reply-To: <20130326200851.GA22080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219196>

If we end up in a sub-process where GIT_WORK_TREE is not set
but GIT_DIR is, we assume the current directory is the root
of the working tree. Since future patches will change that
assumption, let's defensively start setting GIT_WORK_TREE
explicitly.

Signed-off-by: Jeff King <peff@peff.net>
---
I didn't test this very well (in fact, I only noticed the issue after
having written the other two patches, as without it, those ones break
every external command which wants to run in a working tree). I would
not be surprised if there is some code path which sets GIT_DIR but not
this, or if there is some other weird fallout from having GIT_WORK_TREE
set explicitly.

 environment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/environment.c b/environment.c
index 92c5dff..be2e509 100644
--- a/environment.c
+++ b/environment.c
@@ -194,6 +194,7 @@ void set_git_work_tree(const char *new_work_tree)
 	}
 	git_work_tree_initialized = 1;
 	work_tree = xstrdup(real_path(new_work_tree));
+	setenv(GIT_WORK_TREE_ENVIRONMENT, work_tree, 1);
 }
 
 const char *get_git_work_tree(void)
-- 
1.8.2.13.g0f18d3c
