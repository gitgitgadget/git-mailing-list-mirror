From: Junio C Hamano <junkio@cox.net>
Subject: Re: Slow fetches of tags
Date: Wed, 26 Jul 2006 16:27:48 -0700
Message-ID: <7v4px4osjv.fsf@assigned-by-dhcp.cox.net>
References: <20060524131022.GA11449@linux-mips.org>
	<Pine.LNX.4.64.0605240931480.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605240947580.5623@g5.osdl.org>
	<7v64jv8fdx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605241200110.5623@g5.osdl.org>
	<Pine.LNX.4.64.0605241641250.5623@g5.osdl.org>
	<20060525131241.GA8443@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jul 27 01:27:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5snC-0003eB-Qq
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 01:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbWGZX1v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Jul 2006 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWGZX1v
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Jul 2006 19:27:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:63408 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751800AbWGZX1v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jul 2006 19:27:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060726232750.UIYV6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Jul 2006 19:27:50 -0400
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24261>

Ralf Baechle <ralf@linux-mips.org> writes:

> On Wed, May 24, 2006 at 04:43:02PM -0700, Linus Torvalds wrote:
>
>> Actually, maybe the problem is that Ralf's tree has two roots, because of 
>> the old CVS history. It might be following the other root down for the 
>> "have" part, since that one doesn't exist at all in the target and the 
>> other side will never acknowledge any of it. 
>> 
>> I'll play with it.
>
> Interesting idea, so I went to play with it, too.  I took a copy of the
> tree and deleted all branches except the v2.6.16-stable tracking branch
> which I pruned back to v2.6.16.17, then added a new branch starting at
> the oldest commit, your initial import of the kernel tree:

I've been looking at this issue again...

> $ git branch junk 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
> $ git checkout junk
> $ seq -f "%05.0f" 1 100 | while read i; do echo $i; echo $i > Makefile;\
>   git commit -s -m "Blah $i" Makefile; done
>
> So with this I get:
>
> $ git branch
> * junk
>   v2.6.16-stable
> $
>
> If I now run
>
> $ strace git-fetch-pack --thin git://www.kernel.org/pub/scm/linux/kernel/\
> 	git/stable/linux-2.6.16.y.git \
> 	refs/heads/master refs/tags/v2.6.16.18 2>&1 | grep have /tmp/xxx
>
> I get:

... 100 newest commits from the junk branch and then all the
    tags the downloader has are sent as "have"s.

Now, sending the newest commits before sending the tags is
unavoidable, since the other end does not know where you forked
at (the purpose of the handshake is to find out where to begin
with).  But as soon as you send v2.6.16.17 (the latest tag that
you have in common with the other side, _and_ is a proper
ancestor of what you want -- v2.6.16.18 but that fact you do not
know yet), the server end should be able to say "ok, we know
enough".  That is not happening.

A few hints for debugging this:

 * local test is easier -- fetch-pack spawns upload-pack using
   PATH and GIT_EXEC_PATH so set them to point at the updated
   upload-pack being tested.

 * Passing the standard error from "fetch-pack -v" to "name-rev
   --stdin" makes it a bit more pleasant to see what is going on.

With the attached patch, the server side tells the client to
stop immediately after it says it has the commit tagged as
v2.6.16.17 while asking for v2.6.16.18.  With your "100 commits
on junk" repository, it does not make much of a difference,
though.  The reasons are (1) the 100 commits on "junk" are much
younger than any of the tags, so they are sent anyway, (2) we
have a 32-commit window, and keep one window in flight to make
the protocol stream, which means there will be max 64 "have"
that are in flight unacked, and a clone of linux-2.6.16.y
repository that has up to v2.6.16.17 tag has only 52 tags.

So we end up sending all the tags anyway in this particular
case.

I've thought about sending tags and only _tips_ of branches
first, but I think that would have a grave performance impact on
more normal cases.  If you are dealing with a remote repository
with a bunch of tags, your "master" is ahead of the remote
repository, and you do not use tracking branch to track the
remote (pretend you are Linus and pulling from a subsystem
maintainer), then you obviously do not want to send v2.6.12-rc2
tag before you send commits from your "master" branch to get to
where your subsystem maintainer forked from you (otherwise the
remote side would say "I do not know your 'master' commit, but
now we know we have this ancient v2.6.12-rc2 in common, so let's
have a pack between that and the tip of the subsystem tree"), so
I do think sending "100 commits on junk branch" is unavoidable.

I think the attached patch is safe in general, but somebody may
want to give an extra set of eyeballs to double check the logic
is sane.

-- >8 --
upload-pack: squelch downloader more aggressively under multi-ack

When the server side sees "have" line that makes all the "want"
commits somehow reachable from one of the "have" lines so far,
stop responding "continue" to prevent the other end going down
to send too many refs.

---
diff --git a/upload-pack.c b/upload-pack.c
index 617ee46..ac42d0d 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -452,8 +452,13 @@ static int get_common_commits(void)
 			default:
 				memcpy(hex, sha1_to_hex(sha1), 41);
 				if (multi_ack) {
-					const char *msg = "ACK %s continue\n";
-					packet_write(1, msg, hex);
+					const char *msg = "ACK %s%s\n";
+					const char *cont = " continue";
+					if (ok_to_give_up()) {
+						cont = "";
+						multi_ack = 0;
+					}
+					packet_write(1, msg, hex, cont);
 					memcpy(last_hex, hex, 41);
 				}
 				else if (have_obj.nr == 1)
