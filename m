From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git archive --format zip utf-8 issues
Date: Sat, 11 Aug 2012 22:53:29 +0200
Message-ID: <5026C649.2090700@lsrfire.ath.cx>
References: <502583F4.8030308@tu-clausthal.de> <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 11 22:54:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Igs-0006Hd-Q2
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 22:53:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab2HKUxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Aug 2012 16:53:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:39092 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab2HKUxj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 16:53:39 -0400
Received: from [192.168.2.105] (p4FFD986C.dip.t-dialin.net [79.253.152.108])
	by india601.server4you.de (Postfix) with ESMTPSA id 733142F8065;
	Sat, 11 Aug 2012 22:53:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vtxwagy9f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203297>

Am 11.08.2012 00:47, schrieb Junio C Hamano:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>
>> when I create a git repository, add a file containing utf-8 characte=
rs
>> or umlauts (like =C3=B6=C3=A4=C3=BC.txt), commit and then export the=
 HEAD revision to a
>> zip archive using "git archive --format zip -o 1.zip HEAD", the zip =
file
>> contains incorrect filenames:
>
> My reading of archive-zip.c seems to suggest that we write out
> whatever pathname you have in the tree, so a pathname encoded in
> UTF-8 will be literally written out in the resulting zip archive.

Sorry for my imperialistic attitude of "ASCII filenames should be enoug=
h=20
for everybody".  Laziness..

> Do you know in what encoding the pathnames are _expected_ to be
> stored in zip archives?  Random documentation seems to suggest that
> there is no standard encoding, e.g. http://docs.python.org/library/zi=
pfile.html
> says:
>
>      There is no official file name encoding for ZIP files. If you
>      have unicode file names, you must convert them to byte strings
>      in your desired encoding before passing them to write(). WinZip
>      interprets all file names as encoded in CP437, also known as DOS
>      Latin.
>
> which may explain it.

http://www.pkware.com/documents/casestudies/APPNOTE.TXT is the standard=
=20
document, as Sven noted, and it says that filenames are encoded in code=
=20
page 437, or optionally UTF-8 (a later addition).  Discussions like=20
http://stackoverflow.com/questions/106367/ seem to indicate that at=20
least some archivers use the local code page as well.

> It may not be a bad idea for "git archive --format=3Dzip" to
>
>   (1) check if pathname is a correct UTF-8; and
>   (2) check if it can be reencoded to latin-1
>
> and if (and only if) both are true, automatically re-encode the path
> to latin-1.

The standard says we need to convert to CP437, or to UTF-8, or provide=20
both versions. A more interesting question is: What's supported by whic=
h=20
programs?

The ZIP functionality built into Windows 7 doesn't seem to work with=20
UTF-8 encoded filenames (except for those that only use the ASCII=20
subset), and to ignore the UTF-8 part if both are given.  Handling=20
umlauts should be possible anyway, because they are on code page 437,=20
but for other characters we'd have to aim for compatibility with other=20
programs like Info-ZIP and 7-Zip.

How do we know which encoding was used for a filename?

> Of course, "git archive --format=3Dzip --path-reencode=3Dutf8-to-lati=
n1"
> would be the most generic way to do this.

I really hope we can make do without additional options.

Ren=C3=A9
