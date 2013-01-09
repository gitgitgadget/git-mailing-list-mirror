From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: [PATCH 11/19] reset: avoid redundant error message
Date: Wed,  9 Jan 2013 00:16:08 -0800
Message-ID: <1357719376-16406-12-git-send-email-martinvonz@gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 09 09:25:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsqyR-0003Bu-RT
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432Ab3AIIZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:25:00 -0500
Received: from mail-la0-f74.google.com ([209.85.215.74]:60251 "EHLO
	mail-la0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab3AIIY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:24:59 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Jan 2013 03:24:59 EST
Received: by mail-la0-f74.google.com with SMTP id ej20so93746lab.5
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references:x-gm-message-state;
        bh=qe2toSGVe7GNN7T6X9nTsnjPxrpjrMga55ABTtxPb0M=;
        b=TFg7LanhSYgJ4jyAFbcr4wjMfk242oJVLYc6avCDnLPUFKroB2dJWRBx1E0wt2b7nw
         XK5uGJzVCzGSnH6Yn6XbXpnRY9iIhJLpzRimgG/CszgykGCytKN1SEFm7F/t5gCu5jZF
         SsQUzCjENkRk0V6tr5+tCRcw39nzjm0bwdPqUUDYWa2VUrxfZeZwuSNNqPDa+YlJdAMJ
         XSJKr0V8gKLosEbLa42xZ9XZ7G0i5E+0InMvhBefej7ZqM2L4wkuMdWZwzynh+jEAww3
         nod6EI7ZuWMwIBNddqE6CwiyfnNsJq9/UTzF73J2MV6NUdBPs4mcz4XX5wGh+1ZCa8b2
         YT9Q==
X-Received: by 10.14.0.196 with SMTP id 44mr83784607eeb.6.1357719425521;
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id z44si25287752een.0.2013.01.09.00.17.05
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 09 Jan 2013 00:17:05 -0800 (PST)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.144.137])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 1493D200061;
	Wed,  9 Jan 2013 00:17:05 -0800 (PST)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 49457102FD3; Wed,  9 Jan 2013 00:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.331.g1ef2165
In-Reply-To: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
X-Gm-Message-State: ALoCoQm+puf9V0eWOJQ5jfdS5kqvCeHqjQKS/BkhOtFDEzgCjm7ZByOBlNna52PM8EMtqTWgy+HQUCmOEU6B++0cKMW7K1VQAqUA6aQhq2fvONkq+EVnXhoMYvx12cXFYK2BHnk7lvirG1M0EGCKM5d3BXOHJJ42mC2w/5ktAsSgaeeL92R9t1oaP2EbwWfsIdVSTKiwXDA/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213048>

If writing or committing the new index file fails, we print "Could not
write new index file." followed by "Could not reset index file to
revision $rev.". The first message seems to imply the second, so print
only the first message.
---
 builtin/reset.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 8e5d097..54e3c5b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -337,13 +337,11 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		int err = reset_index(sha1, reset_type, quiet);
 		if (reset_type == KEEP && !err)
 			err = reset_index(sha1, MIXED, quiet);
-		if (!err &&
-		    (write_cache(newfd, active_cache, active_nr) ||
-		     commit_locked_index(lock))) {
-			err = error(_("Could not write new index file."));
-		}
 		if (err)
 			die(_("Could not reset index file to revision '%s'."), rev);
+		if (write_cache(newfd, active_cache, active_nr) ||
+		    commit_locked_index(lock))
+			die(_("Could not write new index file."));
 	}
 
 	/* Any resets update HEAD to the head being switched to,
-- 
1.8.1.rc3.331.g1ef2165
