From: Romain Picard <romain.picard@oakbits.com>
Subject: Re: [PATCH] git-p4.py: add support for filetype change
Date: Tue, 29 Dec 2015 18:33:12 +0100
Message-ID: <3d38fd830e58bef6cd50c41650268244@oakbits.com>
References: <1450703365-10427-1-git-send-email-romain.picard@oakbits.com>
 <CAE5ih7-3H=O8GqzGebzKTttwUs=HRA+B+pV85sfWoesAvKXKgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	git-owner@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 21:01:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE0SD-0001aw-CW
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 21:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbbL2UBF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 15:01:05 -0500
Received: from 18.mo7.mail-out.ovh.net ([188.165.56.163]:49283 "EHLO
	18.mo7.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbbL2UBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 15:01:03 -0500
X-Greylist: delayed 8396 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Dec 2015 15:01:03 EST
Received: from mail372.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 578D2FF85B9;
	Tue, 29 Dec 2015 18:33:17 +0100 (CET)
Received: from RCM-2.6.200.35 (localhost [127.0.0.1])
	by mail372.ha.ovh.net (Postfix) with ESMTPA id 9E42B6C0063;
	Tue, 29 Dec 2015 18:33:12 +0100 (CET)
Received: from APoitiers-655-1-396-35.w2-6.abo.wanadoo.fr ([2.6.200.35])
 by ssl0.ovh.net
 with HTTP (HTTP/1.1 POST); Tue, 29 Dec 2015 18:33:12 +0100
In-Reply-To: <CAE5ih7-3H=O8GqzGebzKTttwUs=HRA+B+pV85sfWoesAvKXKgg@mail.gmail.com>
X-Sender: romain.picard@oakbits.com
User-Agent: Roundcube Webmail/1.1.3
X-Originating-IP: 2.6.200.35
X-Webmail-UserID: romain.picard@oakbits.com
X-Ovh-Tracer-Id: 14113155334541566229
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeekiedrheekgdeljecutefuodetggdotffvucfrrhhofhhilhgvmecuqfggjfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283147>

Le 26.12.2015 11:26, Luke Diamand a =C3=A9crit=C2=A0:
> On 21 December 2015 at 13:09, Romain Picard <romain.picard@oakbits.co=
m>=20
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
> Romain,
>=20
> Thanks for looking at this. It looks like a reasonable change.
>=20
> Do you think you could add a unit test as well?

Yes, I will look at the existing tests to see how to add some new ones.

>=20
> Thanks
> Luke
>=20
>=20
>>=20
>> Signed-off-by: Romain Picard <romain.picard@oakbits.com>
>> ---
>>  git-p4.py | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
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
>> --
>> 2.6.4
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
