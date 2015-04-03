From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v3] diff-highlight: do not split multibyte characters
Date: Fri,  3 Apr 2015 15:15:14 -0700
Message-ID: <6a8dcc870e53040e1f54d7c36a1b33a@74d39fa044aa309eaea14b9f57fe79c>
References: <1427730933-26189-1-git-send-email-eungjun.yi@navercorp.com> <20150330221635.GB25212@peff.net> <ffa56a1b1257732077c287a5cfdd138@74d39fa044aa309eaea14b9f57fe79c> <20150403012430.GA16173@peff.net> <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>, Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 00:15:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ye9s7-0000Wd-M6
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 00:15:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbbDCWPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Apr 2015 18:15:24 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34701 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbbDCWPW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Apr 2015 18:15:22 -0400
Received: by pactp5 with SMTP id tp5so128163995pac.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2015 15:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1+8ir0jR/RpibP2z6pON/M0pUCjW7kzx0go4lkJJrUc=;
        b=W0PT8/ChDlk4wvT8PRbViYt0rmnzOWEhIzf7vs0jHFWDrSE3MEHY2J/0PNdBn83E0R
         RJ7JWlOold61YsMW4xNFS7ZFOqasH+nfzEoVbhpuDJeweyQczXvOYbpsCkwzoQfFJiw5
         I1lqI66/5KybffW+S7j/lOYnH9fjCxPsHnYuDEhg5dj4nJV8P4+UiwSBmLY5UlyQQy/x
         2Nkvb9vMywKhkSAMXzDqOQc532Xjs57cgwF9cHvqrlUkE25Ja6/tTToXbX+jgTSP8hAA
         kECaAGnVtpl70QuH1QLapZf3ynygt5U1ED9yFK7RPTG85Bf0aEfF2zA9QXp0uRVN1hyg
         IZ2w==
X-Received: by 10.70.101.65 with SMTP id fe1mr7696911pdb.54.1428099322383;
        Fri, 03 Apr 2015 15:15:22 -0700 (PDT)
Received: from localhost.localdomain ([2002:48c0:ad8d:0:223:12ff:fe05:eebd])
        by mx.google.com with ESMTPSA id v3sm3050682pbs.18.2015.04.03.15.15.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 03 Apr 2015 15:15:21 -0700 (PDT)
In-Reply-To: <CAFT+Tg8-tUBAvgX1bTni7joye_ZuZ_NOT_mmamnnm5GdWzEhrg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266741>

When the input is UTF-8 and Perl is operating on bytes instead of
characters, a diff that changes one multibyte character to another
that shares an initial byte sequence will result in a broken diff
display as the common byte sequence prefix will be separated from
the rest of the bytes in the multibyte character.

For example, if a single line contains only the unicode character
U+C9C4 (encoded as UTF-8 0xEC, 0xA7, 0x84) and that line is then
changed to the unicode character U+C9C0 (encoded as UTF-8 0xEC,
0xA7, 0x80), when operating on bytes diff-highlight will show only
the single byte change from 0x84 to 0x80 thus creating invalid UTF-8
and a broken diff display.

Fix this by putting Perl into character mode when splitting the line
and then back into byte mode after the split is finished.

The utf8::xxx functions require Perl 5.8 so we require that as well.

Also, since we are mucking with code in the split_line function, we
change a '*' quantifier to a '+' quantifier when matching the $COLOR
expression which has the side effect of speeding everything up while
eliminating useless '' elements in the returned array.

Reported-by: Yi EungJun <semtlenori@gmail.com>
Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
---

On Apr 2, 2015, at 19:19, Yi, EungJun wrote:
>> I timed this one versus the existing diff-highlight. It's about 7%
>> slower. That's not great, but is acceptable to me. The  
>> String::Multibyte
>> version was a lot faster, which was nice (but I'm still unclear on
>> _why_).
>
> I think the reason is here:
>
>> sub split_line {
>>   local $_ = shift;
>>   return map { /$COLOR/ ? $_ : ($mbcs ? $mbcs->strsplit('', $_) :  
>> split //) }
>>          split /($COLOR)/;
>> }
>
> I removed "*" from "split /($COLOR*)/". Actually I don't know why "*"
> was required but I need to remove it to make my patch works correctly.
>
> On Fri, Apr 3, 2015 at 10:24 AM, Jeff King <peff@peff.net> wrote:
>> EungJun, does this version meet your needs?

This version differs from the former as follows:

1) Slightly faster code that eliminates the need for Encode::is_utf8.

2) The '*' quantifier is changed to '+' in the split_line regexs which  
was probably the original intent anyway as using '*' generates useless  
empty elements.  This has the side effect of greatly increasing the  
speed so the tiny speed penalty for the UTF-8 checking is vastly  
overwhelmed by the overall speed up. :)

3) The 'use 5.008;' line has been added since the utf8::xxx functions  
require Perl 5.8

-Kyle

 contrib/diff-highlight/diff-highlight | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index 08c88bbc..ffefc31a 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -1,5 +1,6 @@
 #!/usr/bin/perl
 
+use 5.008;
 use warnings FATAL => 'all';
 use strict;
 
@@ -164,8 +165,12 @@ sub highlight_pair {
 
 sub split_line {
 	local $_ = shift;
-	return map { /$COLOR/ ? $_ : (split //) }
-	       split /($COLOR*)/;
+	return utf8::decode($_) ?
+		map { utf8::encode($_); $_ }
+			map { /$COLOR/ ? $_ : (split //) }
+			split /($COLOR+)/ :
+		map { /$COLOR/ ? $_ : (split //) }
+		split /($COLOR+)/;
 }
 
 sub highlight_line {
---
