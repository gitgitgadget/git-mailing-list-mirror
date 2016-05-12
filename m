From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/94] builtin/apply: make gitdiff_verify_name() return void
Date: Thu, 12 May 2016 12:06:07 -0700
Message-ID: <xmqqmvnvf65c.fsf@gitster.mtv.corp.google.com>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
	<20160511131745.2914-2-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Thu May 12 21:06:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0vw8-00071H-5t
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 21:06:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752856AbcELTGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 15:06:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752853AbcELTGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 15:06:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C448B1BAA3;
	Thu, 12 May 2016 15:06:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EZuiEULK03Ku32sxQW0RnnHUhS0=; b=m3rmcr
	zetlnJ/miiafzHxk2xmYoPyDnbufRioU/3b3Zq+ugawSYIXIotyP05BGwA9e4WPo
	yab8bnL9n96/X4DDXCPly8A40+gteWZ9X3RGKcXhd+z3vWWzv4M+JKMvhH+Sk/0N
	piQi8antBJRwBf8iQeP76YTFnp+ksmDipsxTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CD7+trNxT++JsfshEwvw3wNSLex7h26+
	VnsZRn6EKM8QLs3APpU1ztuLs8y2uIUdatWP3oOAQBcfjMRvgc/wBj+u2BUzz47b
	L+3ECJF48uNT/XccPMuSuUpovhQSJMCjUMhWk310Uy5DOWsl977j5x6c1ZJ8XeJQ
	6N9XSwfk9D8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BAE871BAA2;
	Thu, 12 May 2016 15:06:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C7111BAA1;
	Thu, 12 May 2016 15:06:10 -0400 (EDT)
In-Reply-To: <20160511131745.2914-2-chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 11 May 2016 15:16:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 968E783E-1874-11E6-B821-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294428>

Christian Couder <christian.couder@gmail.com> writes:

> As the value returned by gitdiff_verify_name() is put into the
> same variable that is passed as a parameter to this function,
> it is simpler to pass the address of the variable and have
> gitdiff_verify_name() change the variable itself.
>
> This also makes it possible to later have this function return
> -1 instead of die()ing in case of error.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

While I do not agree with "it is simpler" at all (it makes it harder
for callers if they ever want to use different variables--they would
need to invent a temporary variable just for that, and it makes it
no difference for existing callers that happen to use the same
variable), I like the way the real reason why we want to do this is
mentioned in the proposed log message.

Will queue.

>  builtin/apply.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 8e4da2e..fe5aebd 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -925,43 +925,43 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
>  #define DIFF_OLD_NAME 0
>  #define DIFF_NEW_NAME 1
>  
> -static char *gitdiff_verify_name(const char *line, int isnull, char *orig_name, int side)
> +static void gitdiff_verify_name(const char *line, int isnull, char **name, int side)
>  {
> -	if (!orig_name && !isnull)
> -		return find_name(line, NULL, p_value, TERM_TAB);
> +	if (!*name && !isnull) {
> +		*name = find_name(line, NULL, p_value, TERM_TAB);
> +		return;
> +	}
>  
> -	if (orig_name) {
> -		int len = strlen(orig_name);
> +	if (*name) {
> +		int len = strlen(*name);
>  		char *another;
>  		if (isnull)
>  			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
> -			    orig_name, linenr);
> +			    *name, linenr);
>  		another = find_name(line, NULL, p_value, TERM_TAB);
> -		if (!another || memcmp(another, orig_name, len + 1))
> +		if (!another || memcmp(another, *name, len + 1))
>  			die((side == DIFF_NEW_NAME) ?
>  			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
>  			    _("git apply: bad git-diff - inconsistent old filename on line %d"), linenr);
>  		free(another);
> -		return orig_name;
>  	} else {
>  		/* expect "/dev/null" */
>  		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
>  			die(_("git apply: bad git-diff - expected /dev/null on line %d"), linenr);
> -		return NULL;
>  	}
>  }
>  
>  static int gitdiff_oldname(const char *line, struct patch *patch)
>  {
> -	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
> -					      DIFF_OLD_NAME);
> +	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
> +			    DIFF_OLD_NAME);
>  	return 0;
>  }
>  
>  static int gitdiff_newname(const char *line, struct patch *patch)
>  {
> -	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
> -					      DIFF_NEW_NAME);
> +	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
> +			    DIFF_NEW_NAME);
>  	return 0;
>  }
