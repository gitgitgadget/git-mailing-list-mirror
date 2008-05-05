From: Mark Hills <mark@pogo.org.uk>
Subject: Re: [PATCH] Be more careful with objects directory permissions on 
  clone
Date: Mon, 5 May 2008 17:46:42 +0100 (BST)
Message-ID: <alpine.BSO.1.10.0805051742020.10940@zrgural.vwaro.pbz>
References: <alpine.BSO.1.10.0805041234570.5819@zrgural.vwaro.pbz> <481ECCF0.6080308@viscovery.net> <alpine.BSO.1.10.0805051047260.7723@zrgural.vwaro.pbz> <481EDC4B.2010105@viscovery.net> <alpine.BSO.1.10.0805051121090.32248@zrgural.vwaro.pbz>
 <481EE478.9000704@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 05 18:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt3qi-0002Sq-DA
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 18:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755957AbYEEQqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 12:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755938AbYEEQqp
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 12:46:45 -0400
Received: from mailout.ijneb.com ([212.13.201.26]:18045 "EHLO
	metheny.ijneb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755517AbYEEQqn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 12:46:43 -0400
Received: from localhost ([127.0.0.1] ident=mark)
	by metheny.ijneb.com with esmtp (Exim 4.69)
	(envelope-from <mark@pogo.org.uk>)
	id 1Jt3pq-0003tk-GY; Mon, 05 May 2008 17:46:42 +0100
In-Reply-To: <481EE478.9000704@viscovery.net>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: mark@pogo.org.uk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81298>

On Mon, 5 May 2008, Johannes Sixt wrote:

> Mark Hills schrieb:

>> I tend to think that an inclusive match has less scope for future bad 
>> behaviour than an exclusive match. Have I missed the possiblity that 
>> there may be content in the objects directory which is not a directory 
>> or file?
>
> Theoretically, you could have symbolic links to loose objects or packs.
>
> Generally, you shouldn't change the behavior of a program more than 
> necessary.

Okay, here's a revised patch (I made a note about the cpio bug in the 
commit message too).

Thanks,

Mark



Be more careful with objects directory permissions on clone

Honour the setgid and umask when re-creating the objects directory
at the destination.

cpio in copy-pass mode aims to copy file permissions which causes this
problem and cannot be disabled. Be explicit by copying the directory
structure first, honouring the permissions at the destination, then copy
the files with 0444 permissions. This also avoids bugs in some versions
of cpio.

Signed-off-by: Mark Hills <mark@pogo.org.uk>
---
  git-clone.sh |    5 ++++-
  1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-clone.sh b/git-clone.sh
index 8c7fc7f..9d88d1c 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -334,7 +334,10 @@ yes)
  			fi
  		fi &&
  		cd "$repo" &&
-		find objects -depth -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
+		# Create dirs using umask and permissions and destination
+		find objects -type d -print | (cd "$GIT_DIR" && xargs mkdir -p) &&
+		# Copy existing 0444 permissions on content
+		find objects ! -type d -print | cpio $cpio_quiet_flag -pumd$l "$GIT_DIR/" || \
  			exit 1
  	fi
  	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD" || exit 1
-- 
1.5.5.1.126.geeac
