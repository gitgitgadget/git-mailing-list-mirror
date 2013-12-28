From: =?KOI8-R?B?98HTyczJyiDtwcvB0s/X?= <einmalfel@gmail.com>
Subject: [PATCH 2/2] t6010: add test to git merge-base --all --octopus
Date: Sat, 28 Dec 2013 15:04:41 +0400
Message-ID: <CABEtfDFRYkbVsJc2SZcCPwyUBAN=3dMv9yoYuoRce4c7VBxrkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: jrnieder@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 28 12:04:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwrhH-0000yn-1c
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 12:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755089Ab3L1LEn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 06:04:43 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:54790 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab3L1LEm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 06:04:42 -0500
Received: by mail-wi0-f171.google.com with SMTP id bz8so14998722wib.16
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=ajnDQdccXLeuGaE2wyjrPtKqXh0HRX6RKcuifqdHNzM=;
        b=CU5NUC9Fejf1WT1jZnuYF7pJlvMzip8uDSUkt+f4zzTa9Coz9eOJ9zKIKJw2mcZROw
         mnu5no8/ZCiSP+Y3hwIfYoXUvCsmUlBCUiIIRYCm478zPcWNVgF1U+t28keT3WY5jzM5
         vIZFCjVXmSgwq2zD7H+JaIPZFosq8JvZKECJ77tBylfmuvIN7W2yj6Axf7Ja89okz13P
         9T/DWko6fqnwM1x0w3vwj8+KjbvlFR25Diq0qUZ6Xs7RD11Sqg4FGMIDwF35e9lw6pqo
         HP43mWuL/0bIXjZV6BSHB5sqQdlNYA/wUIDa6CpqTDX7A56afuT1sUVAvNrKhMr2qShH
         FG3A==
X-Received: by 10.180.205.138 with SMTP id lg10mr36080048wic.30.1388228681316;
 Sat, 28 Dec 2013 03:04:41 -0800 (PST)
Received: by 10.194.123.228 with HTTP; Sat, 28 Dec 2013 03:04:41 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239783>

And here is the test:

with git 1.8.5.2 this test don't pass because of git merge-base may
return duplicates and incorrect set of bases (not best common
ancestors)
---
 t/t6010-merge-base.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
index f80bba8..8652c12 100755
--- a/t/t6010-merge-base.sh
+++ b/t/t6010-merge-base.sh
@@ -230,4 +230,43 @@ test_expect_success 'criss-cross merge-base for
octopus-step' '
  test_cmp expected.sorted actual.sorted
 '

+test_expect_success 'merge-base --octopus --all for complex tree' '
+ # Best common ancestor for JE, JAA and JDD is JC
+ #             JE
+ #            / |
+ #           /  |
+ #          /   |
+ #  JAA    /    |
+ #   |\   /     |
+ #   | \  | JDD |
+ #   |  \ |/ |  |
+ #   |   JC JD  |
+ #   |    | /|  |
+ #   |    |/ |  |
+ #  JA    |  |  |
+ #   |\  /|  |  |
+ #   | JB |  |  |
+ #   \  \ | /   /
+ #    \__\|/___/
+ #        J
+ test_commit J &&
+ test_commit JB &&
+ git reset --hard J &&
+ test_commit JC &&
+ git reset --hard J &&
+ test_commit JTEMP1 &&
+ test_merge JA JB &&
+ test_merge JAA JC &&
+ git reset --hard J &&
+ test_commit JTEMP2 &&
+ test_merge JD JB &&
+ test_merge JDD JC &&
+ git reset --hard J &&
+ test_commit JTEMP3 &&
+ test_merge JE JC &&
+ git rev-parse JC > expected &&
+ git merge-base --all --octopus JAA JDD JE > actual &&
+ test_cmp expected actual
+'
+
 test_done
-- 
1.8.3.1
