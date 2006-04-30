From: sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] git builtin "push"
Date: Sun, 30 Apr 2006 05:40:49 -0400
Message-ID: <BAYC1-PASMTP011ED54A1802BC6DF017AAAEB00@CEZ.ICE>
References: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 30 11:45:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fa8Uc-0004qL-6Q
	for gcvg-git@gmane.org; Sun, 30 Apr 2006 11:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWD3Jp1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 05:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWD3Jp1
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 05:45:27 -0400
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:54462 "EHLO
	BAYC1-PASMTP01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751084AbWD3Jp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 05:45:26 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 30 Apr 2006 02:45:26 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id B2F6C644C28;
	Sun, 30 Apr 2006 05:45:24 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060430054049.7856f24c.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0604292111570.9901@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 30 Apr 2006 09:45:26.0596 (UTC) FILETIME=[CF26B040:01C66C3A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 29 Apr 2006 21:22:49 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> Comments?  I wrote it so that it _should_ be fairly easy to re-use at 
> least the branches/remotes helper functions for a built-in "git fetch" as 
> well. But I didn't have the multi-URI issue with anything but pushing.


> +	if (strncmp(ref, "tags/", 5))
> +		return 0;
[...]
> +	for_each_ref(expand_one_ref);

How about a for_each_tag() function?


> +	int i, n = get_uri(repo, uri);
[...]
> +	n = get_uri(repo, uri);
> +	if (n <= 0)
> +		die("bad repository '%s'", repo);

get_uri() called twice.


The patch looks good and is easy to read, but wouldn't it be better
to require new c code to be thread safe and not leak memory?  Assuming
run-once-and-exit is making it difficult to push into a library.

Sean

builtin-push.c |   11 +++--------
refs.c         |    5 +++++
refs.h         |    1 +
3 files changed, 9 insertions(+), 8 deletions(-)

0e0e3cff71d65ac4cdc560ae143aded03acb4ceb
diff --git a/builtin-push.c b/builtin-push.c
index a0c1caa..0d74ed1 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -31,10 +31,6 @@ static int expand_one_ref(const char *re
 {
 	/* Ignore the "refs/" at the beginning of the refname */
 	ref += 5;
-
-	if (strncmp(ref, "tags/", 5))
-		return 0;
-
 	add_refspec(strdup(ref));
 	return 0;
 }
@@ -51,9 +47,8 @@ static void expand_refspecs(void)
 		 */
 		return;
 	}
-	if (!tags)
-		return;
-	for_each_ref(expand_one_ref);
+	if (tags)
+		for_each_tag(expand_one_ref);
 }
 
 static void set_refspecs(const char **refs, int nr)
@@ -156,7 +151,7 @@ static int get_uri(const char *repo, con
 static int do_push(const char *repo)
 {
 	const char *uri[MAX_URI];
-	int i, n = get_uri(repo, uri);
+	int i, n;
 	int remote;
 	const char **argv;
 	int argc;
diff --git a/refs.c b/refs.c
index 03398cc..c5a2dd0 100644
--- a/refs.c
+++ b/refs.c
@@ -178,6 +178,11 @@ int head_ref(int (*fn)(const char *path,
 	return 0;
 }
 
+int for_each_tag(int (*fn)(const char *path, const unsigned char *sha1))
+{
+	return do_for_each_ref("refs/tags", fn);
+}
+
 int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1))
 {
 	return do_for_each_ref("refs", fn);
diff --git a/refs.h b/refs.h
index 2625596..b74cd4d 100644
--- a/refs.h
+++ b/refs.h
@@ -7,6 +7,7 @@ #define REFS_H
  */
 extern int head_ref(int (*fn)(const char *path, const unsigned char *sha1));
 extern int for_each_ref(int (*fn)(const char *path, const unsigned char *sha1));
+extern int for_each_tag(int (*fn)(const char *path, const unsigned char *sha1));
 
 /** Reads the refs file specified into sha1 **/
 extern int get_ref_sha1(const char *ref, unsigned char *sha1);
-- 
1.3.1.g9c203
