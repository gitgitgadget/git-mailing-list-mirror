From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] setup: translate symlinks in filename when using
 absolute paths
Date: Tue, 28 Dec 2010 11:47:07 -0800
Message-ID: <7vr5d1wuh0.fsf@alter.siamese.dyndns.org>
References: <1293447277-30598-1-git-send-email-carenas@sajinet.com.pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>
X-From: git-owner@vger.kernel.org Tue Dec 28 20:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXfVz-0004Nw-4N
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 20:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab0L1TrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Dec 2010 14:47:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751033Ab0L1TrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Dec 2010 14:47:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0493B282C;
	Tue, 28 Dec 2010 14:47:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+8D+aPdhGawF
	WIF5TORGQX3tq9U=; b=UKmjiX3iJ04ZRM/zJADfJdG/I/ju5qkAVm3JkLRDPY44
	wyM6ceyjg94CqiOrhp9n5BOLspit+6cM81yneXK/Gw39djHQp2NqspXXdgDLTIwV
	OvgLYa3g/KqavsqPZhSalf96yDaaBpZ14HNsCVR73ghrSgt4JFj0mbd8oXFuJoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JhQYSC
	LvxgpLLqCR79eZN3p/7gqEc5s9Uy5hiJkzRL3DANDjUeWvLxyS/pdA0O0pIGr0Db
	LGZYDtz98KEfq4qEYIHC9YrEB/U3APaPZ9ZrFuumHYPcR2LEMs2iLpbPda9kmKDr
	HauBpyB8/etbUBoqh9zUs21pFT6MDC1O/HGSw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C11FA282B;
	Tue, 28 Dec 2010 14:47:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6D653282A; Tue, 28 Dec 2010
 14:47:40 -0500 (EST)
In-Reply-To: <1293447277-30598-1-git-send-email-carenas@sajinet.com.pe>
 (Carlo Marcelo Arenas Belon's message of "Mon\, 27 Dec 2010 02\:54\:37
 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 56EA436C-12BB-11E0-B93C-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164287>

Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:

> otherwise, comparison to validate against work tree will fail when
> the path includes a symlink and the name passed is not canonical.
>
> Signed-off-by: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>

I take that "path" and "name passed" refer to the same thing (i.e. "pat=
h"
parameter) in the above.

I think you are trying to handle the case where:

 - you give "/home/carenas/one" from the command line;
 - $PWD is "/home/carenas"; and
 - "/home/carenas" is a symlink to "/net/host/home/carenas"

and the scan-from-the-beginning-of-string check done between
"/home/carenas/one" and the return value of get_git_work_tree() which
presumably is "/net/host/home/carenas" disagrees.  I wonder if a more
correct solution might be to help get_git_work_tree() to match the noti=
on
of where the repository and its worktree are to the idea of where the u=
ser
thinks they are, i.e. not "/net/host/home/carenas" but "/home/carenas",=
 a
bit better?

That would involve tweaking make_absolute_path() I guess?

Note that your patch is the right thing to do either case, i.e. with or
without such a change to make_absolute_path(), as the function is used =
to
set up the return value from get_git_work_tree().  Anything we compare
with it should have passed make_absolute_path() at least once.

Nguy=E1=BB=85n?

> ---
>  setup.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/setup.c b/setup.c
> index 91887a4..e7c0d4d 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -7,10 +7,13 @@ static int inside_work_tree =3D -1;
>  char *prefix_path(const char *prefix, int len, const char *path)
>  {
>  	const char *orig =3D path;
> -	char *sanitized =3D xmalloc(len + strlen(path) + 1);
> -	if (is_absolute_path(orig))
> -		strcpy(sanitized, path);
> -	else {
> +	char *sanitized;
> +	if (is_absolute_path(orig)) {
> +		const char *temp =3D make_absolute_path(path);
> +		sanitized =3D xmalloc(len + strlen(temp) + 1);
> +		strcpy(sanitized, temp);
> +	} else {
> +		sanitized =3D xmalloc(len + strlen(path) + 1);
>  		if (len)
>  			memcpy(sanitized, prefix, len);
>  		strcpy(sanitized + len, path);
> --=20
> 1.7.3.4.626.g73e7b.dirty
