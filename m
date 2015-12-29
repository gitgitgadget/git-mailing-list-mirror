From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 01/10] dir: free untracked cache when removing it
Date: Tue, 29 Dec 2015 14:26:42 -0800
Message-ID: <xmqq37ukhowt.fsf@gitster.mtv.corp.google.com>
References: <1451372974-16266-1-git-send-email-chriscool@tuxfamily.org>
	<1451372974-16266-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6gersh?= =?utf-8?Q?ausen?= 
	<tboegi@web.de>, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 23:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE2jC-00080B-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 23:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbL2W0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 17:26:46 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54688 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752609AbbL2W0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 17:26:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8452238018;
	Tue, 29 Dec 2015 17:26:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sVqL8npU1f7Fb9wvDUPkZSTFpA8=; b=Gvq9fJ
	IPFMRjg9rCEZc3XwxcN6asZ0H29yCj9chJ8tPUGY3vxR0SykvMV5cKa+1PL9+aOL
	2Ll0/MfpUAb03BXMyWRILkwPcbNuRt7DXFWUJfbFbFdeI3PI32IV2wljvSLZItWb
	rVrd/sSNmvtammBDIUnVMrj2Wta6Qp186FwTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6REgKETYXoD/Gx1OBI8OUul4f/sqJEI
	p9/Kjcf3fwUSjIgl8xHAgjn1CR5TQJmJAMkQWQeSDGLNloQyZVCXnsFRTB8k+sOI
	xheV7KZzk9xQiB+gwLNEyyWu/LCw7jaVfq5nThCsW3pStz4kLuU17Q3zHROHgJlC
	fFMRRUphCuc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7AA5438017;
	Tue, 29 Dec 2015 17:26:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EB1AF38016;
	Tue, 29 Dec 2015 17:26:43 -0500 (EST)
In-Reply-To: <1451372974-16266-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 29 Dec 2015 08:09:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D7D1DD0-AE7B-11E5-ADDC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283152>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/update-index.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 7431938..a6fff87 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  		add_untracked_ident(the_index.untracked);
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
>  	} else if (!untracked_cache && the_index.untracked) {
> +		free_untracked_cache(the_index.untracked);
>  		the_index.untracked = NULL;
>  		the_index.cache_changed |= UNTRACKED_CHANGED;
>  	}

Looks good.
