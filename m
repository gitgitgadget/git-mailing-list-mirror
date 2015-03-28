From: Vitor Antunes <vitor.hda@gmail.com>
Subject: [PATCH V2 2/2] git-p4: Fix copy detection test
Date: Sat, 28 Mar 2015 00:03:03 +0000
Message-ID: <1427500983-8802-3-git-send-email-vitor.hda@gmail.com>
References: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 28 01:04:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YbeE7-0002gF-CP
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 01:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732AbbC1ADi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 20:03:38 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:32786 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbbC1ADh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 20:03:37 -0400
Received: by wgbgs4 with SMTP id gs4so24072708wgb.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8Ja64udo29fMDH0Qe3PlunN2uLB51oor4GUIe+w0Xrc=;
        b=zk98mQwvD8N4EnJvDwTKAn7y3Uu1MSb+pRVOh1LcJgU4MOZ3L4Q4RrImtGZisiyY4W
         swUSjx79PvE9OuQqZji7GflWgrFGSSGu1alM8UssY4xo9o8c1LExrLSevvv/eyst1cnk
         w9bywbezQ2wNZtN+kqdiNlSfZMLarz+ttkitxDc5h/DgqPZQXG3VeO6a/I/HSp+unyXx
         oGhzXfVXftONGWIDQdV4rnFdi79fqbnJ6Vdo49o4bJiEzd+T0tlSgyc86YMBpBilTFdB
         yIDuGw0kwA4np068Py9bnq/1krYxffb/IrTvZ1+cuJQWtv2e96aNiv3XGpDMpnaMoT0E
         jWHQ==
X-Received: by 10.194.92.169 with SMTP id cn9mr40951322wjb.61.1427501016580;
        Fri, 27 Mar 2015 17:03:36 -0700 (PDT)
Received: from localhost.localdomain (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id hn8sm4879409wib.18.2015.03.27.17.03.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2015 17:03:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1427500983-8802-1-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266408>

File file11 is copied from file2 and diff-tree correctly reports this file as
its the source. But it is possible that the diff-tree algorithm detects file10,
which was also copied from file2, as the origin of the new file.

This fix uses a case statement to support both files as the source of file11, as
was done in other tests in this file.

Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
---
 t/t9814-git-p4-rename.sh |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/t/t9814-git-p4-rename.sh b/t/t9814-git-p4-rename.sh
index efae143..8b9c295 100755
--- a/t/t9814-git-p4-rename.sh
+++ b/t/t9814-git-p4-rename.sh
@@ -163,7 +163,10 @@ test_expect_success 'detect copies' '
 		git commit -a -m "Copy file2 to file11" &&
 		git diff-tree -r -C --find-copies-harder HEAD &&
 		src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
-		test "$src" = file10 &&
+		case "$src" in
+		file2 | file10) : ;; # happy
+		*) false ;; # not
+		esac &&
 		git config git-p4.detectCopiesHarder true &&
 		git p4 submit &&
 		p4 filelog //depot/file11 &&
-- 
1.7.10.4
