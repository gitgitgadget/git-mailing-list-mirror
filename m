From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] lockfile.c: remove PATH_MAX limitation (except in resolve_symlink)
Date: Fri, 01 Aug 2014 09:53:50 -0700
Message-ID: <xmqqfvhgw3q9.fsf@gitster.dls.corp.google.com>
References: <1405858399-23082-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-1-git-send-email-pclouds@gmail.com>
	<1406814214-21725-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, ramsay@ramsay1.demon.co.uk,
	yuelinho777@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 18:54:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDG5l-0003UO-SG
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 18:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574AbaHAQyA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Aug 2014 12:54:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63725 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750851AbaHAQx7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Aug 2014 12:53:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 05E6F2D81E;
	Fri,  1 Aug 2014 12:53:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=BOjOkxDXZGCn
	mPNjXKSUOmsSodg=; b=aAPa7SvlOHsSDMECa6RFQ62EwUg1ILTyZ7YXBqSIC+Rx
	DdoKCRxQpASmg5a0RLUzUWPoKjCsc3OVj0xugSJ74GeVq1ui+BRmWah1YqatRV4W
	53hB89mjugdIYfVshzy+rJzB/hHU7dz+HfE/ENAgX2ty5Wat/J7bPdVFsRzOMTw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lpRGs8
	RUU4BEPgY/FqgORqJo7IZdNqm130/0rD0SRtL0DtUeWmnrzh+mV8jislcW0iHv1/
	N22pgFAxDz+kxExz4ma3i1DD364Jwjb36Y+O1SiyHKRjUJAvLnsYqGECeCxhis8k
	kNYUyDXVTIznN8AbU3/ZxMi+nk3zKak5CDU/o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ECA292D81D;
	Fri,  1 Aug 2014 12:53:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 59DEB2D814;
	Fri,  1 Aug 2014 12:53:52 -0400 (EDT)
In-Reply-To: <1406814214-21725-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 31
 Jul 2014 20:43:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6AB572C2-199C-11E4-AABC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254631>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Somewhat underexplained, given that it seems to add some new
semantics.

> +static void clear_filename(struct lock_file *lk)
> +{
> +	free(lk->filename);
> +	lk->filename =3D NULL;
> +}

It is good to abstract out lk->filename[0] =3D '\0', which used to be
the way we say that we are done with the lock.  But I am somewhat
surprised to see that there aren't so many locations that used to
check !!lk->filename[0] to see if we are done with the lock to require
a corresponding wrapper.

>  static void remove_lock_file(void)
>  {
>  	pid_t me =3D getpid();
> =20
>  	while (lock_file_list) {
>  		if (lock_file_list->owner =3D=3D me &&
> -		    lock_file_list->filename[0]) {
> +		    lock_file_list->filename) {

=2E.. and this seems to be the only location?

> @@ -124,17 +136,12 @@ static char *resolve_symlink(char *p, size_t s)
> =20
>  static int lock_file(struct lock_file *lk, const char *path, int fla=
gs)
>  {
> -	/*
> -	 * subtract 5 from size to make sure there's room for adding
> -	 * ".lock" for the lock file name
> -	 */
> -	static const size_t max_path_len =3D sizeof(lk->filename) - 5;
> -
> -	if (strlen(path) >=3D max_path_len)
> +	int len;
> +	if (!(flags & LOCK_NODEREF) && !(path =3D resolve_symlink(path)))
>  		return -1;

Somehow I found it unnecessarily denser; had to read it twice before
caffeine kicked in ;-)

> @@ -231,16 +238,17 @@ int close_lock_file(struct lock_file *lk)
> =20
>  int commit_lock_file(struct lock_file *lk)
>  {
> -	char result_file[PATH_MAX];
> -	size_t i;
> -	if (lk->fd >=3D 0 && close_lock_file(lk))
> +	char *result_file;
> +	if ((lk->fd >=3D 0 && close_lock_file(lk)) || !lk->filename)
>  		return -1;

We did not protect against somebody calling this with an already
closed lock, but we now return early without attempting renameing
etc., which is a good change but is not explained.  Was there a
specific code path that you needed this change for?

Also the order of the check is not consistent with how the same
check is done in rollback_lock_file().  The order you use in this
new code (and also in commit_locked_index()) may be better than the
existing order in the rollback code path; we want to see the fd
closed, if it is open, even if lk->filename has already been
cleared.  On the other hand, one could argue that anything such a
broken caller tells this function is suspicious, and we shouldn't
close random file descriptor that is likely not owned by the caller
in the first place.  I dunno.

> @@ -273,10 +281,10 @@ int commit_locked_index(struct lock_file *lk)
> =20
>  void rollback_lock_file(struct lock_file *lk)
>  {
> -	if (lk->filename[0]) {
> +	if (lk->filename) {
>  		if (lk->fd >=3D 0)
>  			close(lk->fd);
>  		unlink_or_warn(lk->filename);
>  	}
> -	lk->filename[0] =3D 0;
> +	clear_filename(lk);
>  }
