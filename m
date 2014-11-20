From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Improve the filemode trustability check
Date: Thu, 20 Nov 2014 09:55:53 -0800
Message-ID: <xmqq61e94uza.fsf@gitster.dls.corp.google.com>
References: <546DD52F.90302@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVxb-00044h-3u
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757870AbaKTRz7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Nov 2014 12:55:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757837AbaKTRz6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Nov 2014 12:55:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 262E41EB49;
	Thu, 20 Nov 2014 12:55:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=22vIa4YIdZOL
	PHoO7osafZt8DHM=; b=gFdmSVAWQunNWrc/66+RFuixXIOYJcahIe0tSq0rKmYk
	AfDPoPpSlIwm4O8DN5LBrPgb0EOm9OprqW3c86kHA9sEjJewySlT9deKkkWGSl43
	w7t5I79rMRv58j4oq6ZdUBwH3/93CTxLXZFwTXDAcpkVcb0LUnQ8kJJopV2/kfs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YtGTCl
	TntpGROwj2MfqixU1vRBfULn82Nd/zt/Gl3AckINxs5UmHnUUynW/3w9gLG4Dii+
	HTvK6bNxzkNSBiJxxqiovbCSZBgf+mGPjTKmjjsypD/NncPwZaWtQwPfYlMBdil0
	x+oatUhG8H0EmZtNmNDz7+aDMOx3Il6YRjneQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 12B7E1EB48;
	Thu, 20 Nov 2014 12:55:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C2261EB47;
	Thu, 20 Nov 2014 12:55:56 -0500 (EST)
In-Reply-To: <546DD52F.90302@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of
	"Thu, 20 Nov 2014 12:49:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A5B7C96-70DE-11E4-8F8B-42529F42C9D4-77302942!pb-smtp1.pobox.com
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
> should be false, but this is currently not done.
>
> Detect when ".git/config" has the user executable bit set after
> creat(".git/config", 0666) and set core.filemode to false.

Is this codepath reached _only_ and immediately after creat(0666) of
the config file in the same process?  The function has a local
variable reinit, which is returned to the caller to help it decide
if we are re-initializing an existing repository, so I suspect that
the call to git_config_set() before this part of the code may not
necessarily be creating the file [*1*].

I _think_ in the reinit case that makes us rewrite an existing
config file, the mode bits are propagated to the new file we just
wrote from the old one; checking st1.st_mode is therefore seeing
not what create(0666) gave us but whatever random bits the user had
on the original.

Which is probably not a useful source of information to gauge the
characterisic of the filesystem, no?

[Footnote]

*1* We may have been asked to reinitialize and update an existing
repository that was created with the same or older repository format
number.


> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
> Changes since V1:
> - Improved commit msg (hopefully)
> - Simplified the patch
>  builtin/init-db.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index aab44d2..195a88b 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -252,7 +252,8 @@ static int create_default_files(const char *templ=
ate_path)
>  	filemode =3D TEST_FILEMODE;
>  	if (TEST_FILEMODE && !lstat(path, &st1)) {
>  		struct stat st2;
> -		filemode =3D (!chmod(path, st1.st_mode ^ S_IXUSR) &&
> +		filemode =3D (!(st1.st_mode & S_IXUSR) &&
> +				!chmod(path, st1.st_mode ^ S_IXUSR) &&
>  				!lstat(path, &st2) &&
>  				st1.st_mode !=3D st2.st_mode &&
>  				!chmod(path, st1.st_mode));
