From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: A note on merging conflicts..
Date: Sat, 1 Jul 2006 17:09:26 +0200
Message-ID: <20060701150926.GA25800@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> <7vy7vedntn.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 17:11:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fwh7m-0004tT-MC
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 17:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWGAPJj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 1 Jul 2006 11:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWGAPJj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Jul 2006 11:09:39 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:40406
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751837AbWGAPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jul 2006 11:09:27 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 6509D2400D; Sat,  1 Jul 2006 17:09:26 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2006 at 08:54:33PM -0700, Linus Torvalds wrote:
> Now, the expression
> 
> 	A...B == B...A == A B --not $(git-merge-base --all A B)
> 
> is meaningful (and the one I want for merges), but it's largely useless 
> for anything else. It just means "the set of all commits that aren't 
> trivially in both" (it's not strictly a valid set operation, but it
> approaches being an "xor" instead of a union or an intersection or a 
> difference).

You mean something like the following patch on top of the 'next' branch?
It also documents the --not switch because I needed it for the example.

TODO: There are still a few undocumented options left and setup_revisions()
is fat and ugly.  Any volunteers?  I'd clean it up if I only could
write comprehensible documentation and wasn't that lazy..

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index ad6d14c..ffbf0c9 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -15,6 +15,7 @@ SYNOPSIS
 	     [ \--sparse ]
 	     [ \--no-merges ]
 	     [ \--remove-empty ]
+	     [ \--not ]
 	     [ \--all ]
 	     [ \--topo-order ]
 	     [ \--parents ]
@@ -37,6 +38,14 @@ not in 'baz'".
 A special notation <commit1>..<commit2> can be used as a
 short-hand for {caret}<commit1> <commit2>.
 
+Another special notation is <commit1>...<commit2> which is useful for
+merges.  The resulting set of commits is the symmetric difference
+between the two operands.  The following two commands are equivalent:
+
+------------
+$ git-rev-list A B --not $(git-merge-base --all A B)
+$ git-rev-list A...B
+------------
 
 OPTIONS
 -------
@@ -93,6 +102,11 @@ OPTIONS
 --remove-empty::
 	Stop when a given path disappears from the tree.
 
+--not::
+	Reverses the meaning of the '{caret}' prefix (or lack
+	thereof) for all following revision specifiers, up to
+	the next `--not`.
+
 --all::
 	Pretend as if all the refs in `$GIT_DIR/refs/` are
 	listed on the command line as <commit>.
diff --git a/revision.c b/revision.c
index ae4ca82..d4224a1 100644
--- a/revision.c
+++ b/revision.c
@@ -766,6 +766,47 @@ int setup_revisions(int argc, const char
 			left++;
 			continue;
 		}
+		dotdot = strstr(arg, "...");
+		if (dotdot) {
+			unsigned char other_sha1[20];
+			const char *one = arg;
+			const char *two = dotdot + 3;
+			*dotdot = '\0';
+			if (dotdot == arg)
+				one = "HEAD";
+			if (!*two)
+				two = "HEAD";
+			if (!get_sha1(one, sha1) &&
+			    !get_sha1(two, other_sha1)) {
+				struct commit *a, *b;
+				struct commit_list *exclude;
+
+				a = lookup_commit_reference(sha1);
+				b = lookup_commit_reference(other_sha1);
+				if (!a || !b)
+					die("Invalid symmetric difference expression %s...%s", arg, two);
+
+				if (!seen_dashdash) {
+					*dotdot = '.';
+					verify_non_filename(revs->prefix, arg);
+
+				}
+				exclude = get_merge_bases(a, b);
+				while (exclude) {
+					struct object *object =
+						&exclude->item->object;
+					object->flags |= flags ^ UNINTERESTING;
+					add_pending_object(revs, object, sha1_to_hex(object->sha1));
+					exclude = exclude->next;
+				}
+				a->object.flags |= flags;
+				add_pending_object(revs, &a->object, one);
+				b->object.flags |= flags;
+				add_pending_object(revs, &b->object, two);
+				continue;
+			}
+			*dotdot = '.';
+		}
 		dotdot = strstr(arg, "..");
 		if (dotdot) {
 			unsigned char from_sha1[20];
