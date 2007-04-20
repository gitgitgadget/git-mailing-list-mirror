From: Junio C Hamano <junkio@cox.net>
Subject: Re: git clone problem through HTTP
Date: Fri, 20 Apr 2007 14:02:48 -0700
Message-ID: <7vodliyd1j.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Aubrey Li" <aubreylee@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:02:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf0Fp-0003xX-H0
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 23:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767259AbXDTVCu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 17:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767270AbXDTVCu
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 17:02:50 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:58491 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767259AbXDTVCt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 17:02:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420210249.JXSR1235.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 17:02:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pZ2o1W00K1kojtg0000000; Fri, 20 Apr 2007 17:02:49 -0400
In-Reply-To: <6d6a94c50704200015p65dc4a8dn4abd8aaed35b9521@mail.gmail.com>
	(Aubrey Li's message of "Fri, 20 Apr 2007 15:15:46 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45131>

"Aubrey Li" <aubreylee@gmail.com> writes:

> I'm behind of a firewall on which the git port is not permitted, so I
> can only use http protocol. Unfortunately, I can't clone linus' git
> tree at all. I've tried
>
> git version 1.4.4.2
> git version 1.4.4.4
> git version 1.5.0.1
> git version 1.5.0.4
> git version 1.5.0.6
> git version 1.5.1.1,
>
> none of them work. The following is the error.

        $ git init
        $ git remote add origin http://.../linux-2.6.git
	$ git config branch.master.remote origin
	$ git config branch.master.merge refs/heads/master
        $ git fetch
        $ git merge origin

should work, because I knew about this problem and fixed it in
git-fetch in v1.5.0.

Alas, I forgot to update the matching code in git-clone.

This is why I keep saying that we should get rid of as much code
from git-clone, and make it essentially a thin wrapper around
the six commands I quoted above.

---

diff --git a/git-clone.sh b/git-clone.sh
index 513b574..cad5c0c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -60,7 +60,7 @@ Perhaps git-update-server-info needs to be run there?"
 		else
 			tname=$name
 		fi
-		git-http-fetch $v -a -w "$tname" "$name" "$1" || exit 1
+		git-http-fetch $v -a -w "$tname" "$sha1" "$1" || exit 1
 	done <"$clone_tmp/refs"
 	rm -fr "$clone_tmp"
 	http_fetch "$1/HEAD" "$GIT_DIR/REMOTE_HEAD" ||
