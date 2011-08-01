From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 01 Aug 2011 22:48:09 +0200
Message-ID: <4E371109.7050500@lsrfire.ath.cx>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com> <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org> <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com> <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net> <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	j6t@kdbg.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 01 22:48:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnzPN-0006js-JJ
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 22:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540Ab1HAUsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 16:48:13 -0400
Received: from india601.server4you.de ([85.25.151.105]:42747 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab1HAUsM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 16:48:12 -0400
Received: from [192.168.2.104] (p4FFD8EFC.dip.t-dialin.net [79.253.142.252])
	by india601.server4you.de (Postfix) with ESMTPSA id A22A72F8035;
	Mon,  1 Aug 2011 22:48:10 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <20110801182516.GC10302@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178410>

Am 01.08.2011 20:25, schrieb Jeff King:
> On Mon, Aug 01, 2011 at 08:02:22PM +0200, Erik Faye-Lund wrote:
>=20
>>> Weird. What does j.tgz end up looking like? Is it empty, or does it=
 have
>>> bogus data in it? Does gzip actually get invoked at all? Try runnin=
g
>>> with GIT_TRACE=3D1. I don't suppose you guys have something like st=
race,
>>> which might be helpful.
>>>
>>
>> It does have data, and gzip does get invoked:
>> $ gunzip -c j.tgz | wc -c
>>
>> gzip: j.tgz: invalid compressed data--format violated
>>  131072
>>
>> So it seems there are around 130k of valid data before it barfs.
>>
>> Hmm, but when I try the same after re-running the test, I get a
>> different amount of valid data (491520 bytes this time)... Is this a
>> timing-related issue?
>=20
> Hmm. Non-deterministic output is not good. Could be timing, or we cou=
ld
> be touching memory we're not supposed to. I just ran t5000 through
> valgrind, and nothing turned up. And of course I can't replicate the
> test failure on Linux. So I assume it really is Windows-specific.
>=20
> That makes me suspect some difference in how the run-command API work=
s
> on the two platforms, since that is the code here that will be vastly
> difference. I notice the start_command code uses dup() on Windows
> instead of dup2() (I guess you guys don't have dup2?). I wonder if th=
ere
> could be some issue with another descriptor accidentally pointing to =
the
> same spot. But that's just a wild guess.
>=20
> I think at this point, I'd probably start stepping through the archiv=
e
> code with gdb.

Hrm, here is another data point, for what it's worth (Windows 7 x64,
MinGW):

	$ git archive v1.7.6 | gzip -cn | md5sum
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive --format=3Dtar.gz v1.7.6 | md5sum
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive v1.7.6 | gzip -cn >a.tgz && md5sum <a.tgz
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ ls -l a.tgz
	-rw-r--r--    1 User     Administ  3361584 Aug  1 20:44 a.tgz

	$ git archive --format=3Dtar.gz v1.7.6 >a.tgz && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

	$ ls -l a.tgz
	-rw-r--r--    1 User     Administ  3374383 Aug  1 20:45 a.tgz

	$ git archive --format=3Dtar.gz v1.7.6 >a.tgz && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

	$ git archive --format=3Dtar.gz v1.7.6 >a.tgz && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

	$ git archive v1.7.6 | gzip -cn >a.tgz && md5sum <a.tgz
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive --format=3Dtar.gz v1.7.6 | cat >a.tgz && md5sum <a.tgz
	a0ca1c873a533a5fcd41d248fb325a5b *-

	$ git archive -o a.tgz v1.7.6 && md5sum <a.tgz
	30886283af1aed05ae6a36fc5aeda077 *-

So git archive gives the right results when writing to a pipe, but
always the same wrong result when writing directly to a file.  With
--format=3Dtar there is no difference:

	$ git archive v1.7.6 | md5sum
	fa364f38f9128df019dd8fd509c40a6d *-

	$ git archive v1.7.6 >a.tar && md5sum <a.tar
	fa364f38f9128df019dd8fd509c40a6d *-

Ren=C3=A9
