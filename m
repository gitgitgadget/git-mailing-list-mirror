From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/7] t4018 (funcname patterns): make .gitattributes state
 easier to track
Date: Sat, 21 May 2011 14:11:33 -0500
Message-ID: <20110521191133.GB10530@elie>
References: <BANLkTi=OXznTspN-CJjM0YXfqARxL=J+Ow@mail.gmail.com>
 <20110521185314.GA10530@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 21:11:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNraR-0001M8-58
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 21:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775Ab1EUTLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 15:11:39 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36517 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab1EUTLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 15:11:37 -0400
Received: by iyb14 with SMTP id 14so3666995iyb.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=15vi3PnGHcTywKIKQuXV/t/j/2QHB/02m1KHT1W5j8w=;
        b=MFixqtOvqJ0TJMhJmDEtgcCA0drW0ETgDwzbqoF4TCYVPMDc+0sNirUnFd32ldY4wr
         3TLw7ifplroHXZP7oWcB/F8fZ7siZuN5aPnVaREA0ufC2cZYc+/NJR32k0vuompIJ0aA
         xNK2au4yr0dExzBhxvlFTRHWGbCCWmRWmT+Lo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KhMxowBNHpw/UQoq2JZHDctMYPx6udKyamZswNYO+LOeED6A7j3p97RB5rM4ZEiS2e
         RGkfuVYwrE1MGolN8fiWVcmFDtGXK8ZOHesQNFKU85lrvNyJoyAfExh+tEnhrZQZG+pw
         3Bj30H587ZC7cGRiM5+KH/hH2FezGnwfZrEgs=
Received: by 10.42.219.65 with SMTP id ht1mr6765703icb.14.1306005097146;
        Sat, 21 May 2011 12:11:37 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.ameritech.net [69.209.78.180])
        by mx.google.com with ESMTPS id g16sm2065443ibb.54.2011.05.21.12.11.35
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 12:11:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110521185314.GA10530@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174168>

Most, but not all, tests in this script rely on attributes declaring
that files with a .java extension should use the "java" driver:

	*.java diff=java

Split out a "set up" test to put such a .gitattributes in place after
the tests that do not want it have run, to make it more likely that
individual tests other than this setup test can be safely modified,
rearranged, or skipped.  Presumably this setup code will learn to
request other drivers for other extensions in the same place when the
test suite learns to exercise other diff drivers.

Similarly, make sure that early test assertions that do not use these
default attributes set up .gitattributes appropriately for themselves,
so tests that run before can be modified with less risk of breaking
something.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t4018-diff-funcname.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 3646930..24eb1a3 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -36,11 +36,12 @@ builtin_patterns="bibtex cpp csharp fortran html java objc pascal perl php pytho
 for p in $builtin_patterns
 do
 	test_expect_success "builtin $p pattern compiles" '
-		echo "*.java diff=$p" > .gitattributes &&
+		echo "*.java diff=$p" >.gitattributes &&
 		! { git diff --no-index Beer.java Beer-correct.java 2>&1 |
 			grep "fatal" > /dev/null; }
 	'
 	test_expect_success "builtin $p wordRegex pattern compiles" '
+		echo "*.java diff=$p" >.gitattributes &&
 		! { git diff --no-index --word-diff \
 			Beer.java Beer-correct.java 2>&1 |
 			grep "fatal" > /dev/null; }
@@ -53,8 +54,11 @@ test_expect_success 'default behaviour' '
 	grep "^@@.*@@ public class Beer"
 '
 
+test_expect_success 'set up .gitattributes declaring drivers to test' '
+	echo "*.java diff=java" >.gitattributes
+'
+
 test_expect_success 'preset java pattern' '
-	echo "*.java diff=java" >.gitattributes &&
 	git diff --no-index Beer.java Beer-correct.java |
 	grep "^@@.*@@ public static void main("
 '
-- 
1.7.5.1
