From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Tue, 08 Jul 2014 21:25:39 +0100
Message-ID: <53BC53C3.1010304@ramsay1.demon.co.uk>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>	<53B5C7AC.4040701@web.de> <xmqqsimddrq3.fsf@gitster.dls.corp.google.com> <53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-1?Q?Torsten_B=F6gers?= =?ISO-8859-1?Q?hausen?= 
	<tboegi@web.de>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 22:25:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4bxV-0004AJ-Iy
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 22:25:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753786AbaGHUZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2014 16:25:45 -0400
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:35684 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750947AbaGHUZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 16:25:44 -0400
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id CFC7AA0C08A;
	Tue,  8 Jul 2014 20:18:54 +0100 (BST)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 9736FA0C087;
	Tue,  8 Jul 2014 20:18:54 +0100 (BST)
Received: from [192.168.254.1] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Tue,  8 Jul 2014 20:18:53 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53BC47BD.1000705@web.de>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253043>

On 08/07/14 20:34, Jens Lehmann wrote:
> Am 07.07.2014 21:40, schrieb Torsten B=F6gershausen:
>> On 2014-07-07 19.05, Junio C Hamano wrote:
>>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>
>>>> Junio, do you want me to resend 02/14 without the non-portable "ec=
ho -n"
>>>> or could you just squash the following diff in?
>>>
>>> Amended locally here already; thanks, both.
>>
>> There seems to be some other trouble under Mac OS, not yet fully tra=
cked down,
>> (may be related to the "diff -r")
>=20
> Torsten sees failures of this kind under Mac OS:
>=20
> diff -r .git/modules/sub1/config sub1/.git/config
> 6d5
> <     worktree =3D ../../../sub1
> 8a8
>>     worktree =3D ../../../sub1
>=20
> So the config contains the same content, but the worktree setting mov=
ed
> to a different line. This seems to be the result of setting core.work=
tree
> in the test_git_directory_is_unchanged function just before the "diff=
 -r",
> but only under Mac OS.
>=20
>> And Msysgit complains=20
>> error: fchmod on c:/xxxt/trash directory.t7613-merge-submodule/submo=
dule_update_repo/.git/modules/sub1/config.lock failed: Function not imp=
lemented
>=20
> I'm not sure what this is about, seems to happen during the "cp -R" o=
f
> the repo under .git/modules into the submodule.

I haven't looked into this at all, but from the above message, and
noting that fchmod() is not implemented in mingw (see compat/mingw.h
line 91), and the following:

    $ git grep -n fchmod
    compat/mingw.h:91:static inline int fchmod(int fildes, mode_t mode)
    config.c:1639:          if (fchmod(fd, st.st_mode & 07777) < 0) {
    config.c:1640:                  error("fchmod on %s failed: %s",
    config.c:1818:  if (fchmod(out_fd, st.st_mode & 07777) < 0) {
    config.c:1819:          ret =3D error("fchmod on %s failed: %s",
    $=20

[I happen to be on the pu branch at the moment, so YMMV!]

Both calls to fchmod() above are on config lock files, one
in git_config_set_multivar_in_file() and the other in
git_config_rename_section_in_file().

ATB,
Ramsay Jones
