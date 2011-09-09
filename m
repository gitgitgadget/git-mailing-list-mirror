From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/2] tree-walk: micro-optimization in tree_entry_interesting
Date: Thu,  8 Sep 2011 21:02:46 -0500
Message-ID: <1315533766-25901-2-git-send-email-dpmcgee@gmail.com>
References: <7v62le1vlx.fsf@alter.siamese.dyndns.org>
 <1315533766-25901-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 09 04:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1qQn-0005Z0-Rl
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 04:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab1IICCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 22:02:54 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52341 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932437Ab1IICCx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 22:02:53 -0400
Received: by ywf7 with SMTP id 7so1224717ywf.19
        for <git@vger.kernel.org>; Thu, 08 Sep 2011 19:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UJmNqCVoWWJ5nRSaVaBgU3cY2Zmy7e8dy7/bNOjw0SQ=;
        b=cVqU7wj4o3+W01pPTN/fp8r/gV/IukiZhmkqEqJx3l6rIIpIZpswsNJ33n9dNmH5D0
         imx1ln1FiplkKWWBxuJ/7NdXey8UZe593NUijgS4bNxbrwZfVaJkKDFe8nX6TxUPoQKh
         k1qnyC0hiyZXm/UB78EV79yOh5bRBblKWXk9Y=
Received: by 10.236.80.9 with SMTP id j9mr8730366yhe.94.1315533773394;
        Thu, 08 Sep 2011 19:02:53 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id f63sm5262293yhj.14.2011.09.08.19.02.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Sep 2011 19:02:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.1
In-Reply-To: <1315533766-25901-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181021>

In the case of a wide breadth top-level tree (~2400 entries, all trees
in this case), we can see a noticeable cost in the profiler calling
strncmp() here. Most of the time we are at the base level of the
repository, so base is "" and baselen == 0, which means we will always
test true. Break out this one tiny case so we can short circuit the
strncmp() call.

Test cases are as follows. packages.git is the Arch Linux git-svn clone
of the packages repository which has the characteristics above.

Commands:
[1] packages.git, /usr/bin/time git log >/dev/null
[2] packages.git, /usr/bin/time git log -- autogen/trunk pacman/trunk wget/trunk >/dev/null
[3] linux.git, /usr/bin/time git log >/dev/null
[4] linux.git, /usr/bin/time git log -- drivers/ata drivers/uio tools >/dev/null

Results:
     before  after  %faster
[1]   2.56    2.55   0.4%
[2]  51.82   48.66   6.5%
[3]   5.58    5.61  -0.5%
[4]   1.55    1.51   0.2%

The takeaway here is this doesn't matter in many operations, but it does
for a certain style of repository and operation where it nets a 6.5%
measured improvement. The other changes are likely not significant by
reasonable statistics methods.

Note: the measured improvement when originally submitted was ~11% (43 to
38 secs) for operation [2]. At the time, the repository had 117220
commits; it now has 137537 commits.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index dbcd94a..e401f07 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -591,8 +591,8 @@ int tree_entry_interesting(const struct name_entry *entry,
 					      ps->max_depth);
 		}
 
-		/* Does the base match? */
-		if (!strncmp(base_str, match, baselen)) {
+		/* Either there must be no base, or the base must match. */
+		if (baselen == 0 || !strncmp(base_str, match, baselen)) {
 			if (match_entry(entry, pathlen,
 					match + baselen, matchlen - baselen,
 					&never_interesting))
-- 
1.7.6.1
