From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Wed, 09 May 2007 17:11:15 -0700
Message-ID: <7vd519r10c.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu May 10 02:11:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlwFj-0003WC-E3
	for gcvg-git@gmane.org; Thu, 10 May 2007 02:11:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755176AbXEJALR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 20:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759223AbXEJALR
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 20:11:17 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59498 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755176AbXEJALQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 20:11:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510001115.HWAT13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 20:11:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xCBF1W00K1kojtg0000000; Wed, 09 May 2007 20:11:15 -0400
In-Reply-To: <7vy7jxr35a.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 May 2007 16:25:05 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46814>

Junio C Hamano <junkio@cox.net> writes:

> David Miller <davem@davemloft.net> writes:
>
>> From: Junio C Hamano <junkio@cox.net>
>> Date: Wed, 09 May 2007 15:59:23 -0700
>>
>>> The above sequence is called before we create the new directory
>>> and chdir to it.  Maybe pwd has funny behaviour (e.g. $PWD) and
>>> we need to explicitly say /bin/pwd or somesuch...
>>
>> Indeed:
>>
>> [davem@hera ~]$ pwd
>> /home/davem
>> [davem@hera ~]$ cd git
>> [davem@hera git]$ pwd
>> /home/davem/git
>> [davem@hera git]$ /bin/pwd
>> /home/ftp/pub/scm/linux/kernel/git/davem
>> [davem@hera git]$ 
>
> Thanks.

This would fix it, but I find this kind of ugly.

-- >8 --
git-clone: don't get fooled by $PWD

If you have /home/me/git symlink pointing at /pub/git/mine,
trying to clone from /pub/git/his/ using relative path would not
work as expected:

	$ cd /home/me
        $ cd git
        $ ls ../
        his    mine
        $ git clone -l -s -n ../his/stuff.git

This is because "cd ../his/stuff.git" done inside git-clone to
check if the repository is local is confused by $PWD, which is
set to /home/me, and tries to go to /home/his/stuff.git which is
different from /pub/git/his/stuff.git.

We could probably say "set -P" (or "cd -P") instead, if we know
the shell is POSIX, but the way the patch is coded is probably
more portable.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

diff --git a/git-clone.sh b/git-clone.sh
index cad5c0c..c5852a2 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -18,7 +18,14 @@ usage() {
 }
 
 get_repo_base() {
-	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
+	(
+		cd "`/bin/pwd`" &&
+		cd "$1" &&
+		(
+			cd .git
+			pwd
+		)
+	) 2>/dev/null
 }
 
 if [ -n "$GIT_SSL_NO_VERIFY" ]; then
