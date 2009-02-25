From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 19/21] remote: make guess_remote_head() use exact HEAD lookup if it is available
Date: Wed, 25 Feb 2009 03:32:26 -0500
Message-ID: <19a72f943581d6e91ccc260ca933b95dba4f0473.1235546708.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 25 09:36:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcFFC-0000Xo-TO
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 09:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760101AbZBYIdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 03:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759905AbZBYId3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 03:33:29 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:35129 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760015AbZBYIdQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 03:33:16 -0500
Received: by gxk22 with SMTP id 22so8310869gxk.13
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=b80BN8qcWpY4WELFLjO6YZpKRXvLKNSm7jlUqQAPckI=;
        b=YSQ3+pIa6l8oGI3BHIY5j0yL3SBRylLvAMbXc3FRwWzWfcmJ0JkP5aSaGfO5Fj7jsR
         hk3Op/WTEJqiZ5PFfUy93byE/US6Ki0RiiknDmcnMW09Ybt7QWu3WVQT+HMF2U+QUE/3
         YTP21xR3Ptq6Yu4YQVqoXPJDZkA/NQAh2LNSw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KySytmfEoQO3uKiGfQi27rHq1mPIerGiuaYJDjT9t4I5Y+PpcpoHv+DB58yEUcTH3J
         TMH9AT9GuXD8nHsDvzfimf7YS3bsNT05IZNj1hqArM20CPG05662/IrU5hyHZnCiZ4n6
         JgLyhPEeGzYIibVg1RokP2ChgzLtOwk7z7yOw=
Received: by 10.100.133.2 with SMTP id g2mr898946and.134.1235550794502;
        Wed, 25 Feb 2009 00:33:14 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id b37sm3997930ana.57.2009.02.25.00.33.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Feb 2009 00:33:13 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111413>

From: Jeff King <peff@peff.net>

Our usual method for determining the ref pointed to by HEAD
is to compare HEAD's sha1 to the sha1 of all refs, trying to
find a unique match.

However, some transports actually get to look at HEAD
directly; we should make use of that information when it is
available.  Currently, only http remotes support this
feature.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 remote.c              |   10 ++++++++++
 t/t5550-http-fetch.sh |   11 +++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 926f842..1c09cf0 100644
--- a/remote.c
+++ b/remote.c
@@ -1475,6 +1475,16 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (!head)
 		return NULL;
 
+	/*
+	 * Some transports support directly peeking at
+	 * where HEAD points; if that is the case, then
+	 * we don't have to guess.
+	 */
+	if (head->symref) {
+		r = find_ref_by_name(refs, head->symref);
+		return r ? copy_ref_with_peer(r) : NULL;
+	}
+
 	/* If refs/heads/master could be right, it is. */
 	if (!all) {
 		r = find_ref_by_name(refs, "refs/heads/master");
diff --git a/t/t5550-http-fetch.sh b/t/t5550-http-fetch.sh
index b6e6ec9..05b1b62 100755
--- a/t/t5550-http-fetch.sh
+++ b/t/t5550-http-fetch.sh
@@ -42,5 +42,16 @@ test_expect_success 'fetch changes via http' '
 	test_cmp file clone/file
 '
 
+test_expect_success 'http remote detects correct HEAD' '
+	git push public master:other &&
+	(cd clone &&
+	 git remote set-head origin -d &&
+	 git remote set-head origin -a &&
+	 git symbolic-ref refs/remotes/origin/HEAD > output &&
+	 echo refs/remotes/origin/master > expect &&
+	 test_cmp expect output
+	)
+'
+
 stop_httpd
 test_done
-- 
1.6.2.rc1.291.g83eb
