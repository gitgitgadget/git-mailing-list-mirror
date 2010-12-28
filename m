From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 03/31] rebase: read state outside loop
Date: Tue, 28 Dec 2010 10:30:20 +0100
Message-ID: <1293528648-21873-4-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:34:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYu-0005Wr-Kt
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:34:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052Ab0L1Pdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:33:52 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48315 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab0L1Pc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:27 -0500
Received: by qyk12 with SMTP id 12so10443701qyk.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=xStHDzFp5P3F35ZCAUlZADOlVeIvZz77fyNi2+ZBkgo=;
        b=XkR3DnKF6K/h9MHCi6P5XetOvOzPQgLZZo96qmzV1Pdgy/7IavYMz8rUZqDNgjfCoS
         +/t9JMJKn6d6B1gWOpeg8CWORwZ9eLl8keyGahQ6qrlaHKLj6+Lbyct2OK4PO2v7fwbJ
         tcasuiRUjPJymDSIGv5rWMvTA0kBrzkkWMiII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=UMZEzGFhUFYrCXFbRBTm7gQtWMEcz+yZC9TluVDUrIk4KvhREX5/WXbwaj9uIoKEFX
         b/MLaGq6EIHGgZMCHmiB97MQa0RSkSLfNj5D4iX0iPouQRWMJ6nLH58mz4umDxr0UGmk
         Bj2Ppcr9xyELQwXe328oRTZMocVbad2cyQj3M=
Received: by 10.229.235.142 with SMTP id kg14mr12184323qcb.133.1293550346693;
        Tue, 28 Dec 2010 07:32:26 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164267>

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
index bf144dc..9be831e 100755
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
1.7.3.2.864.gbbb96
