From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 03/31] rebase: read state outside loop
Date: Sun,  6 Feb 2011 13:43:32 -0500
Message-ID: <1297017841-20678-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 06 19:46:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pm9cd-0004j0-1q
	for gcvg-git-2@lo.gmane.org; Sun, 06 Feb 2011 19:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546Ab1BFSpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 13:45:51 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:58585 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753496Ab1BFSpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 13:45:49 -0500
Received: by mail-qw0-f46.google.com with SMTP id 26so3014077qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 10:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VlTNuTQDGxcv0Txsqv6CHjS626z60NVGXSg/DXWqqzE=;
        b=qmOGKC6A3W8uO8AoOxIce4LBjSZiMYoM46IsaeDMol4xcmJADQ09TjG+9WGhtjwXfv
         AOaFVnL2vst7PRIYojxAlznJjA/2CHI/WeT1wLcmHnECGOd8yZ2Rupz7buAtmXYe3o41
         XenBufrMikJFsXa/3EWkjk/DCPE14gMLlYixU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ACNrWNMFjIFxM+zxF/9SvTNrwmOJsO7yQbS8MMS0QC8zI95tm+eTDl40bDa0TIYnLc
         P0+/scRxYOJGYQQyho2xqmM6xql+QZvWY/y8Cyb4P+AvGHAFKr1k2N6BsF1ZxhCNVE5O
         VB+EiNVli2vY29y726hzQq+PpUdGtg9GClhUI=
Received: by 10.229.84.203 with SMTP id k11mr10328255qcl.281.1297017949165;
        Sun, 06 Feb 2011 10:45:49 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h20sm2174330qck.24.2011.02.06.10.45.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Feb 2011 10:45:47 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297017841-20678-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166163>

The 'onto_name' state used in 'git rebase --merge' is currently read
once for each commit that need to be applied. It doesn't change
between each iteration, however, so it should be moved out of the
loop. This also makes the code more readable. Also remove the unused
variable 'end'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 63b5683..70948bc 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -62,6 +62,7 @@ read_state () {
 	then
 		state_dir="$merge_dir"
 		prev_head=$(cat "$merge_dir"/prev_head) &&
+		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
 	else
@@ -123,9 +124,8 @@ call_merge () {
 	hd=$(git rev-parse --verify HEAD)
 	cmt_name=$(git symbolic-ref HEAD 2> /dev/null || echo HEAD)
 	msgnum=$(cat "$merge_dir/msgnum")
-	end=$(cat "$merge_dir/end")
 	eval GITHEAD_$cmt='"${cmt_name##refs/heads/}~$(($end - $msgnum))"'
-	eval GITHEAD_$hd='$(cat "$merge_dir/onto_name")'
+	eval GITHEAD_$hd='$onto_name'
 	export GITHEAD_$cmt GITHEAD_$hd
 	if test -n "$GIT_QUIET"
 	then
-- 
1.7.4.rc2.33.g8a14f
