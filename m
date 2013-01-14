From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] imap-send.c: remove some unused fields from struct
 store
Date: Sun, 13 Jan 2013 22:19:20 -0800
Message-ID: <20130114061920.GE3125@elie.Belkin>
References: <1358141566-26081-1-git-send-email-mhagger@alum.mit.edu>
 <1358141566-26081-7-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:19:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TudOd-0005Sx-T5
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230Ab3ANGT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:19:27 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:48669 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab3ANGT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:19:27 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so1677358dal.1
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sJkjejGl/hfSWZzUxKWvNNfttt3DbXObzaupcJEIgxc=;
        b=mgqJS/LuVap7TA+0SwkPPwBiSlAvXsqm00TErmKiNHoVhvhkjZ+FvrtkURfQD4cpQU
         MeKyma8ALeuyFGg87MivwvegA8DQwjoL5fURZPXPX5dyP9iLSy205D9CsrOkjo/2QOwv
         5tLd/7H5Kl6SEWMWcY2LVGB8t80NAcgE46Nhd+YOK8+cG4BojQFG+V72kJOtGcx9xjox
         1Bkr4A97Y/Pt7qVjdKLnBUIjRCdHqol08RgqbTfgwlo36SdIodb80fZQkH6kNG3lNJqS
         MDKa6oDPaHbqO7HtDZfaiX06YAwlvHPGbmMNF+rRE1ud4DwTvKrbeNB+xLDPWrIJOJ0p
         kkug==
X-Received: by 10.66.9.2 with SMTP id v2mr228760040paa.18.1358144366469;
        Sun, 13 Jan 2013 22:19:26 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ov4sm7621683pbb.45.2013.01.13.22.19.23
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:19:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1358141566-26081-7-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213451>

Michael Haggerty wrote:

> --- a/imap-send.c
> +++ b/imap-send.c
[...]
> @@ -772,13 +767,10 @@ static int get_cmd_result(struct imap_store *ctx, struct imap_cmd *tcmd)
>  				   !strcmp("NO", arg) || !strcmp("BYE", arg)) {
>  				if ((resp = parse_response_code(ctx, NULL, cmd)) != RESP_OK)
>  					return resp;
> -			} else if (!strcmp("CAPABILITY", arg))
> +			} else if (!strcmp("CAPABILITY", arg)) {
>  				parse_capability(imap, cmd);
> -			else if ((arg1 = next_arg(&cmd))) {
> -				if (!strcmp("EXISTS", arg1))
> -					ctx->gen.count = atoi(arg);
> -				else if (!strcmp("RECENT", arg1))
> -					ctx->gen.recent = atoi(arg);
> +			} else if ((arg1 = next_arg(&cmd))) {
> +				/* unused */

Neat.  Let me try to understand what was going on here:

When opening a mailbox with the SELECT command, an IMAP server
responds with tagged data indicating how many messages exist and how
many are marked Recent.  But git imap-send never reads mailboxes and
in particular never uses the SELECT command, so there is no need for
us to parse or record such responses.

Out of paranoia we are keeping the parsing for now, but the parsed
response is unused, hence the comment above.

If I've understood correctly so far (a big assumption), I still am not
sure what it would mean if we hit this ((arg1 = next_arg(&cmd))) case.
Does it mean:

 A. The server has gone haywire and given a tagged response where
    one is not allowed, but let's tolerate it because we always have
    done so?  Or

 B. This is a perfectly normal response to some of the commands we
    send, and we have always been deliberately ignoring it because it
    is not important for what imap-send does?

Curious,
Jonathan
