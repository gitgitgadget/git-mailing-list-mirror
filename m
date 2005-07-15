From: ebiederm@xmission.com (Eric W. Biederman)
Subject: [PATCH 6/6] Update tags to record who made them
Date: Thu, 14 Jul 2005 19:02:10 -0600
Message-ID: <m17jfsyj8t.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 03:03:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtEbE-0002yO-4J
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 03:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVGOBCe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 21:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVGOBCe
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 21:02:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22205 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261742AbVGOBCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 21:02:30 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j6F12BU1020957;
	Thu, 14 Jul 2005 19:02:11 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j6F12A0G020956;
	Thu, 14 Jul 2005 19:02:10 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


And finally what all of this has been leading up to.
The 2 line code change to record who made a tag,
and the 8 line code change to check that we recorded
the tag.

Gosh the error checking is always so much bigger than the code :)

---

 git-tag-script |    3 ++-
 mktag.c        |   10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

6ba7a00f34b28cf6761b517a2ad377c80780186b
diff --git a/git-tag-script b/git-tag-script
--- a/git-tag-script
+++ b/git-tag-script
@@ -7,6 +7,7 @@ name="$1"
 
 object=${2:-$(cat "$GIT_DIR"/HEAD)}
 type=$(git-cat-file -t $object) || exit 1
+tagger=$(git-var GIT_COMMITTER_IDENT) || exit 1
 
 ( echo "#"
   echo "# Write a tag message"
@@ -17,7 +18,7 @@ grep -v '^#' < .editmsg | git-stripspace
 
 [ -s .tagmsg ] || exit
 
-( echo -e "object $object\ntype $type\ntag $name\n"; cat .tagmsg ) > .tmp-tag
+( echo -e "object $object\ntype $type\ntag $name\ntagger $tagger\n"; cat .tagmsg ) > .tmp-tag
 rm -f .tmp-tag.asc .tagmsg
 gpg -bsa .tmp-tag && cat .tmp-tag.asc >> .tmp-tag
 mkdir -p "$GIT_DIR/refs/tags"
diff --git a/mktag.c b/mktag.c
--- a/mktag.c
+++ b/mktag.c
@@ -42,7 +42,7 @@ static int verify_tag(char *buffer, unsi
 	int typelen;
 	char type[20];
 	unsigned char sha1[20];
-	const char *object, *type_line, *tag_line;
+	const char *object, *type_line, *tag_line, *tagger_line;
 
 	if (size < 64 || size > MAXSIZE-1)
 		return -1;
@@ -92,6 +92,12 @@ static int verify_tag(char *buffer, unsi
 		return -1;
 	}
 
+	/* Verify the tagger line */
+	tagger_line = tag_line;
+
+	if (memcmp(tagger_line, "tagger", 6) || (tagger_line[6] == '\n'))
+		return -1;
+
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
 }
@@ -119,7 +125,7 @@ int main(int argc, char **argv)
 		size += ret;
 	}
 
-	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype "
+	// Verify it for some basic sanity: it needs to start with "object <sha1>\ntype\ntagger "
 	if (verify_tag(buffer, size) < 0)
 		die("invalid tag signature file");
 
