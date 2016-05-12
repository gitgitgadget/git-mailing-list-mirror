From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 18/94] builtin/apply: move 'cached' global into 'struct apply_state'
Date: Thu, 12 May 2016 12:33:05 -0700
Message-ID: <xmqqshxndqby.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-19-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Thu May 12 21:33:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0wMF-0005kH-LD
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbcELTdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:33:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932171AbcELTdI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:33:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 04EFC1BCA2;
	Thu, 12 May 2016 15:33:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=30M9R3qyKKGj09/ItrTAqRLeVqQ=; b=DaHrci
	iv4dRDSHWO8rDTq3tCGHPGdI9DpEcjbo0NCsJRP8FkkjCIkfoEeStO6ddDbHBHoq
	fCzlUk1BvpexMOGbFk8oCPDM915t/N+Q0B8x0uFzY0j2hOWn7OIDxmfl5CvCUWIB
	G02A9H90vksvYy0CJDNZVVR3/bk1+Ts9CJjh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CPAaeP59NlYs9qLht62UxBvQa9tAXdKo
	SzuDfk/i5daelhqN8CXqZ44z5nikKLoJogrQrs4Lb8ipUrP0W5BLz0o1NQETj+kz
	B7QdF5e+a2WPausWLmR+KnmReoKUKDIhg+98vGMtS9lYHdo7dh68I9jiB8lM1c6Y
	HSTIkaJJXJc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F09A51BCA1;
	Thu, 12 May 2016 15:33:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BFA61BCA0;
	Thu, 12 May 2016 15:33:07 -0400 (EDT)
In-Reply-To: <20160511131745.2914-19-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5A7C900C-1878-11E6-8D51-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294435>

Christian Couder <christian.couder@gmail.com> writes:

> To libify the apply functionality the 'cached' variable should
> not be static and global to the file. Let's move it into
> 'struct apply_state'.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 8791b28..09af5dc 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -30,6 +30,9 @@ struct apply_state {
>  	int apply_with_reject;
>  	int apply_verbosely;
>  
> +	/* --cached updates only the cache without ever touching the working tree. */
> +	int cached;
> +

Again, this should sit right next to update_index and check_index.

Other than that, this step looks correct.
