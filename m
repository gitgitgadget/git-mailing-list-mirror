From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: make --dense the default (and introduce "--sparse")
Date: Wed, 26 Oct 2005 08:18:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510260757350.10477@g5.osdl.org>
References: <Pine.LNX.4.64.0510251459070.10477@g5.osdl.org>
 <Pine.LNX.4.64.0510251525540.10477@g5.osdl.org> <7vwtk08wnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 17:26:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUn32-0007T0-UT
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 17:18:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbVJZPSV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 11:18:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbVJZPSU
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 11:18:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964783AbVJZPSU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2005 11:18:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9QFIEFC030465
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 26 Oct 2005 08:18:15 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9QFID04031993;
	Wed, 26 Oct 2005 08:18:14 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtk08wnx.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10672>



On Wed, 26 Oct 2005, Junio C Hamano wrote:
> 
> I have not looked closely into what exactly, but the fourth
> thing this does might be to break git-send-pack.

Ack. And I see why.

What happens is that the new logic decides that if it can't look up a 
commit reference (ie "get_commit_reference()" returns NULL), the thing 
must be a pathname.

Fair enough.

But wrong.

The thing is, it may be a perfectly fine ref that _isn't_ a commit. In 
git, you have a tag that points to your PGP key, and in the kernel, I have 
a tag that points to a tree (and a direct ref that points to that tree 
too, for that matter). 

So the rule is (as for all the other programs that mix revs and pathnames) 
not that we only accept commit references, but _any_ valid object ref.

If the object then isn't a commit ref, git-rev-list will either ignore it, 
or add it to the list of non-commit objects (if using "--objects").

The solution is to move the "get_sha1()" out of get_commit_reference(), 
and into the callers. In fact, we already _have_ the SHA1 in the case of 
the handle_all() loop, since for_each_ref() will have done it for us, so 
this is the correct thing to do anyway. 

This patch (on top of the original one) does exactly that.

		Linus

----
diff --git a/rev-list.c b/rev-list.c
index ac7a47f..2b82b8a 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -613,13 +613,10 @@ static void add_pending_object(struct ob
 	add_object(obj, &pending_objects, name);
 }
 
-static struct commit *get_commit_reference(const char *name, unsigned int flags)
+static struct commit *get_commit_reference(const char *name, const unsigned char *sha1, unsigned int flags)
 {
-	unsigned char sha1[20];
 	struct object *object;
 
-	if (get_sha1(name, sha1))
-		return NULL;
 	object = parse_object(sha1);
 	if (!object)
 		die("bad object %s", name);
@@ -697,7 +694,7 @@ static struct commit_list **global_lst;
 
 static int include_one_commit(const char *path, const unsigned char *sha1)
 {
-	struct commit *com = get_commit_reference(path, 0);
+	struct commit *com = get_commit_reference(path, sha1, 0);
 	handle_one_commit(com, global_lst);
 	return 0;
 }
@@ -720,6 +717,7 @@ int main(int argc, const char **argv)
 		const char *arg = argv[i];
 		char *dotdot;
 		struct commit *commit;
+		unsigned char sha1[20];
 
 		if (!strncmp(arg, "--max-count=", 12)) {
 			max_count = atoi(arg + 12);
@@ -808,15 +806,19 @@ int main(int argc, const char **argv)
 		flags = 0;
 		dotdot = strstr(arg, "..");
 		if (dotdot) {
+			unsigned char from_sha1[20];
 			char *next = dotdot + 2;
-			struct commit *exclude = NULL;
-			struct commit *include = NULL;
 			*dotdot = 0;
 			if (!*next)
 				next = "HEAD";
-			exclude = get_commit_reference(arg, UNINTERESTING);
-			include = get_commit_reference(next, 0);
-			if (exclude && include) {
+			if (!get_sha1(arg, from_sha1) && !get_sha1(next, sha1)) {
+				struct commit *exclude;
+				struct commit *include;
+				
+				exclude = get_commit_reference(arg, from_sha1, UNINTERESTING);
+				include = get_commit_reference(next, sha1, 0);
+				if (!exclude || !include)
+					die("Invalid revision range %s..%s", arg, next);
 				limited = 1;
 				handle_one_commit(exclude, &list);
 				handle_one_commit(include, &list);
@@ -829,9 +831,9 @@ int main(int argc, const char **argv)
 			arg++;
 			limited = 1;
 		}
-		commit = get_commit_reference(arg, flags);
-		if (!commit)
+		if (get_sha1(arg, sha1) < 0)
 			break;
+		commit = get_commit_reference(arg, sha1, flags);
 		handle_one_commit(commit, &list);
 	}
 
