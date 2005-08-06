From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] send-pack: allow generic sha1 expression on the source side.
Date: Sat, 06 Aug 2005 10:24:35 -0700
Message-ID: <7vek979dws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat Aug 06 19:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1SPi-0005oq-3u
	for gcvg-git@gmane.org; Sat, 06 Aug 2005 19:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbVHFRYi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Aug 2005 13:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263293AbVHFRYh
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Aug 2005 13:24:37 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:40353 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263291AbVHFRYh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2005 13:24:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050806172437.RGBS1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 6 Aug 2005 13:24:37 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

As promised earlier.  I will shortly push this out with another
send-pack fix, initially in the proposed updates branch.

------------
This extends the source side semantics to match what Linus
suggested.

An example:

    $ git-send-pack kernel.org:/pub/scm/git/git.git pu^^:master pu

    would allow me to push the current pu into pu, and the
    commit two commits before it into master, on my public
    repository.

The revised rule for updating remote heads is as follows.

 $ git-send-pack [--all] <remote> [<ref>...]

 - When no <ref> is specified:

   - with '--all', it is the same as specifying the full refs/*
     path for all local refs;

   - without '--all', it is the same as specifying the full
     refs/* path for refs that exist on both ends;

 - When one or more <ref>s are specified:

   - a single token <ref> (i.e. no colon) must be a pattern that
     tail-matches refs/* path for an existing local ref.  It is
     an error for the pattern to match no local ref, or more
     than one local refs.  The matching ref is pushed to the
     remote end under the same name.

   - <src>:<dst> can have different cases.  <src> is first tried
     as the tail-matching pattern for refs/* path.

     - If more than one matches are found, it is an error.

     - If one match is found, <dst> must either match no remote
       ref and start with "refs/", or match exactly one remote
       ref.  That remote ref is updated with the sha1 value
       obtained from the <src> sha1.

     - If no match is found, it is given to get_extended_sha1();
       it is an error if get_extended_sha1() does not find an
       object name.  If it succeeds, <dst> must either match
       no remote ref and start with "refs/" or match exactly
       one remote ref.  That remote ref is updated with the sha1
       value.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 connect.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

15e02b372ddebd2aac829707786462798f91d509
diff --git a/connect.c b/connect.c
--- a/connect.c
+++ b/connect.c
@@ -133,6 +133,20 @@ static void link_dst_tail(struct ref *re
 	**tail = NULL;
 }
 
+static struct ref *try_explicit_object_name(const char *name)
+{
+	unsigned char sha1[20];
+	struct ref *ref;
+	int len;
+	if (get_sha1(name, sha1))
+		return NULL;
+	len = strlen(name) + 1;
+	ref = xcalloc(1, sizeof(*ref) + len);
+	memcpy(ref->name, name, len);
+	memcpy(ref->new_sha1, sha1, 20);
+	return ref;
+}
+
 static int match_explicit_refs(struct ref *src, struct ref *dst,
 			       struct ref ***dst_tail, struct refspec *rs)
 {
@@ -145,6 +159,12 @@ static int match_explicit_refs(struct re
 		case 1:
 			break;
 		case 0:
+			/* The source could be in the get_sha1() format
+			 * not a reference name.
+			 */
+			matched_src = try_explicit_object_name(rs[i].src);
+			if (matched_src)
+				break;
 			errs = 1;
 			error("src refspec %s does not match any.");
 			break;
