From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Sat,  8 Aug 2009 09:51:08 +0200
Message-ID: <1249717868-10946-1-git-send-email-Matthieu.Moy@imag.fr>
References: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Aug 08 09:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZglP-0004lg-Gn
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 09:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641AbZHHHye (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Aug 2009 03:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933459AbZHHHye
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 03:54:34 -0400
Received: from imag.imag.fr ([129.88.30.1]:40408 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932154AbZHHHyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Aug 2009 03:54:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n787pFrm023193
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 8 Aug 2009 09:51:17 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZghu-00036Q-Vc; Sat, 08 Aug 2009 09:51:14 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZghu-0002rT-UL; Sat, 08 Aug 2009 09:51:14 +0200
X-Mailer: git-send-email 1.6.4.62.g39c83.dirty
In-Reply-To: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sat, 08 Aug 2009 09:51:17 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125263>

'git push' failing because of non-fast forward is a very common situation,
and a beginner does not necessarily understand "fast forward" immediately.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
(hmm, I thought I had sent this v2 already, but seems I didn't)

With grammar fixes from Michael J Gruber.

Junio, this comes on top of your patch, since it refers to the
to-be-added section in 'git push --help'.

 builtin-push.c |   10 +++++++++-
 transport.c    |   10 +++++++---
 transport.h    |    3 ++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..5d4df7f 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -140,6 +140,7 @@ static int do_push(const char *repo, int flags)
 		struct transport *transport =
 			transport_get(remote, url[i]);
 		int err;
+		int nonfastforward;
 		if (receivepack)
 			transport_set_option(transport,
 					     TRANS_OPT_RECEIVEPACK, receivepack);
@@ -148,13 +149,20 @@ static int do_push(const char *repo, int flags)
 
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
+		err = transport_push(transport, refspec_nr, refspec, flags,
+				     &nonfastforward);
 		err |= transport_disconnect(transport);
 
 		if (!err)
 			continue;
 
 		error("failed to push some refs to '%s'", url[i]);
+		if (nonfastforward) {
+			printf("Push was rejected because it would not result in a fast forward:\n"
+			       "Merge in the remote changes (using git pull) before pushing yours,\n"
+			       "or use git push --force to discard the remote changes.\n"
+			       "See 'non-fast forward' section of 'git push --help' for details.\n");
+		}
 		errs++;
 	}
 	return !!errs;
diff --git a/transport.c b/transport.c
index de0d587..f231b35 100644
--- a/transport.c
+++ b/transport.c
@@ -820,7 +820,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-							  int verbose, int porcelain)
+			      int verbose, int porcelain, int * nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -835,11 +835,14 @@ static void print_push_status(const char *dest, struct ref *refs,
 		if (ref->status == REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
 
+	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
 			n += print_one_push_status(ref, dest, n, porcelain);
+		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
+			*nonfastforward = 1;
 	}
 }
 
@@ -997,7 +1000,8 @@ int transport_set_option(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags)
+		   int refspec_nr, const char **refspec, int flags,
+		   int * nonfastforward)
 {
 	verify_remote_names(refspec_nr, refspec);
 
@@ -1024,7 +1028,7 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain, nonfastforward);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 51b5397..639f13d 100644
--- a/transport.h
+++ b/transport.h
@@ -68,7 +68,8 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags);
+		   int refspec_nr, const char **refspec, int flags,
+		   int * nonfastforward);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-- 
1.6.4.62.g39c83.dirty
