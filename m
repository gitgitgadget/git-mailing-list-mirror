From: Jakob Pfender <jpfender@elegosoft.com>
Subject: Re: [RFD] git stash over OpenBSD/Linux NFS - cp -p breakage
Date: Tue, 15 Mar 2011 13:00:02 +0100
Organization: elego Software Solutions GmbH
Message-ID: <4D7F54C2.5060500@elegosoft.com>
References: <4D7F3AA4.1080202@elegosoft.com> <4D7F466A.4090508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, casey@nrlssc.navy.mil, jon.seymour@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 13:00:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzSvG-0003vi-Fw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 13:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757515Ab1COMAO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 08:00:14 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:34079 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459Ab1COMAN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 08:00:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 0C1141B4BC8;
	Tue, 15 Mar 2011 13:00:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5wvzot22FLe3; Tue, 15 Mar 2011 13:00:04 +0100 (CET)
Received: from [10.10.10.30] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id E8FC51B4BC5;
	Tue, 15 Mar 2011 13:00:03 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <4D7F466A.4090508@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169064>



On 03/15/2011 11:58 AM, Johannes Sixt wrote:
 > Am 3/15/2011 11:08, schrieb Jakob Pfender:
 >> We have an NFS setup with Linux machines mounting an NFS that is 
hosted on
 >> an OpenBSD server. Recently, we discovered git-stash breaking with:
 >>
 >> $ git stash
 >> cp: preserving permissions for
 >> `/home/jpfender/stashtest/.git/.git-stash.3056-index': Operation not
 >> supported
 >> Cannot save the current worktree state
 >>
 >> This was discovered to be caused by a bug in cp that causes 'cp -p' to
 >> fail in this particular NFS setup - preserving permissions in an NFS
 >> shared across Linux and OpenBSD machines doesn't work.
 >>
 >> I looked at git-stash.sh and could not discover a reason why it had 
to use
 >> 'cp -p'. I patched it to use only cp without preserving permissions, and
 >> everything seemed to work fine. All stash tests succeeded (bar two known
 >> breakages).
 >>
 >> So my question is: Does git-stash really need 'cp -p'? Is it safe to 
remove?
 >
 > Yes. No.
 >
 > The timestamp of the index file is important. It is needed to discover
 > racily-clean index entries. Therefore, the -p must remain.

You're right. The funny thing is: 'cp --preserve=timestamps' works over 
NFS, 'cp -p' just fails because it wants to copy file ownership as well.

 >
 > You can also try the patch below. Warning: completely untested.

Works fine for me! Also has the advantage that a git tool is used to 
copy the data, which can interpret the data better than cp could if need 
arose.

Does anyone want to commit Hannes' patch with the following log message:

Subject: [PATCH] git-stash.sh: Use git-read-tree instead of cp -p

cp -p fails in certain Linux/*BSD NFS setups because it wants to
preserve file ownership. However, the reason we use -p is because we
want to preserve the timestamp. This can be achieved by using
git-read-tree --index-output=<tmp-file>, which copies all the data
including the timestamp and avoids using cp -p altogether.

Signed-off-by: Johannes Sixt <j.sixt@viscovery.net>
Acked-by: Jakob Pfender <jpfender@elegosoft.com>
---
  git-stash.sh |    3 +--
  1 files changed, 1 insertions(+), 2 deletions(-)

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
  			git diff --name-only -z HEAD | git update-index -z --add --remove 
--stdin &&
  			git write-tree &&
  			rm -f "$TMP-index"
-- 
1.7.0.4
