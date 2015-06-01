From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/3] for-each-ref: report broken references correctly
Date: Mon,  1 Jun 2015 17:53:50 +0200
Message-ID: <1433174031-5471-3-git-send-email-mhagger@alum.mit.edu>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:54:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzS2m-0002xa-Nn
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbbFAPyU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:54:20 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48709 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753883AbbFAPyF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:54:05 -0400
X-AuditID: 1207440d-f79026d000000bad-48-556c8019c6f8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 85.1F.02989.9108C655; Mon,  1 Jun 2015 11:54:01 -0400 (EDT)
Received: from michael.fritz.box (p4FC96750.dip0.t-ipconnect.de [79.201.103.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t51FrsEp010505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 1 Jun 2015 11:54:00 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsUixO6iqCvZkBNq0PJPzOJMX7hF15VuJouG
	3ivMFrdXzGe2+NHSw2yxeXM7iwObx9/3H5g8Fmwq9Wg6c5TZ41nvHkaPi5eUPT5vkgtgi+K2
	SUosKQvOTM/Tt0vgzji/Tb6gQ6ziwfWpLA2MfUJdjJwcEgImEj8nd7JB2GISF+6tB7K5OIQE
	LjNKfP+7jgnCOc4k0d63iAWkik1AV2JRTzMTiC0ioCYxse0QWJxZYDOjROfDIBBbWMBV4mXP
	TUYQm0VAVeL76R9gNbwCzhJbjx1hgdgmJ3H++E9mEJtTwEViyaYvYPVCQDW3V35km8DIu4CR
	YRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrpFebmaJXmpK6SZGSIjx7mD8v07mEKMAB6MSD29G
	d3aoEGtiWXFl7iFGSQ4mJVFe58qcUCG+pPyUyozE4oz4otKc1OJDjBIczEoivFYVQDnelMTK
	qtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgTv7DqgRsGi1PTUirTMnBKENBMH
	J8hwLimR4tS8lNSixNKSjHhQZMQXA2MDJMUDtDcapJ23uCAxFygK0XqKUVFKnHcfSEIAJJFR
	mgc3FpY4XjGKA30pzPsfpIoHmHTgul8BDWYCGtwuADa4JBEhJdXAaPr1wfsbaZsfGgc9mBT+
	aGZdNI/S5P8s835NiVP6Iel379Z570lZb6bbMQZWLb/1tGipUKtp+8s/J45bXQ5wfnu8bCfn
	b6nPx3KWHRZ4uyymY+kaHw5HxyevVzcvOPx8mdGNkqmi3L6W5nU3Hv8RbdyyXWDW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270430>

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
index dc68947..b9af9a9 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	git for-each-ref >full-list
 '
 
-test_expect_failure 'Broken refs are reported correctly' '
+test_expect_success 'Broken refs are reported correctly' '
 	r=refs/heads/bogus &&
 	: >.git/$r &&
 	test_when_finished "rm -f .git/$r" &&
-- 
2.1.4
