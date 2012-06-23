From: Leila Muhtasib <muhtasib@gmail.com>
Subject: [PATCH/RFC] revision: Show friendlier message.
Date: Sat, 23 Jun 2012 15:11:21 -0400
Message-ID: <1340478681-58476-1-git-send-email-muhtasib@gmail.com>
Cc: Leila Muhtasib <muhtasib@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 23 21:12:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiVka-0002fC-Eq
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 21:12:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab2FWTL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jun 2012 15:11:58 -0400
Received: from mail-qc0-f170.google.com ([209.85.216.170]:64271 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab2FWTLY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jun 2012 15:11:24 -0400
Received: by qcmt36 with SMTP id t36so2180977qcm.1
        for <git@vger.kernel.org>; Sat, 23 Jun 2012 12:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=x9rleFKgD/TAkbn38hRkMdyVT8C5AYbsFug9vknEqEo=;
        b=ZcnBkH5qaDW4VcS16YQ7XI52FjyYR1nwDGQGf9RlMF6XjaMM6CbnYp23u9a/psNV1Y
         qA50iKdFfqgFRAiiroHcJPWUP6v4BTSu9pPQnKLXA71xBer+FhoMLSohwiTXh6kJ/3UF
         n7DnrAow0DqttHtvlFYm54QlUZdafVdcJICwolnvELC2vbTYwHm4AH2UuK5Q1h1SoZ4y
         lTOXHIp3LCUkNxglPuG+ceoM7WI/cCFiCYrQEQx6pChexvcBgjnelpkQ9G2ffZqV8GTM
         rISETgDMW/bzMMb7xBAtk8TKOrvOds6seG+zzraDlPsLF2rS8ntMYCXEl69xoWOmM/0S
         c5PQ==
Received: by 10.229.105.158 with SMTP id t30mr3175329qco.16.1340478683469;
        Sat, 23 Jun 2012 12:11:23 -0700 (PDT)
Received: from localhost ([38.117.156.148])
        by mx.google.com with ESMTPS id ej2sm4839844qab.7.2012.06.23.12.11.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 23 Jun 2012 12:11:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.5 (Apple Git-26)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200504>

'git log' on a newly initialized repository
(before any commits) shows an ugly message.

Signed-off-by: Leila Muhtasib <muhtasib@gmail.com>
---
I found this bug on the debian git bug list.
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=412890

See scenario below:

% mkdir test
% cd test
% git init
Initialized empty Git repository in .git/
% git log
fatal: bad default revision 'HEAD'

I've reworded the error message to something friendlier.
I can change the message or add something like the link
suggests about 'Create or switch to an existent branch."
But I don't feel like that message quite captures the
scenario of initializing a new repository. Alternatively,
we can print the message using printf and exit successfully
instead of using 'die'.

Thanks,
Leila

 revision.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 935e7a7..96add37 100644
--- a/revision.c
+++ b/revision.c
@@ -1821,8 +1821,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(revs->def, sha1, &mode))
-			die("bad default revision '%s'", revs->def);
+		if (get_sha1_with_mode(revs->def, sha1, &mode)) {
+			if (!strcmp(argv[0], "log") && !strcmp(revs->def, "HEAD"))
+				die("No commits to display.");
+			else
+				die("bad default revision '%s'", revs->def);
+		}
 		object = get_reference(revs, revs->def, sha1, 0);
 		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
-- 
1.7.7.5 (Apple Git-26)
