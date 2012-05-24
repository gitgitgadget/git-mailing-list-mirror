From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH] progress: don't print if !isatty(2).
Date: Thu, 24 May 2012 01:18:52 -0400
Message-ID: <1337836732-26778-1-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu May 24 07:19:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXQSB-00006o-1k
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 07:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404Ab2EXFTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 01:19:09 -0400
Received: from mail-lb0-f202.google.com ([209.85.217.202]:62499 "EHLO
	mail-lb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320Ab2EXFTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 01:19:08 -0400
Received: by lbbgp10 with SMTP id gp10so459106lbb.1
        for <git@vger.kernel.org>; Wed, 23 May 2012 22:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=soUqNE/fJ/hqavDy+eS+JdLSLL6aU1UIXwKCFizZi40=;
        b=ABQPxmDQQB/4ZGeUOX++n/0NLztXONzh13KQW/McmHSAvmafjL03EjfOP1Q49skBWa
         z8wgQt+mpZdrJLdB/h1YhovIoQhb49pVowZvcGpfIT738Y8C+rv64VKKV3GGGEebrNYM
         fMW/9uHN4e7s+9pAZK8BiidqKLp8E7i3t8Wegl2BB4L48k9EXlGdjT42uTK9rq3CCNCS
         lusGYWtxg6UYxwZNKjOK/9drsRhfbcNMR/TEd3lK5XaPmTmkbnPbKtpyszFepAVwWBFS
         q2osGI4NxjDMKlnkz9U4kO2cevfDtUNzquBKF1uItFfwUIQStEOfaEvOnAy6W/OQsw4a
         5t4w==
Received: by 10.213.113.194 with SMTP id b2mr1596550ebq.10.1337836746824;
        Wed, 23 May 2012 22:19:06 -0700 (PDT)
Received: by 10.213.113.194 with SMTP id b2mr1596545ebq.10.1337836746735;
        Wed, 23 May 2012 22:19:06 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id b16si26623343eeg.3.2012.05.23.22.19.06
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Wed, 23 May 2012 22:19:06 -0700 (PDT)
Received: from emphatic.nyc.corp.google.com (emphatic.nyc.corp.google.com [172.29.18.158])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id 9A620200627;
	Wed, 23 May 2012 22:19:06 -0700 (PDT)
Received: by emphatic.nyc.corp.google.com (Postfix, from userid 133661)
	id DFCDD1C0722; Thu, 24 May 2012 01:19:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.9.dirty
X-Gm-Message-State: ALoCoQnvJlYdIV8gq8ZtWaUNrsEeBc8eNFJkwClRQgQOJ8IOfzTnO+PksErdPTeMRIcvU5tJv83fxR19dCa/s7fJOrHRN4aCannPzDq9o12VbtxT8SUnTIyrBQVMBFga1O04mtRjlfAFi3UEOm9F6av2Uv5ACdNLAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198352>

If stderr isn't a tty, we shouldn't be printing incremental progress
messages.  In particular, this affected 'git checkout -f . >&logfile' unless
you provided -q.  And git-new-workdir has no way to provide -q.

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 progress.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 3971f49..4d9f416 100644
--- a/progress.c
+++ b/progress.c
@@ -211,9 +211,11 @@ int display_progress(struct progress *progress, unsigned n)
 struct progress *start_progress_delay(const char *title, unsigned total,
 				       unsigned percent_treshold, unsigned delay)
 {
-	struct progress *progress = malloc(sizeof(*progress));
+	struct progress *progress = NULL;
+	if (isatty(2))
+		progress = malloc(sizeof(*progress));
 	if (!progress) {
-		/* unlikely, but here's a good fallback */
+		/* use a simple fallback */
 		fprintf(stderr, "%s...\n", title);
 		fflush(stderr);
 		return NULL;
-- 
1.7.9.dirty
