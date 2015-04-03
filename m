From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] diff-highlight: Fix broken multibyte string
Date: Thu,  2 Apr 2015 17:49:24 -0700
Message-ID: <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com> <20150330221635.GB25212@peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 02:49:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydpnu-0000RK-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 02:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbDCAtm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 20:49:42 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33616 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbDCAtl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 20:49:41 -0400
Received: by pdbnk13 with SMTP id nk13so25391021pdb.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=868/4zw0XbOghFkCBWxEelhJIzuErICEEdD/aoK0gNk=;
        b=k4IfUNbu39rum1ytHZRqgAMIUrF4EHguw0eOKmZZxvPXI1xM8VZ/ZyzHs8pylXpgYw
         jzuhz1ZIwlo1NUogB+lprloVJLI/iN1HhSWuOjId4xCsyzwZ3X6GqmD+7irOUze2K4hG
         7oJMWfxHabWUwsHKXTVQbVJjzRr4h06Hc1V2zuytnxTMi8ksdd4rsHUFXL2br0bBnWiP
         d8Jx6MpdpQbv3keKU7kPvyNONE4OGAtqFEOSVgqeFxcBge9eG7FEeaWiq9UNsqnnYwnF
         +0S5KB0qT5gpaHTdpCuu13VAf8S4vb++A3YkdlIi97Di+7XyHPZvSBd28jQ7LXh+/MPJ
         fd7g==
X-Received: by 10.68.110.195 with SMTP id ic3mr92257439pbb.124.1428022181196;
        Thu, 02 Apr 2015 17:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id r7sm6397557pdm.16.2015.04.02.17.49.39
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 17:49:40 -0700 (PDT)
In-Reply-To: <20150330221635.GB25212@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266695>

On Mar 30, 2015, at 15:16, Jeff King wrote:

> Yeah, I agree the current output is not ideal, and this should address
> the problem. I was worried that multi-byte splitting would make things
> slower, but in my tests, it actually speeds things up!

[...]

> Unfortunately, String::Multibyte is not a standard module, and is not
> even packed for Debian systems (I got mine from CPAN). Can we make
> this
> a conditional include (e.g., 'eval "require String::Multibyte"' in
> get_mbcs, and return undef if that fails?). Then people without it can
> still use the script.

[...]

> Yuck. This is a lot more intimate with String::Multibyte's
> implementation than I'd like to be.

So I was curious about this and played with it and was able to
reproduce the problem as described.

Here's an alternate fix that should work for everyone with Perl 5.8
or later.

-Kyle

-- 8< --
Subject: [PATCH v2] diff-highlight: do not split multibyte characters

When the input is UTF-8 and Perl is operating on bytes instead
of characters, a diff that changes one multibyte character to
another that shares an initial byte sequence will result in a
broken diff display as the common byte sequence prefix will be
separated from the rest of the bytes in the multibyte character.

For example, if a single line contains only the unicode
character U+C9C4 (encoded as UTF-8 0xEC, 0xA7, 0x84) and that
line is then changed to the unicode character U+C9C0 (encoded as
UTF-8 0xEC, 0xA7, 0x80), when operating on bytes diff-highlight
will show only the single byte change from 0x84 to 0x80 thus
creating invalid UTF-8 and a broken diff display.

Fix this by putting Perl into character mode when splitting the
line and then back into byte mode after the split is finished.

While the utf8::xxx functions are built-in and do not require
any 'use' statement, the utf8::is_utf8 function did not appear
until Perl 5.8.1, but is identical to the Encode::is_utf8
function which is available in 5.8 so we use that instead of
utf8::is_utf8.

Reported-by: Yi EungJun <semtlenori@gmail.com>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---
 contrib/diff-highlight/diff-highlight | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 08c88bbc..8e9b5ada 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -2,6 +2,7 @@
 
 use warnings FATAL => 'all';
 use strict;
+use Encode ();
 
 # Highlight by reversing foreground and background. You could do
 # other things like bold or underline if you prefer.
@@ -164,8 +165,10 @@ sub highlight_pair {
 
 sub split_line {
 	local $_ = shift;
-	return map { /$COLOR/ ? $_ : (split //) }
-	       split /($COLOR*)/;
+	utf8::decode($_);
+	return map { utf8::encode($_) if Encode::is_utf8($_); $_ }
+		map { /$COLOR/ ? $_ : (split //) }
+		split /($COLOR*)/;
 }
 
 sub highlight_line {
---
