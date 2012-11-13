From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Tue, 13 Nov 2012 01:54:59 +0100
Message-ID: <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
	<20121112233546.GG10531@sigill.intra.peff.net>
	<CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
	<20121113000217.GH10531@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:55:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4mc-0005QZ-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:55:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab2KMAzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:55:01 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:65080 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab2KMAzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:55:00 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6903339oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 16:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XHUPtFs0IA1KwHUte8GblSiVNb/mIIoX3/bnn2mBy5I=;
        b=LGufEQHLI4XmGKV/UQ8x7R2X7cL3F2JQE322TBwMUg8vJCFyFLaTeu+8az6gmb4KLg
         kd2kjEDjfAxH48QmkECcGsaGjYVz3LhLk2xKbjZroQuXAXld98VkkgrYRc/PY1VRItB0
         hwA1o6VUHwPg+AomJ8DlIAsjIHzEPHViwAriB2WT3TJMDJNVNPjzwBzkt7D9VhIU8cwP
         v/rht/8I1C8l1fPCMK1/e2nbtwB5R25cWYfkznsZJU6LoRpMMqCaPzYzHB2PMFUf7zR0
         FLg1jGGZwFik4i3yxKJpHeIjiE/TbcRy+zjwFd2ctyX9TnpgEopEj+v374LcY6fsUeDa
         ooFg==
Received: by 10.182.116.6 with SMTP id js6mr16517138obb.82.1352768099584; Mon,
 12 Nov 2012 16:54:59 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 16:54:59 -0800 (PST)
In-Reply-To: <20121113000217.GH10531@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209555>

On Tue, Nov 13, 2012 at 1:02 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 12:42:02AM +0100, Felipe Contreras wrote:
>
>> > Why not use Git::ident_person() here? It saves some code, and would also
>> > respect environment variables. Or better yet...
>>
>> I assume there was a reason why that code was asking for input;
>> precisely because it would use the environment variables. For some
>> reason the user might have exported GIT_AUTHOR_EMAIL, or maybe EMAIL
>> is not right, or the full name config.
>>
>> OTOH user.name/.email configurations come clearly from the user.
>
> But we use the environment to default the field, so the distinction
> doesn't make much sense to me.  Plus, it has always been the case that
> you can use git without setting user.*, but instead only using the
> environment. I don't see any reason not to follow that principle here,
> too.

And that's why a lot of commits end up like michael
<michael@michael-laptop.(none)>.

> The one distinction that would make sense to me is pausing to ask when
> we use "implicit" methods to look up the ident, like concatenating the
> username with the hostname to get the email.
>
> Git::ident uses "git var" to do its lookup, which will use IDENT_STRICT;
> that stops most junk like empty names and bogus domains. But I think we
> would want to go one step further and actually check
> user_ident_sufficiently_given.  Unfortunately, that is not currently
> available outside of C. You'd probably want something like:
>
> diff --git a/builtin/var.c b/builtin/var.c
> index aedbb53..eaf324e 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -26,6 +26,12 @@ static const char *pager(int flag)
>         return pgm;
>  }
>
> +static const char *explicit_ident(int flag)
> +{
> +       git_committer_info(flag);
> +       return user_ident_sufficiently_given() ? "1" : "0";
> +}
> +
>  struct git_var {
>         const char *name;
>         const char *(*read)(int);
> @@ -35,6 +41,7 @@ static struct git_var git_vars[] = {
>         { "GIT_AUTHOR_IDENT",   git_author_info },
>         { "GIT_EDITOR", editor },
>         { "GIT_PAGER", pager },
> +       { "GIT_EXPLICIT_IDENT", explicit_ident },
>         { "", NULL },
>  };

Probably. But what I really want is to stop 'git send-email' from
asking. I think the one next step further can be done later.

-- 
Felipe Contreras
