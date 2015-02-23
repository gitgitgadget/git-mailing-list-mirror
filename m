From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] index-pack: reduce object_entry size to save memory
Date: Sun, 22 Feb 2015 18:37:03 -0800
Message-ID: <xmqqegphuze8.fsf@gitster.dls.corp.google.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
	<1424397488-22169-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msporleder@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 03:37:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPitd-00060P-1x
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 03:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752156AbbBWChJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2015 21:37:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751290AbbBWChI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2015 21:37:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C8903ADB0;
	Sun, 22 Feb 2015 21:37:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AzA8Iq/CKm8r
	+RYnRV1of6WK73o=; b=dZltzLVZ388eto00oa2rbmBWWmW3V+1GZKYRLdBOy0WK
	itvObme2Whk8uJ0oMRNk3llwUnNBAkwv2qT/G/j6qS2md24JaDp8Y/wM7T/yueoB
	2Q0Aq2FAUKWQSI7oG01jDdPHI7yCF3ZVtmhmPOI5z2y0BFTXqfOLbc+tm8veVoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LUjm0W
	6mGjAsgBPXaiJ/plh4VAuO2N2J149MV0IlXyt02dg3g5KW/6Oz54hIANGfI9QG4/
	EyZkJyitRQlBUuk2iAM7eZkAuZ9Q28TrMTu8FyRZglv5uhA1K6ig6Xwsw0GuyI5i
	BJbBYnnZDKLqJI2n+F1bR/Hla7Y9o2WgQV4OU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22B903ADAF;
	Sun, 22 Feb 2015 21:37:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 11E183ADAE;
	Sun, 22 Feb 2015 21:37:04 -0500 (EST)
In-Reply-To: <1424397488-22169-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 20
 Feb 2015 08:58:07 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DAAC3A34-BB04-11E4-9D1D-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264244>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 4632117..07b2c0c 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -18,9 +18,12 @@ static const char index_pack_usage[] =3D
>  struct object_entry {
>  	struct pack_idx_entry idx;
>  	unsigned long size;
> -	unsigned int hdr_size;
> -	enum object_type type;
> -	enum object_type real_type;
> +	unsigned char hdr_size;
> +	char type;
> +	char real_type;

Don't you need these two fields to be able to hold a negative value
like OBJ_BAD (=3D -1)?  You'd need to spell "signed char" out here.
