From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Tue, 12 Jul 2011 11:53:02 -0500
Message-ID: <20110712165302.GA13578@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 18:53:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QggD3-0007Q4-Oo
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 18:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754095Ab1GLQxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 12:53:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34230 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab1GLQxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 12:53:16 -0400
Received: by gwaa18 with SMTP id a18so2009440gwa.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nsXnfV1y7Y83zn1i3BxDhatslSfqGQHNVjJMfyfFEv8=;
        b=oIV1Km086HBtuj4tQ9nq7BI/CX/KXLriHbBwnHf+ZQDZwh2emPoKsS/jeun9TgVReg
         ZU1uwqmEgtrQsAVkSlNm+M9SShsNDaGOqtqDMWadsdhemRBelKdOJaDZdKayuIpmYe6m
         GIEiPyPzJP/M5j+jUvdiGatm1WUck6vgXQcxY=
Received: by 10.101.164.38 with SMTP id r38mr148327ano.106.1310489595483;
        Tue, 12 Jul 2011 09:53:15 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id m32sm8470374ano.7.2011.07.12.09.53.12
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 09:53:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-3-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176949>

Hi,

Ramkumar Ramachandra wrote:

> The add_message_to_msg function is poorly implemented, has an unclear
> API, and only one callsite.  Replace the callsite with a cleaner
> implementation.  Additionally, fix a bug introduced in 9509af6 (Make
> git-revert & git-cherry-pick a builtin, 2007-03-01) -- a NULL pointer
> was being incremented when "\n\n" was not found in "message".

Rather than being an optimization, the main impact of this change is
to avoid a NULL pointer dereference in some cases, right?

If so, the subject line should say so.  Is it possible to reproduce
this?  Could we add a test to avoid regressing in the future?

Less importantly:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
[...]
> @@ -462,11 +449,16 @@ static int do_pick_commit(void)
>  		}
>  		strbuf_addstr(&msgbuf, ".\n");
>  	} else {
> +		const char *p = strstr(msg.message, "\n\n");
> +
>  		base = parent;
>  		base_label = msg.parent_label;
>  		next = commit;
>  		next_label = msg.label;
> -		add_message_to_msg(&msgbuf, msg.message);
> +
> +		p = p ? p + 2 : sha1_to_hex(commit->object.sha1);
> +		strbuf_addstr(&msgbuf, p);

I think this would be clearer like so:

		const char *p;
		...
		p = strstr(...);
		if (p)
			p += 2;
		else
			p = sha1_to_hex...
		strbuf_addstr(&msgbuf, p);

i.e., putting all the code that manipulates p together.  Besides,
pre-C99 compilers don't like "p" to be initialized to a non-constant.
:)

At [1], I also see a suggestion of a comment that could clarify the
code a little.

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/176139/focus=176183
