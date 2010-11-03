From: martin.von.zweigbergk@gmail.com
Subject: [PATCH 3/5] rebase: read state outside loop
Date: Wed,  3 Nov 2010 22:09:38 +0100
Message-ID: <1288818580-7576-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Nov 04 04:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDqDu-00024F-CR
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 04:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752843Ab0KDDK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 23:10:26 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43895 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab0KDDKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 23:10:14 -0400
Received: by qwf7 with SMTP id 7so831106qwf.19
        for <git@vger.kernel.org>; Wed, 03 Nov 2010 20:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=S4RQC1btsnd9v1GET/B46rdYonpKSaSA817RmdZl6qA=;
        b=GvzdLyxgTyWkNnzPktvz2BouxW3Kr5WQEZagWoNuePFhOVZI0qCbnkhOx1vciALKAc
         4Pu/E9XaHxoBvultj5E23U1dqxD3hZ095iHwp27QY4s3jT88pb7YJ1YuRvVYJTOri2C8
         1Hmg1RlJnis4Giu3BfLmqcXIst2QLrKaALGK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UN6GS2l+wu7rA1TOJDuIDtjwsa9oPilNW2ich41sZvw7NOGYil9FvYbw0QotPQy7D3
         ppks1jh1Am0RrTPXLL1GhoA5hK4hhm4xT2HMVISjm1bcF8LcdGK56htvmIMO59+oTAok
         A/xkHp9y8ESx4oCA2wpDt0efgNMO6xqt9SB5g=
Received: by 10.229.190.204 with SMTP id dj12mr112005qcb.66.1288840213581;
        Wed, 03 Nov 2010 20:10:13 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id u2sm7746119qcq.31.2010.11.03.20.10.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Nov 2010 20:10:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.4.g5879b6
In-Reply-To: <1288818580-7576-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160687>

From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

The 'onto_name' state is used in 'git rebase --merge' is currently read
once for each commit that need to be applied. It doesn't change between
each iteration, however, so it should be moved out of the loop. This also
makes the code more readable. Also remove the unused variable 'end'.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index e0842e3..2c812b2 100755
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
1.7.3.rc1.4.g5879b6
