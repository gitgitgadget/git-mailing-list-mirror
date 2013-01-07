From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Mon, 07 Jan 2013 07:59:53 +0100
Message-ID: <50EA7269.1080006@web.de>
References: <20130107003603.GA25698@odin.tremily.us> <20130107013952.GE3823@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:00:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts6hC-0007T8-VY
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 08:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305Ab3AGHAL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 02:00:11 -0500
Received: from mout.web.de ([212.227.17.12]:61722 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab3AGHAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 02:00:09 -0500
Received: from [192.168.178.41] ([91.3.169.250]) by smtp.web.de (mrweb001)
 with ESMTPA (Nemesis) id 0Md4V8-1TZt2z15c2-00INA9; Mon, 07 Jan 2013 08:00:00
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20130107013952.GE3823@elie.Belkin>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:ZkLcPPwdfBDcRHrrYmXSmMg+cPhlp/x+M+7GEubptkD
 XbEUHftVVafJMBf6o959aWOLJlcAlg1JNjPJfGtwZNUVC9zXhN
 Hzs51QbMlUkZomDD1yxsRj6H/aVBlE4r1SCcpYKa7M4L9MPk+r
 iHE805TmPilOfGDmZklmDIEhdvxoNyvP9SG6foWVMfsmcz8Tvl
 pUkUwK7/pK3l6VXov69Wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212880>

Am 07.01.2013 02:39, schrieb Jonathan Nieder:
> (just cc-ing Jens and Peter, who might be interested)

I=B4m currently working on teaching mv to move submodules and intend
to send those patches to the list after finishing submodule deinit.
Please see
  https://github.com/jlehmann/git-submod-enhancements/commits/mv-submod=
ules
for the current state of this series.

> W. Trevor King wrote:
>=20
>> Today I had to move my first submodule, and I discovered that Git's
>> support for this is pretty limited.  There have been a few patch
>> series attempting to address this [1,2], but none of them seems to
>> have pushed through into master (although I can't put my finger on a
>> reason for why).  There are also some SO postings discussing this
>> [3,4].  It would be nice if `git mv` worked out of the box on
>> submodules.  Failing that, there could be a `git submodule mv` comma=
nd
>> that casts the appropriate spell.  Failing that, there could be a
>> recipe in Documentation/git-submodule.txt.  Here's the best I could
>> come up with for a `git-submodule-mv.sh`:
>>
>>   #!/bin/sh
>>   # usage: git-submodule-mv.sh OLD NEW
>>   OLD=3D$(realpath --relative-to . "$1")
>>   NEW=3D$(realpath --relative-to . "$2")
>>   SHA=3D$(git ls-files -s "$OLD" | sed 's|^[0-9]* \([0-9a-f]*\) .*|\=
1|')
>>   NAME=3D$(git config -f .gitmodules --get-regexp 'submodule\..*\.pa=
th' "$OLD" |
>>     sed -e 's|^submodule.||' -e "s|.path $OLD\$||")
>>   GITDIR=3D$(realpath --relative-to "$NEW" .git/modules/"$NAME")
>>   git config -f .gitmodules submodule."$NAME".path "$NEW"
>>   git config -f .git/modules/"$NAME"/config core.worktree "../../../=
$NEW"
>>   git rm --cached "$OLD"
>>   mv "$OLD" "$NEW"
>>   echo "gitdir: $GITDIR" > "$NEW/.git"
>>   git update-index --add --cacheinfo 160000 "$SHA" "$NEW"
>>
>> This only works from the repository root directory, and I'm sure mak=
es
>> a number of poor assumptions (e.g. old-style submodules that don't u=
se
>> `gitdir` links are not supported).  It does work for some simple tes=
t
>> cases.  The tricky parts (e.g. path -> name conversion) are already
>> worked out more robustly git-submodule.sh, so adding a new cmd_mv
>> shouldn't be very difficult.
>>
>> Could something like this live somewhere in Git, or are we waiting f=
or
>> a more integrated solution?
>>
>> Cheers,
>> Trevor
>>
>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/88720
>> [2]: http://thread.gmane.org/gmane.comp.version-control.git/143250
>> [4]: http://stackoverflow.com/questions/4323558/moving-submodules-wi=
th-git
>> [3]: http://stackoverflow.com/questions/4604486/how-do-i-move-an-exi=
sting-git-submodule-within-a-git-repository
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
