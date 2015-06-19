From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 03/19] fsck: Provide a function to parse fsck message IDs
Date: Fri, 19 Jun 2015 12:13:03 -0700
Message-ID: <xmqq4mm38qbk.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<8129a20ee6befc74eb45b6225edaaa1b61647d08.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 21:13:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z61iw-00019C-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 21:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbbFSTNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 15:13:07 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32798 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753065AbbFSTNF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 15:13:05 -0400
Received: by igbqq3 with SMTP id qq3so23229887igb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 12:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DvVFH9BkYRABwVfcdtTj/gqgGL7l7DgIQNREumblHro=;
        b=NKf3cNnPhX5M0rypTJz0T/knKje4aBs5HDceBPy0rcduplOG+rHd+AqJE+d/j95pKh
         EHBzZGOESWsJUGCuKdU30TyA4vcSAIpT7gGazliWphjrn1XsjKR26doMJ8QEWJJialKX
         h96uM9fIu2fmqCdiqF8LsvDsgFsQlCmLyJPvKSbZkaZVB/jpLJ+YXOSOYrqonG7mYTli
         9ronNKL5KDBlQqAfG3562Hiz2M7TsVIjLCf/U3l03MWMiE/gzpIuEV5SwTcUoNo0s2TD
         FVAum7zVZi5WA6g67w96QkHwdnTG9T442D7GnlVKS1L2ujZu61pD97ERcixgNeNG0rPR
         wpPQ==
X-Received: by 10.50.43.131 with SMTP id w3mr6639022igl.8.1434741184691;
        Fri, 19 Jun 2015 12:13:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id fm3sm4421964igb.1.2015.06.19.12.13.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 12:13:04 -0700 (PDT)
In-Reply-To: <8129a20ee6befc74eb45b6225edaaa1b61647d08.1434720655.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 19 Jun 2015 15:32:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272187>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
>  static struct {
> +	const char *id_string;
>  	int msg_type;
>  } msg_id_info[FSCK_MSG_MAX + 1] = {
>  	FOREACH_MSG_ID(MSG_ID)
> -	{ -1 }
> +	{ NULL, -1 }
>  };
>  #undef MSG_ID
>  
> +static int parse_msg_id(const char *text, int len)
> +{
> +	int i, j;
> +
> +	if (len < 0)
> +		len = strlen(text);
> +
> +	for (i = 0; i < FSCK_MSG_MAX; i++) {

I wonder an array without sentinel at the end with ARRAY_SIZE() may
be a leaner way to do these, especially as this is all limited to
this single file.

> +		const char *key = msg_id_info[i].id_string;
> +		/* match id_string case-insensitively, without underscores. */
> +		for (j = 0; j < len; j++) {
> +			char c = *(key++);
> +			if (c == '_')
> +				c = *(key++);

s/if/while/ perhaps?

> +			if (toupper(text[j]) != c)

I know the performance would not matter very much but calling
toupper() for each letter in the user input FSCK_MSG_MAX times
sounds rather inefficient.

Would it make sense to make the caller upcase instead (or upcase
upfront in the function)?

> +				break;
> +		}
> +		if (j == len && !*key)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
>  static int fsck_msg_type(enum fsck_msg_id msg_id,
>  	struct fsck_options *options)
>  {
