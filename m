From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Improve the filemode trustability check
Date: Wed, 19 Nov 2014 10:58:54 -0800
Message-ID: <xmqqegszrp8x.fsf@gitster.dls.corp.google.com>
References: <546CB2F8.7040501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Nov 19 19:59:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrAT3-0003GF-AV
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 19:59:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756504AbaKSS7A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Nov 2014 13:59:00 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755039AbaKSS67 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Nov 2014 13:58:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F3611DD54;
	Wed, 19 Nov 2014 13:58:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fYyP1AEdZrUs
	1b6MH9XnhalkOJg=; b=Cx/g/nS0DhrVViF2PK5r3Hk+PFeO/2w9kovAjrZU60B7
	5hnvH6jUFhZ6QbvbiH+MDFutGHbv41+ov8/LsU7V6C2bPBSlQm7kCEcJ9sTviBuq
	vkX5pkU+FPiKTudw5gY3LENKCvFrqlCMXuPUHhQQwSG7gI/We0FV7tqhlruQs6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EZGayr
	wHDbDDLEgR5diPrgTafK0/XX5IeHptUUfOdcQstfiAuPd7GKdwdjUKHGB1fh/x2I
	078+Qd1Vo64IKvQMGL8WWZVplO13wTQk/q/d4fMYyq33KYYGOXpC4yC4y0E6AGGR
	H6+WhmHT5wPo/DnraROvCZulCjiCXI5xBOSnA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 355351DD51;
	Wed, 19 Nov 2014 13:58:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4819E1DD4E;
	Wed, 19 Nov 2014 13:58:56 -0500 (EST)
In-Reply-To: <546CB2F8.7040501@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 19 Nov 2014 16:10:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1CD5C240-701E-11E4-B56C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Some file systems do not support the executable bit:
> a) The user executable bit is always 0, e.g. VFAT mounted with -onoex=
ec
> b) The user executable bit is always 1, e.g. cifs mounted with -ofile=
_mode=3D0755
> c) There are system where user executable bit is 1 even if it should =
be 0
>    like b), but the file mode can be maintained locally. chmod -x cha=
nges the
>    file mode from 0766 to 0666, until the file system is unmounted an=
d
>    remounted and the file mode is 0766 again.
>    This been observed when a Windows machine with NTFS exports a shar=
e to
>    Mac OS X via smb or afp.
>
> Case a) and b) are handled by the current code.
> Case c) qualifies as "non trustable executable bit" and core.filemode
> should be false, but this is not done.
>
> Solution:
> Detect when ".git/config" has the user executable bit set after
> creat(".git/config", 0666) and set core.filemode to false.

The readers have been following along a nicely flowing prose; let
them keep going by dropping that abrupt "Solution:" line and instead
doing s/to false./to false to solve this./ or something like that.

The change does not seem to match the above design of the solution,
though.  We've run stat(path, &st1), and I would have expected from
the description that (st1.st_mode & S_IXUSR) without any chmod()
would be the "does the file have executable bit without us asking?"
Either the explanation or the code is wrong.  I cannot tell which.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> This should go on top of "mh/config-flip-xbit-back-after-checking"
>
> Michael, thanks for the test case.
> And no, I havent seen any systems with behaving like d)
>
>  builtin/init-db.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index aab44d2..9b50dde 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -252,10 +252,10 @@ static int create_default_files(const char *tem=
plate_path)
>  	filemode =3D TEST_FILEMODE;
>  	if (TEST_FILEMODE && !lstat(path, &st1)) {
>  		struct stat st2;
> -		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> +		filemode =3D (!chmod(path, st1.st_mode | S_IXUSR) &&
>  				!lstat(path, &st2) &&
>  				st1.st_mode !=3D st2.st_mode &&
> -				!chmod(path, st1.st_mode));
> +				!chmod(path, st1.st_mode & (~S_IXUSR)));
>  	}
>  	git_config_set("core.filemode", filemode ? "true" : "false");
