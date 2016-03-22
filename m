From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] builtin/apply: make gitdiff_verify_name() return void
Date: Tue, 22 Mar 2016 14:25:31 -0700
Message-ID: <xmqq37rigq7o.fsf@gitster.mtv.corp.google.com>
References: <1458680322-17681-1-git-send-email-chriscool@tuxfamily.org>
	<1458680322-17681-3-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 22:25:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiTo3-0006UT-VC
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 22:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbcCVVZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 17:25:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:65313 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751388AbcCVVZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 17:25:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4F5434F8B6;
	Tue, 22 Mar 2016 17:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uWgpxNad0mqP+MQdBwrfs68BpVQ=; b=VfUoWH
	U4kFmEbEV2VPdXwzFG1xRffZfKzXeFxhHP8dH9gv+ApvgQKA5djTvCzGROpPhY7E
	3pB6Y687cSgyaorb8uzPDz7sTPBnYcHWn5wWKmt5ZWst0SfpmMQsfC2QV55fxZ3X
	uVQ44nzbhLwv/XHcJkMJzLPJJkWuBC7t2dYzo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gh/ab3jt6BDCwKSbvvDY7xocr0AmXKzs
	jHu3mf8sKG6BTLqoi18WaO22GRodEfOjZjz+d2i0GqZDGW55EJQHg8yuUoEBE9mO
	A3VjeS5xrYz+wAKyARcV+VH1kYfUlTFbkav4l53MnvUoRZCoYrSog9rJJ4LBQnwJ
	CgWMQHSh0Vo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44EFC4F8B5;
	Tue, 22 Mar 2016 17:25:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A15664F8B4;
	Tue, 22 Mar 2016 17:25:32 -0400 (EDT)
In-Reply-To: <1458680322-17681-3-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Tue, 22 Mar 2016 21:58:41 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BE0DCDC-F074-11E5-AFCC-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289565>

Christian Couder <christian.couder@gmail.com> writes:

> As the value returned by gitdiff_verify_name() is put into the
> same variable that is passed as a parameter to this function,
> it is simpler to pass the address of the variable and have
> gitdiff_verify_name() change the variable itself.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---


This change makes the function less useful by restricting the
callers--only the ones that wants in-place update can call it after
this change, while the old function signature allowed a caller to
pass one variable as orig, receive the result in another variable
(and probably compare them).

It does not matter very much for this file scope static helper
either way, and I would probably say the same thing if the patch
were in reverse (i.e. if the patch were loosening the restriction),
but I cannot offhand see why this is an improvement.  Puzzled...

>  builtin/apply.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 465f954..4cafdaf 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -925,37 +925,37 @@ static int gitdiff_hdrend(const char *line, struct patch *patch)
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
>  	char *orig = patch->old_name;
> -	patch->old_name = gitdiff_verify_name(line, patch->is_new, patch->old_name,
> -					      DIFF_OLD_NAME);
> +	gitdiff_verify_name(line, patch->is_new, &patch->old_name,
> +			    DIFF_OLD_NAME);
>  	if (orig != patch->old_name)
>  		free(orig);
>  	return 0;
> @@ -964,8 +964,8 @@ static int gitdiff_oldname(const char *line, struct patch *patch)
>  static int gitdiff_newname(const char *line, struct patch *patch)
>  {
>  	char *orig = patch->new_name;
> -	patch->new_name = gitdiff_verify_name(line, patch->is_delete, patch->new_name,
> -					      DIFF_NEW_NAME);
> +	gitdiff_verify_name(line, patch->is_delete, &patch->new_name,
> +			    DIFF_NEW_NAME);
>  	if (orig != patch->new_name)
>  		free(orig);
>  	return 0;
