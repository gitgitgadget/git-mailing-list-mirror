From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH 3/3] clean: improve performance when removing lots of directories
Date: Tue, 7 Apr 2015 21:55:24 +0200
Message-ID: <CAMpP7NYixn4491EdPTDX+RQFr3VZfuAoUWZ4JXuYg2rqp9XTeg@mail.gmail.com>
References: <1428320904-12366-1-git-send-email-erik.elfstrom@gmail.com>
	<1428320904-12366-4-git-send-email-erik.elfstrom@gmail.com>
	<CAPig+cQOLJcy-QuACrvd+XrCpP74k0SXxj0rBkNneG5Ovnf47Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 21:55:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfZas-0000mh-U8
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 21:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbbDGTz1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2015 15:55:27 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:36423 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbbDGTzZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2015 15:55:25 -0400
Received: by obbeb7 with SMTP id eb7so32793266obb.3
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 12:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LvIIeeTMGQNsYuyAQPr4r/HGkWZe4OPBbcWne9dyAAk=;
        b=xyOtbvK6Su2WetV7b4t21FhF2+Z+eMQ+fTAbce5q7bu1mMBXzmhbzY4I630pbLV1pO
         AYSKG41LJuwY6PmN5zHTd4cOZYk4h/kLE8BT1hEIMXw/ocwJdBARJ/k4o2sC9uxv98E4
         mH5ehFceFrVxWEEg+XWG8/+wTgYydC1rRW48XBk0HSxywSjCgHbGuxLRy5WngzJBrprY
         iYl95R0MtEekER7Xt92shBlZULAox+fhqtx+/uhrjA0q59SKbz/tEHofnfaFiZBs1f5u
         CeqD0uZKYluwhg8HZHU5/ow4cXv4gXe9zD3Fv/uCXkFvehadUF2+vHQ27frK5rdX2nXy
         vmYg==
X-Received: by 10.60.45.165 with SMTP id o5mr27864385oem.44.1428436524742;
 Tue, 07 Apr 2015 12:55:24 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Tue, 7 Apr 2015 12:55:24 -0700 (PDT)
In-Reply-To: <CAPig+cQOLJcy-QuACrvd+XrCpP74k0SXxj0rBkNneG5Ovnf47Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266937>

On Tue, Apr 7, 2015 at 12:10 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Mon, Apr 6, 2015 at 7:48 AM, Erik Elfstr=C3=B6m <erik.elfstrom@gma=
il.com> wrote:
>> Before this change, clean used resolve_gitlink_ref to check for the
>> presence of nested git repositories. This had the drawback of creati=
ng
>> a ref_cache entry for every directory that should potentially be
>> cleaned. The linear search through the ref_cache list caused a massi=
ve
>> performance hit for large number of directories.
>>
>> Teach clean.c:remove_dirs to use setup.c:is_git_directory
>> instead. is_git_directory will actually open HEAD and parse the HEAD
>> ref but this implies a nested git repository and should be rare when
>> cleaning.
>>
>> Using is_git_directory should give a more standardized check for wha=
t
>> is and what isn't a git repository but also gives a slight behaviora=
l
>> change. We will now detect and respect bare and empty nested git
>> repositories (only init run). Update t7300 to reflect this.
>>
>> The time to clean an untracked directory containing 100000 sub
>> directories went from 61s to 1.7s after this change.
>
> Impressive.
>
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> Helped-by: Jeff King <peff@peff.net>
>
> It is customary for your sign-off to be last.
>
> More below...
>
>> ---
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 98c103f..e951bd9 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -148,6 +147,24 @@ static int exclude_cb(const struct option *opt,=
 const char *arg, int unset)
>>         return 0;
>>  }
>>
>> +static int is_git_repository(struct strbuf *path)
>> +{
>> +       int ret =3D 0;
>> +       if (is_git_directory(path->buf))
>> +               ret =3D 1;
>> +       else {
>> +               int orig_path_len =3D path->len;
>> +               if (path->buf[orig_path_len - 1] !=3D '/')
>
> Minor: I don't know how others feel about it, but I always find it a
> bit disturbing to see a potential negative array access without a
> safety check that orig_path_len is not 0, either directly in the
> conditional or as a documenting assert().
>


I think I would prefer to accept empty input and return false rather
than assert. What to you think about:

static int is_git_repository(struct strbuf *path)
{
    int ret =3D 0;
    size_t orig_path_len =3D path->len;
    if (orig_path_len =3D=3D 0)
        ret =3D 0;
    else if (is_git_directory(path->buf))
        ret =3D 1;
    else {
        if (path->buf[orig_path_len - 1] !=3D '/')
            strbuf_addch(path, '/');
        strbuf_addstr(path, ".git");
        if (is_git_directory(path->buf))
            ret =3D 1;
        strbuf_setlen(path, orig_path_len);
    }

    return ret;
}


Also I borrowed this pattern from remove_dirs and it has the same
problem. Should I add something like this as a separate commit?

diff --git a/builtin/clean.c b/builtin/clean.c
index ccffd8a..88850e3 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -173,7 +173,8 @@ static int remove_dirs(struct strbuf *path, const
char *prefix, int force_flag,
        DIR *dir;
        struct strbuf quoted =3D STRBUF_INIT;
        struct dirent *e;
-       int res =3D 0, ret =3D 0, gone =3D 1, original_len =3D path->le=
n, len;
+       int res =3D 0, ret =3D 0, gone =3D 1;
+       size_t original_len =3D path->len, len;
        struct string_list dels =3D STRING_LIST_INIT_DUP;

        *dir_gone =3D 1;
@@ -201,6 +202,7 @@ static int remove_dirs(struct strbuf *path, const
char *prefix, int force_flag,
                return res;
        }

+       assert(original_len > 0 && "expects non-empty path");
        if (path->buf[original_len - 1] !=3D '/')
                strbuf_addch(path, '/');


>> +                       strbuf_addch(path, '/');
>> +               strbuf_addstr(path, ".git");
>> +               if (is_git_directory(path->buf))
>> +                       ret =3D 1;
>> +               strbuf_setlen(path, orig_path_len);
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  static int remove_dirs(struct strbuf *path, const char *prefix, int=
 force_flag,
>>                 int dry_run, int quiet, int *dir_gone)
>>  {
