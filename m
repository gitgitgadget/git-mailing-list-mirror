From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH 15/19] transport-helper: update ref status after push with export
Date: Wed,  8 Jun 2011 20:48:46 +0200
Message-ID: <1307558930-16074-16-git-send-email-srabbelier@gmail.com>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>, "Jeff King" <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:51:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUNqV-0000Sp-5R
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753290Ab1FHSuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 14:50:46 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63939 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1FHStv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 14:49:51 -0400
Received: by eyx24 with SMTP id 24so279816eyx.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=d0i1/gqWNDVNQSzPIgaGuYRdMn8brbmkQkgJdLA/v3Y=;
        b=M1ASs/tG0BOFoFXv8OQPgwYLJJb3WnHWjdlTmg3l5Vs1urAe1dtzMpC8vSGi0nR9jf
         keq0npvo2Tky5KSQKtQGdZ8u6iKhnPEcgy1i5o8dLyZ9+jVxy3e4srxOg4+K5AfiyKGf
         AxmUouII4js1rP/ntU718JfYw9X38KTRY+KwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qFrdaESMJk5VEqEr50BXtuMvUggVLpIjlBoH+plO48Qq+15BYgSqO5ZtWwFslG3jcC
         DBazjuSmtO3YJiSaqJvTZubJJIQ445YHssTHyzvsphZMesJg1EM5/yeZ0AHeTqxtm+5z
         9ss5jOdZZZkWAM3Ehj5iC/y8rQrZAQLND3RcI=
Received: by 10.213.14.209 with SMTP id h17mr427960eba.23.1307558989618;
        Wed, 08 Jun 2011 11:49:49 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id b1sm729674eeg.19.2011.06.08.11.49.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 11:49:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175439>


Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

 Obviously the testgit helper shouldn't just print 'ok' for master,
 but it demonstrates the idea.

 Jonathan added for those who wondered what it should do:

       When the push is complete, outputs one or more ok <dst> or
       error <dst> <why>?  lines to indicate success or failure of
       each pushed ref. The status report output is terminated by a
       blank line. The option field <why> may be quoted in a C style
       string if it contains an LF.

  So testgit should be getting this information from the
  result of non_local.push(). Another example is if a ref is a
  non-fast-forward, it should probably detect that before even
  exporting it, and report that here.

 git-remote-testgit.py |    3 +++
 transport-helper.c    |    1 +
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-remote-testgit.py b/git-remote-testgit.py
index a8e47d9..47a30da 100644
--- a/git-remote-testgit.py
+++ b/git-remote-testgit.py
@@ -153,6 +153,9 @@ def do_export(repo, args):
     if not repo.local:
         repo.non_local.push(repo.gitdir)
 
+    print "ok refs/heads/master"
+    print
+
 
 def do_gitdir(repo, args):
     """Stores the location of the gitdir.
diff --git a/transport-helper.c b/transport-helper.c
index b0361c2..bb1b97f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -760,6 +760,7 @@ static int push_refs_with_export(struct transport *transport,
 	data->no_disconnect_req = 1;
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
+	push_update_refs_status(data, remote_refs);
 	return 0;
 }
 
-- 
1.7.5.1.292.g728120
