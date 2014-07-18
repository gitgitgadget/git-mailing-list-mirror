From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make locked paths absolute when current directory is changed
Date: Fri, 18 Jul 2014 10:47:02 -0700
Message-ID: <xmqqmwc6mueh.fsf@gitster.dls.corp.google.com>
References: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:47:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8CFY-00078B-1x
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 19:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbaGRRrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 13:47:12 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51615 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030492AbaGRRrL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 13:47:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7C965271C7;
	Fri, 18 Jul 2014 13:47:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3kevLhVQQR+r
	7kA43B9QhZQSJ8I=; b=ahhrEz7ksDR3sq34+5u0IrJvO6yxmL6Yor/HMPmhFDze
	hFBTyX7K+Mic0Giny/wDHl5xbYiVxOxbLZy+83zh3Hrga/9yKCEWHvZsy0B1P0Q2
	e5MeTt/o8ybEJ9cZBxHw/G/jXMulBVPcrfS15IxK8k+NzmDY4SOXP7Tb2otVbGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iSVPDO
	tThbL1uSODZINEYYpoO05FtuIluibA3Pi6DJXzTNj/qs0sdk79vrAme9ktkXgmMR
	HZSLiDIABX7uzKlK9JKM8u7OiBTp+/4hzcjsjCETjhAtMwKJSPyiQxD4XaI9+l18
	gJ+K9yxriYPV4qa6ibclsI/TpeGrJVpBGdz/8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3D7B6271C3;
	Fri, 18 Jul 2014 13:47:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF52A271B0;
	Fri, 18 Jul 2014 13:47:03 -0400 (EDT)
In-Reply-To: <1405688937-22925-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 18
 Jul 2014 20:08:57 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 873BAB72-0EA3-11E4-955A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253832>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Locked paths are saved in a linked list so that if something wrong
> happens, *.lock are removed. This works fine if we keep cwd the same,
> which is true 99% of time except:
>
>  - update-index and read-tree hold the lock on $GIT_DIR/index really
>    early, then later on may call setup_work_tree() to move cwd.
>
>  - Suppose a lock is being held (e.g. by "git add") then somewhere
>    down the line, somebody calls real_path (e.g. "link_alt_odb_entry"=
),
>    which temporarily moves cwd away and back.
>
> During that time when cwd is moved (either permanently or temporarily=
)
> and we decide to die(), attempts to remove relative *.lock will fail,
> and the next operation will complain that some files are still locked=
=2E
>
> Avoid this case by turning relative paths to absolute when chdir() is
> called (or soon to be called, in setup_git_directory_gently case).

The rationale makes sense.

> +extern void make_locked_paths_absolute(void);
> +static inline int chdir_safe(const char *path)
> +{
> +	make_locked_paths_absolute();
> +	return chdir(path);
> +}

Clever ;-).  Instead of making paths absolute when you receive
requests to lock them, you lazily turn the ones relative to cwd()
absolute just before they are about to become invalid/problematic
because the program wants to chdir.

> diff --git a/lockfile.c b/lockfile.c
> index 8fbcb6a..a70d107 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -280,3 +280,19 @@ void rollback_lock_file(struct lock_file *lk)
>  	}
>  	lk->filename[0] =3D 0;
>  }
> +
> +void make_locked_paths_absolute(void)
> +{
> +	struct lock_file *lk;
> +	const char *abspath;
> +	for (lk =3D lock_file_list; lk !=3D NULL; lk =3D lk->next) {
> +		if (!lk->filename[0] || lk->filename[0] =3D=3D '/')
> +			continue;

Do we have to worry about Windows?

> +		abspath =3D absolute_path(lk->filename);
> +		if (strlen(abspath) >=3D sizeof(lk->filename))
> +			warning("locked path %s is relative when current directory "
> +				"is changed", lk->filename);

Shouldn't this be a die() or an error return (which will kill the
caller anyway)?

> @@ -636,6 +636,7 @@ static const char *setup_git_directory_gently_1(i=
nt *nongit_ok)
>  		die_errno("Unable to read current working directory");
>  	offset =3D len =3D strlen(cwd);
> =20
> +	make_locked_paths_absolute();

Just being curious, but this early in the start-up sequence, what
files do we have locks on?
