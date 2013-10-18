From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] sha1_file.c:create_tmpfile(): Fix race when creating
 loose object dirs
Date: Fri, 18 Oct 2013 21:00:41 +0700
Message-ID: <CACsJy8ChkKQJJfV1G6DUQgq1Pwy7Hki1qkD8V4FsLC0bN362PA@mail.gmail.com>
References: <1382102267-18151-1-git-send-email-johan@herland.net> <CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Oct 18 16:09:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXAjb-0004jn-0r
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 16:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755323Ab3JROBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 10:01:18 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43535 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172Ab3JROBO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 10:01:14 -0400
Received: by mail-oa0-f46.google.com with SMTP id g12so2773663oah.19
        for <git@vger.kernel.org>; Fri, 18 Oct 2013 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PFDuQht2XlCYvEPfKtbrMwp164jZcVsiMXABpNCgEZM=;
        b=qIxuXNy4MKs5SYKzw+XddiiSTelSqtHR0SZzYFCkkbx1gzUg20v6lI2qHijk7Ot5x5
         fk2S6nXZH1wwZ0voyI0s6ay5ueaANo/hw9JPxvEWHW5U9emQQti2aBmO9wdw1Z5Mg3EA
         17d9YmseESnT+U1xGa55NBVqz8DnebRxTdjY+vDOLl9ylbRwwjV1MmLGG9ZW5mw8tBvC
         7gPS83vBXvVwFOUk+0Ui3boT5IQ/WEkGzOxHKA6WIfMRp3tOrOCx3dlrKVAhBiX2s6Sf
         vzqHSRGd1xm+zsalosFbGImEwX2FY0GUNrKYnq8jbB2SPgdRgJl2Ti1RtxJt2TcxpJjj
         w72w==
X-Received: by 10.182.149.234 with SMTP id ud10mr384925obb.73.1382104872763;
 Fri, 18 Oct 2013 07:01:12 -0700 (PDT)
Received: by 10.76.0.41 with HTTP; Fri, 18 Oct 2013 07:00:41 -0700 (PDT)
In-Reply-To: <CACsJy8C=kaa2OgdxOrefP+Ck_sSA00tHs9UqMXwkh9v4K3Mdvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236352>

On Fri, Oct 18, 2013 at 8:55 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Oct 18, 2013 at 8:17 PM, Johan Herland <johan@herland.net> wrote:
>> diff --git a/sha1_file.c b/sha1_file.c
>> index f80bbe4..00ffffe 100644
>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -2857,7 +2857,9 @@ static int create_tmpfile(char *buffer, size_t bufsiz, const char *filename)
>>                 /* Make sure the directory exists */
>>                 memcpy(buffer, filename, dirlen);
>>                 buffer[dirlen-1] = 0;
>> -               if (mkdir(buffer, 0777) || adjust_shared_perm(buffer))
>> +               if (mkdir(buffer, 0777) && errno != EEXIST)
>> +                       return -1;
>> +               if (adjust_shared_perm(buffer))
>>                         return -1;
>
> I was going to ask what if the created directory does not have
> permission 0777. But adjust_shared_perm follows immediately after, so
> we're good.

And I sent too early. adjust_shared_perm() does rely on current dir's
permission. So if the creator does "mkdir(buffer, 0)", we still have a
bad permission in the end. And adjust_shared_perm() is only active
when the repository is configured to be shared.
-- 
Duy
