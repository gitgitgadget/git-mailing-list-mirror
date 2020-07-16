Return-Path: <SRS0=27Fn=A3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A63C433E4
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3414D206F4
	for <git@archiver.kernel.org>; Thu, 16 Jul 2020 14:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ltpcgo.com header.i=@ltpcgo.com header.b="pE2XBf+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgGPOZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:25:53 -0400
Received: from mail.ltpcgo.com ([54.93.149.123]:51416 "EHLO mail.ltpcgo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728622AbgGPOZw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jul 2020 10:25:52 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 10:25:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ltpcgo.com; h=
 organization:message-id:subject:subject:from:from:date:date
 :content-transfer-encoding:content-type:content-type
 :mime-version; s=mail; t=1594909545; bh=AX16XLqMxyB81vX80S3jx/Q5
 enm3lT0VSiXXS/LMaCs=; b=pE2XBf+pjxKBIE9s/K6GkzVkQe5IiSgY1b8FxKZY
 7jRUayH9SxhAzCw6cE6FjuSpnsmSSuc3+vixthLeTKFbKlkg8ZqiiK8OcaSbUywU
 i8L6QW+I6a8crLVtMlBCxNd2+W5XqPUXZCEu7IoccIP1lS+whc525atqICkrqZS6
 aRpq8ldyHtDSdD/BNrC4hKWp7Uwskv9/E0dBV76x/FJT+aUpN16NS7XwdG8ZmtS2
 J+ZYzmY7AI+HJiJ4Iu8SmwU7Rd9CUNOLfsTBmo0IMK+SPejm16wgdJYAVg4NH+Pc
 z69mxl6QO1vltyIrW0GvOasdT0zOFUn85+eiRV9YQ37B3Q==
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date:   Thu, 16 Jul 2020 16:25:45 +0200
From:   LTPCGO | George <george@ltpcgo.com>
To:     git@vger.kernel.org
Subject: Issue with insufficient permission for adding an object to repository
 database .git/objects
Message-ID: <d6bbe71e47dcfd7ef31213537eeb3f05@ltpcgo.com>
Organization: LTPCGO
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

See discussion here=20
https://groups.google.com/forum/?fromgroups#!topic/git-users/35HBb76oA6c=20
and https://github.com/trapexit/mergerfs/issues/626

On certain file systems, there are issues with staging a commit because=20
a call to open a file stored under .git/objects fails.  It has been=20
brought up in this discussion group previously.

I have attached a fix below, but it would be much better to fix in the=20
code.  I am curious first, before proposing a fix in the code (although=20
I can't find the specific call in the source at=20
https://github.com/git/git ), what the reasoning is for the current=20
permissions check on the call rather than checking the contents of the=20
opened tmp file.

cc -Wall -O3 -D_GNU_SOURCE -fPIC -c -o githack.o githack.c; gcc -o=20
githack.so -nostartfiles -shared githack.o -ldl;



LD_PRELOAD=3D./githack.so git commit -a -m "Some new commit"



The code is below:

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>
//#define openat ignorethisopen
#define open ignorethisopen
#define open64 ignorethisopen64
#include <fcntl.h>
//#undef openat
#undef open
#undef open64
#include <dlfcn.h>

/*
        'strace git ...' will show git fail on an openat() command
        this is probably implemented as open64() on your system
        you can confirm this by use of 'ltrace git ...'
        you may also need to adjust the oflag comparison of 194
*/

/*static int (*___openat)(int, char *, int, mode_t);*/
static int (*___open)(const char *, int, mode_t);
static int (*___open64)(const char *, int, mode_t);

static void* dlwrap(const char *fn)
{
        const char *e;
        void *p =3D dlsym(RTLD_NEXT, fn);
        if ((e=3Ddlerror())!=3D0)  fprintf(stderr, "dlsym(RTLD_NEXT,'%s')=
:=20
%s\r\n", fn, e);
        return p;
}

void _init(void)
{
        ___open =3D dlwrap("open");
        ___open64 =3D dlwrap("open64");
}

/*int openat(int dirfd, const char *pathname, int oflag, mode_t mode)*/
int open(const char *pathname, int oflag, mode_t mode)
{
        if (oflag && oflag =3D=3D 194)
               return ___open(pathname, oflag, S_IRWXU);
        return ___open(pathname, oflag, mode);
}

int open64(const char *pathname, int oflag, mode_t mode)
{
        if (oflag && oflag =3D=3D 194)
               return ___open64(pathname, oflag, S_IRWXU);
        return ___open64(pathname, oflag, mode);
}

=F0=9F=96=B3 LTPCGO =F0=9F=96=B3
Next-level security
Dr. George O=E2=80=99Neill
+44 7717 318 220
george@ltpcgo.com
https://www.ltpcgo.com/
