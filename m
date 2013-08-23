From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] t3103: demonstrate dir.c:treat_one_path() core.ignorecase failure
Date: Fri, 23 Aug 2013 16:29:18 -0400
Message-ID: <1377289759-46838-2-git-send-email-sunshine@sunshineco.com>
References: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 23 22:29:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCxzQ-0003HZ-IT
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 22:29:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686Ab3HWU3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 16:29:42 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:62220 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174Ab3HWU3l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 16:29:41 -0400
Received: by mail-ie0-f181.google.com with SMTP id a14so1647782iee.12
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7W8owVMAPmvdy5FEN8JosxIMsbCHMph1V7xc00P38R0=;
        b=nwhqIvvJCky09ChjM5JQnJfm6ACtI6Bntx9KGg9NYpIBpDohGncHGSSBmg442y9ptG
         3LBgLJoh5zBK35xevS7bjSR4v1iD6fPs1PzzysWbbdRBcANONxw7Xq7v/zEwGdoV9Z/F
         8idxOxR0UEdWMUdckuNuVsPN1+1bIupFKXAg2LWO+2YJ48NI1VddyLV18I6Le/Dy/yEY
         8haM8W2tIrh3mT3rE9z/HWGZr04RGjB8S7xfok60MDAu6yJ3hS1TNaGcpWgDiXN7CaCF
         /lxt4hlGr18Cyy9kUHGYkvUs0A6VmDEZkWc8Sn+sXcnlr5kq7g8eL73iemupoOwY3INu
         aPDA==
X-Received: by 10.50.114.135 with SMTP id jg7mr1063498igb.49.1377289781180;
        Fri, 23 Aug 2013 13:29:41 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id cl4sm89620igc.1.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 23 Aug 2013 13:29:40 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.557.g46c5bb2
In-Reply-To: <1377289759-46838-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232834>

2eac2a4cc4bdc8d7 (ls-files -k: a directory only can be killed if the
index has a non-directory; 2013-08-15) adds a caller of
directory_exists_in_index(dirname,len) which forgets to satisfy the
undocumented requirement that a '/' must be present at dirname[len]
(despite being past the end-of-string). This oversight leads to
incorrect behavior when core.ignorecase is true. Demonstrate this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3010-ls-files-killed-modified.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3010-ls-files-killed-modified.sh b/t/t3010-ls-files-killed-modified.sh
index 3120efd..198d308 100755
--- a/t/t3010-ls-files-killed-modified.sh
+++ b/t/t3010-ls-files-killed-modified.sh
@@ -103,6 +103,14 @@ test_expect_success 'validate git ls-files -k output.' '
 	test_cmp .expected .output
 '
 
+test_expect_success 'git ls-files -k to show killed files (icase).' '
+	git -c core.ignorecase=true ls-files -k >.output
+'
+
+test_expect_failure 'validate git ls-files -k output (icase).' '
+	test_cmp .expected .output
+'
+
 test_expect_success 'git ls-files -m to show modified files.' '
 	git ls-files -m >.output
 '
-- 
1.8.4.rc4.557.g46c5bb2
