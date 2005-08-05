From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tree tags again..
Date: Thu, 04 Aug 2005 17:17:55 -0700
Message-ID: <7vu0i5qlsc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508041702180.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 05 02:18:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0puU-00080X-W2
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 02:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVHEAR6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Aug 2005 20:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVHEAR6
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Aug 2005 20:17:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:7378 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262793AbVHEAR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2005 20:17:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050805001754.CPAI3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 Aug 2005 20:17:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508041702180.3258@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 4 Aug 2005 17:03:17 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, maybe there should be some test-case for this:
>
> 	error: Object 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is a tree, not a commit
> 	error: remote ref 'refs/tags/v2.6.11' is not a strict subset of local ref 'refs/tags/v2.6.11'.

I assume this is syncing two linux-2.6 repo which both have the
same refs/tags/v2.6.11 (tree tag).

Sorry, in send_pack(), up-to-date check should be made first
before ref_newer() check.  My mistake.

A more interesting question is what to do if they are indeed
different trees.  More realistically, you may decide to
retroactively create a commit that wraps the same v2.6.11 tree,
perhaps grafting it in front of the current 2.6.12-rcX based
history, and replace 'refs/tags/v2.6.11' with a tag to that
commit.  What should happen?

I do not have a good answer to that.  From the end-user point of
view, we _could_ treat tags differently from heads in that we
always omit the ref_newer() check, but from the machinery point
of view, I think the plumbing should just ask the user to use
the --force when such a tag is involved.

------------
diff --git a/send-pack.c b/send-pack.c
--- a/send-pack.c
+++ b/send-pack.c
@@ -173,6 +173,10 @@ static int send_pack(int in, int out, in
 		char old_hex[60], *new_hex;
 		if (!ref->peer_ref)
 			continue;
+		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
+			fprintf(stderr, "'%s': up-to-date\n", ref->name);
+			continue;
+		}
 		if (!is_zero_sha1(ref->old_sha1)) {
 			if (!has_sha1_file(ref->old_sha1)) {
 				error("remote '%s' object %s does not "
@@ -188,10 +192,6 @@ static int send_pack(int in, int out, in
 				continue;
 			}
 		}
-		if (!memcmp(ref->old_sha1, ref->peer_ref->new_sha1, 20)) {
-			fprintf(stderr, "'%s': up-to-date\n", ref->name);
-			continue;
-		}
 		memcpy(ref->new_sha1, ref->peer_ref->new_sha1, 20);
 		if (is_zero_sha1(ref->new_sha1)) {
 			error("cannot happen anymore");
