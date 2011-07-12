From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 2/3] doc/fast-import: document feature import-marks-if-exists
Date: Tue, 12 Jul 2011 21:10:27 +0600
Message-ID: <1310483428-29833-3-git-send-email-divanorama@gmail.com>
References: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 17:10:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qgebc-0005YJ-RM
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 17:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753267Ab1GLPKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 11:10:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40863 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072Ab1GLPKP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 11:10:15 -0400
Received: by mail-bw0-f46.google.com with SMTP id 5so4115707bwd.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ueQ3D6hwuZo0K/PQymNmcVAQi6ifO4YPmciiTmK0W44=;
        b=Gmlra+vEWqh6LsMlwrNznHugrHTymN5qqEi+E337QNT1ESAL//KwtpNc2S9Jkc9YLq
         48SxIEoZMzI8K3HGwvoYY86G9MCEiz5werxX5RNmdsD/p5h9Efsy3VGKVUqKrbkYVD9C
         GhankNeNnsWLJ4AFn0hC9ZM/CozHnZld3jK6s=
Received: by 10.204.40.134 with SMTP id k6mr27927bke.128.1310483414696;
        Tue, 12 Jul 2011 08:10:14 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id u32sm1398878bkk.49.2011.07.12.08.10.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 08:10:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
In-Reply-To: <1310483428-29833-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176942>

fast-import parameter --import-marks-if-exists was introduced in
commit dded4.. --import-marks can be set via a "feature" command in
a fast-import stream and --import-marks-if-exists has support for
such specification too, for free.

Document "feature import-marks-if-exists=<file>" command and add a
minimalistic test for it.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
 Documentation/git-fast-import.txt |    5 +++++
 t/t9300-fast-import.sh            |   15 +++++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 3f5b912..bdcc81c 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1005,6 +1005,11 @@ import-marks::
 	second, an --import-marks= command-line option overrides
 	any "feature import-marks" command in the stream.
 
+import-marks-if-exists::
+	Like import-marks but instead of erroring out, silently
+	skips the file if it does not exist. Differences from --
+	version are the same as with import-marks feature above.
+
 cat-blob::
 ls::
 	Require that the backend support the 'cat-blob' or 'ls' command.
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2a53640..eed57df 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1882,6 +1882,21 @@ test_expect_success 'R: --import-marks-if-exists' '
 	test_cmp expect io.marks
 '
 
+test_expect_success 'R: feature import-marks-if-exists' '
+	rm -f io.marks &&
+	blob=$(echo hi | git hash-object --stdin) &&
+	echo ":1 $blob" >expect &&
+	git fast-import --import-marks-if-exists=io.marks --export-marks=io.marks <<-\EOF &&
+	feature import-marks-if-exists=io.marks
+	blob
+	mark :1
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks
+'
+
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
-- 
1.7.3.4
