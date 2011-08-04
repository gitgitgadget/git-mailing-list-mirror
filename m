From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git-archive's wrong documentation: really write pax rather than
 tar
Date: Thu, 04 Aug 2011 19:39:31 +0200
Message-ID: <4E3AD953.6010808@lsrfire.ath.cx>
References: <1312409879.97173.YahooMailClassic@web29501.mail.ird.yahoo.com> <20110804014143.GA32579@sigill.intra.peff.net> <7v62me6ism.fsf@alter.siamese.dyndns.org> <20110804020054.GA1947@sigill.intra.peff.net> <7vwret6hgj.fsf@alter.siamese.dyndns.org> <20110804022903.GA3388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Hin-Tak Leung <htl10@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 19:39:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qp1ta-0002DJ-N1
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 19:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab1HDRjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 13:39:40 -0400
Received: from india601.server4you.de ([85.25.151.105]:52061 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755182Ab1HDRjj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2011 13:39:39 -0400
Received: from [192.168.2.104] (p579BE51C.dip.t-dialin.net [87.155.229.28])
	by india601.server4you.de (Postfix) with ESMTPSA id 492882F8035;
	Thu,  4 Aug 2011 19:39:37 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <20110804022903.GA3388@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178756>

Am 04.08.2011 04:29, schrieb Jeff King:
> On Wed, Aug 03, 2011 at 07:25:32PM -0700, Junio C Hamano wrote:
>=20
>>> Actually, it is relevant for zip, too. The option should really be
>>> called "--no-commit-id" or something similar. I don't think it's as=
 big
>>> a deal with zip (because there is no compatibility issue), but you =
may
>>> want to omit the header for other reasons (e.g., because you know i=
t
>>> doesn't point to a commit that is public).
>>
>> Hmm, perhaps. It indeed is an implementation detail of the tar backe=
nd
>> that the commit object name is stored in pax header, so --no-commit-=
id
>> might make sense from "git" point of view, but from the point of vie=
w of
>> OP that started this thread, he wouldn't care what that extra inform=
ation
>> is --- it can be a commit object name or it can be phase of the moon=
 when
>> the archive was made --- he just wants the extra header dropped.
>>
>> So I dunno.
>=20
> If the intent of the option is "write plain-vanilla ustar" (I really
> hope it doesn't need to be "plain-vanilla 4.3BSD tar"), then I think =
we
> would do better to have a new --format type. Because from the OP's
> perspective, it's not "drop this header that I don't like" but "make
> something compatible with older versions of tar".

Yes, the commit ID header is just one part of this.  Extended pax
headers are also used to store file names or symlink targets that are
too long.  If none of this applies, the output should be pure ustar, th=
ough.

POSIX says that programs should treat unknown entry types just like
plain files and print an error message.  You'd get an extra file named
pax_global_header, containing only the commit ID, and for long file
names extra files that contain them (and your original files would get
short names based on their object ID).

Looking at the web page linked to in the original post, the problem
seems to be that R (probably http://www.r-project.org/) uses "tar" as a
package format, seems to accept the ustar format but refuses pax
extended headers and thus is incompatible with "POSIX tar" and also
doesn't follow the suggestion to treat unknown entries as plain files.

We could add a "ustar" format that doesn't write commit ID comments and
errors out on file names that are too long.

Ren=C3=A9
