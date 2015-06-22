From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 04/19] fsck: Offer a function to demote fsck errors to warnings
Date: Mon, 22 Jun 2015 10:37:48 -0700
Message-ID: <xmqq616fiqz7.fsf@gitster.dls.corp.google.com>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
	<cover.1434986506.git.johannes.schindelin@gmx.de>
	<08ab723892b4412431b88df8764f506f0abbb0a6.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 19:37:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z75fQ-0006BC-PW
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 19:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbbFVRhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 13:37:53 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:32951 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751883AbbFVRhv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 13:37:51 -0400
Received: by igbqq3 with SMTP id qq3so68943235igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 10:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gkuPHVn2bAc6ibG7z9Zf2s9uympQ53CUakFMZG0QIL0=;
        b=oW7FIMZJu0FKHCLwhWTsjzogwZIeoJUVR4cW05OMATWV1VMderE8qP9nD53s2djVIi
         mtRoWA28nLRd0eJpI69wnGGVms7NtU2CBsLGc87alwwkRKmcYsjJxrp6mjcI+GQEWS5g
         TAp5Vibtwktko/7Y5d2c7GXWQjL87ZemYDT9YGF79DxwTxWc7vVL7HX45Cnh5771qDdq
         89Ji+yZ7ODfGOAh/7Vm/nwub+8Xq1DZWn+vHPwClD2MPW+hxi+ccfvgueKWUgbxqA4Wl
         2koU51zCN+0j/5yF/RFzIsIaLnlyC/d5AZJbekFPlarFLHY2281f5jHi9Oq3P+Jv5gq2
         053Q==
X-Received: by 10.107.47.26 with SMTP id j26mr41191021ioo.17.1434994670556;
        Mon, 22 Jun 2015 10:37:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id fv2sm7922386igb.22.2015.06.22.10.37.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 10:37:50 -0700 (PDT)
In-Reply-To: <08ab723892b4412431b88df8764f506f0abbb0a6.1434986506.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 22 Jun 2015 17:25:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272399>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/fsck.c b/fsck.c
> index 1a3f7ce..e81a342 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -64,30 +64,29 @@ enum fsck_msg_id {
>  #undef MSG_ID
>  
>  #define STR(x) #x
> -#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
> +#define MSG_ID(id, msg_type) { STR(id), NULL, FSCK_##msg_type },
>  static struct {
>  	const char *id_string;
> +	const char *lowercased;
>  	int msg_type;
>  } msg_id_info[FSCK_MSG_MAX + 1] = {
>  	FOREACH_MSG_ID(MSG_ID)
> -	{ NULL, -1 }
> +	{ NULL, NULL, -1 }
>  };
>  #undef MSG_ID
>  
>  static int parse_msg_id(const char *text)
>  {
> -	static char **lowercased;
>  	int i;
>  
> -	if (!lowercased) {
> +	if (!msg_id_info[0].lowercased) {
>  		/* convert id_string to lower case, without underscores. */
> -		lowercased = xmalloc(FSCK_MSG_MAX * sizeof(*lowercased));
>  		for (i = 0; i < FSCK_MSG_MAX; i++) {
>  			const char *p = msg_id_info[i].id_string;
>  			int len = strlen(p);
>  			char *q = xmalloc(len);
>  
> -			lowercased[i] = q;
> +			msg_id_info[i].lowercased = q;
>  			while (*p)
>  				if (*p == '_')
>  					p++;
> @@ -98,7 +97,7 @@ static int parse_msg_id(const char *text)
>  	}
>  
>  	for (i = 0; i < FSCK_MSG_MAX; i++)
> -		if (!strcmp(text, lowercased[i]))
> +		if (!strcmp(text, msg_id_info[i].lowercased))
>  			return i;
>  
>  	return -1;

Heh, this was the first thing that came to my mind when I saw 03/19
that lazily prepares downcased version (which is good) but do so in
a separately allocated buffer (which is improved by this change) ;-)

IOW, I think all of the above should have been part of 03/19, not
"oops I belatedly realized that this way is better" fixup here.

The end result looks good, so let's keep reading.

> +void fsck_set_msg_types(struct fsck_options *options, const char *values)
> +{
> +	char *buf = xstrdup(values), *to_free = buf;
> +	int done = 0;
> +
> +	while (!done) {
> +		int len = strcspn(buf, " ,|"), equal;
> +
> +		done = !buf[len];
> +		if (!len) {
> +			buf++;
> +			continue;
> +		}
> +		buf[len] = '\0';
> +
> +		for (equal = 0; equal < len &&
> +				buf[equal] != '=' && buf[equal] != ':'; equal++)

Style.  I'd format this more like so:

		for (equal = 0;
                     equal < len && buf[equal] != '=' && buf[equal] != ':';
		     equal++)

> +			buf[equal] = tolower(buf[equal]);
> +		buf[equal] = '\0';
> +
> +		if (equal == len)
> +			die("Missing '=': '%s'", buf);
> +
> +		fsck_set_msg_type(options, buf, buf + equal + 1);
> +		buf += len + 1;
> +	}
> +	free(to_free);
> +}

Overall, the change is good (and it was good in v6, too), and I
think it has become simpler to follow the logic with the upfront
downcasing.

Thanks.
