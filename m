From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 15:31:59 +0200
Message-ID: <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
 <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal>
 <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com> <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 15:32:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrTb-0005SZ-MN
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753818Ab2DSNck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 09:32:40 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35673 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751839Ab2DSNcj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 09:32:39 -0400
Received: by pbcun15 with SMTP id un15so10245546pbc.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aafdX3o657q9C2NbtZFCkA3YIenz9AR/zN3KcS1kJ5k=;
        b=UKp2Q5o8r0WhmMIl6sxmE2OUJJSismGmCgg++QAbxT0+JZOVpmn1IXg8E7a27I+Xmb
         epAMnjJMXjjycJO2akz1tri22E6oWV/84hw2fa5p813HROwQYcM0HXo14ExhVHN/k5k/
         t6WvrNbltUpQHUVj2Hf62bnJY8zs0Aw5hpCnnuxq0/BMc8hPobp2KbtpgdOkWQXdpGym
         wQ7H9lzvpJu0iShAqwvJSs2+1IbBEwHovrzUtWrVr8P9pbA/OWZY/8MhidVmE3nxaBT7
         ym3+rl5mGEjkZu33F12J65bwAIOsd4c/Ra+KcUMjAnBTBTYBy9/y9ajvDLsNlzRzip1+
         rFcA==
Received: by 10.68.203.41 with SMTP id kn9mr4892239pbc.75.1334842359440; Thu,
 19 Apr 2012 06:32:39 -0700 (PDT)
Received: by 10.68.236.105 with HTTP; Thu, 19 Apr 2012 06:31:59 -0700 (PDT)
In-Reply-To: <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195943>

On Thu, Apr 19, 2012 at 3:18 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Thu, Apr 19, 2012 at 7:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> This approach has the problem that file-operations apart from pread
>> might (at least in theory) modify the position. To prevent that, we'd
>> either need to use the same locking-mechanism as the CRT use, or use
>> ReadFile with an OVERLAPPED struct, which allows us specify the offset
>> explicitly. The latter seems better to me, and should look something
>> like this (note: untested):
>
> Yeah. I read about ReadFile [1] but dismissed it when I got to async
> i/o mode. Reading again, sync i/o ReadFile with OVERLAPPED struct
> should work fine. It's not clear though if file offset is changed
> (pread man page says it does not change).
>

A quick test shows that it does not:
---8<---
$ cat test.c
#include <stdio.h>
#include <windows.h>
#include <errno.h>
#include <fcntl.h>

ssize_t mingw_pread(int fd, void *buf, size_t size, off_t offset)
{
       OVERLAPPED overlapped = { 0 };
       DWORD ret;

       HANDLE fh = (HANDLE)_get_osfhandle(fd);
       if (fh == INVALID_HANDLE_VALUE) {
               errno = EBADF;
               return -1;
       }

       overlapped.Offset = (DWORD)offset;
       overlapped.OffsetHigh = (DWORD)(offset >> 32);

       if (!ReadFile(fh, buf, size, &ret, &overlapped)) {
               /* errno = err_win_to_posix(GetLastError()); */
               return -1;
       }

       return ret;
}

int main(int argc, const char *argv[])
{
        int i, fd = open(__FILE__, O_RDONLY);
        for (i = 0; i < 2; ++i) {
                char buf[11] = {0};
                mingw_pread(fd, buf, 10, 0);
                printf("buf = '%10s'\n", buf);
        }
        return 0;
}

$ gcc test.c -o test.exe && ./test.exe
test.c: In function 'mingw_pread':
test.c:18: warning: right shift count >= width of type
buf = '#include <'
buf = '#include <'
---8<---

So this looks fine to me.

> Also this approach deals with Windows only. There's still another
> NO_PREAD user, HP-UX something, and NO_PREAD comment mentions cygwin
> before v1.5.22. I personally don't care, just wanted to point out.

Yeah. Other platforms are still an issue. You didn't address those
either in your patch, even though it would be possible to modify it to
deal with them by checking the NO_PREAD and NO_PTHREADS defines.

But they would still have the problem with the file-pointer racing for
non-pread operations. Perhaps simply disabling threading is the better
choice for these?
