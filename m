From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC] Speed up "git status" by caching untracked file info
Date: Tue, 22 Apr 2014 17:13:40 +0700
Message-ID: <CACsJy8AYyhZKBmL=z2H11Oemjw_YoUES0vYtB8s0HnMB+4uyVw@mail.gmail.com>
References: <1397713918-22829-1-git-send-email-pclouds@gmail.com> <53563CB2.5030603@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:14:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcXiT-0002qU-9I
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 12:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbaDVKON convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Apr 2014 06:14:13 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:55075 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420AbaDVKOL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Apr 2014 06:14:11 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so1377635qgd.21
        for <git@vger.kernel.org>; Tue, 22 Apr 2014 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=7tjtb+qPZe9j3kP2K3o1ilCrQQIdc9yjJHQozOmrb5Q=;
        b=RsXoYNabK/W2Gb5rqJYpMcvxt+tQRROjJw8O7wfHqDAmliq1lQereyBDBj0WindpdM
         6EeycmO9emJ5EdM9se24C+DMg3LiZPMdd2V/FlnN4EvRBarhYuqZe/cFx90E5SsWh6fp
         qcsiX9CXrw9eVlwbr1MHroq9leWtknsza/zaKXeFnl7INwyrlmDiFR7rxtDoF4GXZUpf
         jaZFDdRzvAg7v7fIydW+giHu07N/Xws+g+3NlSq2HLGDkYV/o5roLeVXtiLn8RlqB25b
         ikFFShYz1vFxHV61OOE7V1vcKev78aGTr2BGhBjylD8P9FlYhBBzo6J0/FsJWCSEPgQH
         hJ4A==
X-Received: by 10.229.192.7 with SMTP id do7mr46901450qcb.1.1398161650820;
 Tue, 22 Apr 2014 03:14:10 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 22 Apr 2014 03:13:40 -0700 (PDT)
In-Reply-To: <53563CB2.5030603@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246726>

On Tue, Apr 22, 2014 at 4:56 PM, Karsten Blees <karsten.blees@gmail.com=
> wrote:
> Am 17.04.2014 07:51, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> This patch serves as a heads up about a feature I'm working on. I ho=
pe
>> that by posting it early, people could double check if I have made
>> some fundamental mistakes that completely ruin the idea. It's about
>> speeding up "git status" by caching untracked file info in the index
>> _if_ your file system supports it (more below).
>>
>> The whole WIP series is at
>>
>> https://github.com/pclouds/git/commits/untracked-cache
>>
>> I only post the real meat here. I'm aware of a few incomplete detail=
s
>> in this patch, but nothing fundamentally wrong. So far the numbers a=
re
>> promising.  ls-files is updated to run fill_directory() twice in a
>> row and "ls-files -o --directory --no-empty-directory --exclude-stan=
dard"
>> (with gcc -O0) gives me:
>>
>>            first run  second (cached) run
>> gentoo-x86    500 ms             71.6  ms
>> wine          140 ms              9.72 ms
>> webkit        125 ms              6.88 ms
>
> IIRC name_hash.c::lazy_init_name_hash took ~100ms on my system, so ho=
pefully you did a dummy 'cache_name_exists("anything")' before starting=
 the measurement of the first run?

No I didn't. Thanks for pointing it out. I'll see if I can reduce its t=
ime.

>> The following inputs are sufficient to determine what files in a
>> directory are excluded:
>>
>>  - The list of files and directories of the direction in question
>>  - The $GIT_DIR/index
>>  - The content of $GIT_DIR/info/exclude
>>  - The content of core.excludesfile
>>  - The content (or the lack) of .gitignore of all parent directories
>>    from $GIT_WORK_TREE
>>
>
> The dir_struct.flags also play a big role in evaluation of read_direc=
tory.
>
> E.g. it seems untracked files are not properly recorded if the cache =
is filled with '--ignored' option:

Yeah. dir_struct.flags will be part of the input. I intend to optimize
"git status" case only, so if it matches the recorded
dir_struct.flags, the cache is used. Else the cache is ignored.
Caching --ignored is not so interesting, because the list of ignored
files could be huge, while untracked listing is usually small.

>> @@ -1360,15 +1603,18 @@ static enum path_treatment read_directory_re=
cursive(struct dir_struct *dir,
>>                       break;
>>
>>               case path_untracked:
>> -                     if (!(dir->flags & DIR_SHOW_IGNORED))
>> -                             dir_add_name(dir, path.buf, path.len);
>> +                     if (dir->flags & DIR_SHOW_IGNORED)
>> +                             break;
>> +                     dir_add_name(dir, path.buf, path.len);
>> +                     if (cdir.fdir)
>> +                             add_untracked(untracked, path.buf + ba=
selen);
>>                       break;
>
> Similarly, the '--directory' option controls early returns from the d=
irectory scan (via read_directory_recursive's check_only argument), so =
you won't be able to get a full untracked files listing if the cache wa=
s recorded with '--directory'. Additionally, '--directory' aggregates t=
he state at the topmost untracked directory, so that directory's cached=
 state depends on all sub-directories as well...

I missed this. We could ignore check_only if caching is enabled, but
that does not sound really good. Let me think about it more..

>
> I wonder if it makes sense to separate cache recording logic from rea=
d_directory_recursive and friends, which are mainly concerned with flag=
s processing.

The core code path is still shared though, or we would duplicate r_d_r
entirely for caching recording, which sounds like a maintenance
nightmare.

>> At the implementation level, the whole directory structure is saved,
>> each directory corresponds to one struct untracked_dir.
>
> With the usual options (e.g. standard 'git status'), untracked direct=
ories are mostly skipped, so the cache would mostly store tracked direc=
tories. Naming it 'struct untracked_dir' is a bit confusing, IMO.

It's actually just "directories". We may need to store both tracked
and untracked directories. Maybe renaming it to cached_dir..

>> So if all is really well, read_directory() becomes a series of
>> open(".gitignore"), read(".gitignore"), close(), hash_sha1_file() an=
d
>> stat(<dir>) _without_ heavyweight exclude filtering. There should be
>> no overhead if this feature is disabled.
>>
>
> Wouldn't mtime of .gitignore files suffice here (so you don't need to=
 open and parse them every time)?

That's a further optimization. With the current code it's simpler to
open .gitignore. Assume you have a path a/b/c. a/.gitignore's stat
info is good, so you skip opening it. Then you find a/b/.gitignore is
modified and you need to recompute untracked files in a/b. To do that
you need a/.gitignore as well. Lazily opening a/.gitignore at this
stage is possible, but trickier (you have to make sure the rules are
in correct order because of negative patterns).

Anyway, the number of .gitignore files is usually small. We can
already avoid opening non-existent .gitignore, which is proportional
to the number of directories.
--=20
Duy
