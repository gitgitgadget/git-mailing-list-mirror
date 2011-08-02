From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Tue, 02 Aug 2011 18:46:20 +0200
Message-ID: <4E3829DC.8070802@lsrfire.ath.cx>
References: <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net> <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org> <4E37202B.80208@lsrfire.ath.cx> <20110802040004.GC17494@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 02 18:46:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoI6x-00087l-UN
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 18:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622Ab1HBQq1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 12:46:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:35197 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554Ab1HBQqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 12:46:25 -0400
Received: from [192.168.2.104] (p4FFDA3FA.dip.t-dialin.net [79.253.163.250])
	by india601.server4you.de (Postfix) with ESMTPSA id 7900C2F8035;
	Tue,  2 Aug 2011 18:46:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110802040004.GC17494@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178481>

Am 02.08.2011 06:00, schrieb Jeff King:
> On Mon, Aug 01, 2011 at 11:52:43PM +0200, Ren=C3=A9 Scharfe wrote:
>=20
>> Am 01.08.2011 23:20, schrieb Johannes Sixt:
>>> Am 01.08.2011 22:48, schrieb Ren=C3=A9 Scharfe:
>>>> So git archive gives the right results when writing to a pipe, but
>>>> always the same wrong result when writing directly to a file.
>>>
>>> This could indeed be a CRLF issue. archive-tar.c runs gzip to let i=
t
>>> write to the original fd 1 (stdout). gzip is an MSYS program, and M=
SYS
>>> is "clever" and sets up the channel in text mode (CRLF conversion) =
if it
>>> is a regular file, but in binary mode if it is a pipe.
>>>
>>> Without the gzip filter, git-archive writes to stdout itself. Since=
 we
>>> have set up all our channels in binary mode, we do not suffer from =
the
>>> same problem for plain tar format.
>>>
>>> So, I don't think we can do a lot about it, short of patching MSYS =
again...
>>
>> Or we could pipe the output through us, i.e. attach a builtin versio=
n of
>> cat at the output end of the called command.  Only on Windows, of
>> course.  Better ugly and limping then wrong, right?
>=20
> Yeah, that would work. But I am confused. If what Johannes says is tr=
ue,
> isn't MSYS gzip totally broken for:
>=20
>   # works
>   echo foo | gzip -c | cat >foo.gz
>=20
>   # broken; introduces CR
>   echo foo | gzip -c >foo.gz
>=20
> ? (The "works" and "broken" there are my guesses; I don't have a Wind=
ows
> box to test on). IOW, is it simply gzip that is broken, and any fix w=
e
> do is simply working around a bug in gzip? And therefore the right
> solution is for MSYS people to fix gzip?

"foo" may be too short to trigger the issue as the small resulting gz
file has a low probability of containing LFs.

The output of gzip is not simply always mangled, though (taken from my
earlier email, all three are working):

	$ git archive v1.7.6 | gzip -cn | md5sum
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive --format=3Dtar.gz v1.7.6 | md5sum
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive v1.7.6 | gzip -cn >a.tgz && md5sum <a.tgz
	a0ca1c873a533a5fcd41d248fb325a5b *-

It's only broken if we call it from git archive:

	$ git archive --format=3Dtar.gz v1.7.6 >a.tgz && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

	$ git archive -o a.tgz v1.7.6 && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

But not if we stuff the result into a pipe instead of a file:

	$ git archive --format=3Dtar.gz v1.7.6 | cat >a.tgz && md5sum <a.tgz
	a0ca1c873a533a5fcd41d248fb325a5b *-

It _is_ confusing.

Ren=C3=A9
