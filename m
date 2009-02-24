From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 23/23] remote: use exact HEAD lookup if it is available
Date: Tue, 24 Feb 2009 04:51:11 -0500
Message-ID: <c87a95887e5de0258fa4d32f3aac195768b39949.1235467368.git.jaysoffian@gmail.com>
References: <cover.1235467368.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 10:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbu06-0002Ej-Ac
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 10:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756164AbZBXJwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 04:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbZBXJwP
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 04:52:15 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:29393 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111AbZBXJwO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 04:52:14 -0500
Received: by an-out-0708.google.com with SMTP id c2so1048556anc.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2009 01:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=NkNeoxZFzaXuDjYQBkSWWxnKmFLoBbI+Ghhy/6qRFQs=;
        b=LW+sTU46q35igYUc/IaE6uIzFcnlzt5ohOKXyvW46zyqzMkH9fBKhwmSO1TlPMUEuh
         SySw3XXv8nBPgGjfTrqmL3Gq/lau0lJPZqCg0vFWjMqXZSnuMrM+fRmLiOtdlh3SUP6U
         xikH1ucQcSJNza2sQY4v9YuLaElmYtHGeVoM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PMUXoBcIXQyiNAaoLnpSd1EBplm2lofTN8GrZr8wyEs9HIwKJtCcsMrYiAYrsNGR94
         EhGx+wFnouQMmktjHO5tvIFDRXFLzNeu8HkH2mxJSKsF0mzJjtBMMn/on9KQheySa6NJ
         rer823+3pBc/y+hLylOmOVQsw+MCIOwbgHQbw=
Received: by 10.100.32.6 with SMTP id f6mr5459734anf.87.1235469132647;
        Tue, 24 Feb 2009 01:52:12 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id d35sm2235468and.58.2009.02.24.01.52.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Feb 2009 01:52:12 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.291.g83eb
In-Reply-To: <cover.1235467368.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111261>

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
index 96d5c95..682af74 100644
--- a/remote.c
+++ b/remote.c
@@ -1449,6 +1449,16 @@ struct ref *guess_remote_head(const struct ref *head,
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
 		const struct ref *m;
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
