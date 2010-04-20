From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix checkout of large files to network shares under Windows
 XP
Date: Tue, 20 Apr 2010 10:18:25 +0200
Message-ID: <4BCD6351.1050706@viscovery.net>
References: <4BCC5083.30801@gmail.com> <4BCCC05E.4030206@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 20 10:18:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O48fK-00067s-IZ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 10:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946Ab0DTISf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Apr 2010 04:18:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47781 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753912Ab0DTIS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Apr 2010 04:18:29 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O48f4-0004nS-95; Tue, 20 Apr 2010 10:18:26 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id C5C2F1660F;
	Tue, 20 Apr 2010 10:18:25 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BCCC05E.4030206@lsrfire.ath.cx>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145356>

Am 4/19/2010 22:43, schrieb Ren=E9 Scharfe:
> Am 19.04.2010 14:45, schrieb Sebastian Schuberth:
>> +#undef write
>> +ssize_t mingw_write(int fd, const void *buf, size_t count)
>> +{
>> +	ssize_t written =3D 0;
>> +	size_t total =3D 0, size =3D count;
>> +
>> +	while (total < count && size > 0) {
>> +		written =3D write(fd, buf, size);
>> +		if (written < 0 && errno =3D=3D EINVAL) {
>> +			// There seems to be a bug in the Windows XP network stack that
>> +			// causes writes with sizes > 64 MB to fail, so we halve the siz=
e
>> +			// until we succeed or ultimately fail.
>=20
> C style comments (/*...*/) are preferred over C++ style comments (//.=
=2E.)
> for git.
>=20
> Is there a known-good size, or at least a mostly-working one?  Would =
it
> make sense to start with that size instead of halving and trying unti=
l
> that size is reached?
>=20
>> +			size /=3D 2;
>> +		} else {
>> +			buf +=3D written;
>> +			total +=3D written;
>=20
> What about other errors?  You need to break out of the loop instead o=
f
> adding -1 to buf and total, right?

Thanks for a thorough review. I had the gut feeling that something's wr=
ong
with the code due to its structure, but didn't stare at the code long
enough to notice this.

I suggest to have this structure

	write
	if success or failure is not EINVAL
		return

	do
		reduce size
		if larger than known (presumed?) maximum
			reduce to that maximum
		write
	while not success and failure is EINVAL

	while not failure and exactly reduced size written
		write more

I don't think that we will observe any short writes *after* the size wa=
s
reduced, which Albert is concerned about. Somebody who observes the
failure that this works around could instrument the function to see
whether short writes are really a problem.

-- Hannes
