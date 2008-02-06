From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] Add tests for diff/status color parser
Date: Wed, 6 Feb 2008 14:16:26 +0200
Message-ID: <20080206141626.0f2b532c.tihirvon@gmail.com>
References: <47A89E2A.9010905@kergoth.com>
	<20080205203940.1dcff0ce.tihirvon@gmail.com>
	<b6ebd0a50802051045t4949df68u7e405ea618403a31@mail.gmail.com>
	<20080205205856.76a7cd45.tihirvon@gmail.com>
	<20080205211821.e4a15194.tihirvon@gmail.com>
	<7vzluez9q9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 13:17:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMjDY-0007GZ-C7
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 13:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762229AbYBFMQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 07:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762225AbYBFMQi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 07:16:38 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:62645 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762202AbYBFMQh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 07:16:37 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1919522rvb.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 04:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=DJ9WCnL8mVJpjGouU6GheyH0nOEtYsOInYpVIZnoWu0=;
        b=REUv9Yb7mkin8JTLyhG0LCy6T4fBiST3FFENrhdyxiJ5+3LBw5Ivh7jaRqp+bMbyMdNMD5ynuJhUPXs3Pnreb8E7M719cXart17hDwAWo7EnadudfKHvOeRvhLCFQvIHoHxIzACTRHrKwuCat5lTGonausk7Mu5zVOA7D/1XWDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=SBRxjVdwimIpGkRLWF6EfA/iAOHA9ZYLnSxfKCa3qbdhzgjHP5kuwQX11PNxSLggxIQ79ZuGzH1S5EpydQGNhzhZmALaiH/hMCBFyz3eWTgvgFeUH8veUZqLaPwNSnNk2SeO2eUnHdl45dw11smDT2lKj4wXRQLuxFKgj9tXDoE=
Received: by 10.141.20.7 with SMTP id x7mr6560974rvi.82.1202300196908;
        Wed, 06 Feb 2008 04:16:36 -0800 (PST)
Received: from garlic.home.net ( [85.23.16.168])
        by mx.google.com with ESMTPS id k7sm25966847nfh.0.2008.02.06.04.16.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Feb 2008 04:16:34 -0800 (PST)
In-Reply-To: <7vzluez9q9.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72807>

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---
 I don't know if t4026-color.sh is good name for this. Feel free to change.

 t/t4026-color.sh |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)
 create mode 100755 t/t4026-color.sh

diff --git a/t/t4026-color.sh b/t/t4026-color.sh
new file mode 100755
index 0000000..b61e516
--- /dev/null
+++ b/t/t4026-color.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (c) 2008 Timo Hirvonen
+#
+
+test_description='Test diff/status color escape codes'
+. ./test-lib.sh
+
+color()
+{
+	git config diff.color.new "$1" &&
+	test "`git config --get-color diff.color.new`" = "$2"
+}
+
+invalid_color()
+{
+	git config diff.color.new "$1" &&
+	test -z "`git config --get-color diff.color.new 2>/dev/null`"
+}
+
+test_expect_success 'reset' '
+	color "reset" "[m"
+'
+
+test_expect_success 'attribute before color name' '
+	color "bold red" "[1;31m"
+'
+
+test_expect_success 'color name before attribute' '
+	color "red bold" "[1;31m"
+'
+
+test_expect_success 'attr fg bg' '
+	color "ul blue red" "[4;34;41m"
+'
+
+test_expect_success 'fg attr bg' '
+	color "blue ul red" "[4;34;41m"
+'
+
+test_expect_success 'fg bg attr' '
+	color "blue red ul" "[4;34;41m"
+'
+
+test_expect_success '256 colors' '
+	color "254 bold 255" "[1;38;5;254;48;5;255m"
+'
+
+test_expect_success 'color too small' '
+	invalid_color "-2"
+'
+
+test_expect_success 'color too big' '
+	invalid_color "256"
+'
+
+test_expect_success 'extra character after color number' '
+	invalid_color "3X"
+'
+
+test_expect_success 'extra character after color name' '
+	invalid_color "redX"
+'
+
+test_expect_success 'extra character after attribute' '
+	invalid_color "dimX"
+'
+
+test_done
-- 
1.5.4.1135.gae084
