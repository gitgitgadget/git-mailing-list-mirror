From: Junio C Hamano <gitster@pobox.com>
Subject: Re: input validation in receive-pack
Date: Tue, 01 Jan 2008 21:46:36 -0800
Message-ID: <7vhchw3hkz.fsf@gitster.siamese.dyndns.org>
References: <20080101213451.GA26772@auto.tuwien.ac.at>
	<7vzlvp3oya.fsf@gitster.siamese.dyndns.org>
	<alpine.LNX.1.00.0801012353580.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 06:47:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9wRy-0003AJ-9T
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 06:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751869AbYABFq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 00:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYABFq5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 00:46:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYABFq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 00:46:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 82E667EA4;
	Wed,  2 Jan 2008 00:46:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6AF027EA1;
	Wed,  2 Jan 2008 00:46:48 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801012353580.13593@iabervon.org> (Daniel
	Barkalow's message of "Wed, 2 Jan 2008 00:01:20 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69456>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 1 Jan 2008, Junio C Hamano wrote:
>
>> mkoegler@auto.tuwien.ac.at (Martin Koegler) writes:
>> 
>> > In the update code path, the check is done in refs.c:
>> > | struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
>> > | {
>> > |         if (check_ref_format(ref) == -1)
>> > |                 return NULL;
>> > |         return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
>> > | }
>> >
>> > check_ref_format may also return -2 (less than two name levels) and -3
>> > (* at the end), which are ignored. Is it really intended, that
>> > receive-pack can create such refs.
>> 
>> Misconversion in 8558fd9ece4c8250a037a6d5482a8040d600ef47 that
>> changed check_ref_format() without looking at what its callers
>> are checking, I think.
>
> When I got to it, it was already accepting -2. It clearly shouldn't accept 
> -3 (and I don't know why I missed it; I was probably misinterpreting the 
> original logic there.

You are right.

builtin-commit.c uses it to lock "HEAD", and update_ref() calls
it to update any ref so we cannot reject -2.  However, I do not
think allowing wildcard is useful for any caller.

-- >8 --
lock_any_ref_for_update(): reject wildcard return from check_ref_format

Recent check_ref_format() returns -3 as well as -1 (general
error) and -2 (less than two levels).  The caller was explicitly
checking for -1, to allow "HEAD" but still disallow bogus refs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 refs.c |   27 ++++++++++++++++++---------
 refs.h |    5 ++++-
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index 759924d..7484a46 100644
--- a/refs.c
+++ b/refs.c
@@ -613,32 +613,37 @@ int check_ref_format(const char *ref)
 		while ((ch = *cp++) == '/')
 			; /* tolerate duplicated slashes */
 		if (!ch)
-			return -1; /* should not end with slashes */
+			/* should not end with slashes */
+			return CHECK_REF_FORMAT_ERROR;
 
 		/* we are at the beginning of the path component */
 		if (ch == '.')
-			return -1;
+			return CHECK_REF_FORMAT_ERROR;
 		bad_type = bad_ref_char(ch);
 		if (bad_type) {
-			return (bad_type == 2 && !*cp) ? -3 : -1;
+			return (bad_type == 2 && !*cp)
+				? CHECK_REF_FORMAT_WILDCARD
+				: CHECK_REF_FORMAT_ERROR;
 		}
 
 		/* scan the rest of the path component */
 		while ((ch = *cp++) != 0) {
 			bad_type = bad_ref_char(ch);
 			if (bad_type) {
-				return (bad_type == 2 && !*cp) ? -3 : -1;
+				return (bad_type == 2 && !*cp)
+					? CHECK_REF_FORMAT_WILDCARD
+					: CHECK_REF_FORMAT_ERROR;
 			}
 			if (ch == '/')
 				break;
 			if (ch == '.' && *cp == '.')
-				return -1;
+				return CHECK_REF_FORMAT_ERROR;
 		}
 		level++;
 		if (!ch) {
 			if (level < 2)
-				return -2; /* at least of form "heads/blah" */
-			return 0;
+				return CHECK_REF_FORMAT_ONELEVEL;
+			return CHECK_REF_FORMAT_OK;
 		}
 	}
 }
@@ -816,9 +821,13 @@ struct ref_lock *lock_ref_sha1(const char *ref, const unsigned char *old_sha1)
 
 struct ref_lock *lock_any_ref_for_update(const char *ref, const unsigned char *old_sha1, int flags)
 {
-	if (check_ref_format(ref) == -1)
+	switch (check_ref_format(ref)) {
+	case CHECK_REF_FORMAT_ERROR:
+	case CHECK_REF_FORMAT_WILDCARD:
 		return NULL;
-	return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
+	default:
+		return lock_ref_sha1_basic(ref, old_sha1, flags, NULL);
+	}
 }
 
 static struct lock_file packlock;
diff --git a/refs.h b/refs.h
index 9dc8aa0..9cd16f8 100644
--- a/refs.h
+++ b/refs.h
@@ -52,7 +52,10 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
  */
 extern int for_each_reflog(each_ref_fn, void *);
 
-/** Returns 0 if target has the right format for a ref. **/
+#define CHECK_REF_FORMAT_OK 0
+#define CHECK_REF_FORMAT_ERROR (-1)
+#define CHECK_REF_FORMAT_ONELEVEL (-2)
+#define CHECK_REF_FORMAT_WILDCARD (-3)
 extern int check_ref_format(const char *target);
 
 /** rename ref, return 0 on success **/
