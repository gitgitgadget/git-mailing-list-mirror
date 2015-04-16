From: Jeff King <peff@peff.net>
Subject: [PATCH 8/9] read_packed_refs: avoid double-checking sane refs
Date: Thu, 16 Apr 2015 05:03:26 -0400
Message-ID: <20150416090326.GH17938@peff.net>
References: <20150416084733.GA17811@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 16 11:03:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yifhv-0000XZ-4O
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 11:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757205AbbDPJDb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 05:03:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:46129 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756910AbbDPJD2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 05:03:28 -0400
Received: (qmail 22246 invoked by uid 102); 16 Apr 2015 09:03:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 04:03:28 -0500
Received: (qmail 23612 invoked by uid 107); 16 Apr 2015 09:03:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 05:03:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 05:03:26 -0400
Content-Disposition: inline
In-Reply-To: <20150416084733.GA17811@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267269>

Prior to d0f810f (refs.c: allow listing and deleting badly
named refs, 2014-09-03), read_packed_refs would barf on any
malformed refnames by virtue of calling create_ref_entry
with the "check" parameter set to 1. That commit loosened
our reading so that we call check_refname_format ourselves
and just set a REF_BAD_NAME flag.

We then call create_ref_entry with the check parameter set
to 0. That function learned to do an extra safety check even
when the check parameter is 0, so that we don't load any
dangerous refnames (like "../../../etc/passwd"). This is
implemented by calling refname_is_safe() in
create_ref_entry().

However, we can observe that refname_is_safe() can only be
true if check_refname_format() also failed. So in the common
case of a sanely named ref, we perform _both_ checks, even
though we know that the latter will never trigger. This has
a noticeable performance impact when the packed-refs file is
large.

Let's drop the refname_is_safe check from create_ref_entry(),
and make it the responsibility of the caller.  Of the three
callers that pass a check parameter of "0", two will have
just called check_refname_format(), and can check the
refname-safety only when it fails. The third case,
pack_if_possible_fn, is copying from an existing ref entry,
which must have previously passed our safety check.

With this patch, running "git rev-parse refs/heads/does-not-exist"
on a repo with a large (1.6GB) packed-refs file went from:

  real    0m6.768s
  user    0m6.340s
  sys     0m0.432s

to:

  real    0m5.703s
  user    0m5.276s
  sys     0m0.432s

for a wall-clock speedup of 15%.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 47e4e53..f36ea75 100644
--- a/refs.c
+++ b/refs.c
@@ -344,8 +344,6 @@ static struct ref_entry *create_ref_entry(const char *refname,
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
-	if (!check_name && !refname_is_safe(refname))
-		die("Reference has invalid name: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -1178,6 +1176,8 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 			int flag = REF_ISPACKED;
 
 			if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+				if (!refname_is_safe(refname))
+					die("packed refname is dangerous: %s", refname);
 				hashclr(sha1);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
@@ -1323,6 +1323,8 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 			}
 			if (check_refname_format(refname.buf,
 						 REFNAME_ALLOW_ONELEVEL)) {
+				if (!refname_is_safe(refname.buf))
+					die("loose refname is dangerous: %s", refname.buf);
 				hashclr(sha1);
 				flag |= REF_BAD_NAME | REF_ISBROKEN;
 			}
-- 
2.4.0.rc2.384.g7297a4a
