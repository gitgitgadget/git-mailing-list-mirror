From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 09 Aug 2011 12:25:42 +0200
Message-ID: <4E410B26.1080407@lsrfire.ath.cx>
References: <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net> <4E3829DC.8070802@lsrfire.ath.cx> <20110802181357.GA1861@sigill.intra.peff.net> <4E388A55.6080606@kdbg.org> <4E3D0C1D.9000807@lsrfire.ath.cx> <4E3EEF3B.80908@kdbg.org> <4E401869.8060702@lsrfire.ath.cx> <20110809050211.GA3588@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 09 12:26:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqjVi-0007oq-8Y
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 12:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171Ab1HIK0E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Aug 2011 06:26:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:34040 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752949Ab1HIK0D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2011 06:26:03 -0400
Received: from [192.168.2.105] (p579BE327.dip.t-dialin.net [87.155.227.39])
	by india601.server4you.de (Postfix) with ESMTPSA id 6BB4E2F8061;
	Tue,  9 Aug 2011 12:26:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110809050211.GA3588@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179028>

Am 09.08.2011 07:02, schrieb Jeff King:
> On Mon, Aug 08, 2011 at 07:10:01PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>>> -	tar_filter_config("tar.tgz.command", "gzip -cn", NULL);
>>> +	tar_filter_config("tar.tgz.command", "gzip -cn | cat", NULL);
>>>  	tar_filter_config("tar.tgz.remote", "true", NULL);
>>> -	tar_filter_config("tar.tar.gz.command", "gzip -cn", NULL);
>>> +	tar_filter_config("tar.tar.gz.command", "gzip -cn | cat", NULL);
>>>  	tar_filter_config("tar.tar.gz.remote", "true", NULL);
>>>  	git_config(git_tar_config, NULL);
>>>  	for (i =3D 0; i < nr_tar_filters; i++) {
>>>
>>> (provided that 'cat' magically does not suffer from the same proble=
m,
>>> and I do think that it does not.)
>>
>> The external cat can indeed be used.  We'd need to do that for user
>> supplied commands as well, though, like this (ugh):
>>
>> diff --git a/archive-tar.c b/archive-tar.c
>> index 20af005..eaa9a1c 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -326,6 +326,9 @@ static int write_tar_filter_archive(const struct=
 archiver *ar,
>>  		die("BUG: tar-filter archiver called with no filter defined");
>> =20
>>  	strbuf_addstr(&cmd, ar->data);
>> +#ifdef WIN32
>> +	strbuf_addstr(&cmd, " | cat");
>> +#endif
>>  	if (args->compression_level >=3D 0)
>>  		strbuf_addf(&cmd, " -%d", args->compression_level);
>=20
> Do we need to? It seems to me that defaulting to "gzip -cn | cat" is =
not
> "we are on Windows, a platform that needs a special workaround in git=
",
> but rather "this gzip is horribly broken, but at build-time you can
> set a gzip that works".

It's an MSYS platform problem IMHO, and we can work around it.  That
extra cat is nothing to be proud of, sure.  And msysgit avoiding the
issue by distibuting a gzip that never converts line endings would solv=
e
it without any runtime overhead.

> So if the user wants to specify some broken filter, it is up to them =
to
> add "| cat" if their filter merits it.

Well, I'd rather take this responsibility from the user, who might
struggle a while before finding out what is going on.  However...

> But that is somewhat a matter of perception, and it won't make a user=
 on
> Windows who does "git config archive.bz2 bzip2 -c" any happier when t=
hey
> are told it is their responsibility to deal with it.

If all packers shipped with msysgit are usable then we're probably good=
=2E

> BTW, as nice as this "gzip -cn | cat" idea is, I think it needs to be
> wrapped in a shell script. With the code above, we will generate "gzi=
p
> -cn | cat -9".

Yes, the three added lines in the patch above would have to be moved
down two lines, after the compression level is added.  D'oh!

> So we really need:
>=20
>   $ cat `which gzip`
>   #!/bin/sh
>   gzip.real -cn "$@" | cat
>
> and then no hacks need to go into git at all. The fix is about provid=
ing
> a sane gzip, not fixing git.

OK, that's one way to do it; another would be let gzip (and bzip2 etc.)
do whatever cat does to avoid end of line conversions.  And yet another
is to take them from http://unxutils.sourceforge.net/.

> BTW, from what Johannes said, the issue is about a non-msys program
> calling an msys one. Does that mean that having git run:
>=20
>   sh -c 'gzip -cn'
>=20
> would work? If so, then could the solution be as simple as turning of=
f
> the "don't bother with the shell" optimization that run-command uses?
> Something like "gzip -cn" gets split by git and run via spawn now
> (because it has no metacharacters). But we could easily make it alway=
s
> run through the shell.

Just checked -- it doesn't work.  I assume that's because the shell is
also an MSYS program.

Ren=C3=A9
