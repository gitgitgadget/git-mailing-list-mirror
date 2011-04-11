From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Mon, 11 Apr 2011 22:05:54 +0200
Message-ID: <4DA35F22.7090006@web.de>
References: <201103191528.34646.tboegi@web.de> <7vsjuitk59.fsf@alter.siamese.dyndns.org> <4DA144A5.2080103@web.de> <7vd3ksybfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: kusmabite@gmail.com, Git Mailing List <git@vger.kernel.org>,
	tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 22:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9NNM-0002wR-1a
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 22:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755853Ab1DKUGP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2011 16:06:15 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:54557 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755751Ab1DKUGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 16:06:14 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id E04F818C0F61C;
	Mon, 11 Apr 2011 22:06:12 +0200 (CEST)
Received: from [194.22.188.61] (helo=[192.168.209.16])
	by smtp04.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #2)
	id 1Q9NNE-0002gc-00; Mon, 11 Apr 2011 22:06:12 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <7vd3ksybfr.fsf@alter.siamese.dyndns.org>
X-Sender: tboegi@web.de
X-Provags-ID: V01U2FsdGVkX19AKLknljA25JNMfRQhmELAxczbMMwY4UMkClOk
	EUaumWZ1JbG9beeSvEIyOIw/Avq4Iw+T9H63HsWLotwLQlZ9XV
	ujjLBVDxY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171352>

On 04/11/2011 06:55 PM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>>> When two different _names_ "A" and "a" refer to a single file, the =
only
>>> thing that should happen for "git mv A a" is for the cache entry fo=
r "A"
>>> to be moved to cache entry for "a", and no rename("A", "a") should =
be run,
>>> but I don't see any such change in the code. It may happen to work =
(or be
>>> a no-op) on Windows, but because builtin/mv.c is supposed to be gen=
eric
>>> (and that is the reason you introduced the is_same_file() abstracti=
on in
>>> the first place), I'd still see this as a breakage.
>>>
>> Why shouldn't the rename() be done?
>> "git mv A B" changes both the indes and the file system.
>> Isn't it natural to have file name  "a" both in the index and in the
>> file system after "git mv A a"?
>> Note: Windows and MAC OS X allow "mv A a" from command line,
>> while Linux on VFAT gives an error "'A' and 'a' are the same file".
> Yeah, I forgot about the primary thing we are trying to do in this
> discussion.  Sorry about that.  My thinking stopped at 'if we rename =
"A"
> to "a in the index, that is sufficient.  We already know that we can =
still
> open("A") because the filesystem is case insensitive.'
>
> In fact, we want both the index entry "A" renamed to "a" _and_ also w=
e
> want to see next "/bin/ls" to show "a", not "A".  For the latter, we =
do
> want to run rename(2) on them.
>
> There was another thing that made me worry about running rename(2) on=
 two
> equivalent filenames.  You said on Linux VFAT "mv A a" fails.  Does t=
he
> underlying rename(2) fail when you do this?
>
> 	status =3D rename("A", "a");
>
> If old and new resolve to the same existing directory entry or differ=
ent
> directory entries for the same existing file, POSIX says that rename(=
old,
> new) should succeed and perform no other action, so the above should
> succeed on correctly implemented case insensitive filesystems.
>
> But we know not all FS implementations are perfect.  If this can resu=
lt in
> an unnecessary failure, it would be far better if we are careful to a=
void
> running rename("A", "a") and just rename the index entry to make sure=
 "git
> mv A a" succeeds, than trying to fulfil the "we want to see next '/bi=
n/ls'
> to show 'a' not 'A'" wish and make the whole "git mv A a" fail.
>
> But of course we can always blame the breakage on filesystems.  I am
> leaning to prefer running rename("A", "a") unconditionally.
>
> Thanks.
Thanks for reading and for the reply.

>You said on Linux VFAT "mv A a" fails

My excuses for being unclear, as "fails" often means returning -1 and=20
setting errno.
But this is not the case here. I should have said:
rename("A", "a") returns 0 but does not rename the file.

Here comes the  long version. I wrote a short program called "rename", =
=20
and run some tests.
The /D is a VFAT partition, mounted writable for root only.
-----------------------------------
tb@wanderer:/D/test> ls
A  B  x
tb@wanderer:/D/test> rename A A
rename A A res=3D0 Success
tb@wanderer:/D/test> ls
A  B  x
tb@wanderer:/D/test> rename A a
rename A a res=3D0 Success
tb@wanderer:/D/test> ls
A  B  x
tb@wanderer:/D/test> rename A D
rename A D res=3D-1 Permission denied
tb@wanderer:/D/test>
------------------------------------

I had a short look into the Linux kernel. A comment in namei_vfat.c=20
indicates that
rename "filename" "FILENAME" is not supported for now.
(and all respect and thanks from my side to the people who made VFAT=20
working).
(and of course to the git people)
