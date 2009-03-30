From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-gui: run post-checkout hook on checkout
Date: Mon, 30 Mar 2009 22:00:38 +0200
Message-ID: <49D124E6.8010206@web.de>
References: <49CAB4C1.6070004@web.de> <20090330143435.GA23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 22:03:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoNhJ-0003jG-9t
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 22:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760574AbZC3UAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760518AbZC3UAo
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 16:00:44 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:37324 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760584AbZC3UAm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2009 16:00:42 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id 5215DFF2D69A;
	Mon, 30 Mar 2009 22:00:39 +0200 (CEST)
Received: from [80.128.74.92] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #277)
	id 1LoNex-0000Tb-00; Mon, 30 Mar 2009 22:00:39 +0200
User-Agent: Thunderbird 2.0.0.21 (X11/20090302)
In-Reply-To: <20090330143435.GA23521@spearce.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19Cfies/9c51SblEVmN4x0AzT/uSMlAG901CSI6
	9ToB33rhE5kL77s0SQFa083DH4RMjIJ+dhTORtB3pYvTVjSA2L
	N4govuV1GYPPaA5QzhrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115190>

Shawn O. Pearce schrieb:
> Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> +	# -- Run the post-checkout hook.
>> +	#
>> +	set fd_ph [githook_read post-checkout $old_hash $new_hash 1]
>> +	if {$fd_ph ne {}} {
>> +		upvar #0 pch_error pc_err
> 
> I'd rather spell this "global pch_error".
> 
>> +		set pc_err {}

What i noticed when fixing this issue is that i copied this upvar
statement from the calling of the post-commit hook in commit.tcl
with only a minor change (ommitting the "$cmt_id" behind
"pch_error").

It does seem to be incorrect there too, as i couldn't find any use
of the variable "pc_err" or "pch_error$cmt_id" anywhere in git-gui.
So setting "pc_err" to empty seems pretty pointless, as everywhere
else in commit.tcl "pch_error" is used instead.

Or am i overlooking something? If not, the patch below should correct
that.

Jens

--------------------- 8>< ---------------------

>From 5ddd7e8c2d52fc99e496ed3bc96358cc07e538f1 Mon Sep 17 00:00:00 2001
From: Jens Lehmann <Jens.Lehmann@web.de>
Date: Mon, 30 Mar 2009 20:35:57 +0200
Subject: [PATCH] git-gui: When calling post-commit hook wrong variable was cleared.

Before calling the post-commit hook, the variable "pc_err" is cleared
while later only "pch_error" is used. "pch_error$cmt_id" only appeared in
"upvar"-Statements (which were changed to "global") and was removed.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-gui/lib/commit.tcl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-gui/lib/commit.tcl b/git-gui/lib/commit.tcl
index 9cc8410..7255efb 100644
--- a/git-gui/lib/commit.tcl
+++ b/git-gui/lib/commit.tcl
@@ -398,8 +398,8 @@ A rescan will be automatically started now.
 	#
 	set fd_ph [githook_read post-commit]
 	if {$fd_ph ne {}} {
-		upvar #0 pch_error$cmt_id pc_err
-		set pc_err {}
+		global pch_error
+		set pch_error {}
 		fconfigure $fd_ph -blocking 0 -translation binary -eofchar {}
 		fileevent $fd_ph readable \
 			[list commit_postcommit_wait $fd_ph $cmt_id]
@@ -461,7 +461,7 @@ A rescan will be automatically started now.
 }
 
 proc commit_postcommit_wait {fd_ph cmt_id} {
-	upvar #0 pch_error$cmt_id pch_error
+	global pch_error
 
 	append pch_error [read $fd_ph]
 	fconfigure $fd_ph -blocking 1
-- 
1.6.2.1.414.g2daa3
