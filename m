From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] fast-export: don't parse all the commits
Date: Fri, 03 May 2013 14:54:56 -0700
Message-ID: <7vd2t7ybin.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 03 23:55:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYNwY-000123-JY
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 23:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932944Ab3ECVzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 17:55:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756206Ab3ECVy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 17:54:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D940A1BD48;
	Fri,  3 May 2013 21:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slqUqzRExpI6TOSHv66w+RSqCvA=; b=opnJJC
	N3VzGSoj2t0cKlOGznUTM5B9ECVnSkC2EgjmGM7PURYj5uJmw/AvP0psQoe8iIxY
	GkeYKinw6yTHgbfWg8nWJMVVg/2ZeaERqh0K9grJ9i4d15Q78qP4RGURwkaglnPj
	qMhwTuZxoCWp8qbJrCnBZGGE4JCwuZ7mbNxNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZaQTfX+MRKvR9fOvE2S3n6xaxvMvgbSs
	GIREa512KtxP2oOAkLx1uwIyz8oWMzIcK6/QV0sPWr2e5oBhfDIXE2cGmZd46PM4
	cAETurznoVmBSSc2JWQKGTEEJD4XHWUpvfzK5Q3UtDQBolqX+qG61sXagjvPvBdg
	EaRplsiobbo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC01A1BD46;
	Fri,  3 May 2013 21:54:58 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 514EC1BD44;
	Fri,  3 May 2013 21:54:58 +0000 (UTC)
In-Reply-To: <1367555502-4706-4-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Thu, 2 May 2013 23:31:41 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 18E80DEA-B43C-11E2-8E8F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223326>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> We don't need the parsed objects at this point, merely the information
> that they have marks.
>
> Seems to be three times faster in my setup with lots of objects.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/fast-export.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index a5b8da8..3c5a701 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -636,7 +636,7 @@ static void import_marks(char *input_file)
>  			/* only commits */
>  			continue;
>  
> -		object = parse_object(sha1);
> +		object = lookup_unknown_object(sha1);

This updates the parse_object() moved by the previous patch. At this
point in the codeflow, unlike the original, we already _know_ the
object must be a commit; wouldn't an equivalent of:

	object = &(lookup_commit(sha1)->object)

be more correct here?

>  
>  		if (object->flags & SHOWN)
>  			error("Object %s already has a mark", sha1_to_hex(sha1));
