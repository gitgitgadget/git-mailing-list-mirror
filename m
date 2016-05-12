From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 16/94] builtin/apply: move 'update_index' global into 'struct apply_state'
Date: Thu, 12 May 2016 12:31:43 -0700
Message-ID: <xmqqwpmzdqe8.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-17-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 12 21:31:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wKt-0003rW-Uh
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932229AbcELTbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:31:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55037 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932183AbcELTbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:31:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 244E71A883;
	Thu, 12 May 2016 15:31:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UTU43HmvKHk8dDEh32RoASODvsU=; b=IaNhwD
	QdQlbMKu27WmZhA8x9gwB5GSw8O5qJ82zrqXi2xq4AF+z5rvgYb9we7VCD1FXkW6
	7rcdq49TTa5RgrRu2Kc197r10acvjRjUimKSwyFxAMNjkLcjfjs2ugs636Hj5VJD
	qD0VyK4H6QZ07IzSfPTzav56F0GdtwYs4DH48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZe84JsnR8461hu7cPBRZ7l4li2OwrRx
	aLOg8UhHbWs414LdHnYewUWot7buLnAFPLKlVUTplYdtJbh8Cwfyt3yYMamOF9M4
	RCN+MvhUDlgAwTW7+XWHcSX/XXN4w8sorxPYw2I5F9Aw73zfPJMsbaee3rD0eBkx
	+n+FkGmFVSo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BE801A882;
	Thu, 12 May 2016 15:31:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C9D41A880;
	Thu, 12 May 2016 15:31:45 -0400 (EDT)
In-Reply-To: <20160511131745.2914-17-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 29A60BE8-1878-11E6-8242-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294434>

Christian Couder <christian.couder@gmail.com> writes:

> To libify the apply functionality the 'update_index' variable should
> not be static and global to the file. Let's move it into
> 'struct apply_state'.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 97af6ea..635a9ff 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -39,6 +39,7 @@ struct apply_state {
>  	int check_index;
>  
>  	int unidiff_zero;
> +	int update_index;

This should sit right next to check_index, I would think.

Otherwise looks correct.
