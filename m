From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: Regression in e02ca72: git svn rebase is broken on Windows
Date: Wed, 11 Sep 2013 11:19:18 +0800
Message-ID: <CANYiYbFaNP=UUKX-5N7qQppMRehuPgn8p1uN_UOJ6bDwTjzKEQ@mail.gmail.com>
References: <17231378818848@web5m.yandex.ru>
	<xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Tvangeste <i.4m.l33t@yandex.ru>,
	msysgit@googlegroups.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 05:19:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJaxg-0000ce-0K
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 05:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab3IKDTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 23:19:20 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:58626 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab3IKDTT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 23:19:19 -0400
Received: by mail-wi0-f175.google.com with SMTP id ez12so1570539wid.2
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 20:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0C2QhXAGdml2Z1y8sQlgXI2FieekNJB0qZRpMheoIEk=;
        b=vi6rJF4xMK44nrDPzvao7quj9GkfJ9UjV4AXgoiDUVd+PNGxWYCd8DhSJDklq4BCM3
         zkFRun44qtdDIHtigM/+Z3tobUiQiMJe83/nxLaUzX3oRgOKl84cY8SvqlDLINjGC0ie
         B6Jf9rIsm6nF5RLW/Ox1uBD/hRqjen9XjbFNH/yVUQHoU6EIFbVV6hw3kaqnVDsuWp+K
         zw0dHCaDcUD1hpbjzPSGevuNlcVbXI240BiWxWRVkB61jQy8z6GOMZmC7a6M1/bH7cCX
         1fvozOuXZzsx1Ft+mysNQj6sfYuptqFqE8kkqEXlwKsJnHMuGFPxT8fcjjHSvgwSqxgs
         9zLg==
X-Received: by 10.180.188.132 with SMTP id ga4mr15740743wic.10.1378869558484;
 Tue, 10 Sep 2013 20:19:18 -0700 (PDT)
Received: by 10.194.71.175 with HTTP; Tue, 10 Sep 2013 20:19:18 -0700 (PDT)
In-Reply-To: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234520>

2013/9/11 Junio C Hamano <gitster@pobox.com>:
> Tvangeste <i.4m.l33t@yandex.ru> writes:
>
>> Hi,
>>
>> After bisecting this problem I ended up with the mentioned commit that completely breaks git-svn for me on Windows (mingw/msys version).
>>
>> ==========
>> #> git svn rebase
>> warning: unable to access '': Invalid argument
>> warning: unable to access '': Invalid argument
>> fatal: unable to access '../../../../w:/work/my/repo.git/.git/config': Invalid argument
>> fatal: index file open failed: Invalid argument
>> Cannot rebase: You have unstaged changes.
>> Please commit or stash them.
>> rebase refs/remotes/trunk: command returned error: 1
>> ==========
>>
>> Please note that I use the official git repository as-is, this one (no additional patches):
>> git://git.kernel.org/pub/scm/git/git.git
>>
>> e02ca72f70ed8f0268a81f72cb3230c72e538e77 is the first bad commit
>> commit e02ca72f70ed8f0268a81f72cb3230c72e538e77
>> Author: Jiang Xin
>> Date:   Tue Jun 25 23:53:43 2013 +0800
>>
>>     path.c: refactor relative_path(), not only strip prefix
>>
>> Thanks,
>>   --Tvangeste
>
> The suspect commit and symptom look consistent.  You started from a
> directory whose absolute path is "w:/work/..." and the updated code
> mistakenly thoguht that something that begins with "w" (not '/') is
> not an absolute, so added a series of ../ to make it relative, or
> something silly like that.
>
> Jiang?

I tested 'relative_path' function using 'test-path-utils', and got the
following result:

    $ ./test-path-utils relative_path 'C:/a/b' 'D:/x/y'
    ../../../C:/a/b

    $ ./test-path-utils relative_path '/a/b' 'x/y'
    ../..//a/b

    $ ./test-path-utils relative_path 'a/b' '/x/y'
    ../../../a/b

For the first case, in and prefix are on different ROOT, and for the other
two cases, one path is a relative path, and another is an absolute path.

I write a patch to test whether two paths (in and prefix) have the same
root. The result after applied the patch:

    $ ./test-path-utils relative_path 'C:/a/b' 'C:/x/y'
    ../../a/b

    $ ./test-path-utils relative_path 'C:/a/b' 'D:/x/y'
    C:/a/b

    $ ./test-path-utils relative_path '/a/b' 'x/y'
    /a/b

    $ ./test-path-utils relative_path 'a/b' '/x/y'
    a/b


diff --git a/path.c b/path.c
index 7f3324a..51f5d28 100644
--- a/path.c
+++ b/path.c
@@ -441,6 +441,25 @@ int adjust_shared_perm(const char *path)
        return 0;
 }

+static int have_same_root(const char *path1, const char *path2)
+{
+       /* for POSIX:
+
+          return ((path1 && is_dir_sep(*path1)) ^
+                  (path2 && is_dir_sep(*path2))) == 0;
+       */
+       return path1 && path2 && *path1 && *path2 && (
+               (is_dir_sep(*path1) &&
+                is_dir_sep(*path2)) ||
+               (*(path1+1) == ':' &&
+                *(path2+1) == ':' &&
+                !strncasecmp(path1, path2, 1)) ||
+               (!is_dir_sep(*path1) &&
+                !is_dir_sep(*path2) &&
+                *(path1+1) != ':' &&
+                *(path2+1) != ':'));
+}
+
 /*
  * Give path as relative to prefix.
  *
@@ -461,6 +480,9 @@ const char *relative_path(const char *in, const
char *prefix,
        else if (!prefix_len)
                return in;

+       if (!have_same_root(in, prefix))
+               return in;
+

Should I write the function have_same_root as inline function or macro
like 'is_dir_sep'?

-- 
Jiang Xin
