From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH v3] doc/fast-import: document feature import-marks-if-exists
Date: Wed, 17 Aug 2011 16:42:58 +0600
Message-ID: <1313577778-14716-1-git-send-email-divanorama@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Johan Herland <johan@herland.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 12:41:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtdZI-0003Rf-6e
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 12:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab1HQKls (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 06:41:48 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46933 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752025Ab1HQKlr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 06:41:47 -0400
Received: by bke11 with SMTP id 11so584365bke.19
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 03:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xOVvJq9aH9SfRCkGUQ1uPM6WDC6Y7Nche/hZmmkooy0=;
        b=kWV1sC68GqecThlgNJNdJG6+ZKaTWItEHe9yj7U28XuRMU+SPw5wWAjES+ljx/HV4l
         +x74HgT/6EcAxQR+YmVTbqaBabggFqNAcBsTTpPo373w/C2OXKFyqK8d4bEA7qQy4WEa
         q62iMRYmDDBPz5n6eIwiILZ3HikCmAXnaR8BM=
Received: by 10.204.241.14 with SMTP id lc14mr367291bkb.322.1313577705881;
        Wed, 17 Aug 2011 03:41:45 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id f9sm346568bkt.3.2011.08.17.03.41.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Aug 2011 03:41:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179508>

fast-import command-line option --import-marks-if-exists was introduced
in commit dded4f1 (fast-import: Introduce --import-marks-if-exists, 2011-01-15)

--import-marks option can be set via a "feature" command in a fast-import
stream and --import-marks-if-exists had support for such specification
from the very beginning too due to some shared codebase. Though the
documentation for this feature wasn't written in dded4f1.

Add the documentation for "feature import-marks-if-exists=<file>". Also add
a minimalistic test for it.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
This is a new round for 2/3 from [1]. 1/3 and 3/3 are already in master.
The only change from v2 is more tests, now there are:

- feature import-marks-if-exists=nonexisting.marks
- feature import-marks-if-exists=existing.marks
- --import-marks=existing.marks & feature=nonexisting.marks
- --import-marks-if-exists=nonexisting.marks & feature=existing.marks

These seem to cover most cases: feature works and is overriden by command line arguments.
Having more than one feature specified isn't tested to fail, imo it'd be better to support
specifying multiple marks files via features anyway. It's not yet done because unlike other
simple options are easy to override on the fly (we first parse the stream for features and
then parse argv. So argv overrides things), while import marks are more tricky:
- overriding rule is more complex, any command line option should discard all feature ones.
- reading them could be expensive (we do lookup objects they refer to).
- if the lookup fails or file is otherwise corrupt/bad, we die. So we shouldn't read marks
files given by features if they are to be overriden by command line options.

 Documentation/git-fast-import.txt |   10 +++++--
 t/t9300-fast-import.sh            |   47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 2969388..db0d75f 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1012,10 +1012,14 @@ force::
 	(see OPTIONS, above).
 
 import-marks::
+import-marks-if-exists::
 	Like --import-marks except in two respects: first, only one
-	"feature import-marks" command is allowed per stream;
-	second, an --import-marks= command-line option overrides
-	any "feature import-marks" command in the stream.
+	"feature import-marks" or "feature import-marks-if-exists"
+	command is allowed per stream; second, an --import-marks=
+	or --import-marks-if-exists command-line option overrides
+	any of these "feature" commands in the stream; third,
+	"feature import-marks-if-exists" like a corresponding
+	command-line option silently skips a nonexistent file.
 
 cat-blob::
 ls::
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index f256475..2cb4494 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1882,6 +1882,53 @@ test_expect_success 'R: --import-marks-if-exists' '
 	test_cmp expect io.marks
 '
 
+test_expect_success 'R: feature import-marks-if-exists' '
+	rm -f io.marks &&
+	>expect &&
+
+	git fast-import --export-marks=io.marks <<-\EOF &&
+	feature import-marks-if-exists=not_io.marks
+	EOF
+	test_cmp expect io.marks &&
+
+	blob=$(echo hi | git hash-object --stdin) &&
+
+	echo ":1 $blob" >io.marks &&
+	echo ":1 $blob" >expect &&
+	echo ":2 $blob" >>expect &&
+
+	git fast-import --export-marks=io.marks <<-\EOF &&
+	feature import-marks-if-exists=io.marks
+	blob
+	mark :2
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks &&
+
+	echo ":3 $blob" >>expect &&
+
+	git fast-import --import-marks=io.marks \
+			--export-marks=io.marks <<-\EOF &&
+	feature import-marks-if-exists=not_io.marks
+	blob
+	mark :3
+	data 3
+	hi
+
+	EOF
+	test_cmp expect io.marks &&
+
+	>expect &&
+
+	git fast-import --import-marks-if-exists=not_io.marks \
+			--export-marks=io.marks <<-\EOF
+	feature import-marks-if-exists=io.marks
+	EOF
+	test_cmp expect io.marks
+'
+
 cat >input << EOF
 feature import-marks=marks.out
 feature export-marks=marks.new
-- 
1.7.3.4
