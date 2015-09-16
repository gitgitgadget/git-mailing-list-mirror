From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Wed, 16 Sep 2015 12:52:26 -0700
Message-ID: <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154950.GG29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:52:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcIkr-0002g4-Jk
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753079AbbIPTw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:52:29 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33809 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746AbbIPTw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:52:28 -0400
Received: by padhy16 with SMTP id hy16so217828815pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rTdZpYEs49XNw8Yodo3E7yCd3Vvp0t8JAFJJ6aViBz8=;
        b=uwLkU5qLSECfCbMeWY3vCa639HSQ5O12WQJIt7jgYHnUAwQK5FDAVVl77M6vUwHb4N
         TGh7oqMb00SAtwMaDSE6OrLOXfCtDkAT298i2wNJoeLj68AQbeX8IL3dyIZkBmdx6IkT
         +VDJhXvdclsS4+hkM0Vvrvv/XD59lv+6csKchgwBkzwPBVMPw55Ulk1LYl3NR+1Ebsd/
         I8zw9Bli0BDlIe2AYqErXetrSE224d2q5q/qws0xCVx/jPkM0m50SS89YLil7HnCNFXi
         DvzQUOLWnBxvWhQHrL/RDdUaLjkO3IU8TiwNNZqVQoKbONaafXPmPhUGc5Yc4D1h+4TL
         b/fw==
X-Received: by 10.66.193.230 with SMTP id hr6mr63143060pac.39.1442433148498;
        Wed, 16 Sep 2015 12:52:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id g5sm27936796pat.21.2015.09.16.12.52.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 12:52:27 -0700 (PDT)
In-Reply-To: <20150915154950.GG29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:49:50 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278056>

Jeff King <peff@peff.net> writes:

> This code is exactly replicating strdup, so let's just use
> that. It's shorter, and eliminates some confusion (such as
> whether "p - s" is really enough to hold the result; it is,
> because we write NULs as we shrink "p").
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  remote.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 5ab0f7f..1b69751 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -297,7 +297,6 @@ static void read_branches_file(struct remote *remote)
>  	int n = 1000;
>  	FILE *f = fopen(git_path("branches/%.*s", n, remote->name), "r");
>  	char *s, *p;
> -	int len;

Hmm, we would punish those with ridiculously long remote name by
truncating at n but that is OK.

We use buffer[BUFSIZ] to read various things in this file, not just
$GIT_DIR/branches/* files, with fgets(), which may be better done if
we switched to strbuf_getline().  Then we can also use trim family
of calls from the strbuf API suite.

Move to strbuf_getline() may be a doubly attractive proposition,
with a possible change to strbuf_getline() to make it also remove CR
that immediately precedes LF [*1*], helping DOSsy platforms.


[Reference]

*1* http://thread.gmane.org/gmane.comp.version-control.msysgit/21773/focus=21780



>  
>  	if (!f)
>  		return;
> @@ -313,9 +312,7 @@ static void read_branches_file(struct remote *remote)
>  	p = s + strlen(s);
>  	while (isspace(p[-1]))
>  		*--p = 0;
> -	len = p - s;
> -	p = xmalloc(len + 1);
> -	strcpy(p, s);
> +	p = xstrdup(s);
>  
>  	/*
>  	 * The branches file would have URL and optionally
