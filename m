From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: tar on Mac does not like empty tar from git archive
Date: Tue, 09 Apr 2013 21:37:54 +0200
Message-ID: <51646E12.2030506@lsrfire.ath.cx>
References: <ABD0C67A-0B2B-4E32-AF49-93FBABC032A7@bjhargrave.com> <20130408210536.GB9649@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: BJ Hargrave <bj@bjhargrave.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 09 21:38:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPeMs-0007oa-2j
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 21:38:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935628Ab3DITiE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 15:38:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:47435 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760469Ab3DITiD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 15:38:03 -0400
Received: from [192.168.2.105] (p4FFD9211.dip.t-dialin.net [79.253.146.17])
	by india601.server4you.de (Postfix) with ESMTPSA id 72F981E4;
	Tue,  9 Apr 2013 21:38:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <20130408210536.GB9649@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220622>

Am 08.04.2013 23:05, schrieb Jeff King:
> On Mon, Apr 08, 2013 at 02:36:05PM -0400, BJ Hargrave wrote:
>=20
>> Git 1.8.2.1 includes commit bd54cf17 - archive: handle commits with =
an
>> empty tree
>>
>> Test 2 of t5004-archive-corner-cases, "tar archive of empty tree is
>> empty", fails on Mac OS X 10.8.3 (with XCode 4.6.1) since the tar
>> command exits with return code 1 on the generated  tar file.
>=20
> Hmm. So I guess the question is: do we need to work around this in th=
e
> test for platforms that do not like empty tar files, or are the empty
> tarfiles we are making wrong somehow?
>=20
>> tar --version
>> bsdtar 2.8.3 - libarchive 2.8.3
>>
>> It appears that bsdtar does not like the empty tar files created by
>> git archive. An empty tar file created by bsdtar is accepted.
>>
>> tar cT /dev/null | tar t; echo $?
>> 0
>=20
> That makes me think the latter ("we are wrong"). I don't have my OS X
> box handy; can you provide a sample empty tarfile that it creates?

libarchive (on which bsdtar is based) doesn't like extended pax headers
at the end of archives.  Here's the relevant source file:

https://github.com/libarchive/libarchive/blob/master/libarchive/archive=
_read_support_format_tar.c

tar_read_header() calls header_pax_global() to handle a global pax
header, which in turn calls tar_read_header() again to fetch the next
header.  If it reaches the end of the archive then err is set to
ARCHIVE_EOF and "Damaged tar archive" is reported at the end of this
function.

I tried come up with a small patch that convinces it to ignore such a
condition, but it's apparently not as easy as it looks -- I just made
bsdtar report even more obscure errors.  Will look deeper into it
later this week.

Ren=C3=A9
