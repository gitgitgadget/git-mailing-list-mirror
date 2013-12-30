From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/4] completion: fix remote.pushdefault
Date: Mon, 30 Dec 2013 20:22:18 +0530
Message-ID: <1388415138-11011-5-git-send-email-artagnon@gmail.com>
References: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Dec 30 15:52:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VxeCa-00065x-40
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 15:52:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756011Ab3L3OwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 09:52:15 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:54448 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990Ab3L3OwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 09:52:05 -0500
Received: by mail-pd0-f178.google.com with SMTP id y10so11349793pdj.23
        for <git@vger.kernel.org>; Mon, 30 Dec 2013 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F76VVnHOHISzDS2ZyM/SlT41W7alf0zOwUot8KqQaj0=;
        b=UDPZQibha0g8CrDNx7LELszFr7KM0kivgUh38Nu11tQNod+guFCdbrdbPpQzJUVNNd
         +n1HVCUuij31MosAE3WyfgdjvPu0mw6Ry+JNfR+0dBEnJdbUdbRD3UuBiezACIS1Pe2U
         FHiCr1omXEnoxfdWo6cTzweSP9M7zy/cPfftz45NNjDT1WXlapotjijX2a6xllNxFJn0
         R0i4G/Jy6qHxMUGMeVsRUhHMHNBNBezHNp9dzp9voJ22WRtfVQ+F0JTVc9x8KwZQ9NOo
         zKxtqZdcw5FcWuDij4joMPjyh8cfsqAZUyqHcKHLq3lvV75jsfFweLg0Q1U1y21qFCtS
         0iKg==
X-Received: by 10.66.170.138 with SMTP id am10mr69569330pac.51.1388415124064;
        Mon, 30 Dec 2013 06:52:04 -0800 (PST)
Received: from localhost.localdomain ([122.164.121.180])
        by mx.google.com with ESMTPSA id vn10sm82123744pbc.21.2013.12.30.06.52.01
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Dec 2013 06:52:03 -0800 (PST)
X-Mailer: git-send-email 1.8.5.2.227.g53f3478
In-Reply-To: <1388415138-11011-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239804>

When attempting to complete

  $ git config remote.push<TAB>

'pushdefault' doesn't come up. This is because "$cur" is matched with
"remote.*" and a list of remotes are completed. Add 'pushdefault' to the
list of remotes using __gitcomp_2 ().

Also take care to not complete

  $ git config remote.pushdefault.<TAB>

with the usual remote.<name>. candidates.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0bda757..9e0213d 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1896,6 +1896,9 @@ _git_config ()
 		;;
 	remote.*.*)
 		local pfx="${cur%.*}." cur_="${cur##*.}"
+		if [ "$pfx" == "remote.pushdefault." ]; then
+			return
+		fi
 		__gitcomp "
 			url proxy fetch push mirror skipDefaultUpdate
 			receivepack uploadpack tagopt pushurl
@@ -1904,7 +1907,7 @@ _git_config ()
 		;;
 	remote.*)
 		local pfx="${cur%.*}." cur_="${cur#*.}"
-		__gitcomp_nl "$(__git_remotes)" "$pfx" "$cur_" "."
+		__gitcomp_2 "$(__git_remotes)" "pushdefault" "$pfx" "$cur_" "."
 		return
 		;;
 	url.*.*)
-- 
1.8.5.2.227.g53f3478
