From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 06/19] fsck: Report the ID of the error/warning
Date: Fri, 19 Jun 2015 12:28:40 -0700
Message-ID: <xmqqvbej7b13.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<d0c24a7643acd3a1a17ab3abf0ba54ab352b3e41.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:28:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61y3-0006yI-02
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953AbbFST2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:28:43 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33685 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbFST2m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:28:42 -0400
Received: by igbqq3 with SMTP id qq3so23520447igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aXJQakEOxxT7N2/VNBYWs2n3oXyWIvkoq7ZYAdX+OpY=;
        b=eMGdP7cQiuBznaLK1MmsIkg1pjnCAQJIWdShFcl1VFEkB1errZ6bE4vMMqa6xCfKbJ
         2nlUvtO+dPhMPgr5NR0KWws5O+yohpwMiLSInIxJYQ/16NPq4NzjSZB54s6rtXN8fYUJ
         lyoqoMTmVRJEihvlJjCZAP18+igA31vEYhWGTPkFaP/5lJsoXxND9lg6IvicifHsMBYM
         1CND3UXpczVeGjvGoim/lYlt330BoLSGDT/HEaAOk8BHnjgjaYsVl9K1+BwUK1Zu9CUC
         yi/IAUDRYzRTSZP4geZq4EVRZ0FasTALafhhBvWTfHZ3XiBjyrKnv1i6GjaA+uaBfo0h
         XPfQ==
X-Received: by 10.107.9.66 with SMTP id j63mr24977659ioi.37.1434742121511;
        Fri, 19 Jun 2015 12:28:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id fv2sm2274014igb.22.2015.06.19.12.28.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:28:40 -0700 (PDT)
In-Reply-To: <d0c24a7643acd3a1a17ab3abf0ba54ab352b3e41.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:33:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272189>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Some legacy code has objects with non-fatal fsck issues; To enable the
> user to ignore those issues, let's print out the ID (e.g. when
> encountering "missingemail", the user might want to call `git config
> --add receive.fsck.missingemail=warn`).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c          | 16 ++++++++++++++++
>  t/t1450-fsck.sh |  4 ++--
>  2 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index 8e6faa8..0b3e18f 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -190,6 +190,20 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
>  	}
>  }
>  
> +static void append_msg_id(struct strbuf *sb, const char *msg_id)
> +{
> +	for (;;) {
> +		char c = *(msg_id)++;
> +
> +		if (!c)
> +			break;
> +		if (c != '_')
> +			strbuf_addch(sb, tolower(c));
> +	}
> +
> +	strbuf_addstr(sb, ": ");
> +}
> +
>  __attribute__((format (printf, 4, 5)))
>  static int report(struct fsck_options *options, struct object *object,
>  	enum fsck_msg_id id, const char *fmt, ...)
> @@ -198,6 +212,8 @@ static int report(struct fsck_options *options, struct object *object,
>  	struct strbuf sb = STRBUF_INIT;
>  	int msg_type = fsck_msg_type(id, options), result;
>  
> +	append_msg_id(&sb, msg_id_info[id].id_string);


Nice.  The append function can be made a bit more context sensitive
to upcase a char immediately after _ to make it easier to cut and
paste into "git config" and keep the result readable, I think.

	git config --add receive.fsck.missingEmail=warn

>  	va_start(ap, fmt);
>  	strbuf_vaddf(&sb, fmt, ap);
>  	result = options->error_func(object, msg_type, sb.buf);
> diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
> index cfb32b6..d6d3b13 100755
> --- a/t/t1450-fsck.sh
> +++ b/t/t1450-fsck.sh
> @@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
>  	git fsck --tags 2>out &&
>  
>  	cat >expect <<-EOF &&
> -	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
> -	warning in tag $tag: invalid format - expected '\''tagger'\'' line
> +	warning in tag $tag: badtagname: invalid '\''tag'\'' name: wrong name format
> +	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
>  	EOF
>  	test_cmp expect out
>  '
