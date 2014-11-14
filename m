From: Alex Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH 1/1] git-config: git-config --list fixed when GIT_CONFIG value starts with ~/
Date: Sat, 15 Nov 2014 01:38:36 +0600
Message-ID: <87vbmh8syq.fsf@gmail.com>
References: <1415989760-20259-1-git-send-email-kuleshovmail@gmail.com> <CAPig+cTpUyfKYj4VTK1AT-ga6UvupJrERsTHWTEzNP-Ogc4ujQ@mail.gmail.com> <20141114193049.GB10860@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	0xAX <kuleshovmail@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:47:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpMqV-0003q4-GG
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 20:47:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161455AbaKNTrr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 14:47:47 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:42436 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaKNTrr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 14:47:47 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so13581071lbv.12
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=references:from:to:cc:subject:date:in-reply-to:message-id
         :mime-version:content-type;
        bh=VkfS5VCRiz+fVoTfO6D8knYzaIzEHXnOS0lykRd/Ml8=;
        b=tQ/gjuJJmZDutEU1Ye0w1Tv74c2FsO+d10p6X70FKMOcl8yc51e2R/zc5ePy0YMkro
         YlVRxAbT2J//Xv567B5myOk9eVaQOd+2VjGzsZuQ6h30JQHVYQI8MZglxVuV3P2RZWnZ
         Royc9Zvf/1qyvmwQ9bL26XriEHTf1b2H42XH6GohLqtbHCue9HE2u9tC1WnTCi+E26rR
         4x4kRcB3nvQSfwIAsJQTFnjh3Iveu/ZEUBshyA/ALKkP7J2OPVxYsBsKzVKm+XUF4imd
         EiH6TXuG+uC2cjHfrNdUqxxSrEgqU7q8aWk5BQOp/4p0vNb3tG16w/+emGUk1sTydXEi
         RwRA==
X-Received: by 10.112.132.34 with SMTP id or2mr4251645lbb.75.1415994465351;
        Fri, 14 Nov 2014 11:47:45 -0800 (PST)
Received: from alex-desktop ([2.133.4.138])
        by mx.google.com with ESMTPSA id lu5sm7251329lac.0.2014.11.14.11.47.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 11:47:44 -0800 (PST)
In-reply-to: <20141114193049.GB10860@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hello Eric and Jeff,

>Eric Sunshine
>A few issues:
>
>(1) Style: s/char* /char */
>
>(2) Avoid declaration (of 'newpath') after statement.
>
>(3) You can drop 'newpath' altogether and just assign the result of
>expand_user_path() directly to given_config_source.file.
>
>This code is potentially leaking the old value of
>given_config_source.file, and (later) the new value, however, as
>given_config_source.file is already being leaked elsewhere, it
>probably does not make the situation much worse.

It is my first patch to git's code base, so many thanks for your
feedback, i'll fix these issues if there will be need in this patch.

>Jeff King <peff@peff.net>
>
> Yeah, I'd agree it is a little unexpected to expand here. The "~" is
> mostly a shell thing, and doing:
>
>   GIT_CONFIG=~/.gitconfig git config --list
>
> from the shell generally works, because the shell will expand the "~"
> before it even hits git. If you're not using a shell to set the
> variable, you probably should be pre-expanding it yourself.

Yes, you're right here, but i put GIT_CONFIG=~/.gitconfig to my .bashrc
and it doesn't work so.

>
> Note that this code path affects "git config --file=~/.gitconfig", too.
> At least there it would be a little bit useful because the shell will
> not expand for you, but it still feels a bit unconventional to me.
>
>> >  builtin/config.c | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/builtin/config.c b/builtin/config.c
>> > index 7bba516..df1bee0 100644
>> > --- a/builtin/config.c
>> > +++ b/builtin/config.c
>> > @@ -540,6 +540,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>> >
>> >         if (actions == ACTION_LIST) {
>> >                 check_argc(argc, 0, 0);
>> > +               const char* newpath = expand_user_path(given_config_source.file);
>> > +               given_config_source.file = newpath;
>
> If we _were_ going to do such an expansion, this is absolutely the wrong
> place for it. It works only for the "--list" action; if we are going to
> expand it, we would want to do so everywhere. And we do not even know if
> given_config_source.file is non-NULL here (we could be reading from
> stdin, or a blob). Fortunately expand_user_path will pass through a NULL
> without segfaulting.
>
> Probably the right place would be the if/else chain around
> builtin/config.c:514, where we convert a relative path into an absolute
> one. But I'm not convinced it's a good thing to be doing in the first
> place.
>
> -Peff

What if we'll put path expanding right after getting value of file path,
after given_config_source.file = getenv(CONFIG_ENVIRONMENT); at 451?

Thank you.

--
Best regards.
0xAX
