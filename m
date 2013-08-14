From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: Git bug. "make [all]" does not use USE_LIBPCRE when "configure
 --with-libpcre" was previously run
Date: Wed, 14 Aug 2013 16:48:49 +0400
Message-ID: <20130814124849.GA8234@ashu.dyn1.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 14:48:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9aVV-0005OE-VV
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 14:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320Ab3HNMsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 08:48:54 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:62145 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab3HNMsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 08:48:53 -0400
Received: by mail-lb0-f175.google.com with SMTP id 13so6819592lba.34
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=QZ9K/1VJJzFLJae3K5fB85ikvEIFwpIrESJEVSYlGuY=;
        b=BIDFUHiLuJ0HcE4UIma09F3EukHoCjXMVePvgK0Ceku3NFtxCuyWdu4BO81g33GLtf
         AEkPEGYV6zn/GjkbP3VY4SeNSPpYHwmX6CJ8SEUdQSU2U62mxFwYbDCw27u0RYwIeYAU
         1d+sIElf/RHc71Xm3+wLVLB22q8sggEeIV8eU/XY3I7U366i731wBiU+fxeTooU17G5J
         9Ltq7pCpLCzvRVuStULdcQlk98yRKwEFZaUSFsr9sN7r+BGk8v0z686sYuQWSiVxFnuy
         SQiA+whH0uNocVMY/RPaL1LuLj/OjtgMZ1vIqG5Z2Mv0lb91IkxFAuWqDVTYUGHbuQBE
         zZtA==
X-Received: by 10.152.3.42 with SMTP id 10mr8598741laz.22.1376484531600;
        Wed, 14 Aug 2013 05:48:51 -0700 (PDT)
Received: from localhost ([85.21.218.130])
        by mx.google.com with ESMTPSA id v5sm190045lbv.15.2013.08.14.05.48.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 05:48:50 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232283>

Hello, Stefan!

I'll begin from afar.

>From time to time, I use `git grep -P` to search text in sources using PCRE.
Today I was suprised when that command gave me the error
    "fatal: cannot use Perl-compatible regexes when not compiled with
    USE_LIBPCRE"

As far as I always use
    ./configure --with-libpcre 
    make all
to build my Cygwin version of Git that was a VERY sudden error for me.
(but this is not a Cygwin-specific error, I've reproduced it on my Linux
box).

I've found out that `make` "does not know" anymore about USE_LIBPCRE=YesPlease
even `./configure --with-libpcre` was run before it. But I do remember
that it worked in some versions before (currently I use latest - v1.8.3.4).

So, I've got armed with the following test script:

---8<---
#!/bin/sh

set -e
./configure --with-libpcre
make
set +e
./bin-wrappers/git grep -qIP das+
# if "cannot use Perl-compatible regexes" error occurs
# then Git exits with an error code 128 (but `git bisect run` fails to
# expect this exit code).
if test $? -eq 128
then
    exit 1
fi
---8<---

and `git bisect run` to find out where Git was broken.
That gave me:

---8<---
40bfbde9da5c6cbc85f49a755f27162dc966fd89 is the first bad commit
commit 40bfbde9da5c6cbc85f49a755f27162dc966fd89
Author: Stefano Lattarini <stefano.lattarini@gmail.com>
Date:   Tue Sep 11 17:45:30 2012 +0200

    build: don't duplicate substitution of make variables
    
    Thanks to our 'GIT_CONF_SUBST' layer in configure.ac, a make variable 'VAR'
    can be defined to a value 'VAL' at ./configure runtime in our build system
    simply by using "GIT_CONF_SUBST([VAR], [VAL])" in configure.ac, rather than
    having both to call "AC_SUBST([VAR], [VAL])" in configure.ac and adding the
    'VAR = @VAR@' definition in config.mak.in.  Less duplication, less margin
    for error, less possibility of confusion.
    
    While at it, fix some formatting issues in configure.ac that unnecessarily
    obscured the code flow.
    
    Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

:100644 100644 802d34223a2859ee1341d94ee722d7939b7276aa 69d48382fe69b8699eb350949fff04975db923f8 M      config.mak.in
:100644 100644 450bbe7f1020711b4af2ad6ea52d717651c30b0b da1f41f58871b2102a9ed5eaeff7df3c9623f4bd M      configure.ac
bisect run success

---8<---

I'm not a C programmer to fix that, so I ask you to.

-- 
Alexey Shumkin
