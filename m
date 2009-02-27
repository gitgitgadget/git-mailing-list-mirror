From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 19/21] remote: make guess_remote_head() use exact HEAD lookup if it is available
Date: Fri, 27 Feb 2009 14:10:06 -0500
Message-ID: <710d1a0d6059e6dee31732c2762aed7e909daad7.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
 <45e13cde37f6da8e6c379b5deea81b00148b4355.1235759631.git.jaysoffian@gmail.com>
 <9d146489b82f3f8108903dcb9acbe569a4b690a1.1235759631.git.jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 27 20:19:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld8EY-000320-6I
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 20:18:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbZB0TR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 14:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbZB0TR0
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 14:17:26 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:49457 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754646AbZB0TRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 14:17:25 -0500
Received: by qw-out-2122.google.com with SMTP id 5so2095494qwi.37
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :references:mime-version:content-type:content-transfer-encoding;
        bh=OsSNQVQRCeygLhUp74nSAHi+xSGECkXWANYjFEmPr7Y=;
        b=dnWNA6g6tvrz169tjgkFdWkg7T8Iipqllhcm9oJuU0PGcsPyVWzYQ8XluVrnIQjJA3
         hOzV1c1ysVX/FjTJkSUDZeIzFi40DmZH7E/M/hBkC42zk1EpYNWb2+Gly5zDO3FP6Kk8
         AsIXIpdQlzzU/oXPSTFk5jxVDZeNbSVsZZbMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=vVTOoRVqQ2e4it3bHpQyQQUa+Hf+nAUU6VLUxWxhF1uEuK9BBwDsWWPHc3ZiamQSFM
         9Pb4Nn0eLeVpT/RqH8lhLi+eM8UMPfhndbuO1Pf/lOjsutg08xIXfIV1tj8zWs/ZAfX2
         gbhp9Rs/QWId58jukmPjL+3xTvcYtK3R01eOc=
Received: by 10.224.73.212 with SMTP id r20mr4614216qaj.318.1235761817414;
        Fri, 27 Feb 2009 11:10:17 -0800 (PST)
Received: from localhost (cpe-075-182-093-216.nc.res.rr.com [75.182.93.216])
        by mx.google.com with ESMTPS id 6sm1720213qwd.13.2009.02.27.11.10.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Feb 2009 11:10:16 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.309.g5f417
In-Reply-To: <9d146489b82f3f8108903dcb9acbe569a4b690a1.1235759631.git.jaysoffian@gmail.com>
In-Reply-To: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235759631.git.jaysoffian@gmail.com>
References: <cover.1235546707.git.jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111698>

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
This patch replaces 19/21 in the original series
series - http://article.gmane.org/gmane.comp.version-control.git/111394

 remote.c              |    8 ++++++++
 t/t5550-http-fetch.sh |   11 +++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 2123005..9b8522d 100644
--- a/remote.c
+++ b/remote.c
@@ -1476,6 +1476,14 @@ struct ref *guess_remote_head(const struct ref *head,
 	if (!head)
 		return NULL;
 
+	/*
+	 * Some transports support directly peeking at
+	 * where HEAD points; if that is the case, then
+	 * we don't have to guess.
+	 */
+	if (head->symref)
+		return copy_ref(find_ref_by_name(refs, head->symref));
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
1.6.2.rc1.309.g5f417
