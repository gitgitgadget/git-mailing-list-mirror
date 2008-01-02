From: Junio C Hamano <gitster@pobox.com>
Subject: Re: input validation in receive-pack
Date: Wed, 02 Jan 2008 11:14:40 -0800
Message-ID: <7vfxxgvy3j.fsf@gitster.siamese.dyndns.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at>
	<7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801012353580.13593@iabervon.org>
	<7vhchw3hkz.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801021043220.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA93v-0004Xb-Om
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 20:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYABTO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 14:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYABTO4
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 14:14:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753265AbYABTOz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 14:14:55 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CF94EBAF5;
	Wed,  2 Jan 2008 14:14:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EF5F5BAF2;
	Wed,  2 Jan 2008 14:14:46 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69485>

Daniel Barkalow <barkalow@iabervon.org> writes:

> It might be wise to make "default" the return NULL case, and list the two 
> okay cases explicitly, so it doesn't need to be changed if 
> check_ref_format() someday gets additional "okay for some purposes" 
> values.

Sounds sensible.

> Aside from that, it looks good, except that builtin-send-pack.c and 
> fast-import.c should probably use the symbolic constants, too. (All other 
> callers only check whether the value is true or not).

Also sensible.

-- >8 --
Update callers of check_ref_format()

This updates send-pack and fast-import to use symbolic constants
for checking the return values from check_ref_format(), and also
futureproof the logic in lock_any_ref_for_update() to explicitly
name the case that is usually considered an error but is Ok for
this particular use.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-send-pack.c |   10 ++++++----
 fast-import.c       |    5 +++--
 refs.c              |    6 +++---
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 25ae1fe..8afb1d0 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -541,10 +541,12 @@ static void verify_remote_names(int nr_heads, const char **heads)
 		remote = remote ? (remote + 1) : heads[i];
 		switch (check_ref_format(remote)) {
 		case 0: /* ok */
-		case -2: /* ok but a single level -- that is fine for
-			  * a match pattern.
-			  */
-		case -3: /* ok but ends with a pattern-match character */
+		case CHECK_REF_FORMAT_ONELEVEL:
+			/* ok but a single level -- that is fine for
+			 * a match pattern.
+			 */
+		case CHECK_REF_FORMAT_WILDCARD:
+			/* ok but ends with a pattern-match character */
 			continue;
 		}
 		die("remote part of refspec is not a valid name in %s",
diff --git a/fast-import.c b/fast-import.c
index 4646c05..74597c9 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -642,8 +642,9 @@ static struct branch *new_branch(const char *name)
 	if (b)
 		die("Invalid attempt to create duplicate branch: %s", name);
 	switch (check_ref_format(name)) {
-	case  0: break; /* its valid */
-	case -2: break; /* valid, but too few '/', allow anyway */
+	case 0: break; /* its valid */
+	case CHECK_REF_FORMAT_ONELEVEL:
+		break; /* valid, but too few '/', allow anyway */
 	default:
 		die("Branch name doesn't conform to GIT standards: %s", name);
 	}
diff --git a/refs.c b/refs.c
index 7484a46..58f6d17 100644
--- a/refs.c
+++ b/refs.c
@@ -822,10 +822,10 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
 	switch (check_ref_format(ref)) {
-	case CHECK_REF_FORMAT_ERROR:
-	case CHECK_REF_FORMAT_WILDCARD:
-		return NULL;
 	default:
+		return NULL;
+	case 0:
+	case CHECK_REF_FORMAT_ONELEVEL:
 		return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
 	}
 }
