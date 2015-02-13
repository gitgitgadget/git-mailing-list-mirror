From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] hex.c: reduce memory footprint of sha1_to_hex static buffers
Date: Fri, 13 Feb 2015 13:41:51 -0800
Message-ID: <xmqq7fvlmqu8.fsf@gitster.dls.corp.google.com>
References: <1423862329-7899-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, torvalds@linux-foundation.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:42:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMNzr-00014P-PU
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 22:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbbBMVly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2015 16:41:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752805AbbBMVly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 16:41:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F53337F25;
	Fri, 13 Feb 2015 16:41:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pyH38OyuaLwWPDrxg77ZsHNlcwc=; b=YncKAL
	fIy4ZuLtCOAZ27RIgEWclQh2ynnA1nXD4OTeWIPuV07OBCxKhnxAaq89xlcv8zHd
	GpaQ19Syt0kis9AN2MNi//YEKNtSMgkGIYYmgeI8xtwUg95zrCIVjiGSBQxYJsiV
	kOrBpvuo7hbYpSvcFYrS/hkzJeGlRy0HAM55Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NbNtY57wDto4E7zBWadnWfbE93qWImCW
	L6jUBu7lA6RGYoOJ4youvNJThkU2o1VlynjVS3dbYyeqXFUN/RDv+znP9kn9+Mq2
	TfAn4bj2+dHU7/chXoglzgZkWIcJSmIDpoKdX8e1WpOVUUkGAWjeh+yEHitjw9Ig
	ldDJEDeMFJ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4654737F24;
	Fri, 13 Feb 2015 16:41:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE0FF37F23;
	Fri, 13 Feb 2015 16:41:52 -0500 (EST)
In-Reply-To: <1423862329-7899-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Fri, 13 Feb 2015 13:18:49 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1F9922E4-B3C9-11E4-A667-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263838>

Stefan Beller <sbeller@google.com> writes:

> 41 bytes is the exact number of bytes needed for having the returned
> hex string represented. 50 seems to be an arbitrary number, such
> that there are no benefits from alignment to certain address boundaries.

Yes, with s/seems to be/is/;

This comes from e83c5163 (Initial revision of "git", the information
manager from hell, 2005-04-07), and when dcb3450f (sha1_to_hex()
usage cleanup, 2006-05-03) introduced the "4 recycled buffers" on
top, the underlying array was left at 50 bytes long.

You can now have "I fixed Linus's bug" badge ;-)

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  hex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hex.c b/hex.c
> index 9ebc050..cfd9d72 100644
> --- a/hex.c
> +++ b/hex.c
> @@ -59,7 +59,7 @@ int get_sha1_hex(const char *hex, unsigned char *sha1)
>  char *sha1_to_hex(const unsigned char *sha1)
>  {
>  	static int bufno;
> -	static char hexbuffer[4][50];
> +	static char hexbuffer[4][41];
>  	static const char hex[] = "0123456789abcdef";
>  	char *buffer = hexbuffer[3 & ++bufno], *buf = buffer;
>  	int i;
