From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 07:55:17 +0100
Message-ID: <56D7DFD5.8010108@kdbg.org>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
 <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 07:55:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abNAV-0005Qt-08
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 07:55:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbcCCGzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 01:55:22 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:57609 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751010AbcCCGzV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 01:55:21 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3qG2yG2ZLbz5tlS;
	Thu,  3 Mar 2016 07:55:18 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D1E815220;
	Thu,  3 Mar 2016 07:55:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288167>

Am 03.03.2016 um 02:04 schrieb Duy Nguyen:
> On Thu, Mar 3, 2016 at 7:07 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>>
>> It looks like commit 57ea7123c86771f47f34e7d92d1822d8b429897a (git.c:
>> make sure we do not leak GIT_* to alias scripts, Dec 20 14:50:19 2015)
>> broke "./t0001-init.sh --valgrind".
> 
> Just wanted to confirm the problem. I will look at it later today.
> 

Here's a patch.

---- 8< ----
Subject: [PATCH] t0001: fix GIT_* environment variable check under --valgrind

When a test case is run without --valgrind, the wrap-for-bin.sh
helper script inserts the environment variable GIT_TEXTDOMAINDIR, but
when run with --valgrind, the variable is missing. A recently
introduced test case expects the presence of the variable, though, and
fails under --valgrind.

Rewrite the test case to strip conditially defined environment variables
from both expected and actual output.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 t/t0001-init.sh | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 295aa59..a5b9e7a 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -88,19 +88,17 @@ test_expect_success 'plain nested in bare through aliased command' '
 '
 
 test_expect_success 'No extra GIT_* on alias scripts' '
-	(
-		env | sed -ne "/^GIT_/s/=.*//p" &&
-		echo GIT_PREFIX &&        # setup.c
-		echo GIT_TEXTDOMAINDIR    # wrapper-for-bin.sh
-	) | sort | uniq >expected &&
-	cat <<-\EOF >script &&
-	#!/bin/sh
-	env | sed -ne "/^GIT_/s/=.*//p" | sort >actual
-	exit 0
+	write_script script <<-\EOF &&
+	env |
+		sed -n \
+			-e "/^GIT_PREFIX=/d" \
+			-e "/^GIT_TEXTDOMAINDIR=/d" \
+			-e "/^GIT_/s/=.*//p" |
+		sort
 	EOF
-	chmod 755 script &&
+	./script >expected &&
 	git config alias.script \!./script &&
-	( mkdir sub && cd sub && git script ) &&
+	( mkdir sub && cd sub && git script >../actual ) &&
 	test_cmp expected actual
 '
 
-- 
2.7.0.118.g90056ae
