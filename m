From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 07/11] sequencer.c: teach append_signoff how to detect
 duplicate s-o-b
Date: Sun, 27 Jan 2013 19:14:24 -0800
Message-ID: <20130128031424.GK8206@elie.Belkin>
References: <1359335515-13818-1-git-send-email-drafnel@gmail.com>
 <1359335515-13818-8-git-send-email-drafnel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com,
	Brandon Casey <bcasey@nvidia.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 04:14:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzfBN-0006xk-4V
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 04:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753000Ab3A1DOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 22:14:32 -0500
Received: from mail-da0-f51.google.com ([209.85.210.51]:38326 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380Ab3A1DOa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 22:14:30 -0500
Received: by mail-da0-f51.google.com with SMTP id i30so1023504dad.24
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 19:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1mZskCtdzuk9/3mVwjDdJUBgZnlAmWLACywN9etWlVo=;
        b=E8qJuu+rsSOAcLeVc5A+qudXZOUciWCkdwIjbk1B4r/1VHaVioC+R+YwbLzj4FHKh9
         dfX546n81wHA9u5xM/ZlR0nL8qR2F56mSSc82Ka1KsyK3H30DZitjzkcyo36tkouKkty
         1DfqersD7zgqncUd8v+gq/iLtMdqg6zSXFwAIrKj/2mTTmxzZ1Vu+nkdaIpKGU6A7L8i
         z+xnfPzRJkfzPb0B91SGlqDmFrKzh0rr5CfYlWl2iS04Ho8NURjZwclphuO0FWlxIK+F
         JLwwjwe+AIVygcSkPGLSEwEUqIiZTVAtCIdpHodrv72Ns75uZ4+xoi/e7FXs2ldRJHrb
         uvuw==
X-Received: by 10.66.9.2 with SMTP id v2mr32637467paa.18.1359342870320;
        Sun, 27 Jan 2013 19:14:30 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id pw10sm99541pbb.28.2013.01.27.19.14.28
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 27 Jan 2013 19:14:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359335515-13818-8-git-send-email-drafnel@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214795>

Brandon Casey wrote:

> --- a/sequencer.c
> +++ b/sequencer.c
[...]
> @@ -1096,10 +1117,16 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer)
>  	strbuf_addch(&sob, '\n');
>  	for (i = msgbuf->len - 1 - ignore_footer; i > 0 && msgbuf->buf[i - 1] != '\n'; i--)
>  		; /* do nothing */
> -	if (prefixcmp(msgbuf->buf + i, sob.buf)) {
> -		if (!i || !has_conforming_footer(msgbuf, ignore_footer))
> -			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, "\n", 1);
> -		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0, sob.buf, sob.len);
> -	}
> +
> +	if (i)
> +		has_footer = has_conforming_footer(msgbuf, &sob, ignore_footer);

Is this "if (i)" test needed?  I'd expect that if the message has no newlines,
has_conforming_footer() would notice that and return 0.
