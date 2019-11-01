Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6441F454
	for <e@80x24.org>; Fri,  1 Nov 2019 23:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbfKAXlZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 19:41:25 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:58187 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725989AbfKAXlZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 1 Nov 2019 19:41:25 -0400
X-Greylist: delayed 347 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Nov 2019 19:41:23 EDT
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10b])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id A06CE5F80840;
        Sat,  2 Nov 2019 02:35:34 +0300 (MSK)
Received: from iva4-994a9845f60e.qloud-c.yandex.net (iva4-994a9845f60e.qloud-c.yandex.net [2a02:6b8:c0c:152e:0:640:994a:9845])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id trjNR1j7HO-ZYNWM6hQ;
        Sat, 02 Nov 2019 02:35:34 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1572651334; bh=U0zTFs8vQRPzbafY7EXHTC9u/tyMRBmFIom5gt5t3dk=;
        h=Subject:To:From:Message-Id:Cc:Date;
        b=mgOzuxen79uMqxryN5SdcmYKtqi50+wOZOeuqSLg70xYw9NJ6zuOm/emPlqkT3H5D
         XTmelJKu/gTumaXAWwNBGFi05t+cpvi23jWKha+rBD2/ZuaHIGx0F1XFXRetUkOmHb
         nuZ+aT86UGg9rHEOoxe1AbK0mpBe7up9H39MHYXk=
Authentication-Results: mxback2j.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
Received: by iva4-994a9845f60e.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id hzwTqGuNc9-ZXWWtKOB;
        Sat, 02 Nov 2019 02:35:33 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87=D0=B5=D0=BD=D0=BA=D0=BE?= 
        <dpb@corrigendum.ru>
To:     paulus@ozlabs.org
Cc:     git@vger.kernel.org,
        =?UTF-8?q?=D0=A0=D0=BE=D0=BC=D0=B0=D0=BD=20=D0=94=D0=BE=D0=BD=D1=87?=
         =?UTF-8?q?=D0=B5=D0=BD=D0=BA=D0=BE?= <dpb@corrigendum.ru>
Subject: [PATCH] gitk: don't highlight files after submodules as submodules
Date:   Sat,  2 Nov 2019 02:34:27 +0300
Message-Id: <20191101233427.4108-1-dpb@corrigendum.ru>
X-Mailer: git-send-email 2.19.1.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitk applies submodule highlighting (coloring lines starting with
"  >" and "  <") when `currdiffsubmod` is not an empty string.
However, it fails to reset `currdiffsubmod` after a submodule diff
ends, so any file diffs following a submodule diff will still be
highlighted as if they were submodule diffs.

There are two problems with the way gitk tries to reset `currdiffsubmod`:

1. The code says `set $currdiffsubmod` instead of `set currdiffsubmod`,
   so it actually sets the variable whose name is the submodule path
   instead.

2. It tries to do it after the first line in a submodule diff, which
   is incorrect, since submodule diffs can contain multiple lines.

Fix this by resetting `currdiffsubmod` when a file diff starts.

Signed-off-by: Роман Донченко <dpb@corrigendum.ru>
---
 gitk | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index abe4805..7c425d2 100755
--- a/gitk
+++ b/gitk
@@ -8146,6 +8146,8 @@ proc parseblobdiffline {ids line} {
 	}
 	# start of a new file
 	set diffinhdr 1
+	set currdiffsubmod ""
+
 	$ctext insert end "\n"
 	set curdiffstart [$ctext index "end - 1c"]
 	lappend ctext_file_names ""
@@ -8229,11 +8231,9 @@ proc parseblobdiffline {ids line} {
 	    $ctext insert end "$line\n" filesep
 	}
     } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  >" $line]} {
-	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" dresult
     } elseif {$currdiffsubmod != "" && ![string compare -length 3 "  <" $line]} {
-	set $currdiffsubmod ""
 	set line [encoding convertfrom $diffencoding $line]
 	$ctext insert end "$line\n" d0
     } elseif {$diffinhdr} {
-- 
2.19.1.windows.1

