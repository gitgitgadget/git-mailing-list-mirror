From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 2/3] for-each-ref: report broken references correctly
Date: Tue,  2 Jun 2015 17:57:26 +0200
Message-ID: <1433260647-18181-3-git-send-email-mhagger@alum.mit.edu>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 17:58:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzoZe-0004QF-A9
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 17:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbbFBP5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 11:57:49 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:42312 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759109AbbFBP5o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 11:57:44 -0400
X-AuditID: 12074413-f79386d000000d23-d3-556dd2764744
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 76.F6.03363.672DD655; Tue,  2 Jun 2015 11:57:42 -0400 (EDT)
Received: from michael.fritz.box (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52FvbBW010977
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 11:57:41 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsUixO6iqFt2KTfUoPe4mMWZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnfFxeWTBWrGKi/dXMTcwbhTqYuTkkBAwkbjRvp0RwhaTuHBvPVsXIxeH
	kMBlRokrb7YzQzgnmCSmXfjJDlLFJqArsainmQnEFhFQk5jYdogFxGYW2Mwo0fkwCMQWFvCQ
	WPv6PVgNi4CqxPq5i4BqODh4BVwknj8whFgmJ3H++E9mEJtTwFWi91IXWLkQUMnb8z9YJjDy
	LmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokREmDCOxh3nZQ7xCjAwajE
	w8vwKSdUiDWxrLgy9xCjJAeTkijvjeO5oUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeAU3AOV4
	UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNLUrNTUwtSi2CyMhwcShK85y4CNQoWpaanVqRl5pQg
	pJk4OEGGc0mJFKfmpaQWJZaWZMSD4iK+GBgZICkeoL1zQdp5iwsSc4GiEK2nGBWlxHlLQBIC
	IImM0jy4sbC08YpRHOhLYV4ZkCoeYMqB634FNJgJaHC7QA7I4JJEhJRUA6PJk755PRHh8xe3
	b0wWqFOynF4lx/d5gdRXVXfRX3v/3D5aFCzrwnq4h0m0bG3m1lmLv66bLHtSK3xmglGZsUHL
	fPFTPz93JMmUfJsYqPVmlvLDjZGel5lYFMue1bNo/JlQWZfRorJ0jUNdssqZh3Mf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270559>

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
