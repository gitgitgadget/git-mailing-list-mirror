From: Junio C Hamano <gitster@pobox.com>
Subject: Re* ext3: fix ext3_dx_readdir hash collision handling - Regression
Date: Fri, 24 Oct 2008 15:00:24 -0700
Message-ID: <7vwsfx1wnb.fsf_-_@gitster.siamese.dyndns.org>
References: <20081022093201.GA2227@gentoox2.trippelsdorf.de>
 <20081023032832.GE10369@mit.edu>
 <20081023063740.GA2438@gentoox2.trippelsdorf.de>
 <20081024000109.GD7842@mit.edu>
 <20081024042851.GA2360@gentoox2.trippelsdorf.de>
 <alpine.LFD.2.00.0810240853310.3287@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:01:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUjA-0006NO-2H
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534AbYJXWAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754491AbYJXWAj
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:00:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbYJXWAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:00:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4C9DD730FC;
	Fri, 24 Oct 2008 18:00:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 70C55730F6; Fri, 24 Oct 2008 18:00:30 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810240853310.3287@nehalem.linux-foundation.org> (Linus
 Torvalds's message of "Fri, 24 Oct 2008 09:08:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3085F26E-A217-11DD-8DB5-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99070>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> The "git buglet" looks liek this:
>
>  - build a kernel
>
>  - do "git clean -dqfx". This fails with
>
> 	warning: failed to remove 'include/config/'
>
>  - do "git clean -dqfx" again. And now it works - apparently because the 
>    first invocation deleted enough of the big directory.
>
> Doing an 'strace' to see what is going on, I see:
>
> 	..
> 	getdents(3, /* 132 entries */, 4096)    = 3888
> 	lstat("include/config/sgi", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> 	open("include/config/sgi", O_RDONLY|O_NONBLOCK|O_DIRECTORY|0x80000) = 4
> 	fstat(4, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> 	getdents(4, /* 3 entries */, 4096)      = 80
> 	lstat("include/config/sgi/partition.h", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
> 	unlink("include/config/sgi/partition.h") = 0
> 	getdents(4, /* 0 entries */, 4096)      = 0
> 	close(4)                                = 0
> 	rmdir("include/config/sgi")             = 0
> 	lstat("include/config/sgi", 0x7fffdc4d2110) = -1 ENOENT (No such file or directory)
> 	close(3)                                = 0
> 	write(2, "warning: failed to remove \'include/config/\'\n", 44) = 44
> 	..
>
> and notice how it does that
>
> 	lstat("include/config/sgi", ..
>
> _twice_. That, in turn (knowing the git implementation), implies that it 
> was returned twice from that first "getdents(3, ...)" call.
>
> So what git clean does is to scan over the readdir() return values, see if 
> it's a file it knows about, try to remove it if not, lstat() every entry, 
> recurse into them if they are directories, and then remove it. If the 
> lstat() fails, "git clean" will fail.

Hmm, interesting.

-- >8 --
Subject: allow readdir(3) to return the same entry twice

When removing a large directory recursively, repeatedly running unlink(2)
on what we read from readdir(3) can cause readdir(3) (or underlying
getdents(2)) to return the same entry twice.  If we have already removed
it, running lstat() on the entry would fail with ENOENT, but there is no
harm if we ignore such an error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 dir.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git i/dir.c w/dir.c
index 0131983..293df4e 100644
--- i/dir.c
+++ w/dir.c
@@ -800,8 +800,11 @@ int remove_dir_recursively(struct strbuf *path, int only_empty)
 
 		strbuf_setlen(path, len);
 		strbuf_addstr(path, e->d_name);
-		if (lstat(path->buf, &st))
-			; /* fall thru */
+		if (lstat(path->buf, &st)) {
+			if (errno == ENOENT)
+				continue;
+			/* otherwise fall thru */
+		}
 		else if (S_ISDIR(st.st_mode)) {
 			if (!remove_dir_recursively(path, only_empty))
 				continue; /* happy */
