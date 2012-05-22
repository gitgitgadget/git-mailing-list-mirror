From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Tue, 22 May 2012 20:50:58 +0200
Message-ID: <4FBBE012.6090702@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue May 22 20:51:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWuAx-0000xY-9T
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760145Ab2EVSvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:51:07 -0400
Received: from india601.server4you.de ([85.25.151.105]:33070 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760125Ab2EVSvD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:51:03 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 64C682F825D;
	Tue, 22 May 2012 20:51:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198225>

Convert the parameter subdirname of search_for_subdir() to a
length-limted string and then simply pass the interesting slice of the
refname from find_containing_dir(), thereby avoiding to duplicate the
string.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Why allocate a NUL-terminated copy at all when we can teach the code to
stop after a given number of characters just as easily?  Alas, this
will still trigger an allocation in search_ref_dir() (see first patch).

 refs.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index c5e167b..96e943c 100644
--- a/refs.c
+++ b/refs.c
@@ -352,9 +352,9 @@ static struct ref_entry *search_ref_dir(struct ref_dir *dir,
  * directory cannot be found.  dir must already be complete.
  */
 static struct ref_dir *search_for_subdir(struct ref_dir *dir,
-					 const char *subdirname, int mkdir)
+					 const char *subdirname, size_t len,
+					 int mkdir)
 {
-	size_t len = strlen(subdirname);
 	struct ref_entry *entry = search_ref_dir(dir, subdirname, len);
 	if (!entry) {
 		if (!mkdir)
@@ -383,15 +383,11 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
 static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 					   const char *refname, int mkdir)
 {
-	struct strbuf dirname;
 	const char *slash;
-	strbuf_init(&dirname, PATH_MAX);
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
+		size_t dirnamelen = slash - refname + 1;
 		struct ref_dir *subdir;
-		strbuf_add(&dirname,
-			   refname + dirname.len,
-			   (slash + 1) - (refname + dirname.len));
-		subdir = search_for_subdir(dir, dirname.buf, mkdir);
+		subdir = search_for_subdir(dir, refname, dirnamelen, mkdir);
 		if (!subdir) {
 			dir = NULL;
 			break;
@@ -399,7 +395,6 @@ static struct ref_dir *find_containing_dir(struct ref_dir *dir,
 		dir = subdir;
 	}
 
-	strbuf_release(&dirname);
 	return dir;
 }
 
-- 
1.7.10.2
