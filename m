From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Copy resolve_ref() return value for longer use
Date: Sun, 13 Nov 2011 12:41:41 -0800
Message-ID: <7vbosfoiuy.fsf@alter.siamese.dyndns.org>
References: <7vobwgo3l5.fsf@alter.siamese.dyndns.org>
 <1321179735-21890-1-git-send-email-pclouds@gmail.com>
 <1321179735-21890-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 13 21:41:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPgs9-0004iH-UL
	for gcvg-git-2@lo.gmane.org; Sun, 13 Nov 2011 21:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab1KMUlp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Nov 2011 15:41:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44032 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453Ab1KMUlo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2011 15:41:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE71B5059;
	Sun, 13 Nov 2011 15:41:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=C2Hj16b9WsEV
	rjKRqjTySRDDA7o=; b=XRp8kM/5hRVzQBpLJ0xl/7u8/6qIKi7Y4UBQ172qXteR
	Hmfy9lS8eMJAY59pOHrYJwUvKsJ0gH/JTjtVxTImpcWhgfBje8V0tKkBJfDWA46s
	aIRHp+LbrYrZztr7S1prvvPNMvf+jZ5qKo2c+U/uNVMuwmFEqzGNKom2rWTbxjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Zy19lX
	BlAm4tNEs4+N8V0IvWEvv+mpapzZ1ADuNZcR/AJY3prbzNgy+j3ftS49VuxRndlx
	ZR7o8HuSMDRDcJAFyG9qKJ6B2s5mUsAj+KRVLaw92y0g6Ptw8cf0HKcNw1Kat4Gd
	nGIJEuBBMSBQ0rQEDZAk4X2w10XNC4IJS2dcg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D55685057;
	Sun, 13 Nov 2011 15:41:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FBAF5056; Sun, 13 Nov 2011
 15:41:43 -0500 (EST)
In-Reply-To: <1321179735-21890-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 13 Nov
 2011 17:22:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E573877E-0E37-11E1-938A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185347>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> resolve_ref() may return a pointer to a static buffer. Callers that
> use this value longer than a couple of statements should copy the
> value to avoid some hidden resolve_ref() call that may change the
> static buffer's value.
>
> The bug found by Tony Wang <wwwjfy@gmail.com> in builtin/merge.c
> demonstrates this. The first call is in cmd_merge()
>
> branch =3D resolve_ref("HEAD", head_sha1, 0, &flag);
>
> Then deep in lookup_commit_or_die() a few lines after, resolve_ref()
> may be called again and destroy "branch".
>
> lookup_commit_or_die
>  lookup_commit_reference
>   lookup_commit_reference_gently
>    parse_object
>     lookup_replace_object
>      do_lookup_replace_object
>       prepare_replace_object
>        for_each_replace_ref
>         do_for_each_ref
>          get_loose_refs
>           get_ref_dir
>            get_ref_dir
>             resolve_ref
>
> All call sites are checked and made sure that xstrdup() is called if
> the value should be saved.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Unfortunately there are still 37 resolve_ref() calls. An API change
>  would touch all of them and potentially introduce more bugs along th=
e
>  way, either leak more memory or free() the wrong way.
>
>  So I'd stick with this for v1.7.8.
>
>  builtin/branch.c        |    5 +++-
>  builtin/checkout.c      |    4 ++-
>  builtin/commit.c        |    3 +-
>  builtin/fmt-merge-msg.c |    6 ++++-
>  builtin/merge.c         |   62 ++++++++++++++++++++++++++++++-------=
---------
>  builtin/notes.c         |    6 ++++-
>  builtin/receive-pack.c  |    3 ++
>  reflog-walk.c           |    5 +++-
>  8 files changed, 66 insertions(+), 28 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 0fe9c4d..5b6d839 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -115,8 +115,10 @@ static int branch_merged(int kind, const char *n=
ame,
>  		    branch->merge[0] &&
>  		    branch->merge[0]->dst &&
>  		    (reference_name =3D
> -		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)
> +		     resolve_ref(branch->merge[0]->dst, sha1, 1, NULL)) !=3D NULL)=
 {
> +			reference_name =3D xstrdup(reference_name);
>  			reference_rev =3D lookup_commit_reference(sha1);
> +		}
>  	}
>  	if (!reference_rev)
>  		reference_rev =3D head_rev;
> @@ -141,6 +143,7 @@ static int branch_merged(int kind, const char *na=
me,
>  				"         '%s', even though it is merged to HEAD."),
>  				name, reference_name);
>  	}
> +	free((char*)reference_name);
>  	return merged;
>  }

Now reference_name stores the result of xstrdup(), it does not have rea=
son
to be of type "const char *". It is preferable to lose the cast here, I
think. The same comment applies to the remainder of the patch.

Otherwise the patch looks good. Thanks.
