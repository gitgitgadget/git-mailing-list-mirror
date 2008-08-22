From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] remote.c: add a function for deleting a refspec array and
 use it (twice)
Date: Thu, 21 Aug 2008 19:16:30 -0500
Message-ID: <wFl399-gCL5aWJVzIQInmJ7pEp0R-MPJKSzJw3vAxISbcHFg2DaDTA@cipher.nrlssc.navy.mil>
References: <7vpro3ks15.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <meyering@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 02:18:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWKLn-0006GY-Ti
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 02:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945AbYHVAQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 20:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752854AbYHVAQz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 20:16:55 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48769 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314AbYHVAQy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 20:16:54 -0400
Received: by mail.nrlssc.navy.mil id m7M0GV4p004220; Thu, 21 Aug 2008 19:16:31 -0500
In-Reply-To: <7vpro3ks15.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 22 Aug 2008 00:16:30.0341 (UTC) FILETIME=[536A4B50:01C903EC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93235>

A number of call sites allocate memory for a refspec array, populate
its members with heap memory, and then free only the refspec pointer
while leaking the memory allocated for the member elements. Provide
a function for freeing the elements of a refspec array and the array
itself.

Caution to callers: code paths must be checked to ensure that the
refspec members "src" and "dst" can be passed to free.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 remote.c |   29 +++++++++++++++++++++++++++--
 remote.h |    1 +
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/remote.c b/remote.c
index 105668f..3ef09a4 100644
--- a/remote.c
+++ b/remote.c
@@ -449,6 +449,26 @@ static int verify_refname(char *name, int is_glob)
 	return result;
 }
 
+/*
+ * This function frees a refspec array.
+ * Warning: code paths should be checked to ensure that the src
+ *          and dst pointers are always freeable pointers as well
+ *          as the refspec pointer itself.
+ */
+void free_refspecs(struct refspec *refspec, int nr_refspec)
+{
+	int i;
+
+	if (!refspec)
+		return;
+
+	for (i = 0; i < nr_refspec; i++) {
+		free(refspec[i].src);
+		free(refspec[i].dst);
+	}
+	free(refspec);
+}
+
 static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
@@ -567,7 +587,12 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
  invalid:
 	if (verify) {
-		free(rs);
+		/*
+		 * nr_refspec must be greater than zero and i must be valid
+		 * since it is only possible to reach this point from within
+		 * the for loop above.
+		 */
+		free_refspecs(rs, i+1);
 		return NULL;
 	}
 	die("Invalid refspec '%s'", refspec[i]);
@@ -579,7 +604,7 @@ int valid_fetch_refspec(const char *fetch_refspec_str)
 	struct refspec *refspec;
 
 	refspec = parse_refspec_internal(1, fetch_refspec, 1, 1);
-	free(refspec);
+	free_refspecs(refspec, 1);
 	return !!refspec;
 }
 
diff --git a/remote.h b/remote.h
index 091b1d0..2601f6e 100644
--- a/remote.h
+++ b/remote.h
@@ -78,6 +78,7 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
+void free_refspecs(struct refspec *refspec, int nr_refspec);
 
 int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	       int nr_refspec, const char **refspec, int all);
-- 
1.6.0.21.g35a2e
