From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/7] correct blame for files commited with CRLF
Date: Fri, 01 Apr 2016 15:29:32 -0700
Message-ID: <xmqq60w1gdyr.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459526911-19985-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Sat Apr 02 00:29:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am7ZU-0003rN-9R
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 00:29:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbcDAW3g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 18:29:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752585AbcDAW3f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Apr 2016 18:29:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7DF3C4F958;
	Fri,  1 Apr 2016 18:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=t0nMOehbWgMs
	kOv0VS4KkZt5JbA=; b=DknOfx/vj0lsVL6SgH9gWkjOeMrGrgM85mBHnBZV6sXR
	8j+9kfCMDss42rXfr217U7o5An9wpprfkWSntKFaqcbF9SQk0pphUK2BxEL4eHyH
	4ym6ArMPGt8ZKhVVeSQ9eVxeSrVyG+2wehKcCcI8OkHSRyAyMQeBKHm47b6xT6M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y/zZXv
	BrBdVyTDzytvEGIc2Gzgqr0LQwH/8vEoqNAVYlqQy1vP8t7x5p/Vb6breAN2IJgJ
	t/Pw52ak49Lz8Ccvh/GQA2qVJUCgAIwu4DF4GhJSnCV3qCtf0XH5RfxoFkqncH3d
	mHRHD2l0dkkTCs3QPzH2ivR7VemNYdPdxZVsE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 74C8D4F957;
	Fri,  1 Apr 2016 18:29:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB7BD4F954;
	Fri,  1 Apr 2016 18:29:33 -0400 (EDT)
In-Reply-To: <1459526911-19985-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Fri, 1 Apr 2016 18:08:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 359A7266-F859-11E5-8959-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290587>

tboegi@web.de writes:

> Whenever a CLRF conversion is needed (or any filter us set), load the
> index temporally, before calling convert_to_git()

I am not sure if this is needed.  We should just do read_cache()
unconditionally at the beginning of fake_working_tree_commit(),
without even discarding it.  Most Git commands that work on the
working tree files follow that pattern, and I do not think the
"optimization" this patch does over that simple pattern, while it
may be nice, is an unnecessary complication.

By the way, thanks for pushing back in the [v1 6/7] discussion
thread to show me where convert_to_git() was failing.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  builtin/blame.c               |  6 +++++-
>  convert.c                     | 10 ++++++++++
>  convert.h                     |  1 +
>  t/t8003-blame-corner-cases.sh | 14 ++++++++++++++
>  4 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/blame.c b/builtin/blame.c
> index e982fb8..a219068 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -2376,7 +2376,11 @@ static struct commit *fake_working_tree_commit=
(struct diff_options *opt,
>  		if (strbuf_read(&buf, 0, 0) < 0)
>  			die_errno("failed to read from stdin");
>  	}
> -	convert_to_git(path, buf.buf, buf.len, &buf, 0);
> +	if (convert_needs_conversion(path)) {
> +		read_cache();
> +		convert_to_git(path, buf.buf, buf.len, &buf, 0);
> +		discard_cache();
> +	}
>  	origin->file.ptr =3D buf.buf;
>  	origin->file.size =3D buf.len;
>  	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_sha1);
> diff --git a/convert.c b/convert.c
> index 4ed5d89..02c50da 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -903,6 +903,16 @@ const char *get_convert_attr_ascii(const char *p=
ath)
>  	return "";
>  }
> =20
> +int convert_needs_conversion(const char *path)
> +{
> +	struct conv_attrs ca;
> +
> +	convert_attrs(&ca, path);
> +	if (ca.drv || ca.ident || ca.crlf_action !=3D CRLF_BINARY)
> +		return 1;
> +	return 0;
> +}
> +
>  int convert_to_git(const char *path, const char *src, size_t len,
>                     struct strbuf *dst, enum safe_crlf checksafe)
>  {
> diff --git a/convert.h b/convert.h
> index ccf436b..ffd9c32 100644
> --- a/convert.h
> +++ b/convert.h
> @@ -35,6 +35,7 @@ extern enum eol core_eol;
>  extern const char *get_cached_convert_stats_ascii(const char *path);
>  extern const char *get_wt_convert_stats_ascii(const char *path);
>  extern const char *get_convert_attr_ascii(const char *path);
> +int convert_needs_conversion(const char *path);
> =20
>  /* returns 1 if *dst was used */
>  extern int convert_to_git(const char *path, const char *src, size_t =
len,
> diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cas=
es.sh
> index 6568429..a9b266f 100755
> --- a/t/t8003-blame-corner-cases.sh
> +++ b/t/t8003-blame-corner-cases.sh
> @@ -212,4 +212,18 @@ test_expect_success 'blame file with CRLF attrib=
utes text' '
>  	grep "A U Thor" actual
>  '
> =20
> +test_expect_success 'blame file with CRLF core.autocrlf=3Dtrue' '
> +	git config core.autocrlf false &&
> +	printf "testcase\r\n" >crlfinrepo &&
> +	>.gitattributes &&
> +	git add crlfinrepo &&
> +	git commit -m "add crlfinrepo" &&
> +	git config core.autocrlf true &&
> +	mv crlfinrepo tmp &&
> +	git checkout crlfinrepo &&
> +	rm tmp &&
> +	git blame crlfinrepo >actual &&
> +	grep "A U Thor" actual
> +'
> +
>  test_done
