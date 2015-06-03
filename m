From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 2/4] for-each-ref: report broken references correctly
Date: Wed,  3 Jun 2015 15:51:57 +0200
Message-ID: <505661bfc79d989cf0a155c7bb865e1a54f9ee07.1433339279.git.mhagger@alum.mit.edu>
References: <cover.1433339279.git.mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 15:52:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z095e-0005gd-P0
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 15:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbbFCNwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 09:52:11 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:51190 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754615AbbFCNwH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 09:52:07 -0400
X-AuditID: 1207440e-f79fc6d000000caf-e7-556f0687b692
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 1E.8E.03247.7860F655; Wed,  3 Jun 2015 09:52:07 -0400 (EDT)
Received: from michael.fritz.box (p4FC96DFC.dip0.t-ipconnect.de [79.201.109.252])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t53Dq152005566
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 3 Jun 2015 09:52:05 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1433339279.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsUixO6iqNvOlh9qMOkTm8WZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnfFxeWTBWrGKi/dXMTcwbhTqYuTkkBAwkfjVuIEZwhaTuHBvPVsXIxeH
	kMBlRok5RxazQDgnmCQaPz5kA6liE9CVWNTTzARiiwioSUxsO8QCYjMLbGaU6HwYBGILC3hI
	vOneBBZnEVCVODjxDJjNKxAlcej6RqhtchLnj/8Esjk4OAUsJPbc0AYxhQTMJc6flJ/AyLuA
	kWEVo1xiTmmubm5iZk5xarJucXJiXl5qka6xXm5miV5qSukmRkh48e1gbF8vc4hRgINRiYfX
	ISwvVIg1say4MvcQoyQHk5Io75ovQCG+pPyUyozE4oz4otKc1OJDjBIczEoivC/fAeV4UxIr
	q1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK8raz5oUKCRanpqRVpmTklCGkm
	Dk6Q4VxSIsWpeSmpRYmlJRnxoKiILwbGBUiKB2hvHEg7b3FBYi5QFKL1FKOilDhvJEhCACSR
	UZoHNxaWNF4xigN9Kcx7F6SKB5hw4LpfAQ1mAhrcLpADMrgkESEl1cDYbNYcfGKm/daqL0Hs
	U2Z/vdypeMo15tCsuyvbZN38dv6RLRDiOaez73Pcnj1Fl9++NKt9fkbuJ/ei/y9P7QpT67H6
	MnX6G70r1vc1azzvR7EaWAQVaN09eXTDZn/B3ZICH1sY36uIOj2KXHopJOr/ixtc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270686>

If there is a loose reference file with invalid contents, "git
for-each-ref" incorrectly reports the problem as being a missing
object with name NULL_SHA1:

    $ echo '12345678' >.git/refs/heads/nonsense
    $ git for-each-ref
    fatal: missing object 0000000000000000000000000000000000000000 for refs/heads/nonsense

With an explicit "--format" string, it can even report that the
reference validly points at NULL_SHA1:

    $ git for-each-ref --format='%(objectname) %(refname)'
    0000000000000000000000000000000000000000 refs/heads/nonsense
    $ echo $?
    0

This has been broken since

    b7dd2d2 for-each-ref: Do not lookup objects when they will not be used (2009-05-27)

, which changed for-each-ref from using for_each_ref() to using
git_for_each_rawref() in order to avoid looking up the referred-to
objects unnecessarily. (When "git for-each-ref" is given a "--format"
string that doesn't include information about the pointed-to object,
it does not look up the object at all, which makes it considerably
faster. Iterating with DO_FOR_EACH_INCLUDE_BROKEN is essential to this
optimization because otherwise for_each_ref() would itself need to
check whether the object exists as part of its brokenness test.)

But for_each_rawref() includes broken references in the iteration, and
"git for-each-ref" doesn't itself reject references with REF_ISBROKEN.
The result is that broken references are processed *as if* they had
the value NULL_SHA1, which is the value stored in entries for broken
references.

Change "git for-each-ref" to emit warnings for references that are
REF_ISBROKEN but to otherwise skip them.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/for-each-ref.c         | 5 +++++
 t/t6301-for-each-ref-errors.sh | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..13d2172 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -851,6 +851,11 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 		  return 0;
 	}
 
+	if (flag & REF_ISBROKEN) {
+		  warning("ignoring broken ref %s", refname);
+		  return 0;
+	}
+
 	if (*cb->grab_pattern) {
 		const char **pattern;
 		int namelen = strlen(refname);
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index cf25244..72d2397 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -14,7 +14,7 @@ test_expect_success setup '
 	git for-each-ref --format="%(objectname) %(refname)" >brief-list
 '
 
-test_expect_failure 'Broken refs are reported correctly' '
+test_expect_success 'Broken refs are reported correctly' '
 	r=refs/heads/bogus &&
 	: >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-- 
2.1.4
