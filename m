From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 19/19] delete_ref(): use the usual convention for old_sha1
Date: Mon, 22 Jun 2015 16:03:10 +0200
Message-ID: <29ca4c18c045147c5260eb699dad31d0e4036e8b.1434980615.git.mhagger@alum.mit.edu>
References: <cover.1434980615.git.mhagger@alum.mit.edu>
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 16:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z72KY-0005pZ-TW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 16:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933695AbbFVOEA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 10:04:00 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:42118 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933550AbbFVODu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Jun 2015 10:03:50 -0400
X-AuditID: 1207440f-f79df6d000007c0f-b7-558815bb73b6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 09.99.31759.BB518855; Mon, 22 Jun 2015 10:03:39 -0400 (EDT)
Received: from michael.fritz.box (p4FC977DB.dip0.t-ipconnect.de [79.201.119.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t5ME3CcH030627
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 22 Jun 2015 10:03:38 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <cover.1434980615.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqLtbtCPU4OFuHouuK91MFg29V5gt
	bq+Yz2zxo6WH2WLz5nYWB1aPv+8/MHks2FTq8ax3D6PHxUvKHp83yQWwRnHbJCWWlAVnpufp
	2yVwZ8xeco21YKpKxa+H65gaGG/JdDFycEgImEic2M3WxcgJZIpJXLi3Hsjm4hASuMwoserx
	cVYI5ySTxOztv5hBqtgEdCUW9TQzgdgiAmoSE9sOsYAUMQt0MEpcWL6NHSQhLOArsefSVLAi
	FgFVidd3VoI18wpESWyfe5kVYp2cxPnjP8HinAIWEvP3/QfrFRIwl5g48xHLBEbeBYwMqxjl
	EnNKc3VzEzNzilOTdYuTE/PyUot0TfRyM0v0UlNKNzFCQop/B2PXeplDjAIcjEo8vA627aFC
	rIllxZW5hxglOZiURHkPvAYK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuFtOQuU401JrKxKLcqH
	SUlzsCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8PqJdIQKCRalpqdWpGXmlCCkmTg4QYZz
	SYkUp+alpBYllpZkxINiI74YGB0gKR6gvTkg7bzFBYm5QFGI1lOMilLivJNBEgIgiYzSPLix
	sETxilEc6Eth3j3CQFU8wCQD1/0KaDAT0OAvuW0gg0sSEVJSDYxZoU2Td7c0u6ZM5gy4sL3U
	UpPpmG3iNRP9i+UlFz437Pvp4pb9vW+n1ocD+f1r439d8LdLffdnzcT4Gt8Ahsh7If9jjSc2
	Rr8KPPoww8fO+NiFFL9VyR7/3bZOuD5XQVT6vnxvq03a1lP3ppwQC/d6vdD3p/HE 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272352>

The ref_transaction_update() family of functions use the following
convention for their old_sha1 parameters:

* old_sha1 == NULL: Don't check the old value at all.
* is_null_sha1(old_sha1): Ensure that the reference didn't exist
  before the transaction.
* otherwise: Ensure that the reference had the specified value before
  the transaction.

delete_ref() had a different convention, namely treating
is_null_sha1(old_sha1) as "don't care". Change it to adhere to the
standard convention to reduce the scope for confusion.

Please note that it is now a bug to pass old_sha1=NULL_SHA1 to
delete_ref() (because it doesn't make sense to delete a reference that
you already know doesn't exist). This is consistent with the behavior
of ref_transaction_delete().

Most of the callers of delete_ref() never pass old_sha1=NULL_SHA1 to
delete_ref(), and are therefore unaffected by this change. The
two exceptions are:

* The call in cmd_update_ref(), which passed NULL_SHA1 if the old
  value passed in on the command line was 0{40} or the empty string.
  Change that caller to pass NULL in those cases.

  Arguably, it should be an error to call "update-ref -d" with the old
  value set to "does not exist", just as it is for the `--stdin`
  command "delete". But since this usage was accepted until now,
  continue to accept it.

* The call in delete_branches(), which could pass NULL_SHA1 if
  deleting a broken or symbolic ref. Change it to pass NULL in these
  cases.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/branch.c     |  3 ++-
 builtin/update-ref.c |  8 +++++++-
 refs.c               |  8 --------
 refs.h               | 10 +++++-----
 4 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 47e3eb9..58aa84f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -253,7 +253,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			continue;
 		}
 
-		if (delete_ref(name, sha1, REF_NODEREF)) {
+		if (delete_ref(name, is_null_sha1(sha1) ? NULL : sha1,
+			       REF_NODEREF)) {
 			error(remote_branch
 			      ? _("Error deleting remote-tracking branch '%s'")
 			      : _("Error deleting branch '%s'"),
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 160c7ac..6763cf1 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -422,7 +422,13 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	if (no_deref)
 		flags = REF_NODEREF;
 	if (delete)
-		return delete_ref(refname, oldval ? oldsha1 : NULL, flags);
+		/*
+		 * For purposes of backwards compatibility, we treat
+		 * NULL_SHA1 as "don't care" here:
+		 */
+		return delete_ref(refname,
+				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
+				  flags);
 	else
 		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
 				  flags, UPDATE_REFS_DIE_ON_ERR);
diff --git a/refs.c b/refs.c
index 2ba618e..adf3dc2 100644
--- a/refs.c
+++ b/refs.c
@@ -2821,14 +2821,6 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
 
-	/*
-	 * Treat NULL_SHA1 and NULL alike, to mean "we don't care what
-	 * the old value of the reference was (or even if it didn't
-	 * exist)":
-	 */
-	if (old_sha1 && is_null_sha1(old_sha1))
-		old_sha1 = NULL;
-
 	transaction = ref_transaction_begin(&err);
 	if (!transaction ||
 	    ref_transaction_delete(transaction, refname, old_sha1,
diff --git a/refs.h b/refs.h
index c9596ea..e82fca5 100644
--- a/refs.h
+++ b/refs.h
@@ -240,11 +240,11 @@ extern int read_ref_at(const char *refname, unsigned int flags,
 extern int reflog_exists(const char *refname);
 
 /*
- * Delete the specified reference. If old_sha1 is non-NULL and not
- * NULL_SHA1, then verify that the current value of the reference is
- * old_sha1 before deleting it. If old_sha1 is NULL or NULL_SHA1,
- * delete the reference if it exists, regardless of its old value.
- * flags is passed through to ref_transaction_delete().
+ * Delete the specified reference. If old_sha1 is non-NULL, then
+ * verify that the current value of the reference is old_sha1 before
+ * deleting it. If old_sha1 is NULL, delete the reference if it
+ * exists, regardless of its old value. It is an error for old_sha1 to
+ * be NULL_SHA1. flags is passed through to ref_transaction_delete().
  */
 extern int delete_ref(const char *refname, const unsigned char *old_sha1,
 		      unsigned int flags);
-- 
2.1.4
