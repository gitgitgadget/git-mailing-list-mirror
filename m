From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFD] git stash over OpenBSD/Linux NFS - cp -p breakage
Date: Tue, 15 Mar 2011 11:58:50 +0100
Message-ID: <4D7F466A.4090508@viscovery.net>
References: <4D7F3AA4.1080202@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, casey@nrlssc.navy.mil, jon.seymour@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Jakob Pfender <jpfender@elegosoft.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 11:59:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzRy0-0001WA-26
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 11:59:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757127Ab1COK67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 06:58:59 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29397 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756239Ab1COK66 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 06:58:58 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PzRxi-0001FA-Tg; Tue, 15 Mar 2011 11:58:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9B81F1660F;
	Tue, 15 Mar 2011 11:58:50 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D7F3AA4.1080202@elegosoft.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169061>

Am 3/15/2011 11:08, schrieb Jakob Pfender:
> We have an NFS setup with Linux machines mounting an NFS that is hosted on
> an OpenBSD server. Recently, we discovered git-stash breaking with:
> 
> $ git stash
> cp: preserving permissions for
> `/home/jpfender/stashtest/.git/.git-stash.3056-index': Operation not
> supported
> Cannot save the current worktree state
> 
> This was discovered to be caused by a bug in cp that causes 'cp -p' to
> fail in this particular NFS setup - preserving permissions in an NFS
> shared across Linux and OpenBSD machines doesn't work.
> 
> I looked at git-stash.sh and could not discover a reason why it had to use
> 'cp -p'. I patched it to use only cp without preserving permissions, and
> everything seemed to work fine. All stash tests succeeded (bar two known
> breakages).
> 
> So my question is: Does git-stash really need 'cp -p'? Is it safe to remove?

Yes. No.

The timestamp of the index file is important. It is needed to discover
racily-clean index entries. Therefore, the -p must remain.

You can also try the patch below. Warning: completely untested.

-- Hannes

diff --git a/git-stash.sh b/git-stash.sh
index 7561b37..fa62135 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -82,10 +82,9 @@ create_stash () {
 		# state of the working tree
 		w_tree=$( (
 			rm -f "$TMP-index" &&
-			cp -p ${GIT_INDEX_FILE-"$GIT_DIR/index"} "$TMP-index" &&
+			git read-tree --index-output="$TMP-index" -m $i_tree &&
 			GIT_INDEX_FILE="$TMP-index" &&
 			export GIT_INDEX_FILE &&
-			git read-tree -m $i_tree &&
 			git diff --name-only -z HEAD | git update-index -z --add --remove --stdin &&
 			git write-tree &&
 			rm -f "$TMP-index"
