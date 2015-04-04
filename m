From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 1/4] sha1_file.c: support reading from a loose object of unknown type
Date: Sat, 04 Apr 2015 12:34:04 -0700
Message-ID: <xmqq7ftrg02b.fsf@gitster.dls.corp.google.com>
References: <551F7984.5070902@gmail.com>
	<1428126162-18987-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 04 21:34:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeTpd-00051F-QX
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 21:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574AbbDDTeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 15:34:09 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752522AbbDDTeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 15:34:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 823AC45735;
	Sat,  4 Apr 2015 15:34:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ygc7MhJg7ByhxtKa+F5FAEp3PGk=; b=PXG1A3
	FOdgb84pQGWudv0Dk5FtiX4+1r8Ef4l3s1Q/cPlNLNT2M8JBMuhOnaSkMENdMpf/
	ienn+aJHgPYd/dwfhZG2xD8+BtSIMnmfotVXASVU5BqAbmoImnzJyIScC9sb0dSL
	4kCq/Lm/DEnaL9ZPxxfLoDtRMKwymSqJZz8eQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7woB5/tGGfs7TwWoRbn7+Cd9Nu70oca
	5LLSNrB/kB9GUeVMoEs/9jy0z+r0u+pEFdMe/xDWBWKGtEwwZI8EK0prT71dCeZ4
	YxHHUXMz4t2Z6HVn3f7Kr8WivHdEoWjOQG/FXaVeduVGKoB4Jhszn6NjI8bDZF0T
	SFW6cbN6hFU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79E9545733;
	Sat,  4 Apr 2015 15:34:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0227345732;
	Sat,  4 Apr 2015 15:34:05 -0400 (EDT)
In-Reply-To: <1428126162-18987-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Sat, 4 Apr 2015 11:12:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8E80D8BE-DB01-11E4-ACA1-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266779>

Karthik Nayak <karthik.188@gmail.com> writes:

> @@ -2586,13 +2649,15 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  			*(oi->disk_sizep) = 0;
>  		if (oi->delta_base_sha1)
>  			hashclr(oi->delta_base_sha1);
> +		if (oi->typename)
> +			strbuf_addstr(oi->typename, typename(co->type));
>  		oi->whence = OI_CACHED;
>  		return 0;
>  	}

Just before the pre-context of this hunk, there is this bit:

	if (oi->typep)
		*(oi->typep) = co->type;

which tells me that the callers of this function is allowed to pass
a NULL in oi->typep when they are not interested in the type of the
object.

>  	if (!find_pack_entry(real, &e)) {
>  		/* Most likely it's a loose object. */
> -		if (!sha1_loose_object_info(real, oi)) {
> +		if (!sha1_loose_object_info(real, oi, flags)) {
>  			oi->whence = OI_LOOSE;
>  			return 0;
>  		}
> @@ -2616,6 +2681,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
>  		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
>  					 rtype == OBJ_OFS_DELTA);
>  	}
> +	if (oi->typename)
> +		strbuf_addstr(oi->typename, typename(*oi->typep));

So, it makes me wonder what guarantee we have that this does not
dereference a NULL here.
