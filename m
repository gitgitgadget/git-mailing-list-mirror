From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 18:54:21 +0100
Message-ID: <54E3804D.6020301@web.de>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com> <vpqtwyl90mx.fsf@anie.imag.fr> <340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com> <vpqiof14qu8.fsf@anie.imag.fr> <13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com> <vpqr3tozzs5.fsf@anie.imag.fr> <CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, git@vger.kernel.org, tboegi@web.de
To: Fairuzan Roslan <fairuzan.roslan@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:58:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNmPG-0001Y1-1k
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbbBQRye convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Feb 2015 12:54:34 -0500
Received: from mout.web.de ([212.227.17.11]:55329 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498AbbBQRyd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 12:54:33 -0500
Received: from macce9.local ([217.211.68.12]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MfYn9-1YC3I72DkJ-00P8Ld; Tue, 17 Feb 2015 18:54:28
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <CA0F915F-74B1-4292-AFB8-D1A4C76C0137@gmail.com>
X-Provags-ID: V03:K0:d/gn1F8aeQ/TSZAYrrGyHRsF5omB977TXjKyjCymDGWfijzW305
 cU/NN20uAkmA5uQlmntF0/iFtKWbQtiUN6rNaAtIiFwr2pnnJxCLzodJi0rJAAwnSPaWlN2
 BMCLIsDo9/ZFeun/ljGEsyVyHD/1ATgOlonXBO3WixIVzCV4xn5OrTSVZ8PPxC9c92Q46ZI
 asH+DXKPfVquimPjd6k3g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263971>

On 17/02/15 17:58, Fairuzan Roslan wrote:
>=20
>> On Feb 17, 2015, at 4:51 PM, Matthieu Moy <Matthieu.Moy@grenoble-inp=
=2Efr> wrote:
>>
>> Fairuzan Roslan <fairuzan.roslan@gmail.com> writes:
>>
>>> $ git clone https://github.com/robbyrussell/oh-my-zsh.git
>>> Cloning into 'oh-my-zsh'...
>>> remote: Counting objects: 11830, done.
>>> remote: Total 11830 (delta 0), reused 0 (delta 0)
>>> Receiving objects: 100% (11830/11830), 2.12 MiB | 481.00 KiB/s, don=
e.
>>> Resolving deltas: 100% (6510/6510), done.
>>> warning: unable to unlink /Volumes/installer/oh-my-zsh/.git/objects=
/pack/tmp_pack_zjPxuc: Operation not permitted
>>
>> This should be fixable from Git itself, by replacing the calls to
>> "unlink" with something like
>>
>> int unlink_or_chmod(...) {
>> 	if (unlink(...)) {
>> 		chmod(...); // give user write permission
>> 		return unlink(...);
>> 	}
>> }
>>
>> This does not add extra cost in the normal case, and would fix this
>> particular issue for afp shares. So, I think that would fix the bigg=
est
>> problem for afp-share users without disturbing others. It seems
>> reasonable to me to do that unconditionnally.
>>
>>> $ rm -rf oh-my-zsh/.git/objects/pack/tmp_*
>>> rm: oh-my-zsh/.git/objects/pack/tmp_idx_oUN1sb: Operation not permi=
tted
>>> rm: oh-my-zsh/.git/objects/pack/tmp_pack_zjPxuc: Operation not perm=
itted
>>
>> What happens if you do "rm -fr oh-my-zsh/.git/objects/pack/" (i.e.
>> remove the directory, not the files)?
>>
>> If you can still remove the directory, then I'd say the solution abo=
ve
>> could be sufficient: the user isn't supposed to interfer with the
>> content of .git/objects other than by using Git, and if he or she do=
es,
>> then asking a chmod prior to an rm seems reasonable.
>>
>> If you can't, then it's another problematic use-case (basically, you
>> can't just "rm -fr" a whole clone), and then it deserves at least an
>> opt-in configuration to get writable pack files.
>>
>> (Unfortunately, I suspect we're in the later case)
>>
>>> If you insist on setting the tmp idx & pack file permission to 0444=
 at
>>> least give it a u+w permission whenever you try to unlink and renam=
e
>>> it so it won=E2=80=99t fail.
>>
>> Yes. In case you hadn't guessed, this is precisely what I had in min=
d
>> when I asked "Is it a problem when using Git [...] or when trying to
>> remove files outside Git?".
>>
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
>=20
> Yes. It=E2=80=99s a problem when using Git where it fails to unlink a=
nd rename the tmp idx and pack files.
> The reason I tries to rm -rf the tmp_idx_XXXXXX and tmp_pack_XXXXXX i=
s to proof a point why Git fails
>=20
> Perhaps my explanation wasn=E2=80=99t clear enough. Maybe it=E2=80=99=
s hard for you to understand without having to test it yourself on a AF=
P filesystem.
>=20
> Let me explain why AFP filesystem is more strict and different from y=
our typical filesystem like ext4,hfs+,etc.
>=20
> $ mkdir testdir; chmod 0755 testdir; touch testdir/testfile; chmod 04=
44 testdir/testfile; ls -la testdir
> total 0
> drwxr-xr-x  1 user  staff  264 Feb 18 00:26 .
> drwx------  1 user  staff  264 Feb 18 00:26 ..
> -r--r--r--  1 user  staff    0 Feb 18 00:26 testfile
>=20
> $ rm -rf testdir
> rm: testdir/testfile: Operation not permitted
> rm: testdir: Directory not empty
>=20
This works on my system (Mac OS 10.9 as server and client)

> $ chmod +w testdir/testfile; ls -la testdir
> total 0
> drwxr-xr-x  1 riaf  staff  264 Feb 18 00:26 .
> drwx------  1 riaf  staff  264 Feb 18 00:26 ..
> -rw-r=E2=80=94r--  1 riaf  staff    0 Feb 18 00:26 testfile
>=20
> $ rm -rf testdir <=E2=80=94=E2=80=94 No error message
>=20
> This show that you cannot delete a directory or a file without a writ=
e permission in AFP filesystem.
>=20
> The problem with Git failing is not because its inability to delete a=
 directory but its inability to unlink and rename tmp_idx_XXXXXX and tm=
p_pack_XXXXXX because those files were set to 0444 by odb_mkstemp.
> Try google for =E2=80=9CGit AFP=E2=80=9D and you will see a lot peopl=
e are facing with the same problem.
Yes, (at least to my knowledge) you seem to be one of the first to repo=
rt it here, thanks for that.
>=20
> Regarding your suggestion, yes I think it would work but you have to =
take care (chmod) every calls that rename or unlink or delete files wit=
h 0444 permission.
>=20
> Regards,
> Fairuzan
>=20
The "right" solution is to make a wrapper function, and to re-define un=
link() and rename() with help
of the preprocessor.

git-compat-util.h has an example for fopen(), so that can be used for a=
 patch.

And no, as I can not reproduce it here, I can only help with reviews or=
 so.







=20
