From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 06/28] connect.c: teach get_remote_heads to parse "shallow" lines
Date: Mon, 25 Nov 2013 13:42:07 -0800
Message-ID: <xmqqtxf0w440.fsf@gitster.dls.corp.google.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 22:42:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3v7-00069d-6a
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 22:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3KYVmN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Nov 2013 16:42:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48841 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005Ab3KYVmM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Nov 2013 16:42:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 859AC55779;
	Mon, 25 Nov 2013 16:42:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yV0xsFnLLUoH
	Do7fmE5OEVg/eUA=; b=i3vtO7vRWLpScxSE+51YVMd335mgUFD7JI2Z1z/P9hzY
	TR3w83c7qRN1h6mzDQfYtTSk5wlc0Ey7J1AqXARNXGep7DlKGc3YXS2bTxSwT7lS
	DY4IXN3cq4XAiUMgb0x5BXCyBkZV/52jdvzoQxj+yTi8AvP/DskXhY2Wcf8ANZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=lzf1G7
	4/ByS23SC/EPWwqj96FzcwSLz/9l4Su2743ApnERxZXHrTE4E0nKxYH/bGeMEj2Z
	LEp0HFUVTHICummLnUDgjBr7xro26kF6+LZjm5gzhd0ICqfCirUTIuwN3Ywb4/pe
	wZPP0auV6Dwcxs5chqWgWHP6hMqUtFotn6f1I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72B0B55778;
	Mon, 25 Nov 2013 16:42:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8026C5576E;
	Mon, 25 Nov 2013 16:42:10 -0500 (EST)
In-Reply-To: <1385351754-9954-7-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 25
 Nov 2013 10:55:32 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7059F19E-561A-11E3-BA08-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238359>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> No callers pass a non-empty pointer as shallow_points at this
> stage. As a result, all clients still refuse to talk to shallow
> repository on the other end.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/fetch-pack.c |  2 +-
>  builtin/send-pack.c  |  2 +-
>  connect.c            | 12 +++++++++++-
>  remote-curl.c        |  2 +-
>  remote.h             |  3 ++-
>  transport.c          |  7 ++++---
>  6 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index c8e8582..c1d918f 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -150,7 +150,7 @@ int cmd_fetch_pack(int argc, const char **argv, c=
onst char *prefix)
>  				   args.verbose ? CONNECT_VERBOSE : 0);
>  	}
> =20
> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
> +	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, NULL);
> =20
>  	ref =3D fetch_pack(&args, fd, conn, ref, dest,
>  			 sought, nr_sought, pack_lockfile_ptr);
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index 51121f2..bfa9253 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -233,7 +233,7 @@ int cmd_send_pack(int argc, const char **argv, co=
nst char *prefix)
> =20
>  	memset(&extra_have, 0, sizeof(extra_have));
> =20
> -	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_h=
ave);
> +	get_remote_heads(fd[0], NULL, 0, &remote_refs, REF_NORMAL, &extra_h=
ave, NULL);
> =20
>  	transport_verify_remote_names(nr_refspecs, refspecs);
> =20
> diff --git a/connect.c b/connect.c
> index 06e88b0..d0602b0 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -122,7 +122,8 @@ static void annotate_refs_with_symref_info(struct=
 ref *ref)
>   */
>  struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
>  			      struct ref **list, unsigned int flags,
> -			      struct extra_have_objects *extra_have)
> +			      struct extra_have_objects *extra_have,
> +			      struct extra_have_objects *shallow_points)

The _shape_ of the information you would want to keep track of for
the shallow cut-off points may exactly be the same as that is for
extra-have endspoints, but it still feels wrong to throw these
shallow cut-off points into a structure called "extra have". After
all, these are objects the other end does not have, which is the
direct opposite of extra-have.

Perhaps a preparatory patch needs to rename the structure type to
object_name_list or something.  And then we can make the variable
names, not typenames, responsible for signalling what they mean,
i.e.

	get_remote_heads(...
        	struct list_of_objects *extra_have,
                struct list_of_objects *shallow_points);

when we introduce the new parameter.
