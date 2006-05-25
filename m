From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 24 May 2006 21:48:34 -0700
Message-ID: <7vd5e21zh9.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	<7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
	<7vd5e23n5a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 06:48:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj7m3-0007Cf-Rr
	for gcvg-git@gmane.org; Thu, 25 May 2006 06:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWEYEsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 00:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWEYEsg
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 00:48:36 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:36234 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965027AbWEYEsg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 00:48:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525044835.HDVH9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 00:48:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vd5e23n5a.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 24 May 2006 18:32:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20724>

Junio C Hamano <junkio@cox.net> writes:

> It might be worth changing fetch-pack to note that it has sent
> many "have"s after it got an "continue" ACK, and give up early,
> say using a heuristic between the age of the commit that did got
> an ACK and the one we are about to send out as a "have".

I think the right fix for this is to change upload-pack to
traverse reachability chain from the "want" heads as it gets
"have" from the downloader, and stop responding "continue" when
all "want" heads can reach some "have" commits.  This would not
prevent it from going down all the way to the root commit if
what is wanted does not have anything to do with what the other
end has (e.g. if you have only my main project branches, and you
ask for html head for the first time), but it would have
prevented Ralf's tree from getting "continue" after he asked
only for v2.6.16.18 tag and said he has 2.6.16.18 commit and its
ancestors.  It should not be too difficult to do this, but here
is an alternative, client-side workaround.

-- >8 --
[PATCH] fetch-pack: give up after getting too many "ack continue"

If your repository have more roots than the remote repository
you ask an object for, the remote upload-pack keeps responding
"ack continue" until it fills up its received-have buffer
(currently 256 entries).  Usually this is not a problem because
the requester stops traversing the ancestry chain from the commit
it gets "ack continue" for, but this mechanism does not work as
a roadblock when it traverses down the path to the root the
other side does not have.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/fetch-pack.c b/fetch-pack.c
index 8daa93d..8371348 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -18,6 +18,12 @@ #define COMMON_REF	(1U << 2)
 #define SEEN		(1U << 3)
 #define POPPED		(1U << 4)
 
+/*
+ * After sending this many "have"s if we do not get any new ACK , we
+ * give up traversing our history.
+ */
+#define MAX_IN_VAIN 256
+
 static struct commit_list *rev_list = NULL;
 static int non_common_revs = 0, multi_ack = 0, use_thin_pack = 0;
 
@@ -134,6 +140,8 @@ static int find_common(int fd[2], unsign
 	int fetching;
 	int count = 0, flushes = 0, retval;
 	const unsigned char *sha1;
+	unsigned in_vain = 0;
+	int got_continue = 0;
 
 	for_each_ref(rev_list_insert_ref);
 
@@ -172,6 +180,7 @@ static int find_common(int fd[2], unsign
 		packet_write(fd[1], "have %s\n", sha1_to_hex(sha1));
 		if (verbose)
 			fprintf(stderr, "have %s\n", sha1_to_hex(sha1));
+		in_vain++;
 		if (!(31 & ++count)) {
 			int ack;
 
@@ -200,9 +209,16 @@ static int find_common(int fd[2], unsign
 						lookup_commit(result_sha1);
 					mark_common(commit, 0, 1);
 					retval = 0;
+					in_vain = 0;
+					got_continue = 1;
 				}
 			} while (ack);
 			flushes--;
+			if (got_continue && MAX_IN_VAIN < in_vain) {
+				if (verbose)
+					fprintf(stderr, "giving up\n");
+				break; /* give up */
+			}
 		}
 	}
 done:
