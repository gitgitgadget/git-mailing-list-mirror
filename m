From: Romain Picard <romain.picard@oakbits.com>
Subject: Re: [PATCH v2] git-p4.py: add support for filetype change
Date: Tue, 05 Jan 2016 14:08:42 +0100
Message-ID: <011e31179a6b263636562de374102fd7@oakbits.com>
References: <1451904764-338-1-git-send-email-romain.picard@oakbits.com>
 <CAE5ih78Jb9u8FKNd5hoWkWVFsZJBa2_dqaQ1G1SKtjm8Ec4J6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git-owner@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Jan 05 17:46:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGUkZ-0005GW-HS
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 17:46:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751623AbcAEQqO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Jan 2016 11:46:14 -0500
Received: from 11.mo7.mail-out.ovh.net ([87.98.173.157]:49599 "EHLO
	11.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbcAEQqN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 11:46:13 -0500
X-Greylist: delayed 12003 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2016 11:46:13 EST
Received: from mail352.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id A3884FF8A3F;
	Tue,  5 Jan 2016 14:08:47 +0100 (CET)
Received: from RCM-149.6.166.170 (localhost [127.0.0.1])
	by mail352.ha.ovh.net (Postfix) with ESMTPA id D9AE3200065;
	Tue,  5 Jan 2016 14:08:42 +0100 (CET)
Received: from [149.6.166.170]
 by ssl0.ovh.net
 with HTTP (HTTP/1.1 POST); Tue, 05 Jan 2016 14:08:42 +0100
In-Reply-To: <CAE5ih78Jb9u8FKNd5hoWkWVFsZJBa2_dqaQ1G1SKtjm8Ec4J6Q@mail.gmail.com>
X-Sender: romain.picard@oakbits.com
User-Agent: Roundcube Webmail/1.1.3
X-Originating-IP: 149.6.166.170
X-Webmail-UserID: romain.picard@oakbits.com
X-Ovh-Tracer-Id: 13861798179472826645
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrieelgdegjecutefuodetggdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283386>

Le 04.01.2016 23:16, Luke Diamand a =C3=A9crit=C2=A0:
> On 4 January 2016 at 10:52, Romain Picard <romain.picard@oakbits.com>=
=20
> wrote:
>> After changing the type of a file in the git repository, it is not=20
>> possible to
>> "git p4 publish" the commit to perforce. This is due to the fact tha=
t=20
>> the git
>> "T" status is not handled in git-p4.py. This can typically occur whe=
n=20
>> replacing
>> an existing file with a symbolic link.
>>=20
>> The "T" modifier is now supported in git-p4.py. When a file type has=
=20
>> changed,
>> inform perforce with the "p4 edit -f auto" command.
>=20
> Looks good to me, thanks for adding the test. I think the test needs
> to say what the terms of the copyright are (GPL, etc) but other than
> that it looks good.

I copy/pasted the copyright present in "t/README" and other tests. Tell=
=20
me if you
want an explicit reference to a license.

However since many existing tests do not have any copyright I can just=20
remove it.

>=20
> Thanks
> Luke
>=20
>>=20
>> Signed-off-by: Romain Picard <romain.picard@oakbits.com>
>> ---
>>  git-p4.py                         |  9 +++--
>>  t/t9827-git-p4-change-filetype.sh | 69=20
>> +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 76 insertions(+), 2 deletions(-)
>>  create mode 100755 t/t9827-git-p4-change-filetype.sh
>>=20
>> diff --git a/git-p4.py b/git-p4.py
>> index a7ec118..b7a3494 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -240,8 +240,8 @@ def p4_add(f):
>>  def p4_delete(f):
>>      p4_system(["delete", wildcard_encode(f)])
>>=20
>> -def p4_edit(f):
>> -    p4_system(["edit", wildcard_encode(f)])
>> +def p4_edit(f, *options):
>> +    p4_system(["edit"] + list(options) + [wildcard_encode(f)])
>>=20
>>  def p4_revert(f):
>>      p4_system(["revert", wildcard_encode(f)])
>> @@ -1344,6 +1344,7 @@ class P4Submit(Command, P4UserMap):
>>=20
>>          diff =3D read_pipe_lines("git diff-tree -r %s \"%s^\" \"%s\=
"" %=20
>> (self.diffOpts, id, id))
>>          filesToAdd =3D set()
>> +        filesToChangeType =3D set()
>>          filesToDelete =3D set()
>>          editedFiles =3D set()
>>          pureRenameCopy =3D set()
>> @@ -1404,6 +1405,8 @@ class P4Submit(Command, P4UserMap):
>>                      os.unlink(dest)
>>                      filesToDelete.add(src)
>>                  editedFiles.add(dest)
>> +            elif modifier =3D=3D "T":
>> +                filesToChangeType.add(path)
>>              else:
>>                  die("unknown modifier %s for %s" % (modifier, path)=
)
>>=20
>> @@ -1463,6 +1466,8 @@ class P4Submit(Command, P4UserMap):
>>          #
>>          system(applyPatchCmd)
>>=20
>> +        for f in filesToChangeType:
>> +            p4_edit(f, "-t", "auto")
>>          for f in filesToAdd:
>>              p4_add(f)
>>          for f in filesToDelete:
>> diff --git a/t/t9827-git-p4-change-filetype.sh=20
>> b/t/t9827-git-p4-change-filetype.sh
>> new file mode 100755
>> index 0000000..b0a9f62
>> --- /dev/null
>> +++ b/t/t9827-git-p4-change-filetype.sh
>> @@ -0,0 +1,69 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2016 Romain Picard
>> +#
>> +
>> +test_description=3D'git p4 support for file type change'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d' '
>> +       start_p4d
>> +'
>> +
>> +test_expect_success 'create files' '
>> +       (
>> +               cd "$cli" &&
>> +               p4 client -o | sed "/LineEnd/s/:.*/:unix/" | p4 clie=
nt=20
>> -i &&
>> +               cat >file1 <<-EOF &&
>> +               This is a first file.
>> +               EOF
>> +               cat >file2 <<-EOF &&
>> +               This is a second file whose type will change.
>> +               EOF
>> +               p4 add file1 file2 &&
>> +               p4 submit -d "add files"
>> +       )
>> +'
>> +
>> +test_expect_success 'change file to symbolic link' '
>> +       git p4 clone --dest=3D"$git" //depot@all &&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git" &&
>> +               git config git-p4.skipSubmitEdit true &&
>> +
>> +               rm file2 &&
>> +               ln -s file1 file2 &&
>> +               git add file2 &&
>> +               git commit -m "symlink file1 to file2" &&
>> +               git p4 submit &&
>> +               p4 filelog -m 1 //depot/file2 >filelog &&
>> +               grep "(symlink)" filelog
>> +       )
>> +'
>> +
>> +test_expect_success 'change symbolic link to file' '
>> +       git p4 clone --dest=3D"$git" //depot@all &&
>> +       test_when_finished cleanup_git &&
>> +       (
>> +               cd "$git" &&
>> +               git config git-p4.skipSubmitEdit true &&
>> +
>> +               rm file2 &&
>> +               cat >file2 <<-EOF &&
>> +               This is another content for the second file.
>> +               EOF
>> +               git add file2 &&
>> +               git commit -m "re-write file2" &&
>> +               git p4 submit &&
>> +               p4 filelog -m 1 //depot/file2 >filelog &&
>> +               grep "(text)" filelog
>> +       )
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +       kill_p4d
>> +'
>> +
>> +test_done
>> --
>> 2.6.4
>>=20
