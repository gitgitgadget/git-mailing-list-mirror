From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v3 1/6] t5541-http-push.sh: add tests for non-fast-forward
 pushes
Date: Thu, 24 Dec 2009 15:40:57 +0800
Message-ID: <20091224154057.33611ae7.rctay89@gmail.com>
References: <20091224154005.a642c8ec.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Daniel Barkalow" <barkalow@iabervon.org>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 24 08:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNiPu-0008Tz-BX
	for gcvg-git-2@lo.gmane.org; Thu, 24 Dec 2009 08:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756924AbZLXHrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Dec 2009 02:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756911AbZLXHrV
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Dec 2009 02:47:21 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:37369 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756885AbZLXHrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Dec 2009 02:47:21 -0500
Received: by ywh6 with SMTP id 6so8161348ywh.4
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 23:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=yR7JRXG0t1/IsmskU6nIW/kvKPiQC+hAz3jvll5sYFo=;
        b=GKsG2UrACwKxiTx+LguGAnZyivbVj9mIxA3ncq37g1/44mLDrk8fimSf3p6rE8Tg8h
         wVJi+lzggmlh/cB2eDliIIqVCcrILhmQqDT3VL8exAAXju72F9hYVeEfAiBuev4KLYO6
         ZarOi8J44jATjTCW4CtfkToky+FmbqvXj3PMA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=K8YQq9XB9bhEFoXIYqGJhnFURFP8TLLw2+pZG31Cp2pi1FcfvSesdkHtulTkJDDQdC
         hf4aGIDSVss+D/FDjWvX3h70eRPNghxB0FQDhvosLekhAqF7gFOemckPdA1qozg8CXpa
         75ERvRg+Y/j/TJXWmxqUelMY8Mkr0c7h2ebvk=
Received: by 10.90.17.6 with SMTP id 6mr298404agq.7.1261640464640;
        Wed, 23 Dec 2009 23:41:04 -0800 (PST)
Received: from your-cukc5e3z5n (cm133.zeta152.maxonline.com.sg [116.87.152.133])
        by mx.google.com with ESMTPS id 13sm4110479gxk.1.2009.12.23.23.41.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 23:41:04 -0800 (PST)
In-Reply-To: <20091224154005.a642c8ec.rctay89@gmail.com>
X-Mailer: Sylpheed 2.6.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135650>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5541-http-push.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t5541-http-push.sh b/t/t5541-http-push.sh
index 2a58d0c..f49c7c4 100755
--- a/t/t5541-http-push.sh
+++ b/t/t5541-http-push.sh
@@ -88,5 +88,28 @@ test_expect_success 'used receive-pack service' '
 	test_cmp exp act
 '

+test_expect_success 'non-fast-forward push fails' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout master &&
+	echo "changed" > path2 &&
+	git commit -a -m path2 --amend &&
+
+	HEAD=$(git rev-parse --verify HEAD) &&
+	!(git push -v origin >output 2>&1) &&
+	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
+	 test $HEAD != $(git rev-parse --verify HEAD))
+'
+
+test_expect_failure 'non-fast-forward push show ref status' '
+	grep "^ ! \[rejected\][ ]*master -> master (non-fast-forward)$" output
+'
+
+test_expect_failure 'non-fast-forward push shows help message' '
+	grep \
+"To prevent you from losing history, non-fast-forward updates were rejected
+Merge the remote changes before pushing again.  See the '"'non-fast-forward'"'
+section of '"'git push --help'"' for details." output
+'
+
 stop_httpd
 test_done
--
1.6.6.rc1.249.g048b3
