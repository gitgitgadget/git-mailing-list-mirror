From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/32] read-cache: split-index mode
Date: Mon, 28 Apr 2014 15:46:40 -0700
Message-ID: <xmqq1twhnkbz.fsf@gitster.dls.corp.google.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
	<1398682553-11634-18-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 00:46:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeuK2-0003mK-KX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 00:46:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756014AbaD1Wqq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 18:46:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33454 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755988AbaD1Wqp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Apr 2014 18:46:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2623E811A7;
	Mon, 28 Apr 2014 18:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=P/BCxLl6MISg
	Ybz1DA++fZlNhZ8=; b=wZfHw7Co0CWUccTzrc4tgvpHBosPchOS2MBL9gGsQgVN
	VzTbggxHcSex4KQehy2oduRfm9THbM/D8uKRXBr/JDOeUF7jF9mHiTooVgXfFlFX
	V0TqOJIFBNVO7MspL4q9EsMNjU5s57Q5MhaNaF5f62WqRacRnhl+he1YctKrXek=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=GGqdkt
	074mrtlSUkVPkxTVnntTkPe5c926iF8PK4lyMVFcWfQlsAx0zy9u7Unb1hRgPdye
	fBcFmYyzWfTKWUDk0d0q/jfRd9XkdOE353d/uXw31eCXG0Ow0BPqYMhm/8haY0iH
	i+xKItMh/NnE4TZQDKcC9zA0HLLUaD0FzjsDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 093EA811A5;
	Mon, 28 Apr 2014 18:46:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87C7C811A0;
	Mon, 28 Apr 2014 18:46:42 -0400 (EDT)
In-Reply-To: <1398682553-11634-18-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 28
 Apr 2014 17:55:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7E42C1C-CF26-11E3-A11A-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247461>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/cache.h b/cache.h
> index 0f6247c..90a5998 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -135,6 +135,7 @@ struct cache_entry {
>  	unsigned int ce_mode;
>  	unsigned int ce_flags;
>  	unsigned int ce_namelen;
> +	unsigned int index;	/* for link extension */
>  	unsigned char sha1[20];
>  	char name[FLEX_ARRAY]; /* more */
>  };

I am not sure if we want to keep an otherwise unused 8-byte around
per cache entry (especially for a large project where the split
index mode should matter) after we read the index.

I expected to see some code where entries in this incremental index
are used to override the entries from the base/shared index, but
merge_base_index() seems to do just memcpy() to discard the former
and replace them with the latter.  Is this step meant to work at
all, or is it a smaller step meant to be completed in later patches?

I do think it is sensible to keep two arrays of "struct cache_entry"
around (one for base and one for incremental changes) inside
index_state, and the patch seems to do so via "struct split_index"
that does have a copy of saved_cache.  If the write-out codepath
walks these two sorted arrays in parallel, shouldn't it be able to
figure out which entry is added, deleted and modified without
fattening this structure?

Maybe it is too early for me to be asking these questions and it may
be better if I read the whole series twice and wait it to become
clear to me why this field is necessary.  I dunno.
