From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 02/14] t5500: add tests of fetch-pack --all --depth=N $URL $REF
Date: Sun,  9 Sep 2012 08:19:37 +0200
Message-ID: <1347171589-13327-3-git-send-email-mhagger@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 08:22:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAauC-0003OI-LY
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 08:22:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698Ab2IIGVN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 02:21:13 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:50480 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751949Ab2IIGU3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 02:20:29 -0400
X-AuditID: 1207440f-b7fde6d00000095c-95-504c352c2efa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id B8.8A.02396.C253C405; Sun,  9 Sep 2012 02:20:29 -0400 (EDT)
Received: from michael.fritz.box (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q896KIlf029164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 02:20:27 -0400
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsUixO6iqKtr6hNgsG4fo0XXlW4mi4beK8wW
	t1fMZ7b40dLDbNE5VdaB1ePv+w9MHsuXrmP0eNa7h9Hj4iVlj8+b5AJYo7htkhJLyoIz0/P0
	7RK4M+79XM1csJirovuLUAPjdo4uRk4OCQETiVvL3rFB2GISF+6tB7OFBC4zSrRsiuxi5AKy
	zzBJbP08lREkwSagK7Gop5kJxBYRUJOY2HaIBaSIWaCLUWL5ul9g3cICQRK9O08xg9gsAqoS
	53Z0gNm8Ai4Scy7sYofYpijx4/sasDingKvEq5m7GSE2u0hs2nmNdQIj7wJGhlWMcok5pbm6
	uYmZOcWpybrFyYl5ealFuiZ6uZkleqkppZsYIQHFv4Oxa73MIUYBDkYlHt6VN70DhFgTy4or
	cw8xSnIwKYnyapj4BAjxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4b3KDpTjTUmsrEotyodJSXOw
	KInzqi9R9xMSSE8sSc1OTS1ILYLJynBwKEnwfjAGahQsSk1PrUjLzClBSDNxcIIILpANPEAb
	roMU8hYXJOYWZ6ZDFJ1iVJQS55UCOUsAJJFRmgc3ABb7rxjFgf4R5mUBqeIBpg247ldAg5mA
	Bos88wAZXJKIkJJqYIwr5pIJ/bfgZrba0c43/twPez6f3v5htq/f1x0/fv5xXmFwQypiWd2S
	TVMvSpX01EwUzrvdxmdha60Ye5D9uo/htDPPmWTUv38R/ddVtjH7Zp58/TVNxjvTSgM6DT97
	CkwLm38j/BXHZblZji/PuZpt6Eibsib64J8VVxWENp2eZxmodnHyUkYlluKMREMt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205065>

Document some bugs in "git fetch-pack":

1. If "git fetch-pack" is called with "--all", "--depth", and an
explicit existing non-tag reference to fetch, then it falsely reports
that the reference was not found, even though it was fetched
correctly.

2. If "git fetch-pack" is called with "--all", "--depth", and an
explicit existing tag reference to fetch, then it segfaults in
filter_refs() because return_refs is used without having been
initialized.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5500-fetch-pack.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 6fa1cef..15d277f 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -427,4 +427,19 @@ test_expect_success 'test missing ref before existing' '
 	test_cmp expect-error error-me
 '
 
+test_expect_failure 'test --all, --depth, and explicit head' '
+	(
+		cd client &&
+		git fetch-pack --no-progress --all --depth=1 .. refs/heads/A
+	) >out-adh 2>error-adh
+'
+
+test_expect_failure 'test --all, --depth, and explicit tag' '
+	git tag OLDTAG refs/heads/B~5 &&
+	(
+		cd client &&
+		git fetch-pack --no-progress --all --depth=1 .. refs/tags/OLDTAG
+	) >out-adt 2>error-adt
+'
+
 test_done
-- 
1.7.11.3
