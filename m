From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] archive-tar: stream large blobs to tar file
Date: Mon, 30 Apr 2012 12:01:57 -0700
Message-ID: <7vmx5tf3h6.fsf@alter.siamese.dyndns.org>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com>
 <1335761837-12482-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 21:02:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOvrR-0007nV-4C
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 21:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab2D3TCB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 15:02:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35701 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755720Ab2D3TCA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Apr 2012 15:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD48A710F;
	Mon, 30 Apr 2012 15:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3LOpRT9Ss9f9
	YbOmmMY2V7iGuyA=; b=pOAUlH7bzsibKUP3cH48FxUL+W0YpEEyJawepANH2Pmv
	uaefeHnGT3BZvZ2ICfUyEQGXX32C1C1GCbJygn0WoPxObddPnbN1wKXagf0W1HI6
	c2IsgixBurR8H7/CN835shj/drpSyCBNVcRlJNUukzQ0geEbUFrB3kcd3IS3vJo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=f1vdt3
	6hSosItWfmJem85s2GgQffGxqZoBeoTf4raW8Rrlr3PNKdJDwlLY1T2jswx4mTk8
	bKA0UMenwkZ3/xIauiImfa1vuazsWyG7yUOSAfGy9TO7gz2ncEp3vT1MsVVQqop6
	Q6HL8VxKVlgx5yp/6Ve7GB00h26aus8LTGkxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B332E710E;
	Mon, 30 Apr 2012 15:01:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 11C63710B; Mon, 30 Apr 2012
 15:01:58 -0400 (EDT)
In-Reply-To: <1335761837-12482-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 30 Apr
 2012 11:57:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F65E9B48-92F6-11E1-9AF8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196592>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  archive-tar.c    |   38 +++++++++++++++++++++++++++++++++++---
>  t/t1050-large.sh |    4 ++++
>  2 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/archive-tar.c b/archive-tar.c
> index 61821f4..865ef6d 100644
> --- a/archive-tar.c
> +++ b/archive-tar.c
> @@ -4,6 +4,7 @@
>  #include "cache.h"
>  #include "tar.h"
>  #include "archive.h"
> +#include "streaming.h"
>  #include "run-command.h"
> =20
>  #define RECORDSIZE	(512)
> @@ -62,6 +63,29 @@ static void write_blocked(const void *data, unsign=
ed long size)
>  	write_if_needed();
>  }
> =20
> +static int stream_blob_to_file(const unsigned char *sha1)

The name of this function is misleading and caused me to look for an
existing implementation that streams blob contents to a given fd while
wondering how that fd is passed to this function.

I do not think it would make sense to reuse stream_blob_to_fd() here, a=
s
is it too much hassle to account for blocking factors.  In order to mak=
e
it clear for future futzers that this is not something they can turn in=
to
global function and reuse outside the context of generating tar archive
output, please rename it either to stream_blob_to_tarfile(), which is m=
ore
specific, or stream_blocked(), which is too vague and nobody sane would
think about exporting from the file just like existing write_blocked() =
is.
