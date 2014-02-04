From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Tue, 04 Feb 2014 15:43:20 -0800
Message-ID: <xmqqsiry5trb.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Feb 05 00:43:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WApeM-0006DK-C6
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 00:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933298AbaBDXn0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Feb 2014 18:43:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41356 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932495AbaBDXnY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 18:43:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65D0269C82;
	Tue,  4 Feb 2014 18:43:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=sAtRSR55wpmz
	WiX31CB3ciIB6Yc=; b=nTl1RBRqG/8Jzq+m0q94VoGk1wsmF4MvDUNy7TMJ/Szm
	lpS8mUrJTCL9Woco3yI06x+Ks+GvqPb+TJJNGzUFgdvvckXOneOAdzi36BSPpvyy
	0RPJcxtekF4mXwh7UpEynOUOLUgrHJglf0o8XcxxH3o6PDwT2OHHMEhspwjqgV0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CquZYd
	AoJiu/GR5WYNEl7NcYrNJaSLnjULpt0j8VsebiX5KaIASCYwXhMwDCRicmBHpF3Y
	Lfs9PjLEsGxfZzbb6js9tvnNOKXA0iM4EhRrJR8RRZ/KJWm87xC7IlS9/UkdoKIu
	EgRqeaoN6+fGzW3nDJgFDZqVqUibJOHb5LWCQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 552D169C81;
	Tue,  4 Feb 2014 18:43:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E28869C80;
	Tue,  4 Feb 2014 18:43:22 -0500 (EST)
In-Reply-To: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 04 Feb 2014 15:40:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 222A3722-8DF6-11E3-9C40-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241587>

Junio C Hamano <gitster@pobox.com> writes:

> This comment in builtin/repack.c:
> ...

Oops; there was supposed to be these lines before anythning else:

	From: Torsten B=C3=B6gershausen <tboegi@web.de>
	Date: Sun Feb 2 16:09:56 2014 +0100

>     First see if there are packs of the same name and if so
>     if we can move them out of the way (this can happen if we
>     repacked immediately after packing fully).
>
> When a repo was fully repacked, and is repacked again, we may run
> into the situation that "new" packfiles have the same name as
> already existing ones (traditionally packfiles have been named after
> the list of names of objects in them, so repacking all the objects
> in a single pack would have produced a packfile with the same name).
>
> The logic is to rename the existing ones into filename like
> "old-XXX", create the new ones and then remove the "old-" ones.
> When something went wrong in the middle, this sequence is rolled
> back by renaming the "old-" files back.
>
> The renaming into "old-" did not work as designed, because
> file_exists() was done on the wrong file name.  This could give
> problems for a repo on a network share under Windows, as reported by
> Jochen Haag <zwanzig12@googlemail.com>.
>
> Formulate the filenames objects/pack/pack-XXXX.{pack,idx} correctly
> (the code originally lacked "pack-" prefix when checking if the file
> exists).
>
> Also rename the variables to match what they are used for:
> fname for the final name of the new packfile, fname_old for the name
> of the existing one, and fname_tmp for the temporary name pack-object=
s
> created the new packfile in.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>
>  * Somehow this came to my private mailbox without Cc to list, so I
>    am forwarding it.
>
>    I think with 1190a1ac (pack-objects: name pack files after
>    trailer hash, 2013-12-05), repacking the same set of objects may
>    have less chance of producing colliding names, especially if you
>    are on a box with more than one core, but it still would be a
>    good idea to get this part right in the upcoming release.
>
>    The bug in the first hunk will cause us not to find any existing
>    file, even when there is a name clash.  And then we try to
>    immediately the final rename without any provision for rolling
>    back.  The other two hunks are pure noise renaming variables.
>
>    I think the patch looks correct, but I'd appreciate a second set
>    of eyeballs.
>
>    Thanks.
>
>  builtin/repack.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index bca7710..3b01353 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -260,7 +260,7 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
>  			char *fname, *fname_old;
> -			fname =3D mkpathdup("%s/%s%s", packdir,
> +			fname =3D mkpathdup("%s/pack-%s%s", packdir,
>  						item->string, exts[ext]);
>  			if (!file_exists(fname)) {
>  				free(fname);
> @@ -316,33 +316,33 @@ int cmd_repack(int argc, const char **argv, con=
st char *prefix)
>  	/* Now the ones with the same name are out of the way... */
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
> -			char *fname, *fname_old;
> +			char *fname, *fname_tmp;
>  			struct stat statbuffer;
>  			fname =3D mkpathdup("%s/pack-%s%s",
>  					packdir, item->string, exts[ext]);
> -			fname_old =3D mkpathdup("%s-%s%s",
> +			fname_tmp =3D mkpathdup("%s-%s%s",
>  					packtmp, item->string, exts[ext]);
> -			if (!stat(fname_old, &statbuffer)) {
> +			if (!stat(fname_tmp, &statbuffer)) {
>  				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -				chmod(fname_old, statbuffer.st_mode);
> +				chmod(fname_tmp, statbuffer.st_mode);
>  			}
> -			if (rename(fname_old, fname))
> -				die_errno(_("renaming '%s' failed"), fname_old);
> +			if (rename(fname_tmp, fname))
> +				die_errno(_("renaming '%s' into '%s' failed"), fname_tmp, fname)=
;
>  			free(fname);
> -			free(fname_old);
> +			free(fname_tmp);
>  		}
>  	}
> =20
>  	/* Remove the "old-" files */
>  	for_each_string_list_item(item, &names) {
>  		for (ext =3D 0; ext < 2; ext++) {
> -			char *fname;
> -			fname =3D mkpath("%s/old-pack-%s%s",
> +			char *fname_old;
> +			fname_old =3D mkpath("%s/old-%s%s",
>  					packdir,
>  					item->string,
>  					exts[ext]);
> -			if (remove_path(fname))
> -				warning(_("removing '%s' failed"), fname);
> +			if (remove_path(fname_old))
> +				warning(_("removing '%s' failed"), fname_old);
>  		}
>  	}
