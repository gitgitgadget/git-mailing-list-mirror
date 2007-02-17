From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a
 certain blob
Date: Sun, 18 Feb 2007 00:52:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702180049210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vr6sotzft.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:52:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZLn-0007Zd-HH
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:52:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbXBQXwQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965407AbXBQXwQ
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:52:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:43982 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965389AbXBQXwP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:52:15 -0500
Received: (qmail invoked by alias); 17 Feb 2007 23:52:14 -0000
X-Provags-ID: V01U2FsdGVkX190hSA9ZWl0MQTJAB7583X/h7slEnXfe1oeqdbQpx
	5t2Q==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vr6sotzft.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40029>

Hi,

On Sat, 17 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > If you want to know which revisions contained a certain version
> > of a file, just say
> >
> > 	git name-rev --file <filename>
> >
> > which will read the file, and give you a list of revisions
> > containing a file with the same contents. If <filename> is "-",
> > it will read the contents from stdin. Of course, this is a really
> > expensive operation.
> 
> I expected this to take arbitrary object name and let the caller
> to do 'hash-object', so that you could also find a certain tree,
> not just blob.

That was easier than I feared. Here's a patch on top of 2/2:

--
[PATCH] name-rev --file: also accept SHA1 of blobs and trees

This allows you to say

	git name-rev --file master:t/

to see in which revisions the whole directory "t" is identical to what it 
is in "master".

The first hunk is a bugfix for a potential segv.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-name-rev.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index f08b065..e4addc7 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -43,7 +43,7 @@ struct object_name {
 static struct object_name *name_file(struct tree *tree)
 {
 	static struct object_name null_name = { 0, NULL };
-	struct object_name *name;
+	struct object_name *name = NULL;
 	struct tree_desc desc;
 	struct name_entry entry;
 
@@ -141,7 +141,8 @@ copy_data:
 		return;
 
 	if (file_sha1 && !(commit->object.flags & CONTAINS_FILE) &&
-			(file_name = name_file(commit->tree))) {
+			((file_name = name_file(commit->tree)) ||
+			 !hashcmp(commit->tree->object.sha1, file_sha1))) {
 		commit->object.flags |= CONTAINS_FILE;
 		add_object_array(&commit->object, NULL, &file_commits);
 	}
@@ -270,7 +271,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			} else if (!strcmp(*argv, "--file")) {
 				if (argc != 2)
 					usage(name_rev_usage);
-				if (get_file(argv[1]))
+				if (get_file(argv[1]) &&
+						get_sha1(argv[1], file_sha1))
 					die("Could not read '%s'", argv[1]);
 				cutoff = 0;
 				argc = 1;
@@ -313,7 +315,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 			printf("%s", rev_name->tip_name);
 			if (rev_name->generation)
 				printf("^%d", rev_name->generation);
-			printf(":%s\n", obj_name->name);
+			printf(":%s\n", obj_name ? obj_name->name : "");
 		}
 		return 0;
 	}
-- 
1.5.0.2139.gdafc9-dirty
