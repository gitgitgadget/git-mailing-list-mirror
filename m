From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v3 3/8] Read .gitignore from index if it is
 assume-unchanged
Date: Tue, 11 Aug 2009 19:51:53 -0700
Message-ID: <7vocqlbv7a.fsf@alter.siamese.dyndns.org>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
 <1250005446-12047-2-git-send-email-pclouds@gmail.com>
 <1250005446-12047-3-git-send-email-pclouds@gmail.com>
 <1250005446-12047-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 04:52:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mb3wg-0005zM-LP
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 04:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750AbZHLCwA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 22:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755747AbZHLCwA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 22:52:00 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720AbZHLCv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2009 22:51:59 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE337A6F;
	Tue, 11 Aug 2009 22:52:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0802F7A65; Tue, 11 Aug
 2009 22:51:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1BAE58CC-86EB-11DE-89E9-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125647>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/Documentation/technical/api-directory-listing.txt b/Docu=
mentation/technical/api-directory-listing.txt
> index 5bbd18f..7d0e282 100644
> --- a/Documentation/technical/api-directory-listing.txt
> +++ b/Documentation/technical/api-directory-listing.txt
> @@ -58,6 +58,9 @@ The result of the enumeration is left in these fiel=
ds::
>  Calling sequence
>  ----------------
> =20
> +* Ensure the_index is populated as it may have CE_VALID entries that
> +  affect directory listing.
> +

When you want to enumerate all paths in the work tree, instead of not j=
ust
the untracked ones, it used to be possible to first run read_directory(=
)
before calling read_cache().  You are now forbidding this.

I do not think it is hard to resurrect the feature if it is necessary (=
add
an option to dir_struct and teach dir_add_name() not to ignore paths th=
e
index knows about), and I do not think none of the existing code relies=
 on
it anymore (I think "git add" used to), but there may be some codepath =
I
forgot about, which is a concern.

> diff --git a/builtin-clean.c b/builtin-clean.c
> index 2d8c735..d917472 100644
> --- a/builtin-clean.c
> +++ b/builtin-clean.c
> @@ -71,8 +71,11 @@ int cmd_clean(int argc, const char **argv, const c=
har *prefix)
> =20
>  	dir.flags |=3D DIR_SHOW_OTHER_DIRECTORIES;
> =20
> -	if (!ignored)
> +	if (!ignored) {
> +		if (read_cache() < 0)
> +			die("index file corrupt");
>  		setup_standard_excludes(&dir);
> +	}
> =20
>  	pathspec =3D get_pathspec(prefix, argv);
>  	read_cache();

Wouldn't it be much cleaner to move the existing read_cache() up, like =
you
did for ls-files, instead of conditionally reading the index at a rando=
m
place in the program sequence depending on the combinations of options?
