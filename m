From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] remote-hg: add tests for special filenames
Date: Sat,  7 Dec 2013 07:09:43 -0600
Message-ID: <1386421783-27781-5-git-send-email-felipe.contreras@gmail.com>
References: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 07 14:17:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpHl9-0003G3-TX
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 14:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757403Ab3LGNRZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Dec 2013 08:17:25 -0500
Received: from mail-oa0-f48.google.com ([209.85.219.48]:43424 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab3LGNRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 08:17:22 -0500
Received: by mail-oa0-f48.google.com with SMTP id l6so2041629oag.7
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 05:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=KFG4L+mG8qQ/KxlMc9yvTKEg8PuVCHL5DFBsBBS50NM=;
        b=QK5127g97ajIBS1EXMdcbCo+PNtiAOp5tnuFcmuHdU5Rg1Wm7tox104O17Pu8rnAUA
         pPKg/uyUR3Ys7SOrF3yauykPwX6oFQL2zD9XIoBe9EsNZFDlc/1/B3PXwfK03z6rgJCN
         YzznJA14oG0LJuFJ+MkQZCThRPuqu8BY+tq2yFnXcODgchyQcJGH/aSBE++DxyOTOWPS
         DLBKeOEcvQRNfvnSqZQCZ9QdGS5+RPbeBrdSvZiYsr0WOz9aEsWvbtMG4tx9s27GZKlR
         ytnhi5Zf6DnH/s/vLoxlCplBi5v/FLiQdGSvSy05wT/qBaJ6XGCDbHJRSyoaMalCTlAS
         CcdA==
X-Received: by 10.182.143.103 with SMTP id sd7mr232744obb.70.1386422241933;
        Sat, 07 Dec 2013 05:17:21 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id jz7sm5241175oeb.4.2013.12.07.05.17.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2013 05:17:21 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1386421783-27781-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238983>

So that we check that UTF-8 and spaces work fine.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg.sh | 68 +++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 68 insertions(+)

diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers=
/test-hg.sh
index 72f745d..56840ff 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -442,6 +442,74 @@ test_expect_success 'remote new bookmark multiple =
branch head' '
 # cleanup previous stuff
 rm -rf hgrepo
=20
+test_expect_success 'fetch special filenames' '
+	test_when_finished "rm -rf hgrepo gitrepo && LC_ALL=3DC" &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo test >> "=C3=A6 r=C3=B8" &&
+	hg add "=C3=A6 r=C3=B8" &&
+	echo test >> "=C3=B8~?" &&
+	hg add "=C3=B8~?" &&
+	hg commit -m add-utf-8 &&
+	echo test >> "=C3=A6 r=C3=B8" &&
+	hg commit -m test-utf-8 &&
+	hg rm "=C3=B8~?" &&
+	hg mv "=C3=A6 r=C3=B8" "=C3=B8~?" &&
+	hg commit -m hg-mv-utf-8
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+	git -c core.quotepath=3Dfalse ls-files > ../actual
+	) &&
+	echo "=C3=B8~?" > expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'push special filenames' '
+	test_when_finished "rm -rf hgrepo gitrepo && LC_ALL=3DC" &&
+
+	mkdir -p tmp && cd tmp &&
+
+	LC_ALL=3Den_US.UTF-8
+	export LC_ALL
+
+	(
+	hg init hgrepo &&
+	cd hgrepo &&
+
+	echo one >> content &&
+	hg add content &&
+	hg commit -m one
+	) &&
+
+	(
+	git clone "hg::hgrepo" gitrepo &&
+	cd gitrepo &&
+
+	echo test >> "=C3=A6 r=C3=B8" &&
+	git add "=C3=A6 r=C3=B8" &&
+	git commit -m utf-8 &&
+
+	git push
+	) &&
+
+	(cd hgrepo &&
+	hg update &&
+	hg manifest > ../actual
+	) &&
+
+	printf "content\n=C3=A6 r=C3=B8\n" > expected &&
+	test_cmp expected actual
+'
+
 setup_big_push () {
 	(
 	hg init hgrepo &&
--=20
1.8.4.2+fc1
