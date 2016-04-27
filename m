From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 24/29] ref_transaction_update(): check refname_is_safe() at a minimum
Date: Wed, 27 Apr 2016 18:57:41 +0200
Message-ID: <a67a1b745d0a14111c774f13a5776d3756cbf2f2.1461768690.git.mhagger@alum.mit.edu>
References: <cover.1461768689.git.mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org, David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:59:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSoI-00047Q-6j
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:59:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbcD0Q7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:59:23 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:47369 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753220AbcD0Q6t (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2016 12:58:49 -0400
X-AuditID: 12074411-e2bff70000000955-36-5720efc36707
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 98.6D.02389.3CFE0275; Wed, 27 Apr 2016 12:58:44 -0400 (EDT)
Received: from michael.fritz.box (p548D622A.dip0.t-ipconnect.de [84.141.98.42])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u3RGvw6b022189
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 27 Apr 2016 12:58:42 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1461768689.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqHvkvUK4QUcfk8X8TScYLbqudDNZ
	NPReYba4vWI+s0X3lLeMFj9aepgtZl61dmD3+Pv+A5PHzll32T2e9e5h9Lh4Sdlj/9JtbB4L
	nt9n9/i8SS6APYrbJimxpCw4Mz1P3y6BO+Pq9ICCoyIVsze9Z2pg/CTQxcjJISFgItF67Adb
	FyMXh5DAVkaJ4/cPQznHmSRmTn7PBFLFJqArsainGcwWEXCQWL7yFztIEbNAE5PE9+VNLCAJ
	YYFQiYl/FrGC2CwCqhI3/05lBLF5BaIkPp9axwixTk7i8vQHbCA2p4CFxJfWt2BxIQFziSUP
	VrNPYORZwMiwilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXVC83s0QvNaV0EyMkxAR3MM44KXeI
	UYCDUYmHt0BCIVyINbGsuDL3EKMkB5OSKO+Ss0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzT
	3wDleFMSK6tSi/JhUtIcLErivHxL1P2EBNITS1KzU1MLUotgsjIcHEoSvEffATUKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2IgvhgYBSApHqC9pSDtvMUFiblAUYjWU4yKUuK8
	r0ESAiCJjNI8uLGwxPGKURzoS2FeZ2AaEeIBJh247ldAg5mABl8+JAsyuCQRISXVwJhgzxB1
	XGtOVFweW9Hn6fNWf9YrOxbC9NhJVVHU8dADwX1XVsurHDzBuPegwDmjuBPXF31R0jMvnqho
	medTdUKi0MJ3Fg9bnpUXg7NF3ImsCT8LE3RL32lXvn8W5bkzauPXBVPspLQdX/iV 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292764>

If the user has asked that a new value be set for a reference, we use
check_refname_format() to verify that the reference name satisfies all
of the rules. But in other cases, at least check that refname_is_safe().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
There are remaining problems in this area of the code. For example,
check_refname_format() is *less* strict than refname_is_safe(). It
allows almost arbitrary top-level reference names like "foo" and
"refs". (The latter is especially fun because if you manage to create
a reference called "refs", Git stops recognizing the directory as a
Git repository.) On the other hand, some callers call
check_refname_format() with incomplete reference names (e.g., branch
names like "master"), so the functions can't be made stricter until
those callers are changed.

I'll address these problems separately if I find the time.

 refs.c                  | 5 +++--
 t/t1400-update-ref.sh   | 2 +-
 t/t1430-bad-ref-name.sh | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 858b6d7..41eb9e2 100644
--- a/refs.c
+++ b/refs.c
@@ -802,8 +802,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
 	if ((flags & REF_ISPRUNING) && !(flags & REF_NODEREF))
 		die("BUG: REF_ISPRUNING set without REF_NODEREF");
 
-	if (new_sha1 && !is_null_sha1(new_sha1) &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+	if ((new_sha1 && !is_null_sha1(new_sha1)) ?
+	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL) :
+	    !refname_is_safe(refname)) {
 		strbuf_addf(err, "refusing to update ref with bad name '%s'",
 			    refname);
 		return -1;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 40b0cce..08bd8fd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -23,7 +23,7 @@ test_expect_success setup '
 m=refs/heads/master
 n_dir=refs/heads/gu
 n=$n_dir/fixes
-outside=foo
+outside=refs/foo
 
 test_expect_success \
 	"create $m" \
diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
index 25ddab4..8937e25 100755
--- a/t/t1430-bad-ref-name.sh
+++ b/t/t1430-bad-ref-name.sh
@@ -285,7 +285,7 @@ test_expect_success 'update-ref -d cannot delete non-ref in .git dir' '
 	echo precious >expect &&
 	test_must_fail git update-ref -d my-private-file >output 2>error &&
 	test_must_be_empty output &&
-	test_i18ngrep -e "cannot lock .*: unable to resolve reference" error &&
+	test_i18ngrep -e "refusing to update ref with bad name" error &&
 	test_cmp expect .git/my-private-file
 '
 
-- 
2.8.1
