From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] push: point to 'git pull' and 'git push --force' in case of non-fast forward
Date: Thu,  6 Aug 2009 19:32:13 +0200
Message-ID: <1249579933-1782-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 06 19:36:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZ6su-0006bh-F1
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 19:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756404AbZHFRgD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 13:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756350AbZHFRgD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 13:36:03 -0400
Received: from imag.imag.fr ([129.88.30.1]:43413 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756345AbZHFRgC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 13:36:02 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id n76HWI0p009426
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 6 Aug 2009 19:32:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1MZ6p8-0001SM-Sp; Thu, 06 Aug 2009 19:32:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1MZ6p8-0000TN-Mo; Thu, 06 Aug 2009 19:32:18 +0200
X-Mailer: git-send-email 1.6.4.57.g116738.dirty
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Thu, 06 Aug 2009 19:32:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125098>

'git push' failing because of non-fast forward is a very common situation,
and a beginner does not necessarily understand "fast forward" immediately.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
That may be a bit verbose, but I think it's worth it.

Ideally, there should be a core.expertUser config variable to disable
these kind of messages, but that's another story.

 builtin-push.c |    9 ++++++++-
 transport.c    |   10 +++++++---
 transport.h    |    3 ++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/builtin-push.c b/builtin-push.c
index 1d92e22..214ca77 100644
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
@@ -148,13 +149,19 @@ static int do_push(const char *repo, int flags)
 
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
+			printf("Some branch push were rejected due to non-fast forward:\n");
+			printf("Merge the remote changes (git pull) before pushing your's\n");
+			printf("or use git push --force to discard the remote changes.\n");
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
1.6.4.57.g116738.dirty
