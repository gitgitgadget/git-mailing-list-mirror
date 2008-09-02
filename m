From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Extend index to save more flags
Date: Tue, 02 Sep 2008 00:25:57 -0700
Message-ID: <7vhc8zm2ka.fsf@gitster.siamese.dyndns.org>
References: <48BBE881.1050206@viscovery.net>
 <1220278585-26969-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 09:27:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaQIF-0006vW-8c
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 09:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbYIBH0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2008 03:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752010AbYIBH0J
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 03:26:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbYIBH0H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2008 03:26:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F2DFB5993D;
	Tue,  2 Sep 2008 03:26:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 453A55993C; Tue,  2 Sep 2008 03:26:02 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 684B98A0-78C0-11DD-830F-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94658>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The on-disk format of index only saves 16 bit flags, nearly all have
> been used. The last bit (CE_EXTENDED) is used to for future extension=
=2E
>
> This patch extends index entry format to save more flags in future.
> The new entry format will be used when CE_EXTENDED bit is 1.
>
> Because older implementation may not understand CE_EXTENDED bit and
> misread the new format, if there is any extended entry in index, inde=
x
> header version will turn 3, which makes it incompatible for older git=
=2E
> If there is none, header version will return to 2 again.

I think this is a good change.

> diff --git a/cache.h b/cache.h
> index f725783..f8578d1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -109,6 +109,26 @@ struct ondisk_cache_entry {
>  	char name[FLEX_ARRAY]; /* more */
>  };
> =20
> +/*
> + * This struct is used when CE_EXTENDED bit is 1
> + * The struct must match ondisk_cache_entry exactly from
> + * ctime till flags
> + */
> +struct ondisk_cache_entry_extended {
> +	struct cache_time ctime;
> +	struct cache_time mtime;
> +	unsigned int dev;
> +	unsigned int ino;
> +	unsigned int mode;
> +	unsigned int uid;
> +	unsigned int gid;
> +	unsigned int size;
> +	unsigned char sha1[20];
> +	unsigned short flags;
> +	unsigned short flags2;
> +	char name[FLEX_ARRAY]; /* more */
> +};
> +

We should change these to more explicitly sized uint32_t both in the
original and this extended structure, but after this patch (or later
variant of it) lands in the tree.
