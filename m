From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH/RFC 03/20] rebase: read state outside loop
Date: Thu, 25 Nov 2010 20:57:46 +0100
Message-ID: <1290715083-16919-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 26 02:58:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLna5-0001kp-20
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 02:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab0KZB6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Nov 2010 20:58:14 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:62199 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0KZB6J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Nov 2010 20:58:09 -0500
Received: by mail-vw0-f46.google.com with SMTP id 3so347969vws.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 17:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=cJnCyXxjAtT3TMi3Bqi/CsSV0+1llePVXBLPgtaPy8k=;
        b=WhtdxYbFeuR3KP5B3wqWkN2V38FjbM06RbUur/FcU4uX5Vc+l5lyNeJ6HPX/1oofRs
         zRJdUVcUOi+oKOwhrm+NN/umjsX6w9Y01EqLekIYqh98IK68znXcJ/ScZe//Q49AEQYk
         jRsVkHPUxoy+kDta0Ovjsi9kBGvw04wH8kv94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FSwKPWq/z5o8Q4B44pppwfSF0t01uPHNJ5QVRArmYBUd12dds4t6cF+ZTruzu7SMiU
         gPAVgalFDAF+LFO+t1YfWz3DCTTjFQjTlHnrSLH8ZrRcUmil/PQO9EwljAjjBnAHg4pL
         mIKnoqzLNznslgZf9TxSO6xIud4DeVuPwBudk=
Received: by 10.220.199.76 with SMTP id er12mr418160vcb.1.1290736688575;
        Thu, 25 Nov 2010 17:58:08 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id y14sm193301vch.28.2010.11.25.17.58.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 17:58:08 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1290715083-16919-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162162>

The 'onto_name' state is used in 'git rebase --merge' is currently read
once for each commit that need to be applied. It doesn't change between
each iteration, however, so it should be moved out of the loop. This also
makes the code more readable. Also remove the unused variable 'end'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index a325dd9..b1fadb6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -61,6 +61,7 @@ read_state () {
 	then
 		state_dir="$merge_dir"
 		prev_head=$(cat "$merge_dir"/prev_head) &&
+		onto_name=$(cat "$merge_dir"/onto_name) &&
 		end=$(cat "$merge_dir"/end) &&
 		msgnum=$(cat "$merge_dir"/msgnum)
 	else
@@ -122,9 +123,8 @@ call_merge () {
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
1.7.3.2.864.gbbb96
