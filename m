From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: inotify to minimize stat() calls
Date: Fri, 08 Mar 2013 08:01:41 +0100
Message-ID: <51398CD5.1070603@web.de>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh> <7vhaljudos.fsf@alter.siamese.dyndns.org> <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com> <513911B3.7010903@web.de> <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 08 08:02:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDrK3-0000Ob-Qj
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 08:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346Ab3CHHCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Mar 2013 02:02:05 -0500
Received: from mout.web.de ([212.227.17.12]:53315 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932697Ab3CHHCD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 02:02:03 -0500
Received: from [192.168.2.107] ([79.223.122.215]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0Le4Lg-1UYes01ZDI-00qVFp; Fri, 08 Mar 2013 08:01:48
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130216 Thunderbird/17.0.3
In-Reply-To: <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:7jyYObyLdhoe/X07QrzDxFlcJNOCC0k1J/5zFWTwS6y
 xYD4auA7JLvIVJwskEEk/tRuWI4SKaHvAqm4PtKj4bTKK9Z8sG
 kyMwuuRlhvrH0HxMw1FR5UvJgZeGBs0EN8e5Zhz1+SCYUL9Bdk
 07igyC+DksyhSmSuW8ULIZt4M8VKfuxXuBUG7cKQT7lgzZ1kC9
 3kyfToDjvfZY4WV3ORqBQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217642>

On 08.03.13 01:04, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>=20
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index d6dd3df..6a5ba11 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1158,6 +1158,8 @@ int cmd_status(int argc, const char **argv, co=
nst char *prefix)
>>  	unsigned char sha1[20];
>>  	static struct option builtin_status_options[] =3D {
>>  		OPT__VERBOSE(&verbose, N_("be verbose")),
>> +		OPT_BOOLEAN('c', "changed-only", &s.check_changed_only,
>> +			    N_("Ignore untracked files. Check if files known to git are =
modified")),
>=20
> Doesn't this make one wonder why a separate bit and implementation
> is necessary to say "I am not interested in untracked files" when
> "-uno" option is already there?
Thanks Junio,
this is good news.
I need to admit that I wasn't aware about "git status -uno".

Thinking about it, how many git users are aware of the speed penalty
when running git status to find out which (tracked) files they had chan=
ged?

Or to put it the other way, when a developer wants a quick overview
about the files she changed, then git status -uno may be a good and fas=
t friend.

Does it make sence to stress put that someway in the documentation?

diff --git a/Documentation/git-status.txt b/Documentation/git-status.tx=
t
index 9f1ef9a..360d813 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -51,13 +51,18 @@ default is 'normal', i.e. show untracked files and =
directori
 +
 The possible options are:
 +
-       - 'no'     - Show no untracked files
+       - 'no'     - Show no untracked files (this is fastest)
        - 'normal' - Shows untracked files and directories
        - 'all'    - Also shows individual files in untracked directori=
es.
 +
 The default can be changed using the status.showUntrackedFiles
 configuration variable documented in linkgit:git-config[1].
=20
++
+Note: Searching for untracked files or directories may take some time.
+A fast way to get a status of files tracked by git is to use
+'git status -uno'
+












>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
