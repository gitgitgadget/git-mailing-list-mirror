From: David Rientjes <rientjes@google.com>
Subject: [PATCH 20/28] makes fetch_pack void
Date: Mon, 14 Aug 2006 13:35:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141335050.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 14 22:36:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCjAI-00018y-7h
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 22:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964830AbWHNUf7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 16:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWHNUf7
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 16:35:59 -0400
Received: from smtp-out.google.com ([216.239.45.12]:33175 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S964830AbWHNUf6
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 16:35:58 -0400
Received: from zps77.corp.google.com (zps77.corp.google.com [172.25.146.77])
	by smtp-out.google.com with ESMTP id k7EKZiYW018653
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:47 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=lEEwlcngJ8VrWbDNTs29DCHKSNn0kY7oc/MsLKsvYIE15I6KfzqGAD3bm66pMYvVV
	49yHSdOxgXPLGuA1e3W9Q==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps77.corp.google.com with ESMTP id k7EKZg5X030965
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:42 -0700
Received: by localhost (Postfix, from userid 24081)
	id 5CEFF87D71; Mon, 14 Aug 2006 13:35:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 58C5F87D70
	for <git@vger.kernel.org>; Mon, 14 Aug 2006 13:35:42 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25401>

Makes fetch_pack void and cleans up function calls.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 fetch-pack.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b7824db..f187636 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -414,7 +414,7 @@ static int everything_local(struct ref *
 	return retval;
 }
 
-static int fetch_pack(int fd[2], int nr_match, char **match)
+static void fetch_pack(int fd[2], int nr_match, char **match)
 {
 	struct ref *ref;
 	unsigned char sha1[20];
@@ -460,12 +460,11 @@ static int fetch_pack(int fd[2], int nr_
 		       sha1_to_hex(ref->old_sha1), ref->name);
 		ref = ref->next;
 	}
-	return 0;
 }
 
 int main(int argc, char **argv)
 {
-	int i, ret, nr_heads;
+	int i, nr_heads;
 	char *dest = NULL, **heads;
 	int fd[2];
 	pid_t pid;
@@ -516,12 +515,12 @@ int main(int argc, char **argv)
 	pid = git_connect(fd, dest, exec);
 	if (pid < 0)
 		return 1;
-	ret = fetch_pack(fd, nr_heads, heads);
+	fetch_pack(fd, nr_heads, heads);
 	close(fd[0]);
 	close(fd[1]);
 	finish_connect(pid);
 
-	if (!ret && nr_heads) {
+	if (nr_heads) {
 		/* If the heads to pull were given, we should have
 		 * consumed all of them by matching the remote.
 		 * Otherwise, 'git-fetch remote no-such-ref' would
@@ -530,9 +529,9 @@ int main(int argc, char **argv)
 		for (i = 0; i < nr_heads; i++)
 			if (heads[i] && heads[i][0]) {
 				error("no such remote ref %s", heads[i]);
-				ret = 1;
+				return 1;
 			}
 	}
 
-	return ret;
+	return 0;
 }
-- 
1.4.2.g89bb-dirty
