From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-mv: succeed even if source is a prefix of destination
Date: Wed, 16 Aug 2006 10:44:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608161041300.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060815205150.GA467@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com>
 <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060816054944.GA5218@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 10:44:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDH0T-0000c3-8F
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 10:44:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWHPIoF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 04:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWHPIoF
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 04:44:05 -0400
Received: from mail.gmx.de ([213.165.64.20]:64997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751008AbWHPIoE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 04:44:04 -0400
Received: (qmail invoked by alias); 16 Aug 2006 08:44:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 16 Aug 2006 10:44:02 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060816054944.GA5218@c165.ib.student.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25508>

Hi,

On Wed, 16 Aug 2006, Fredrik Kuivinen wrote:

> On Wed, Aug 16, 2006 at 02:20:32AM +0200, Johannes Schindelin wrote:
> > 
> > As noted by Fredrik Kuivinen, without this patch, git-mv fails on
> > 
> > 	git-mv README README-renamed
> > 
> > because "README" is a prefix of "README-renamed".
> > 
> 
> Thank you. 'git-mv README README-renamed' works for me too now.
> 
> However, there still seems to be some minor problem with git-mv.
> 
>     $ git mv t t
>     fatal: renaming t failed: Invalid argument
>     $ git mv t t/
>     fatal: renaming t failed: Invalid argument
>     $ git mv t/ t/
>     fatal: cannot move directory over file, source=t/, destination=t/
>     $ git mv t/ t 
>     fatal: cannot move directory over file, source=t/, destination=t/
> 
> I kind of expected to get 'can not move directory into itself' in all
> of those cases. At least the same error messages should be given in
> all cases.
> 
> It looks like we need some kind of path normalization before we do
> those tests.

I kind of hoped it was not necessary to do this, since get_pathspec() does 
a rudimentary version of it (BTW git-mv.perl got it wrong: it substituted 
"./" by "", which would fail for a directory name like "endsWithADot.").

It was a little more involved:

-- 8< --
[PATCH] git-mv: add more path normalization

We already use the normalization from get_pathspec(), but now we also
remove a trailing slash. So,

	git mv some_path/ into_some_path/

works now.

Also, move the "can not move directory into itself" test before the
subdirectory expansion.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 builtin-mv.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index e7b5eb7..c0c8764 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -17,12 +17,19 @@ static const char builtin_mv_usage[] =
 static const char **copy_pathspec(const char *prefix, const char **pathspec,
 				  int count, int base_name)
 {
+	int i;
 	const char **result = xmalloc((count + 1) * sizeof(const char *));
 	memcpy(result, pathspec, count * sizeof(const char *));
 	result[count] = NULL;
-	if (base_name) {
-		int i;
-		for (i = 0; i < count; i++) {
+	for (i = 0; i < count; i++) {
+		int length = strlen(result[i]);
+		if (length > 0 && result[i][length - 1] == '/') {
+			char *without_slash = xmalloc(length);
+			memcpy(without_slash, result[i], length - 1);
+			without_slash[length] = '\0';
+			result[i] = without_slash;
+		}
+		if (base_name) {
 			const char *last_slash = strrchr(result[i], '/');
 			if (last_slash)
 				result[i] = last_slash + 1;
@@ -129,6 +136,12 @@ int cmd_mv(int argc, const char **argv, 
 		if (lstat(source[i], &st) < 0)
 			bad = "bad source";
 
+		if (!bad &&
+		    (length = strlen(source[i])) >= 0 &&
+		    !strncmp(destination[i], source[i], length) &&
+		    (destination[i][length] == 0 || destination[i][length] == '/'))
+			bad = "can not move directory into itself";
+
 		if (S_ISDIR(st.st_mode)) {
 			const char *dir = source[i], *dest_dir = destination[i];
 			int first, last, len = strlen(dir);
@@ -204,12 +217,6 @@ int cmd_mv(int argc, const char **argv, 
 			}
 		}
 
-		if (!bad &&
-		    (length = strlen(source[i])) >= 0 &&
-		    !strncmp(destination[i], source[i], length) &&
-		    (destination[i][length] == 0 || destination[i][length] == '/'))
-			bad = "can not move directory into itself";
-
 		if (!bad && cache_name_pos(source[i], strlen(source[i])) < 0)
 			bad = "not under version control";
 
-- 
1.4.2.gf71ee
