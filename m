From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] revert: Use assert to catch inherent program bugs
Date: Fri, 20 May 2011 13:35:13 -0500
Message-ID: <20110520183513.GE17177@elie>
References: <20110520071609.GA6755@domU-12-31-39-06-A8-0A.compute-1.internal>
 <1305880223-7542-1-git-send-email-artagnon@gmail.com>
 <1305880223-7542-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:35:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNUXo-0000dh-46
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935237Ab1ETSfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 14:35:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61651 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934869Ab1ETSfS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 14:35:18 -0400
Received: by iyb14 with SMTP id 14so3147054iyb.19
        for <git@vger.kernel.org>; Fri, 20 May 2011 11:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Fogy+FhQx9Xkx/yugxkuE+i0uMaRSWjmt9PTmb5SSvQ=;
        b=rk4T/G/EV80+Z3eqhD2ZqYviIugXqKg5cUIPns4bvPnZYtWp2XO6OmxGfPCLD3XfeT
         YAQORpX5Lf4JWhC1Itt6MQok5vvOmcXT0fK0QAtmqiLSYek8cIi+am6tJhNOEXFWrIbY
         oCD3M7YcPdg7kA3M4Ir/EoGcMaEvvNNwLElpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xIF2q+2f16MAqHpNG1vI8yL+IXe9rfoZLH27hXLdHYqs7zPn/5lL+Yje9LS5gHevwR
         HYs2j+vCZK4WxHJ3hr/XShUrjnkWQDA69RR/piC1cNSb7SfKpVjlVIGS3/2moD+mrfKa
         GvOxxt4Bbu4gXJtAlY767QwIPlwmjFisHikbw=
Received: by 10.42.161.129 with SMTP id t1mr5550815icx.123.1305916517912;
        Fri, 20 May 2011 11:35:17 -0700 (PDT)
Received: from elie (adsl-69-209-78-180.dsl.chcgil.sbcglobal.net [69.209.78.180])
        by mx.google.com with ESMTPS id 10sm1630948ibc.11.2011.05.20.11.35.15
        (version=SSLv3 cipher=OTHER);
        Fri, 20 May 2011 11:35:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1305880223-7542-2-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174073>

Ramkumar Ramachandra wrote:

> This situation is hence treated as an inherent bug in
> the program, rather than a runtime error.

Well, programming errors can be run-time errors, too. :)  But anyway,
it is not obvious at a glance to me that this assertion would always
hold, which makes it a bad candidate for an assert().

"Wait a second," you might say.  "You said in a previous message that
the check in get_encoding() could be an assert() or die("BUG: ...") to
avoid having to remember the commit id for use in the error message."

And that's still true:

> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -123,8 +123,7 @@ static int get_message(const char *raw_message, struct commit_message *out)
>  	int abbrev_len, subject_len;
>  	char *q;
>  
> -	if (!raw_message)
> -		return -1;
> +	assert(raw_message);
>  	encoding = get_encoding(raw_message);

get_encoding() only gets called after the check here, so in the
existing code, the raw_message parameter to get_encoding() can never
be NULL.

By contrast, get_message() gets called by do_pick_commit() and passed
a buffer that is populated long before then.  Can it ever be NULL?  I
don't know, so the check is certainly doing something useful for my
peace of mind.

> @@ -444,9 +441,7 @@ static int do_pick_commit(void)
>  		die(_("%s: cannot parse parent commit %s"),
>  		    me, sha1_to_hex(parent->object.sha1));
>  
> -	if (get_message(commit->buffer, &msg) != 0)
> -		die(_("Cannot get commit message for %s"),
> -				sha1_to_hex(commit->object.sha1));
> +	get_message(commit->buffer, &msg);

Forgetting what's mentioned above, this change would be a regression.
What if get_message() learns to return error() for some other reason?
It is only safe to call a function like this if deliberately ignoring
errors (in which case a comment might be helpful for explaining why to
ignore the errors) or if the function returns "void".
