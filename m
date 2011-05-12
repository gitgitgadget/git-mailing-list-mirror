From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 20/48] i18n: git-submodule die + eval_gettext messages
Date: Thu, 12 May 2011 16:20:37 +0200
Message-ID: <4DCBECB5.5050502@viscovery.net>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>	<1304857280-14773-21-git-send-email-avarab@gmail.com>	<4DCB9592.2090503@viscovery.net> <BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 16:20:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKWkz-00032S-4Q
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 16:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757339Ab1ELOUm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 May 2011 10:20:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:32862 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab1ELOUm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2011 10:20:42 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QKWko-00011d-2R; Thu, 12 May 2011 16:20:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 51AD31660F;
	Thu, 12 May 2011 16:20:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTik98wsBvoHNtausLBw0F1FqdDhAuQ@mail.gmail.com>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173470>

Am 5/12/2011 15:48, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> On Thu, May 12, 2011 at 10:08, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
>> Am 5/8/2011 14:20, schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> -             say "Submodule '$name' ($url) registered for path '$p=
ath'"
>>> +             say "$(eval_gettext "Submodule '\$name' (\$url) regis=
tered for path '\$path'")"
>>
>> On Windows, we have a problem with messages like this (and many othe=
rs)
>> that reference $path. eval_gettext has to export 'path', but on Wind=
ows
>> environment variables are case-insensitive. In the substitution, thi=
s
>> happens to pick the value of 'PATH' rather than of 'path'... Can you=
 do
>> something about this?
>>
>> Of course, the problem is not limited to 'path' at all, but it is a
>> prominent example discovered by the test suite.
>=20
> I didn't know Windows had that limitation. We can easily work around
> it by just renaming $path to something else (e.g. $filepath).
>=20
> Since we do:
>=20
>     export PATH $(git sh-i18n--envsubst --variables "$1");
>=20
> I assume this problem only occurs with variables that match
> /^path$/i. Or are there other problems on Windows?

It is *not* limited to PATH. There can be other variables in the
environment that are the same name as some that are exported in this
statement. Here's a brief test:

--- 8< ---
$ cat git-test
#!/bin/sh

=2E git-sh-setup
=2E git-sh-i18n

AppData=3Dmyappdata
username=3DmyUserName
proMPT=3Dmyprompt

echo "$(eval_gettext "AppData: '\$AppData'
username: \$username
proMPT: \$proMPT
path: '\$path'")"

$ git --exec-path=3D. test
AppData: 'C:\Dokumente und Einstellungen\jsixt\Anwendungsdaten'
username: jsixt
proMPT: $P$G
path:
'd:/Src/mingw-git/.;d:\Src\mingw-git;d:\Src\mingw-git\;d:\Src\mingw-git=
;...snip...;.'
--- 8< ---

Particularly PROMPT and USERNAME appear regularly in the environment an=
d
are rather generic names likely to be used in scripts as (non-exported)
variables. For exposition, these are the environment variables that I u=
se
in production:

ALLUSERSPROFILE
APPDATA
CLIENTNAME
CommonProgramFiles
COMPUTERNAME
ComSpec
=46P_NO_HOST_CHECK
GIT_EDITOR
HOME
HOMEDRIVE
HOMEPATH
LESS
LOGONSERVER
MSYSDIR
NUMBER_OF_PROCESSORS
OS
OS_ROOTDIR
OS_TMPDIR
Path
PATHEXT
PROCESSOR_ARCHITECTURE
PROCESSOR_IDENTIFIER
PROCESSOR_LEVEL
PROCESSOR_REVISION
ProgramFiles
PROMPT
SESSIONNAME
SystemDrive
SystemRoot
TEMP
TERM
TMP
USERDOMAIN
USERNAME
USERPROFILE
VS100COMNTOOLS
VS90COMNTOOLS
windir
WXWIN

-- Hannes
