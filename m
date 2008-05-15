From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Add support for GIT_CEILING_DIRS
Date: Thu, 15 May 2008 10:38:52 +0200
Message-ID: <482BF69C.6020604@viscovery.net>
References: <482B935D.20105@facebook.com> <482BE0EB.6040306@viscovery.net> <482BE238.5020309@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Reiss <dreiss@facebook.com>
X-From: git-owner@vger.kernel.org Thu May 15 10:39:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZ06-0005la-R2
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 10:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753149AbYEOIi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 04:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753268AbYEOIi5
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 04:38:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:6638 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753063AbYEOIi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 04:38:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JwYzF-0004WJ-04; Thu, 15 May 2008 10:38:53 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id BDCE7546; Thu, 15 May 2008 10:38:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <482BE238.5020309@facebook.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82188>

David Reiss schrieb:
>> If you make it so that the default value of ceil_offset is 0 (i.e. in the
>> absence of any GIT_CEILING_DIRS),
> This is what the new version of the patch does.
> 
>> and at this place you did
>>
>>                 } while (offset > ceil_offset && cwd[--offset] != '/');
>>
>> you wouldn't have to bend backwards with this off-by-one magic, would you?
> It seems like that would cause it to continue on with the outer loop, rather
> than aborting (which is what the current version does) when you hit the ceiling.
> Or maybe I'm misunderstanding something.

Ok, I see. I'm proposing that the meaning of ceil_offset should be "do not look
at this many characters at the beginning of cwd". And we always have
cwd[ceil_offset] == '/'. Something like this on top of your patch.
Further tweaking will be necessary (I'm just illustrating my point),
in particular you could name it min_offset again.

-- Hannes

diff --git a/setup.c b/setup.c
index de9e7f1..5dbc080 100644
--- a/setup.c
+++ b/setup.c
@@ -368,13 +368,13 @@ const char *read_gitfile_gently(const char *path)
 static int longest_ancestor_length(const char *path, const char *prefix_list)
 {
 	const char *ceil, *colon;
-	int max_len = -1;
+	int max_len = 0;

 	if (prefix_list == NULL)
-		return -1;
-	/* "/" is a tricky edge case.  It should always return -1, though. */
+		return 0;
+	/* "/" is a tricky edge case.  It should always return 0, though. */
 	if (!strcmp(path, "/"))
-		return -1;
+		return 0;

 	ceil = prefix_list;
 	for (;;) {
@@ -522,7 +522,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 	 * Putting it so far to the right is necessary in order to bail out of the
 	 * "--offset" loop early enough.
 	 */
-	ceil_offset = 1 + longest_ancestor_length(cwd, env_ceiling_dirs);
+	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);

 	/*
 	 * Test in the following order (relative to the cwd):
@@ -553,17 +553,16 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		do {
-			if (offset <= ceil_offset) {
-				if (nongit_ok) {
-					if (chdir(cwd))
-						die("Cannot come back to cwd");
-					*nongit_ok = 1;
-					return NULL;
-				}
-				die("Not a git repository");
+		do { } while (offset > ceil_offset && cwd[--offset] != '/');
+		if (offset <= ceil_offset) {
+			if (nongit_ok) {
+				if (chdir(cwd))
+					die("Cannot come back to cwd");
+				*nongit_ok = 1;
+				return NULL;
 			}
-		} while (cwd[--offset] != '/');
+			die("Not a git repository");
+		}
 		chdir("..");
 	}
