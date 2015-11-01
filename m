From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit the size of the data block passed to SHA1_Update()
Date: Sun, 01 Nov 2015 10:37:48 -0800
Message-ID: <xmqqh9l5h8g3.fsf@gitster.mtv.corp.google.com>
References: <CAPig+cRRjCDhdT-DvGtZqns1mMxygnxi=ZnRKzg+H_do7oRpqQ@mail.gmail.com>
	<1446359536-25829-1-git-send-email-apahlevan@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	rsbecker@nexbridge.com, Atousa Pahlevan Duprat <apahlevan@ieee.org>
To: atousa.p@gmail.com
X-From: git-owner@vger.kernel.org Sun Nov 01 19:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsxVq-0003rB-Vs
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 19:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbKAShv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 13:37:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752408AbbKAShu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 13:37:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D7C65276FB;
	Sun,  1 Nov 2015 13:37:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1AcFVdFE5LMYM0A6Ep458DO8VB4=; b=K7nmNo
	MD110+UuTPKFRojAtwz2iaDYhxdbxYIjiFYZu0eZsXRKNzHfJ0ybpX8w3xYrIpfs
	oZ/3613uWIDIDIMl1TEwFXMvIZvXYV8Wh0f1Kb5iy5jonE1lTz8u7wNaczfwxzmk
	ZElr3+gMztG8LF5tjrvmZ29Y3crHf91Dwy5iY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xMqIqM5UvO4KODMszdsR+LsNrkz1CwbW
	9BU+feCjdCN7EVI5xyGEHKm2Ix4luHGhx+s/GPXj1HZhqPtsfgKKkoTqMMzVADs/
	pMXNG2nAyB5SeYc4vVs63CW9TqBqT1YebGFW+wMePyBxzm1Wlln+JJpEsisE+3It
	QjQi8AbA/WQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CFAB8276FA;
	Sun,  1 Nov 2015 13:37:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 585C9276F9;
	Sun,  1 Nov 2015 13:37:49 -0500 (EST)
In-Reply-To: <1446359536-25829-1-git-send-email-apahlevan@ieee.org> (atousa
	p.'s message of "Sat, 31 Oct 2015 23:32:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A7110EDC-80C7-11E5-A438-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280650>

atousa.p@gmail.com writes:

> diff --git a/cache.h b/cache.h
> index 79066e5..ec84b16 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -14,7 +14,12 @@
>  #ifndef git_SHA_CTX
>  #define git_SHA_CTX	SHA_CTX
>  #define git_SHA1_Init	SHA1_Init
> -#define git_SHA1_Update	SHA1_Update
> +#ifdef SHA1_MAX_BLOCK_SIZE
> +extern int SHA1_Update_Chunked(SHA_CTX *, const void *, size_t);
> +#define git_SHA1_Update SHA1_Update_Chunked
> +#else
> +#define git_SHA1_Update SHA1_Update
> +#endif
>  #define git_SHA1_Final	SHA1_Final
>  #endif

Hmm, I admit that this mess is my creation, but unfortunately it
does not allow us to say:

	make SHA1_MAX_BLOCK_SIZE='1024L*1024L*1024L'

when using other SHA-1 implementations (e.g. blk_SHA1_Update()).

Ideas for cleaning it up, anybody?
