From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 24/36] rebase: cherry-pick: fix mode storage
Date: Sun,  9 Jun 2013 14:24:38 -0500
Message-ID: <1370805890-3453-25-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:28:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllHj-0003yF-Eo
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433Ab3FIT1y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:54 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:63149 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab3FIT1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:53 -0400
Received: by mail-ob0-f173.google.com with SMTP id wc20so9157475obb.32
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NVm4wmwjeWHX5NGQbqDEuMXeHo6fbL8QWIhoCmnFdw8=;
        b=PgJQ2BPduNRETIVfeGpryrz2+QbkcD/h+fNpwKd9lFpvvyy0M8tIU+OpDHzdk3q7qk
         42JGZa27oLxe599/ulRcUPbUaM1AJDfSqHc49Jpb6CgwOLdhwYAVqsiYQi9h2f6cSU9f
         ipRQbFEtzn1sg3tgJwRrG7MWEf3dOWCn4hJqtgvNsdTF1xFTuGZ4RB/Ym2aMTvjOPtls
         b4QdCB1/REYP1xV7/rv8wZHG7v501gbGaEdzoFm9ZbjGce2+MtNC9LGxBGanDa3riqxb
         ytXOsKeRW+5kxTVoeVnD6JSzaRWbZ9ruwzkTArpNVoTk5rqxA7Y3/X1UzxSt2mL7dAgt
         dI7w==
X-Received: by 10.182.98.135 with SMTP id ei7mr5462649obb.102.1370806073077;
        Sun, 09 Jun 2013 12:27:53 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm16048214obl.1.2013.06.09.12.27.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227132>

We don't use the 'rebase-apply'.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 5 ++++-
 git-rebase.sh             | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 2c16995..e142cfb 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -18,12 +18,15 @@ esac
 
 test -n "$rebase_root" && root_flag=--root
 
+mkdir -p "$state_dir" || die "Could not create temporary $state_dir"
+: > "$state_dir"/cherrypick || die "Could not mark as cherrypick"
+
 git cherry-pick --allow-empty "$revisions"
 ret=$?
 
 if test 0 != $ret
 then
-	test -d "$state_dir" && write_basic_state
+	write_basic_state
 	return $ret
 fi
 
diff --git a/git-rebase.sh b/git-rebase.sh
index 70762f1..4465daf 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -205,6 +205,9 @@ then
 	then
 		type=interactive
 		interactive_rebase=explicit
+	elif test -f "$merge_dir"/cherrypick
+	then
+		type=cherrypick
 	else
 		type=merge
 	fi
@@ -416,7 +419,7 @@ then
 elif test -n "$keep_empty"
 then
 	type=cherrypick
-	state_dir="$apply_dir"
+	state_dir="$merge_dir"
 else
 	type=am
 	state_dir="$apply_dir"
-- 
1.8.3.698.g079b096
