From: Chris Wilson <cwilson@vigilantsw.com>
Subject: [PATCH] Fix config_file file leak.
Date: Thu, 14 Jul 2011 14:19:48 -0400
Message-ID: <20110714181948.GA23288@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 20:20:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhQVz-0000Ja-A1
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 20:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1GNSTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 14:19:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47294 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400Ab1GNSTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 14:19:52 -0400
Received: by iwn6 with SMTP id 6so443875iwn.19
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 11:19:52 -0700 (PDT)
Received: by 10.231.193.137 with SMTP id du9mr2347198ibb.136.1310667591856;
        Thu, 14 Jul 2011 11:19:51 -0700 (PDT)
Received: from localhost (c-67-180-177-185.hsd1.ca.comcast.net [67.180.177.185])
        by mx.google.com with ESMTPS id y3sm296691ibc.20.2011.07.14.11.19.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 14 Jul 2011 11:19:51 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177145>

Hi,

We are using Sentry (a C/C++ static analysis tool) to analyze
git on a nightly basis. Sentry found that a file leak
was recently introduced in the commit 924aaf3.

I'm hoping the attached patch correctly fixes up this leak.

Thanks,
Chris

-- 
Chris Wilson
http://vigilantsw.com/
Vigilant Software, A C/C++ Static Analysis Company

---
 config.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index 1fc063b..bf61f09 100644
--- a/config.c
+++ b/config.c
@@ -1434,7 +1434,7 @@ int git_config_rename_section(const char *old_name, const char *new
        struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
        int out_fd;
        char buf[1024];
-       FILE *config_file;
+       FILE *config_file = 0;

        if (config_exclusive_filename)
                config_filename = xstrdup(config_exclusive_filename);
@@ -1498,12 +1498,13 @@ int git_config_rename_section(const char *old_name, const char *n
                        goto out;
                }
        }
-       fclose(config_file);
  unlock_and_out:
        if (commit_lock_file(lock) < 0)
                ret = error("could not commit config file %s", config_filename);
  out: 
        free(config_filename);
+        if (config_file)
+               fclose(config_file);
        return ret;
 }

-- 
1.7.0.4
