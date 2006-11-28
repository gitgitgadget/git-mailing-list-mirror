X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: can I remove or move a tag in a remote repository?
Date: Tue, 28 Nov 2006 13:46:04 -0800
Message-ID: <7virgz1bz7.fsf@assigned-by-dhcp.cox.net>
References: <87wt5rffbm.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 21:46:57 +0000 (UTC)
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87wt5rffbm.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sun, 19 Nov 2006 19:42:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32584>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAmf-0006HN-QZ for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:46:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757041AbWK1VqR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757049AbWK1VqQ
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:46:16 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:46762 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1757041AbWK1VqP
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:46:15 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061128214605.OIJK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Tue, 28
 Nov 2006 16:46:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id sMmD1V0091kojtg0000000; Tue, 28 Nov 2006
 16:46:13 -0500
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Jim Meyering <jim@meyering.net> writes:

> Here's the problem:
> When I try to push the new tags, git-push fails:
>
>   $ git-push -f --tags ssh+git://git.sv.gnu.org/srv/git/coreutils master:refs/heads/master
>   updating 'refs/tags/cvs-head'
>     from 2fd3fd29a8b40be695bc2327c8cd3bd33e521100
>     to   db18f53ffb221e9957124d8af81c11a7e350ac3b
>   ...
>   Total 1, written 1 (delta 0), reused 0 (delta 0)
>   Unpacking 1 objects
>   error: denying non-fast forward; you should pull first
>
> I get the same error also when using --force.

I think this is due to overeager receive.denyNonFastForwards
configuration setting at the repository you are pushing into.

I _think_ what receive-pack does in this case is totally wrong.
It should either:

 (1) deny overwriting existing tags -- tags are meant to be
     immutable so it should not allow them to be "updated"
     regardless of fast-forwardness, or

 (2) allow overwriting things under refs/tags/ without any
     fast-forward checking.  After all, a tag could point at a
     tree or a blob, and there is no fast-forwardness among
     trees.

The client side check in "git fetch" takes the latter viewpoint,
and I think we should be consistent with it.

Johannes, what do you think?  Does the following patch look sane
to you?

---

diff --git a/receive-pack.c b/receive-pack.c
index 1a141dc..6c3de47 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -120,7 +120,7 @@ static int update(struct command *cmd)
 			     "but I can't find it!", new_hex);
 	}
 	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
-	    !is_null_sha1(old_sha1)) {
+	    !is_null_sha1(old_sha1) && !strncmp(name, "refs/heads/", 11)) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
