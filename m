From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 01 Aug 2011 23:42:59 +0200
Message-ID: <4E371DE3.3000008@lsrfire.ath.cx>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com> <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org> <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com> <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net> <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 23:43:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo0GS-0002c0-9v
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 23:43:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab1HAVnF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 17:43:05 -0400
Received: from india601.server4you.de ([85.25.151.105]:50876 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab1HAVnD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 17:43:03 -0400
Received: from [192.168.2.104] (p4FFD8EFC.dip.t-dialin.net [79.253.142.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 5B3FA2F8035;
	Mon,  1 Aug 2011 23:43:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E3718B4.6090803@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178418>

Am 01.08.2011 23:20, schrieb Johannes Sixt:
> Am 01.08.2011 22:48, schrieb Ren=C3=A9 Scharfe:
>> So git archive gives the right results when writing to a pipe, but
>> always the same wrong result when writing directly to a file.
>=20
> This could indeed be a CRLF issue. archive-tar.c runs gzip to let it
> write to the original fd 1 (stdout). gzip is an MSYS program, and MSY=
S
> is "clever" and sets up the channel in text mode (CRLF conversion) if=
 it
> is a regular file, but in binary mode if it is a pipe.
>=20
> Without the gzip filter, git-archive writes to stdout itself. Since w=
e
> have set up all our channels in binary mode, we do not suffer from th=
e
> same problem for plain tar format.

That seems to be it indeed:

	$ git config tar.t.command 'tar tf -'
	$ git archive --format=3Dt v1.7.6 >a.t
	$ git archive --format=3Dt v1.7.6 | cat >b.t

	$ diff -b a.t b.t | wc -l
	      0

	$ md5sum <a.t
	8026ba48963ec4f849ae863f822bccbc *-

	$ md5sum <b.t
	7bcaa37bfcc47b1ae535369ae0399d90 *-

	$ sed 's/\r//' <a.t | md5sum
	7bcaa37bfcc47b1ae535369ae0399d90 *-

Ren=C3=A9
