From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] GIT v1.5.0-rc2
Date: Sun, 21 Jan 2007 22:25:41 -0800
Message-ID: <7vk5zfvaqi.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 07:25:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8sck-0008Ob-1m
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 07:25:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXAVGZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 01:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbXAVGZn
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 01:25:43 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52817 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXAVGZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 01:25:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122062542.DPTT15640.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 01:25:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E6Rz1W00i1kojtg0000000; Mon, 22 Jan 2007 01:26:00 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37397>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>    - Cloning and fetching _from_ a shallow clone are not
>>      supported (nor tested -- so they might work by accident but
>>      they are not expected to).
>
> Maybe we should go the "restrict first, and loosen later" approach? I.e. 
> forbid git-upload-pack to run if is_repository_shallow()?
>
>>    - Pushing from nor into a shallow clone are not expected to
>>      work.
>
> Maybe forbid git-push and git-receive-pack to run if 
> is_repository_shallow()?
>
> (I _think_ git-push should be safe, but not git-receive-pack.)

I think that is sensible.  Let's do this.

-- >8 --
[PATCH] shallow repository: disable unsupported operations for now.

We currently do not support fetching/cloning from a shallow repository
nor pushing into one.  Make sure these are not attempted so that we
do not have to worry about corrupting repositories needlessly.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 receive-pack.c |    3 +++
 upload-pack.c  |    3 ++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index c176d8f..6333f00 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -421,6 +421,9 @@ int main(int argc, char **argv)
 	if (!enter_repo(dir, 0))
 		die("'%s': unable to chdir or not a git archive", dir);
 
+	if (is_repository_shallow())
+		die("attempt to push into a shallow repository");
+
 	setup_ident();
 	/* don't die if gecos is empty */
 	ignore_missing_committer_name();
diff --git a/upload-pack.c b/upload-pack.c
index 3a466c6..3648aae 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -672,7 +672,8 @@ int main(int argc, char **argv)
 
 	if (!enter_repo(dir, strict))
 		die("'%s': unable to chdir or not a git archive", dir);
-
+	if (is_repository_shallow())
+		die("attempt to fetch/clone from a shallow repository");
 	upload_pack();
 	return 0;
 }
-- 
1.5.0.rc2
