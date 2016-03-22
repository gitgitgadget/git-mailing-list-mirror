From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] builtin/apply: simplify gitdiff_{old,new}name()
Date: Tue, 22 Mar 2016 14:35:31 -0700
Message-ID: <xmqqy49afb6k.fsf@gitster.mtv.corp.google.com>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
	<1458680322-17681-4-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:35:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTxo-00055B-IY
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752495AbcCVVfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:35:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752473AbcCVVfe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:35:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 43F2E4FBF3;
	Tue, 22 Mar 2016 17:35:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Np4xJu+m2p+bR555c3lRwJHT2iw=; b=la/lf2
	w2sOxO1xmC2lw3Lt4EgHXYm3k13AbbnUpyyn0KhAyxWOOirfSdWLVGl7rpZEBtit
	Q9Y7D3EcVk5XM0+VHu4blgJ3QQjph7H5tNIu0IOuD9SM81vZtLpoJsbFecBLbfwZ
	YoymGzY4mXm11AitqtTXROp8D5TQAC16HJ0Sg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JDcGzkyV+dp1lNXYIyw22QHpScDkg5JR
	g09bszHI5fRHCEt/uS6ksVJlfY9vtH2NJ9lRD2taIHzmW8oC++PT9v9hsA1it0Rp
	2O/XIxyolWiyKcviiIPNEyaeleHZkIo8LSnnHJyeaXlAyrsfWOwh3lMRx3IDY5N5
	78G013qANtY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3C88C4FBF2;
	Tue, 22 Mar 2016 17:35:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B660F4FBF1;
	Tue, 22 Mar 2016 17:35:32 -0400 (EDT)
In-Reply-To: <1458680322-17681-4-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 22 Mar 2016 21:58:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 018E4384-F076-11E5-9647-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289567>

Christian Couder <christian.couder@gmail.com> writes:

> After the previous simplifications, it is easy to see that
> there is no need to free the original string passed to
> gitdiff_verify_name(), because this string can be changed
> only when it is NULL.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

I do not think you need either 1/3 or 2/3 to see that (I actually
think it is easier to see this without 2/3).  The caller passes
patch->old_name and

 - if that is NULL, then we will either get NULL or a new string
   from find_name(); either way, we do not have to worry about
   calling free() on the original NULL;

 - if that is not NULL, then the only possible value returned from
   the function is itself (otherwise it will die()), so we won't be
   calling free() in this code.

so I agree with the conclusion, i.e. the conditional free() can go
from these places.

>  builtin/apply.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 4cafdaf..9cfa9f4 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -953,21 +953,15 @@ static void gitdiff_verify_name(const char *line, int isnull, char **name, int s
>  
>  static int gitdiff_oldname(const char *line, struct patch *patch)
>  {
> -	char *orig = patch->old_name;
>  	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
>  			    DIFF_OLD_NAME);
> -	if (orig != patch->old_name)
> -		free(orig);
>  	return 0;
>  }
>  
>  static int gitdiff_newname(const char *line, struct patch *patch)
>  {
> -	char *orig = patch->new_name;
>  	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
>  			    DIFF_NEW_NAME);
> -	if (orig != patch->new_name)
> -		free(orig);
>  	return 0;
>  }
