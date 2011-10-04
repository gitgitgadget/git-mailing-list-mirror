From: Phil Hord <phil.hord@gmail.com>
Subject: [PATCH 2/4] Learn to handle gitfiles in enter_repo
Date: Tue, 4 Oct 2011 16:05:17 -0400
Message-ID: <CABURp0r7o8Mq4RyjEac18syU3HwCXWm7FOe+Mu0PshVXddJwuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 22:05:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBBFH-0006Fq-BU
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 22:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933580Ab1JDUFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 16:05:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60470 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933403Ab1JDUFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 16:05:38 -0400
Received: by wwf22 with SMTP id 22so1377990wwf.1
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=qqu4OapXU9sUOeyzuh60q7fhm1ahHUGPjuOKiN/NcoM=;
        b=FnxSbf02ECtQxz7N4F5KjfSp2Qm10h3G0GM141dt6GsAB92X0ifgCzi9Qc6uP7VDGw
         pjCfmvShL4+UbetWVYEUKbnVNui0g/RixcxeP+KROElFS6XG8xpO80zt7wViiSppW1Ek
         oUqdMYVmrm6FND1atcCY59vqNv1ZeIcnevM1M=
Received: by 10.216.190.131 with SMTP id e3mr2054625wen.48.1317758737111; Tue,
 04 Oct 2011 13:05:37 -0700 (PDT)
Received: by 10.216.88.72 with HTTP; Tue, 4 Oct 2011 13:05:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182792>

The enter_repo() function is used to navigate into a .git
directory.  It knows how to find standard alternatives (DWIM) but
it doesn't handle gitfiles created by git init --separate-git-dir.
This means that git-fetch and others do not work with repositories
using the separate-git-dir mechanism.

Teach enter_repo() to deal with the gitfile mechanism by resolving
the path to the redirected path and continuing tests on that path
instead of the found file.

Signed-off-by: Phil Hord <hordp@cisco.com>
---

This change allows enter_repo to work with gitfiles, but another change
is required to teach transport.c to recognize gitfiles as git-dirs.

diff --git a/path.c b/path.c
index 01028f2..b6f71d1 100644
--- a/path.c
+++ b/path.c
@@ -295,6 +295,7 @@ const char *enter_repo(const char *path, int strict)
 		static const char *suffix[] = {
 			".git/.git", "/.git", ".git", "", NULL,
 		};
+		const char *gitfile;
 		int len = strlen(path);
 		int i;
 		while ((1 < len) && (path[len-1] == '/'))
@@ -329,7 +330,12 @@ const char *enter_repo(const char *path, int strict)
 				break;
 			}
 		}
-		if (!suffix[i] || chdir(used_path))
+		if (!suffix[i])
+			return NULL;
+		gitfile = read_gitfile(used_path) ;
+		if (gitfile)
+			strcpy(used_path, gitfile);
+		if (chdir(used_path))
 			return NULL;
 		path = validated_path;
 	}
-- 
1.7.7.503.g26392.dirty
