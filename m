From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Teach 'git remote' that the config var branch.*.rebase can be 'interactive'
Date: Tue, 12 Jan 2016 15:53:07 -0800
Message-ID: <xmqqk2nes6cc.fsf@gitster.mtv.corp.google.com>
References: <cover.1452612112.git.johannes.schindelin@gmx.de>
	<8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:53:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8kU-0004VZ-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753496AbcALXxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:53:11 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752961AbcALXxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:53:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C1E0A3BA50;
	Tue, 12 Jan 2016 18:53:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h6XE4TjG3N4S1aUD28Mm0+56ais=; b=I6hlB5
	pDdh/bkS+Sw3SY2GqinV0ohyt1OHqplch6uIG0fGUOU2ET8aMKjycOm62vD/5ycL
	QdiKI22MB9fCfFg9G2rxRBQ772vX1MUieXlOPyzPRxzXzqCtfi3E6Gb2QsJY2RUR
	21SWqUXFxRMITsL48f7iSoXJj/B7rM9RVVHDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JxGK0/MUJ/qA2BGkqQxBi6/QKLegC1+F
	CPKazNpB/6f7CSg7AwGj/19Er05r5Eg0PRKGJmCfco8qEvakjYONfN11YaBS5H6u
	+MYfIhpWtbOIRBwDQ5XE3PDJoCnGK3cWxj70XUl1r9cZZPgSl634SbleOGpg3rpO
	9iqj+uAcsHU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BA3AD3BA4E;
	Tue, 12 Jan 2016 18:53:08 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4093A3BA4D;
	Tue, 12 Jan 2016 18:53:08 -0500 (EST)
In-Reply-To: <8c98523f8a3f2c6f2f3db1e4572e05c28f94688d.1452612112.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Tue, 12 Jan 2016 16:22:16 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A14FFB68-B987-11E5-A832-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283855>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/remote.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 6694cf2..0af8300 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -251,7 +251,7 @@ static int add(int argc, const char **argv)
>  struct branch_info {
>  	char *remote_name;
>  	struct string_list merge;
> -	int rebase;
> +	enum { NO_REBASE, NORMAL_REBASE, INTERACTIVE_REBASE } rebase;
>  };
>  
>  static struct string_list branch_list;
> @@ -312,6 +312,8 @@ static int config_read_branches(const char *key, const char *value, void *cb)
>  				info->rebase = v;
>  			else if (!strcmp(value, "preserve"))
>  				info->rebase = 1;

This should become NORMAL_REBASE, I would think, even though the
resulting machine code should be identical.

> +			else if (!strcmp(value, "interactive"))
> +				info->rebase = INTERACTIVE_REBASE;
>  		}
>  	}
>  	return 0;
> @@ -980,7 +982,9 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
>  
>  	printf("    %-*s ", show_info->width, item->string);
>  	if (branch_info->rebase) {
> -		printf_ln(_("rebases onto remote %s"), merge->items[0].string);
> +		printf_ln(_(branch_info->rebase == INTERACTIVE_REBASE ?
> +			"rebases interactively onto remote %s" :
> +			"rebases onto remote %s"), merge->items[0].string);
>  		return 0;
>  	} else if (show_info->any_rebase) {
>  		printf_ln(_(" merges with remote %s"), merge->items[0].string);
