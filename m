From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix rev-list when showing objects involving submodules
Date: Mon, 12 Nov 2007 12:43:57 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711121231570.3062@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711112335020.4362@racer.site> <4738AF60.90207@vilain.net> <Pine.LNX.4.64.0711122020270.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:44:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irg96-0004Qf-7v
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:44:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752193AbXKLUoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbXKLUoV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:44:21 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35468 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752129AbXKLUoU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 15:44:20 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKhxc6024058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 12:44:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lACKhwJa008046;
	Mon, 12 Nov 2007 12:43:58 -0800
In-Reply-To: <Pine.LNX.4.64.0711122020270.4362@racer.site>
X-Spam-Status: No, hits=-4.734 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64702>



On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> 
> You mean something like
> 
> 		else if (S_ISREG(entry.mod) || S_ISLNK(entry.mod))
> 
> Hmm?  Sure, I have no preference there.

Maybe more along the line of something like this?

In general, I suspect we should try to start moving away from using the 
"S_ISLNK()" like things for internal git state. It was a mistake to just 
assume the numbers all were same across all systems in the first place.

So this just converts to the "object_type", and then uses a case 
statement.

		Linus

---
 builtin-pack-objects.c |    2 +-
 revision.c             |   11 +++++++++--
 tree-walk.h            |    7 +++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 545ece5..4f44658 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -990,7 +990,7 @@ static void add_pbase_object(struct tree_desc *tree,
 			return;
 		if (name[cmplen] != '/') {
 			add_object_entry(entry.sha1,
-					 S_ISDIR(entry.mode) ? OBJ_TREE : OBJ_BLOB,
+					 object_type(entry.mode),
 					 fullname, 1);
 			return;
 		}
diff --git a/revision.c b/revision.c
index 931f978..c054a82 100644
--- a/revision.c
+++ b/revision.c
@@ -67,10 +67,17 @@ void mark_tree_uninteresting(struct tree *tree)
 
 	init_tree_desc(&desc, tree->buffer, tree->size);
 	while (tree_entry(&desc, &entry)) {
-		if (S_ISDIR(entry.mode))
+		switch (object_type(entry.mode)) {
+		case OBJ_TREE:
 			mark_tree_uninteresting(lookup_tree(entry.sha1));
-		else
+			break;
+		case OBJ_BLOB:
 			mark_blob_uninteresting(lookup_blob(entry.sha1));
+			break;
+		default:
+			/* Subproject commit - not in this repository */
+			break;
+		}
 	}
 
 	/*
diff --git a/tree-walk.h b/tree-walk.h
index db0fbdc..903a7b0 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -7,6 +7,13 @@ struct name_entry {
 	unsigned int mode;
 };
 
+static inline enum object_type object_type(unsigned int mode)
+{
+	return S_ISDIR(mode) ? OBJ_TREE :
+		S_ISGITLINK(mode) ? OBJ_COMMIT :
+		OBJ_BLOB;
+}
+
 struct tree_desc {
 	const void *buffer;
 	struct name_entry entry;
