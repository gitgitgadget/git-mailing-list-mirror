From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] Allow git mv FileA fILEa when core.ignorecase = true
Date: Sat, 19 Mar 2011 15:28:28 +0100
Message-ID: <4D84BD8C.7020906@web.de>
References: <201103042240.38969.tboegi@web.de> <AANLkTin2s_=TVaKx6yv+nDvXB41BxebWHX4iaDYSGd-e@mail.gmail.com> <AANLkTikvkzUKBCqygGJoUG3qXNDArXpEX0RM5_5dbnBD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: kusmabite@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 19 15:34:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xEw-0005Nd-BE
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 15:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753395Ab1CSOeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 10:34:44 -0400
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:58599 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752515Ab1CSOen (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 10:34:43 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Mar 2011 10:34:42 EDT
Received: from birne.lan (213.64.3.195) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4D65154400701223; Sat, 19 Mar 2011 15:28:28 +0100
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTikvkzUKBCqygGJoUG3qXNDArXpEX0RM5_5dbnBD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169434>

On 16.03.11 14:18, Erik Faye-Lund wrote:
> 2011/3/16 Erik Faye-Lund <kusmabite@gmail.com>:
>> 2011/3/4 Torsten B=F6gershausen <tboegi@web.de>:
>>>    The typical use case is when a file "FileA" should be renamed in=
to fILEa
>>>    and we are on a case insenstive file system (system core.ignorec=
ase =3D true).
>>>    Source and destination are the same file, it can be accessed und=
er both names.
>>>    This makes git think that the destination file exists.
>>>    Unless used with --forced, git will refuse the "git mv FileA fIL=
Ea".
>>>    This change will allow "git mv FileA fILEa", when core.ignorecas=
e =3D true
>>>    and source and destination filenames only differ in case and the=
 file length
>>>    is identical.
>>>    On Linux/Unix/Mac OS X the mv is allowed when the inode of the s=
ource and
>>>    destination are equal.
>>>    On  this allows renames of M=C4RCHEN into M=E4rchen on Mac OS X.
>>>    (As a side effect, a file can be renamed to a name which is alre=
ady
>>>    hard-linked to the same inode)
>>>
>>> Signed-off-by: Torsten B=F6gershausen <tboegi@web.de>
>>> ---
>>>  builtin/mv.c  |   20 +++++++++++++++-----
>>>  t/t7001-mv.sh |   29 +++++++++++++++++++++++++++++
>>>  2 files changed, 44 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/builtin/mv.c b/builtin/mv.c
>>> index 93e8995..e0aad62 100644
>>> --- a/builtin/mv.c
>>> +++ b/builtin/mv.c
>>> @@ -62,7 +62,7 @@ int cmd_mv(int argc, const char **argv, const cha=
r *prefix)
>>>        };
>>>        const char **source, **destination, **dest_path;
>>>        enum update_mode { BOTH =3D 0, WORKING_DIRECTORY, INDEX } *m=
odes;
>>> -       struct stat st;
>>> +       struct stat st, st_dst;
>>>        struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
>>>
>>>        git_config(git_default_config, NULL);
>>> @@ -164,15 +164,25 @@ int cmd_mv(int argc, const char **argv, const=
 char *prefix)
>>>                        }
>>>                } else if (cache_name_pos(src, length) < 0)
>>>                        bad =3D "not under version control";
>>> -               else if (lstat(dst, &st) =3D=3D 0) {
>>> +               else if (lstat(dst, &st_dst) =3D=3D 0) {
>>> +                       int allow_force =3D force;
>>>                        bad =3D "destination exists";
>>> -                       if (force) {
>>> +                       /* Allow when src and dst have the same ino=
de (Mac OS X) */
>>> +                       /* Allow when ignore_case and same file len=
gth (Windows) */
>>
>> Wait, what? Same file length is sufficient to trigger overwriting
>> without -f? I find this to be a very dubious heuristic...
>>
>> Shouldn't you be checking something like nFileIndexLow/High from
>> BY_HANDLE_FILE_INFORMATION instead? (ref:
>> http://msdn.microsoft.com/en-us/library/aa363788(v=3DVS.85).aspx)
>>
>> Sure, we'd need some API to check that, but if we assume that this
>> code path is rare-ish we could do something like this (note,
>> untested):
>>
>> diff --git a/compat/mingw.c b/compat/mingw.c
>> index 6750e67..fee4113 100644
>> --- a/compat/mingw.c
>> +++ b/compat/mingw.c
>> @@ -299,6 +299,21 @@ void mingw_mark_as_git_dir(const char *dir)
>>                 "dotGitOnly" : "true"));
>>  }
>>
>> +int is_same_file(const char *a, const char *b)
>> +{
>> +       BY_HANDLE_FILE_INFORMATION hia, hib;
>> +       HANDLE ha =3D OpenFileA(a, NULL, OF_READ),
>> +              hb =3D OpenFileA(b, NULL, OF_READ);
>> +       if (!ha || !hb ||
>> +           !GetFileInformationByHandle(ha) ||
>> +           !GetFileInformationByHandle(hb))
>> +               return 0;
>> +
>=20
> And if couse:
> CloseHandle(ha);
> CloseHandle(hb);
Good point. I will send a new patch, including your suggestion,
but 50% different ;-)
/Torsten
