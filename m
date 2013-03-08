From: Jeff King <peff@peff.net>
Subject: [PATCH v2 2/3] environment: add GIT_PREFIX to local_repo_env
Date: Fri, 8 Mar 2013 04:30:25 -0500
Message-ID: <20130308093025.GB1923@sigill.intra.peff.net>
References: <20130308092824.GA9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 10:30:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtdf-0006ZU-Bj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933945Ab3CHJa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 04:30:29 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40784 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933454Ab3CHJa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:30:28 -0500
Received: (qmail 15100 invoked by uid 107); 8 Mar 2013 09:32:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 04:32:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 04:30:25 -0500
Content-Disposition: inline
In-Reply-To: <20130308092824.GA9127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217652>

The GIT_PREFIX variable is set based on our location within
the working tree. It should therefore be cleared whenever
GIT_WORK_TREE is cleared.

In practice, this doesn't cause any bugs, because none of
the sub-programs we invoke with local_repo_env cleared
actually care about GIT_PREFIX. But this is the right thing
to do, and future proofs us again that assumption changing.

While we're at it, let's define a GIT_PREFIX_ENVIRONMENT
macro; this avoids repetition of the string literal, which
can help catch any spelling mistakes in the code.

Signed-off-by: Jeff King <peff@peff.net>
---
I noticed this one because it was near code I was touching in an earlier
iteration of patch 3. I gave a quick skim and did not notice any other
variables which would want to receive the same treatment.

 cache.h       | 1 +
 environment.c | 1 +
 setup.c       | 4 ++--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/cache.h b/cache.h
index b90044a..23e6e62 100644
--- a/cache.h
+++ b/cache.h
@@ -345,6 +345,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
+#define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
diff --git a/environment.c b/environment.c
index dc73927..2bd1c37 100644
--- a/environment.c
+++ b/environment.c
@@ -95,6 +95,7 @@ const char * const local_repo_env[] = {
 	GRAFT_ENVIRONMENT,
 	INDEX_ENVIRONMENT,
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
+	GIT_PREFIX_ENVIRONMENT,
 	NULL
 };
 
diff --git a/setup.c b/setup.c
index 1dee47e..1996295 100644
--- a/setup.c
+++ b/setup.c
@@ -794,9 +794,9 @@ const char *setup_git_directory_gently(int *nongit_ok)
 
 	prefix = setup_git_directory_gently_1(nongit_ok);
 	if (prefix)
-		setenv("GIT_PREFIX", prefix, 1);
+		setenv(GIT_PREFIX_ENVIRONMENT, prefix, 1);
 	else
-		setenv("GIT_PREFIX", "", 1);
+		setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
 
 	if (startup_info) {
 		startup_info->have_repository = !nongit_ok || !*nongit_ok;
-- 
1.8.2.rc2.4.g3e774bb
