From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH v2] blame: prevent a segv when -L given start > EOF
Date: Tue,  9 Feb 2010 12:59:52 -0500
Message-ID: <1265738392-61503-1-git-send-email-jaysoffian@gmail.com>
References: <4B71122F.3040809@viscovery.net>
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuNk-0005r1-IP
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab0BISAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 13:00:10 -0500
Received: from mail-gx0-f224.google.com ([209.85.217.224]:63971 "EHLO
	mail-gx0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab0BISAI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 13:00:08 -0500
Received: by gxk24 with SMTP id 24so2002445gxk.1
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 10:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ASvTLrBqkLM3Ogq6iIn+nWYgcrQf+8pYz8NvadDq2OI=;
        b=qz3/VagOPqzf57VWlE0ApDkQ8gHAz4ofBRLh4goYikIdX38VXPUGMDvbw1VVr3W9d+
         N1lDbUUnLg4/dvFsMTx+QqkqSpLF2TA6RrmibAeSUg9SZedm2zwzxc9pcmbQal46zju7
         ggVDl3eD7478cP99YejibMlUYE3O1YWdQkJGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rQiBC7YvGYWp/bszRvPqm/JY5V4u34eOsdIU38TDu2z27HN4yL2F35IkuC7Zvx9JQm
         llX5Mgv+K1tKeZNg41Mra88/h0qMEO1yLGP/Suhv7okkV17rjWS91q7iPKZMqh1JKJJT
         uQMzRXhbx+HnSlGLywvrG5h3wjOUak4K38Mow=
Received: by 10.91.51.19 with SMTP id d19mr463353agk.101.1265738403513;
        Tue, 09 Feb 2010 10:00:03 -0800 (PST)
Received: from localhost (cpe-065-190-041-119.nc.res.rr.com [65.190.41.119])
        by mx.google.com with ESMTPS id 16sm198244gxk.3.2010.02.09.10.00.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Feb 2010 10:00:02 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc1.200.g9c1f9
In-Reply-To: <4B71122F.3040809@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139426>

blame would segv if given -L <lineno> with <lineno> past the end of the file.
While we're fixing the bug, add test cases for an invalid <start> when called
as -L <start>,<end> or -L<start>.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
Modified the tests per Hannes recommendations.

 builtin-blame.c  |    2 +-
 t/t8003-blame.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 6408ec8..10f7eac 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2433,7 +2433,7 @@ parse_done:
 	if (top < 1)
 		top = lno;
 	bottom--;
-	if (lno < top)
+	if (lno < top || lno < bottom)
 		die("file %s has only %lu lines", path, lno);
 
 	ent = xcalloc(1, sizeof(*ent));
diff --git a/t/t8003-blame.sh b/t/t8003-blame.sh
index ad834f2..be648b2 100755
--- a/t/t8003-blame.sh
+++ b/t/t8003-blame.sh
@@ -157,4 +157,14 @@ EOF
   git --no-pager blame $COMMIT -- uno >/dev/null
 '
 
+test_expect_success 'blame -L with invalid start' '
+	test_must_fail git blame -L5 tres >output 2>&1 &&
+	grep "has only 2 lines" output
+'
+
+test_expect_success 'blame -L with invalid end' '
+	test_must_fail git blame -L1,5 tres >output 2>&1 &&
+	grep "has only 2 lines" output
+'
+
 test_done
-- 
1.7.0.rc1.200.g9c1f9
