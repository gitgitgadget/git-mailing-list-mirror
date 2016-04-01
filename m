From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/apply: free patch when parse_chunk() fails
Date: Fri, 01 Apr 2016 10:23:26 -0700
Message-ID: <xmqqr3epi6pd.fsf@gitster.mtv.corp.google.com>
References: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:23:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am2nF-0003Th-Ni
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbcDARXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:23:30 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbcDARX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:23:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1BD3B4FA78;
	Fri,  1 Apr 2016 13:23:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTz1ibp2y0Qo9VrdyJUELCD9zpU=; b=akKEub
	O+8fAwH0qDNzuaRIlHeBgDCmrqflVW8DDihHJe+TqhU2ypla5+sPAsn8yRXiWE7O
	Cb9JGtDZrlcU1KAw3VgNdeBDLsIiDGmkXBz15szd2sDGyILSny3ju8lzZhHOUx1t
	WN7m1jD6KdZiBF4cS6mrZXE91V0hxGxJaVaU8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=usQkO6VdYKKZq1uoSK/eh2IB/02Ekfpb
	202v66eF+/W5Z0Pj5ttDtR57wqTQdtzzw6glSWmj1FXoj7ZbZYJTAtSa93K++2mN
	PJ9Hs1OT1CVKvSHP88GAjZaXETuCIw72pI5T/DHPmMt0Ryo9UeincsNw1BLZuNL9
	uxa3bAxPIz8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 11DB74FA76;
	Fri,  1 Apr 2016 13:23:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7F3DD4FA75;
	Fri,  1 Apr 2016 13:23:27 -0400 (EDT)
In-Reply-To: <1458156911-26649-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 16 Mar 2016 20:35:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7259A5EE-F82E-11E5-8574-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290564>

Christian Couder <christian.couder@gmail.com> writes:

> When parse_chunk() fails it can return -1, for example
> when find_header() doesn't find a patch header.
>
> In this case it's better in apply_patch() to free the
> "struct patch" that we just allocated instead of
> leaking it.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 4 +++-

OK.  Will queue.  Thanks.

>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 42c610e..bf78282 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -4373,8 +4373,10 @@ static int apply_patch(int fd, const char *filename, int options)
>  		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
>  		patch->recount =  !!(options & RECOUNT);
>  		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
> -		if (nr < 0)
> +		if (nr < 0) {
> +			free_patch(patch);
>  			break;
> +		}
>  		if (apply_in_reverse)
>  			reverse_patches(patch);
>  		if (use_patch(patch)) {
