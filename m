From: =?UTF-8?Q?erik_elfstr=C3=B6m?= <erik.elfstrom@gmail.com>
Subject: Re: [PATCH v2 3/3] clean: improve performance when removing lots of directories
Date: Fri, 17 Apr 2015 20:15:40 +0200
Message-ID: <CAMpP7NbQ7pmcjT4pDn5dA5yvfgMgirbkoMD6ijjiFp7zmARPbA@mail.gmail.com>
References: <1428770587-9674-1-git-send-email-erik.elfstrom@gmail.com>
	<1428770587-9674-5-git-send-email-erik.elfstrom@gmail.com>
	<xmqqpp75l1gd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 20:15:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjAnr-0008Qd-EV
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 20:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbbDQSPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 14:15:42 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:32942 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488AbbDQSPl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 14:15:41 -0400
Received: by oblw8 with SMTP id w8so77772707obl.0
        for <git@vger.kernel.org>; Fri, 17 Apr 2015 11:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Z5Jax0LYNviSCU18NcUhldN6W8ruGLFd/CGNpfQ3GVc=;
        b=UjKhd7dy1ikgbBfHAOSikIVbizLDKhtMxYw/gip3nU4a60rZ8YRT/VMC0mxmB2aA5J
         XXc4GNJ+h3CiTxFBBbzXlkwWyIrUrK+e8tALRy9KbK2cFOeFdtcnq5NsmQ7T4kygxn0p
         C9rVbyKva3EXV+/YpNCATLEHZny9RSmOw65vD6gbLrBGeqHtl/Zibkn85uZb+uE7VjIY
         PG+Qea0/YfEjYUp7e+fp55w5dxrtaNtjiQR8c5lczW3TKsJ7NK5wlyPvfa4ILEc0EwTf
         ONMepreFCBQEuoZFAZS3Y7d4XKkFT/6bg1m3dW1qVH7TM+G6aCRjmAiNEOSQzyZKMTrY
         FJAA==
X-Received: by 10.202.72.213 with SMTP id v204mr3937284oia.116.1429294540377;
 Fri, 17 Apr 2015 11:15:40 -0700 (PDT)
Received: by 10.182.154.72 with HTTP; Fri, 17 Apr 2015 11:15:40 -0700 (PDT)
In-Reply-To: <xmqqpp75l1gd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267373>

On Wed, Apr 15, 2015 at 7:56 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com> writes:
>
>> Before this change, clean used resolve_gitlink_ref to check for the
>> presence of nested git repositories. This had the drawback of creati=
ng
>> a ref_cache entry for every directory that should potentially be
>> cleaned. The linear search through the ref_cache list caused a massi=
ve
>> performance hit for large number of directories.
>
> I'd prefer to see the "current state" described in the current
> tense, e.g.
>
>     "git clean" uses resolve_gitlink_ref() to check for the presence =
of
>     nested git repositories, but it has the drawback of creating a
>     ref_cache entry for every directory that should potentially be
>     cleaned. The linear search through the ref_cache list causes a
>     massive performance hit for large number of directories.
>

Yes, that reads better.

>> Teach clean.c:remove_dirs to use setup.c:is_git_directory
>> instead. is_git_directory will actually open HEAD and parse the HEAD
>> ref but this implies a nested git repository and should be rare when
>> cleaning.
>
> I am not sure what you wanted to say in this paragraph.  What does
> it being rare have to do with it?  Even if it is not rare (i.e. the
> top-level project you are working with has many submodules checked
> out without using the more recent "a file .git pointing into
> .git/modules/ via 'gitdir: $overThere'" mechanism), if we found a
> nested git repository, we treat it as special and exclude it from
> cleaning it out, which is a good thing, no?
>

I was trying to motivate that the performance of is_git_directory is no=
t a
problem for us even though it opens a file and parses it. I see now whe=
n I
read it again that this is not very clear.

> Doesn't this implementation get confused by modern submodule
> checkouts and descend into and clean their working tree, though?
> Module M with path P would have a directory P in the working tree of
> the top-level project, and P/.git is a regular file that will fail
> "is_git_directory()" test but records the location of the real
> submodule repository i.e. ".git/modules/M" via the "gitdir:"
> mechanism.
>

Yes, there is a problem here. I've added the test below and it fails af=
ter
my change by cleaning sub2 (sub1 is not cleaned). Are there more cases
here that I should test for?

+test_expect_success 'should not clean submodules' '
+       rm -fr repo to_clean sub1 sub2 &&
+       mkdir -p repo to_clean &&
+       (
+               cd repo &&
+               git init &&
+               >hello.world
+               git add . &&
+               git commit -a -m nested
+       ) &&
+       git submodule add ./repo/.git sub1 &&
+       git commit -m "sub1" &&
+       git branch before_sub2 &&
+       git submodule add ./repo/.git sub2 &&
+       git commit -m "sub2" &&
+       git checkout before_sub2 &&
+       >to_clean/should_clean.this &&
+       git clean -f -d &&
+       test_path_is_file repo/.git/index &&
+       test_path_is_file repo/hello.world &&
+       test_path_is_file sub1/.git &&
+       test_path_is_file sub1/hello.world &&
+       test_path_is_file sub2/.git &&
+       test_path_is_file sub2/hello.world &&
+       test_path_is_missing to_clean
+'

Base on the previous discussion of the patch topic I can see 3 options
for how to fix this:

Option 1:
 Plug the hole in my new is_git_repository function. A quick and dirty
 fix that passes the above test would be:

diff --git a/builtin/clean.c b/builtin/clean.c
index b679913..4f2fe95 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -153,14 +153,21 @@ static int is_git_repository(struct strbuf *path)
        if (is_git_directory(path->buf))
                ret =3D 1;
        else {
-               size_t orig_path_len =3D path->len;
-               assert(orig_path_len !=3D 0);
-               if (path->buf[orig_path_len - 1] !=3D '/')
-                       strbuf_addch(path, '/');
-               strbuf_addstr(path, ".git");
-               if (is_git_directory(path->buf))
-                       ret =3D 1;
-               strbuf_setlen(path, orig_path_len);
+               struct stat st;
+               const char *submodule_git_dir =3D
git_path_submodule(path->buf, "");
+               lstat(submodule_git_dir, &st);
+               if (S_ISDIR(st.st_mode))
+                       ret =3D 1;
+               else {
+                       size_t orig_path_len =3D path->len;
+                       assert(orig_path_len !=3D 0);
+                       if (path->buf[orig_path_len - 1] !=3D '/')
+                               strbuf_addch(path, '/');
+                       strbuf_addstr(path, ".git");
+                       if (is_git_directory(path->buf))
+                               ret =3D 1;
+                       strbuf_setlen(path, orig_path_len);
+               }
        }

        return ret;

There are probably more elegant solutions available here, suggestions
welcome.

Option 2:
 Go with the current solution of using resolve_gitlink_ref but either
 A) avoid placing non-submodule paths in the ref_cache list, or
 B) remove non-submodule paths from the ref_cache list after we
 have detected that they are not submodules.

Option 3:
 Speed up the ref_cache enough to make these dummy entires not matter.
 Nothing wrong with speeding up the lookup but it would still feel stra=
nge to
 populate it with junk entries.

Are there more options available?
What direction would you prefer?

>> Using is_git_directory should give a more standardized check for wha=
t
>> is and what isn't a git repository but also gives a slight behaviora=
l
>> change. We will now detect and respect bare and empty nested git
>> repositories (only init run). Update t7300 to reflect this.
>>
>> The time to clean an untracked directory containing 100000 sub
>> directories went from 61s to 1.7s after this change.
>>
>> Helped-by: Jeff King <peff@peff.net>
>> Signed-off-by: Erik Elfstr=C3=B6m <erik.elfstrom@gmail.com>
>> ---
>>  builtin/clean.c  | 24 ++++++++++++++++++++----
>>  t/t7300-clean.sh |  4 ++--
>>  2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index 98c103f..b679913 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -10,7 +10,6 @@
>>  #include "cache.h"
>>  #include "dir.h"
>>  #include "parse-options.h"
>> -#include "refs.h"
>>  #include "string-list.h"
>>  #include "quote.h"
>>  #include "column.h"
>> @@ -148,6 +147,25 @@ static int exclude_cb(const struct option *opt,=
 const char *arg, int unset)
>>       return 0;
>>  }
>>
>> +static int is_git_repository(struct strbuf *path)
>> +{
>> +     int ret =3D 0;
>> +     if (is_git_directory(path->buf))
>> +             ret =3D 1;
>> +     else {
>> +             size_t orig_path_len =3D path->len;
>> +             assert(orig_path_len !=3D 0);
>> +             if (path->buf[orig_path_len - 1] !=3D '/')
>> +                     strbuf_addch(path, '/');
>> +             strbuf_addstr(path, ".git");
>> +             if (is_git_directory(path->buf))
>> +                     ret =3D 1;
>> +             strbuf_setlen(path, orig_path_len);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  static int remove_dirs(struct strbuf *path, const char *prefix, int=
 force_flag,
>>               int dry_run, int quiet, int *dir_gone)
>>  {
>> @@ -155,13 +173,11 @@ static int remove_dirs(struct strbuf *path, co=
nst char *prefix, int force_flag,
>>       struct strbuf quoted =3D STRBUF_INIT;
>>       struct dirent *e;
>>       int res =3D 0, ret =3D 0, gone =3D 1, original_len =3D path->l=
en, len;
>> -     unsigned char submodule_head[20];
>>       struct string_list dels =3D STRING_LIST_INIT_DUP;
>>
>>       *dir_gone =3D 1;
>>
>> -     if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
>> -                     !resolve_gitlink_ref(path->buf, "HEAD", submod=
ule_head)) {
>> +     if ((force_flag & REMOVE_DIR_KEEP_NESTED_GIT) && is_git_reposi=
tory(path)) {
>>               if (!quiet) {
>>                       quote_path_relative(path->buf, prefix, &quoted=
);
>>                       printf(dry_run ?  _(msg_would_skip_git_dir) : =
_(msg_skip_git_dir),
>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index 58e6b4a..da294fe 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -455,7 +455,7 @@ test_expect_success 'nested git work tree' '
>>       ! test -d bar
>>  '
>>
>> -test_expect_failure 'nested git (only init) should be kept' '
>> +test_expect_success 'nested git (only init) should be kept' '
>>       rm -fr foo bar &&
>>       git init foo &&
>>       mkdir bar &&
>> @@ -465,7 +465,7 @@ test_expect_failure 'nested git (only init) shou=
ld be kept' '
>>       test_path_is_missing bar
>>  '
>>
>> -test_expect_failure 'nested git (bare) should be kept' '
>> +test_expect_success 'nested git (bare) should be kept' '
>>       rm -fr foo bar &&
>>       git init --bare foo &&
>>       mkdir bar &&
