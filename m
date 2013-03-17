From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_name: pass object name length to
 diagnose_invalid_sha1_path()
Date: Sun, 17 Mar 2013 00:10:31 -0700
Message-ID: <7vzjy2qz6g.fsf@alter.siamese.dyndns.org>
References: <5144BA0B.2040109@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git discussion list <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Mar 17 08:11:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UH7kJ-0003qC-Sj
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 08:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834Ab3CQHKf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Mar 2013 03:10:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752414Ab3CQHKe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Mar 2013 03:10:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED342AB83;
	Sun, 17 Mar 2013 03:10:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eZWWWuR8VCDm
	ay6fyv8KQMQYSiI=; b=G0AdFzCgQMuG2RxLqQoEdhsx9gevZZUrWljHRazr6YrD
	gvV3xOQs8VjG/pMphpGvPulZWmbRbjvYyc6lAjDyAno/KbtZj+ENJxH1+XMY6Jei
	P64LFrmxOTioYRtbPIgMsWFq1dGEVhJzcM6o+yaaHiJGTIoCu6KioGjG5A5uotM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=HFblNP
	Zsy1ABdcHkd7PSEQ0kayiBemmAdxM8iKhDzFyRvD9zrLFqguQ3fQtWJNBrY9/XT2
	1trNf4O93ki29LjrNumwsh19EZyCYQ31L7W6pp2BlsoHS+YA7NhppOiKnYkbfj6C
	qBciKbgcAZ36p9bMkhxi9OBTL49h4/FlsZ8DI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDD42AB82;
	Sun, 17 Mar 2013 03:10:33 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17649AB81; Sun, 17 Mar 2013
 03:10:33 -0400 (EDT)
In-Reply-To: <5144BA0B.2040109@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Sat, 16 Mar 2013 19:29:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C224D176-8ED1-11E2-AF7D-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218344>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> The only caller of diagnose_invalid_sha1_path() extracts a substring =
from
> an object name by creating a NUL-terminated copy of the interesting p=
art.
> Add a length parameter to the function and thus avoid the need for an
> allocation, thereby simplifying the code.
>
> Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> ---
>  sha1_name.c | 32 ++++++++++++++------------------
>  1 file changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 95003c7..4cea6d3 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1137,7 +1137,8 @@ int get_sha1_blob(const char *name, unsigned ch=
ar *sha1)
>  static void diagnose_invalid_sha1_path(const char *prefix,
>  				       const char *filename,
>  				       const unsigned char *tree_sha1,
> -				       const char *object_name)
> +				       const char *object_name,
> +				       int object_name_len)
>  {
>  	struct stat st;
>  	unsigned char sha1[20];
> @@ -1147,8 +1148,8 @@ static void diagnose_invalid_sha1_path(const ch=
ar *prefix,
>  		prefix =3D "";
> =20
>  	if (!lstat(filename, &st))
> -		die("Path '%s' exists on disk, but not in '%s'.",
> -		    filename, object_name);
> +		die("Path '%s' exists on disk, but not in '%.*s'.",
> +		    filename, object_name_len, object_name);
>  	if (errno =3D=3D ENOENT || errno =3D=3D ENOTDIR) {
>  		char *fullname =3D xmalloc(strlen(filename)
>  					     + strlen(prefix) + 1);
> @@ -1158,16 +1159,16 @@ static void diagnose_invalid_sha1_path(const =
char *prefix,
>  		if (!get_tree_entry(tree_sha1, fullname,
>  				    sha1, &mode)) {
>  			die("Path '%s' exists, but not '%s'.\n"
> -			    "Did you mean '%s:%s' aka '%s:./%s'?",
> +			    "Did you mean '%.*s:%s' aka '.*%.*s:./%s'?",

This is so unlike what I call "Scharfe patch", which I can apply
with my eyes closed and expect everything to be perfect.

Other than that, I see this as a usual "Scharfe patch" ;-)  Will
squash an obvious fix in and apply.

Thanks.

>  			    fullname,
>  			    filename,
> -			    object_name,
> +			    object_name_len, object_name,
>  			    fullname,
> -			    object_name,
> +			    object_name_len, object_name,
>  			    filename);
>  		}
> -		die("Path '%s' does not exist in '%s'",
> -		    filename, object_name);
> +		die("Path '%s' does not exist in '%.*s'",
> +		    filename, object_name_len, object_name);
>  	}
>  }
> =20
> @@ -1332,13 +1333,8 @@ static int get_sha1_with_context_1(const char =
*name,
>  	}
>  	if (*cp =3D=3D ':') {
>  		unsigned char tree_sha1[20];
> -		char *object_name =3D NULL;
> -		if (only_to_die) {
> -			object_name =3D xmalloc(cp-name+1);
> -			strncpy(object_name, name, cp-name);
> -			object_name[cp-name] =3D '\0';
> -		}
> -		if (!get_sha1_1(name, cp-name, tree_sha1, GET_SHA1_TREEISH)) {
> +		int len =3D cp - name;
> +		if (!get_sha1_1(name, len, tree_sha1, GET_SHA1_TREEISH)) {
>  			const char *filename =3D cp+1;
>  			char *new_filename =3D NULL;
> =20
> @@ -1348,8 +1344,8 @@ static int get_sha1_with_context_1(const char *=
name,
>  			ret =3D get_tree_entry(tree_sha1, filename, sha1, &oc->mode);
>  			if (ret && only_to_die) {
>  				diagnose_invalid_sha1_path(prefix, filename,
> -							   tree_sha1, object_name);
> -				free(object_name);
> +							   tree_sha1,
> +							   name, len);
>  			}
>  			hashcpy(oc->tree, tree_sha1);
>  			strncpy(oc->path, filename,
> @@ -1360,7 +1356,7 @@ static int get_sha1_with_context_1(const char *=
name,
>  			return ret;
>  		} else {
>  			if (only_to_die)
> -				die("Invalid object name '%s'.", object_name);
> +				die("Invalid object name '%.*s'.", len, name);
>  		}
>  	}
>  	return ret;
