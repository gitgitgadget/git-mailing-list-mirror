From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 08/11] sequencer.c: teach append_signoff to avoid
 adding a duplicate newline
Date: Sun, 27 Jan 2013 19:23:02 -0800
Message-ID: <20130128032302.GL8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-9-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:23:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfJm-0002O7-3f
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab3A1DXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:23:10 -0500
Received: from mail-da0-f52.google.com ([209.85.210.52]:61604 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab3A1DXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:23:09 -0500
Received: by mail-da0-f52.google.com with SMTP id f10so1032386dak.39
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=PmzHjFlBxCwgfbNmkOrU4GrDevlNA0GpSvzLla6Nykg=;
        b=Jo7k7VvsqlwKnGjZEW0uUvY5fTKKmVtrwkMJ78gSp6P/KOQckDgjYPJBpedVR1S+JI
         FpcUsXwf16sUiDiV6wKnjZ9u98GTYRgyJLiREKe2DHBLR73XvCRQpxm0Kb74OjQIymBr
         GPlJWuHMSUMd9X6EemhxMblG63/WQWvF4ikqYCJljXVEpMkixhQpcNrKzWzqzdWlsXeJ
         XYuG8rBnWsvbdyJexeVDH6fJq9Tr+OkTRgslSgsX6yMetWDf3RLpgF0jWwyMb0J5A2mA
         TLDfGQS0uCfkBGDrPQb72XVms63e32/1x5BBcgD46IyYlS4ucx7Gs4pq6PG4f4RgBAGM
         NLmw==
X-Received: by 10.68.130.170 with SMTP id of10mr34064474pbb.131.1359343388836;
        Sun, 27 Jan 2013 19:23:08 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id c2sm5806415pay.34.2013.01.27.19.23.06
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:23:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-9-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214796>

Brandon Casey wrote:

> Teach append_signoff to detect whether a blank line exists at the position
> that the signed-off-by line will be added, and avoid adding an additional
> one if one already exists.  This is necessary to allow format-patch to add a
> s-o-b to a patch with no commit message without adding an extra newline.

I assume this means you're preserving historical behavior when adding
a sign-off to a commit with empty description (which is a good thing),
but what is that behavior?  Is it a deliberate choice or something
that developed by default?

[...]
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1118,11 +1118,15 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
>  	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
>  		; /* do nothing */
>  
> -	if (i)
> -		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);
> -
> -	if (!has_footer)
> -		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
> +	if (msgbuf->buf[i] != '\n') {
> +		if (i)
> +			has_footer = has_conforming_footer(msgbuf, &sob,
> +					ignore_footer);
> +
> +		if (!has_footer)
> +			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
> +					"\n", 1);
> +	}
>  
>  	if (has_footer != 3 && (!no_dup_sob || has_footer != 2))

This is too much nesting for my small mind to keep track of.  Am I
correct in imagining the effect is the same as the following?

	has_footer = has_conforming_footer(...)

	if (!has_footer && msgbuf->buf[i] != '\n')
		strbuf_splice(...);	/* add blank line */

	if (has_footer != 3 && ...
