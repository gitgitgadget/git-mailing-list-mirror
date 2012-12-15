From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC 0/3] compiling git with gcc -O3 -Wuninitialized
Date: Sat, 15 Dec 2012 10:07:54 +0700
Message-ID: <CACsJy8BqOEvEHy7i89fKSgQH5kUYFWvchJwD_fQsYjagrh+X2w@mail.gmail.com>
References: <20121214220903.GA18418@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 04:12:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjiAn-0007FP-D4
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 04:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab2LODIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2012 22:08:25 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38364 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab2LODIY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2012 22:08:24 -0500
Received: by mail-ob0-f174.google.com with SMTP id ta14so4052077obb.19
        for <git@vger.kernel.org>; Fri, 14 Dec 2012 19:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=M+Eu3wP/rgG/AOK/cB0BGcU7CWP2W8101Xo/0i2OGec=;
        b=nMhWZDbkg150YOQUR8SIXV0+Ln+F352AWsQWKkyubpFou177q30h4Kwv4t+A253gno
         qkCzNd4hbzsJkPmwi8FgLVk4oocb7HZCNp6xqbKouuN0EOt+/sZpt3yeayZOoaSXE+Ou
         icZ5cu5eL3Hi40XsUcLu08hhjE0ixVG0eXnNvyUgKsUVPuIzFBbvmotZNR7LcXxFU4ic
         +pHmkYDvKo5mmuPnbL2nWGzguHF2SUoImqE74YECnqj0doVprDVbpkRfRSOIy2PjQnOm
         +9+ueH89H1lN5MRTrW5PIlHPxbjBvSOu8luNq1h+yCCYawH4OYN3Z+GMtAMRRtPi8znc
         FUgg==
Received: by 10.182.177.72 with SMTP id co8mr6368389obc.53.1355540904334; Fri,
 14 Dec 2012 19:08:24 -0800 (PST)
Received: by 10.182.41.229 with HTTP; Fri, 14 Dec 2012 19:07:54 -0800 (PST)
In-Reply-To: <20121214220903.GA18418@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211516>

On Sat, Dec 15, 2012 at 5:09 AM, Jeff King <peff@peff.net> wrote:
> I always compile git with "gcc -Wall -Werror", because it catches a lot
> of dubious constructs, and we usually keep the code warning-free.
> However, I also typically compile with "-O0" because I end up debugging
> a fair bit.
>
> Sometimes, though, I compile with -O3, which yields a bunch of new
> "variable might be used uninitialized" warnings. What's happening is
> that as functions get inlined, the compiler can do more static analysis
> of the variables. So given two functions like:
>
>   int get_foo(int *foo)
>   {
>         if (something_that_might_fail() < 0)
>                 return error("unable to get foo");
>         *foo = 0;
>         return 0;
>   }
>
>   void some_fun(void)
>   {
>           int foo;
>           if (get_foo(&foo) < 0)
>                   return -1;
>           printf("foo is %d\n", foo);
>   }
>
> If get_foo() is not inlined, then when compiling some_fun, gcc sees only
> that a pointer to the local variable is passed, and must assume that it
> is an out parameter that is initialized after get_foo returns.
>
> However, when get_foo() is inlined, the compiler may look at all of the
> code together and see that some code paths in get_foo() do not
> initialize the variable. And we get the extra warnings.

Other options:

 - Any __attribute__ or #pragma to aid flow analysis (or would gcc dev be
   willing to add one)?

 - Maintain a list of false positives and filter them out from gcc output?

And if we do this, should we support other compilers as well? I tried
clang once a long while ago and got a bunch of warnings iirc.
-- 
Duy
