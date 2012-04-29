From: mhagger@alum.mit.edu
Subject: [PATCH] create_ref_entry(): move check_refname_format() call to callers
Date: Sun, 29 Apr 2012 08:18:08 +0200
Message-ID: <1335680288-5128-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 29 08:18:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SONSp-0003B4-CQ
	for gcvg-git-2@plane.gmane.org; Sun, 29 Apr 2012 08:18:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab2D2GS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Apr 2012 02:18:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:47990 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab2D2GS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2012 02:18:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0BD1D.dip.t-dialin.net [79.192.189.29])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3T6IH6h014222;
	Sun, 29 Apr 2012 08:18:17 +0200
X-Mailer: git-send-email 1.7.10
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196504>

From: Michael Haggerty <mhagger@alum.mit.edu>

This allows the caller to decide what flags to use for
check_refname_format().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

On 04/27/2012 05:06 PM, Junio C Hamano wrote:
> Jeff King<peff@peff.net>  writes:
> 
>> I upgraded git on a machine recently, and it created problems for a repo
>> with a bogus character in a ref name.  Older versions of git never
>> complained about it. Newer ones, containing your dce4bab ("add_ref():
>> verify that the refname is formatted correctly") do. That's fine; it's
>> bogus and git _should_ complain about it.
>>
>> However, recovering from the situation is unnecessarily hard, ...
>> ...
>> I seem to recall discussing this format-tightening and trying to be sure
>> that users were left with a way forward for fixing their repos. But I
>> can't find the discussion, and I don't recall any conclusion we came to.
> 
> I haven't dug the archive but I do recall pointing many issues out
> around the theme "be liberal in what you accept and strict in what you
> produce" on this topic, and loosening one or two showstoppers during the
> review cycle, but obviously we did not catch all of them.
> 
> Michael?

I will work on providing more infrastructure for checking refnames at
varying levels of strictness, but I don't know enough about the code
paths to be able to find the places where the strictness levels need
tweaking.

For this to work, the various callers of check_refname_format() will
have to be able to influence the level of strictness that they want to
enforce.  This patch is one trivial step in that direction.

 refs.c |   23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 09322fe..bc735e7 100644
--- a/refs.c
+++ b/refs.c
@@ -172,15 +172,11 @@ struct ref_entry {
 };
 
 static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag,
-					  int check_name)
+					  const unsigned char *sha1, int flag)
 {
 	int len;
 	struct ref_entry *ref;
 
-	if (check_name &&
-	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
-		die("Reference has invalid format: '%s'", refname);
 	len = strlen(refname) + 1;
 	ref = xmalloc(sizeof(struct ref_entry) + len);
 	hashcpy(ref->u.value.sha1, sha1);
@@ -710,7 +706,11 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 
 		refname = parse_ref_line(refline, sha1);
 		if (refname) {
-			last = create_ref_entry(refname, sha1, flag, 1);
+			if (check_refname_format(refname,
+						 REFNAME_ALLOW_ONELEVEL|
+						 REFNAME_DOT_COMPONENT))
+				die("Packed reference has invalid format: '%s'", refname);
+			last = create_ref_entry(refname, sha1, flag);
 			add_ref(dir, last);
 			continue;
 		}
@@ -745,8 +745,11 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 
 void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
+	if (check_refname_format(refname,
+				 REFNAME_ALLOW_ONELEVEL|REFNAME_DOT_COMPONENT))
+		die("Reference has invalid format: '%s'", refname);
 	add_ref(get_packed_refs(get_ref_cache(NULL)),
-			create_ref_entry(refname, sha1, REF_ISPACKED, 1));
+			create_ref_entry(refname, sha1, REF_ISPACKED));
 }
 
 static void get_ref_dir(struct ref_cache *refs, const char *base,
@@ -805,7 +808,11 @@ static void get_ref_dir(struct ref_cache *refs, const char *base,
 				hashclr(sha1);
 				flag |= REF_ISBROKEN;
 			}
-			add_ref(dir, create_ref_entry(refname, sha1, flag, 1));
+			if (check_refname_format(refname,
+						 REFNAME_ALLOW_ONELEVEL|
+						 REFNAME_DOT_COMPONENT))
+				die("Loose reference has invalid format: '%s'", refname);
+			add_ref(dir, create_ref_entry(refname, sha1, flag));
 		}
 		free(refname);
 		closedir(d);
-- 
1.7.10
