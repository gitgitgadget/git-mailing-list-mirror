X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-clone --use-separate-remote the default
Date: Thu, 23 Nov 2006 22:36:49 -0800
Message-ID: <7vpsbde4fy.fsf@assigned-by-dhcp.cox.net>
References: <20061123225835.30071.99265.stgit@machine.or.cz>
	<7vejrtiwqd.fsf@assigned-by-dhcp.cox.net>
	<20061123234203.GN7201@pasky.or.cz>
	<7vlkm1hf57.fsf@assigned-by-dhcp.cox.net>
	<7vzmahe6qe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 06:37:05 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vzmahe6qe.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 23 Nov 2006 21:47:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32189>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnUgB-0007vQ-U4 for gcvg-git@gmane.org; Fri, 24 Nov
 2006 07:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934446AbWKXGgv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 01:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934447AbWKXGgv
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 01:36:51 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:18602 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S934446AbWKXGgu
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 01:36:50 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124063649.JGFZ20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 01:36:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qWcx1V00y1kojtg0000000; Fri, 24 Nov 2006
 01:36:57 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> However, this simple command fails:
>
> 	$ git push $URL master
>
> if the target repository $URL is made with use-separate-remote.
>
> This is because 'master' matches more than one on the remote
> side (heads/master and remotes/origin/master) which triggers
> "Hey, that's ambiguous, make yourself clear which one you mean!"
> check.  This breaks t5400 test.  We could "fix" the test to make
> it more explicit, but that is just a workaround.
>
> I think the send-pack/receive-pack pair needs to be taught that
> an unadorned branch name 'master' never matches anything under
> refs/remotes. This means that it would require an explicit
> refspec heads/master:remotes/origin/master in order to pudate
> refs under refs/remotes on the remote side with a push.
> ...
> The function to fix is connect.c::match_explicit_refs() and I
> _think_ making connect.c::count_refspec_match() not to consider
> 'foo' to match 'refs/remotes/origin/foo' (but still keeping it
> to match 'refs/heads/foo' or 'refs/tags/foo') is enough to make
> this happen.

That is,...

-- >8 --
[PATCH] refs outside refs/{heads,tags} match less strongly.

This changes the refname matching logic used to decide which ref
is updated with git-send-pack.  We used to error out when
pushing 'master' when the other end has both 'master' branch and
a tracking branch 'remotes/$name/master' but with this, 'master'
matches only 'refs/heads/master' when both and no other 'master'
exist.

Pushing 'foo' when both heads/foo and tags/foo exist at the
remote end is still considered an error and you would need to
disambiguate between them by being more explicit.

When neither heads/foo nor tags/foo exists at the remote,
pushing 'foo' when there is only remotes/origin/foo is not
ambiguous, while it still is ambiguous when there are more than
one such weaker match (remotes/origin/foo and remotes/alt/foo,
for example).

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

diff --git a/connect.c b/connect.c
index c55a20a..b9666cc 100644
--- a/connect.c
+++ b/connect.c
@@ -174,21 +174,58 @@ static int count_refspec_match(const cha
 			       struct ref *refs,
 			       struct ref **matched_ref)
 {
-	int match;
 	int patlen = strlen(pattern);
+	struct ref *matched_weak = NULL;
+	struct ref *matched = NULL;
+	int weak_match = 0;
+	int match = 0;
 
-	for (match = 0; refs; refs = refs->next) {
+	for (weak_match = match = 0; refs; refs = refs->next) {
 		char *name = refs->name;
 		int namelen = strlen(name);
+		int weak_match;
+
 		if (namelen < patlen ||
 		    memcmp(name + namelen - patlen, pattern, patlen))
 			continue;
 		if (namelen != patlen && name[namelen - patlen - 1] != '/')
 			continue;
-		match++;
-		*matched_ref = refs;
+
+		/* A match is "weak" if it is with refs outside
+		 * heads or tags, and did not specify the pattern
+		 * in full (e.g. "refs/remotes/origin/master") or at
+		 * least from the toplevel (e.g. "remotes/origin/master");
+		 * otherwise "git push $URL master" would result in
+		 * ambiguity between remotes/origin/master and heads/master
+		 * at the remote site.
+		 */
+		if (namelen != patlen &&
+		    patlen != namelen - 5 &&
+		    strncmp(name, "refs/heads/", 11) &&
+		    strncmp(name, "refs/tags/", 10)) {
+			/* We want to catch the case where only weak
+			 * matches are found and there are multiple
+			 * matches, and where more than one strong
+			 * matches are found, as ambiguous.  One
+			 * strong match with zero or more weak matches
+			 * are acceptable as a unique match.
+			 */
+			matched_weak = refs;
+			weak_match++;
+		}
+		else {
+			matched = refs;
+			match++;
+		}
+	}
+	if (!matched) {
+		*matched_ref = matched_weak;
+		return weak_match;
+	}
+	else {
+		*matched_ref = matched;
+		return match;
 	}
-	return match;
 }
 
 static void link_dst_tail(struct ref *ref, struct ref ***tail)
