From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH sb/diff-orderfile-config] diff test: reading a directory as a
 file need not error out
Date: Fri, 10 Jan 2014 12:10:31 -0800
Message-ID: <20140110201031.GI4776@google.com>
References: <CADsOX3DBmNituJsiYEBRENQeosASXtV_hd0zUW13cBoDZWHRhg@mail.gmail.com>
 <1387411692-15562-3-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Anders Waldenborg <anders@0x63.nu>,
	Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 21:10:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1iPm-0006NJ-0I
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 21:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbaAJUKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 15:10:37 -0500
Received: from mail-yh0-f51.google.com ([209.85.213.51]:57844 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbaAJUKf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 15:10:35 -0500
Received: by mail-yh0-f51.google.com with SMTP id l109so783908yhq.38
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=aT4ChR1mNzHZfnexd/b1n577ePdKokdwqhM7XXW0i5E=;
        b=v/BoDTzTx0MZ6N0rDFHJNuMBY4Ba6s7cXSVqCd/NF1x+69j4gdjUALeBqIY4/V3qvB
         dO3FUgAPbgaBXiYEDUcb4O/otKKWbrH2mlzxqt0gNJ706/8d2hFnkC+AA4dUnq2aB0Q0
         uNSKStgNFM4Ze1AWvqy3e/yYufqkbK0qu7ZcIBdLmXjZ4ZQro05yGHPysCiPyPfoVW40
         J8I/zlinYQY3C3W4xhTiv3xcCtMjNUL4Q5Z7sctQDX92Ndpvqe+vjqS2qC7s/85w+ghI
         jnl3B43Ox2r/mT3d0dDmFsLD5qISwkjgo5yYhnRCmEvw2b7APxm05ydR5f+v2ZJnQT1L
         i+6w==
X-Received: by 10.236.147.129 with SMTP id t1mr2654204yhj.91.1389384634738;
        Fri, 10 Jan 2014 12:10:34 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 23sm5583225yhj.5.2014.01.10.12.10.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 10 Jan 2014 12:10:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1387411692-15562-3-git-send-email-naesten@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240315>

There is no guarantee that strbuf_read_file must error out for
directories.  On some operating systems (e.g., Debian GNU/kFreeBSD
wheezy), reading a directory gives its raw content:

	$ head -c5 < / | cat -A
	^AM-|^_^@^L$

As a result, 'git diff -O/' succeeds instead of erroring out on
these systems, causing t4056.5 "orderfile is a directory" to fail.

On some weird OS it might even make sense to pass a directory to the
-O option and this is not a common user mistake that needs catching.
Remove the test.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

t4056 is failing on systems using glibc with the kernel of FreeBSD[1]:

| expecting success: 
| 	test_must_fail git diff -O/ --name-only HEAD^..HEAD
|
| a.h
| b.c
| c/Makefile
| d.txt
| test_must_fail: command succeeded: git diff -O/ --name-only HEAD^..HEAD
| not ok 5 - orderfile is a directory

How about this patch?

Thanks,
Jonathan

[1] https://buildd.debian.org/status/fetch.php?pkg=git&arch=kfreebsd-amd64&ver=1%3A2.0~next.20140107-1&stamp=1389379274

 t/t4056-diff-order.sh | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
index 1ddd226..9e2b29e 100755
--- a/t/t4056-diff-order.sh
+++ b/t/t4056-diff-order.sh
@@ -68,10 +68,6 @@ test_expect_success POSIXPERM,SANITY 'unreadable orderfile' '
 	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
 '
 
-test_expect_success 'orderfile is a directory' '
-	test_must_fail git diff -O/ --name-only HEAD^..HEAD
-'
-
 for i in 1 2
 do
 	test_expect_success "orderfile using option ($i)" '
-- 
1.8.5.1
