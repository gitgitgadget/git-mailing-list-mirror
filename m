From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 1/5] Fix generation of Documentation/usage-%.txt.
Date: Fri, 23 Jan 2015 14:24:55 +0100
Message-ID: <1422019499-2012-2-git-send-email-cederp@opera.com>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Jan 23 14:25:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEeFI-0003zH-2N
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 14:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbbAWNZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 08:25:51 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:44326 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbbAWNZu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 08:25:50 -0500
Received: by mail-wi0-f171.google.com with SMTP id l15so2803204wiw.4
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 05:25:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eZ+wHdszKOas7v/o6HQu9T3j7mMrLh8i86CZkV+3GxY=;
        b=bP5Wd21Ww3w3nNqOxaxrwImCwNlyF3ykoncxCLmhj2IlVLPG6WYECrcYNy3SLj6sA0
         ZDaAwgPx6yGGm4TkuzG5xj9dhDnF9F0tghwwoJf56waCQLvsKMkS0x6UvvTz5CjTc3Ke
         NDY/iXepVhfkjiVYaqzMLeVFRCl4EcHhLqRlBLnVPevigWECGXC+GB4DMYcY+hogj6GY
         shH94XOAWzITLmajlalQpXxE5a8pP92nNuQa7b04HrCJyD09+THVPRCx/gBq+4suna3o
         4x7iEmF+gQe1EVDIg3Tb2s35oODSwai+EfEq+ZEathAujGbHdNb0M3FnYiJaQE2KVX6E
         cvjA==
X-Gm-Message-State: ALoCoQm5IEm+oO+zmSoGeyL9hfx9Sd8fIe/ZEwbEqvToi2KjEuI/Ekq3WkQQar/w66i2983fTNib
X-Received: by 10.180.206.79 with SMTP id lm15mr3702617wic.67.1422019548952;
        Fri, 23 Jan 2015 05:25:48 -0800 (PST)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id fi10sm1841950wib.13.2015.01.23.05.25.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Jan 2015 05:25:47 -0800 (PST)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1422019499-2012-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262922>

The old rule worked, most of the time, but had several issues:

 - It depended on the corresponding guilt-*.txt file, but the usage.sh
   script actually reads ../guilt-foo.

 - Actually, each usage-%.txt depended on all guilt-*.txt files, so
   make had to do more work than necessary if a single file was
   altered.

 - The construct broke parallel make, which would spawn several
   usage.sh at once.  This leads to unnecessary work, and could
   potentially result in broken usage files if the "echo some_string >
   some_file" construct used by usage.sh isn't atomic.

Fixed by letting the usage.sh script update a single file, and writing
a proper implicit make rule.  This makes parallel make work a lot
better.

There is a small downside, though, as usage.sh will now be run once
for each command (if everything is regenerated).  I think it is worth
to pay that price to get the correctness.  This command is still very
fast compared to the docbook processing.

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 Documentation/Makefile | 4 ++--
 Documentation/usage.sh | 8 +++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index b6c3285..ec3c9e8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -66,8 +66,8 @@ clean:
 	rm -f usage-*.txt
 	rm -f version.txt
 
-usage-%.txt: $(MAN1_TXT) usage.sh
-	sh ./usage.sh
+usage-guilt-%.txt: ../guilt-% usage.sh
+	sh ./usage.sh $<
 
 %.html : %.txt footer.txt version.txt
 	$(ASCIIDOC) -b xhtml11 -d manpage -f asciidoc.conf $(ASCIIDOC_EXTRA) $<
diff --git a/Documentation/usage.sh b/Documentation/usage.sh
index 20fdca4..629f546 100644
--- a/Documentation/usage.sh
+++ b/Documentation/usage.sh
@@ -1,7 +1,5 @@
 #!/bin/sh
 
-for i in `ls ../guilt-*`; do
-	name=$(basename $i)
-	u=$(grep USAGE $i |  sed 's/USAGE="//' | sed 's/"$//') 
-	echo "'$name' $u"  > usage-$name.txt
-done
+name=$(basename $1)
+u=$(grep USAGE $1 |  sed 's/USAGE="//' | sed 's/"$//') 
+echo "'$name' $u"  > usage-$name.txt
-- 
2.1.0
