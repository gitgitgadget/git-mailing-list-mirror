From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship with git-mailinfo
Date: Fri, 26 Jun 2015 13:41:57 -0700
Message-ID: <xmqqbng2td62.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<72c470f3a6890dfcb66f1439383d2278@www.dscho.org>
	<CACRoPnSyu6or8nkMQ0yS_KcLwumJVNv3pfSFGcSDyk4-P_VZ_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 22:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8aRy-0007Yj-68
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 22:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbbFZUmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 16:42:10 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35204 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040AbbFZUmD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 16:42:03 -0400
Received: by iebrt9 with SMTP id rt9so83133266ieb.2
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=gNS+BIClWbXciFXpMWrt4ssoaPovRm7xOYW9R69A8hw=;
        b=koARF1fZsPlrf5vRMjOrjGYVUhtp+vVXHDk96gzbQAXBOwoBAoKjAvQFWqZgVAaC8R
         2AzOrddlAsSp77OS182owa6Byyf5M+JImtlxKI0+qWH21EULjoje8jCF3T22bG/KzWXS
         csdGmtma1QZQEG51XeLCQGG8G3vWj8MwJIb3tkigL/053+k7jQzZWbepi63E2pS6nTwh
         zYCQxmBPkmXcFHYiUJ+lTj5ZjGWD1832LspSd/quGPB7fvMCZhOQK3wugIpyXublhIzd
         jj7K8FobzTJQ7PFTFg7pNWxrIP34mI1XSd+qBVew9tuMjZChzOsI9wV6hcqjj3uHmmzU
         ojqQ==
X-Received: by 10.50.90.179 with SMTP id bx19mr5948904igb.43.1435351322720;
        Fri, 26 Jun 2015 13:42:02 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id z195sm22317878iod.33.2015.06.26.13.42.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 13:42:00 -0700 (PDT)
In-Reply-To: <CACRoPnSyu6or8nkMQ0yS_KcLwumJVNv3pfSFGcSDyk4-P_VZ_A@mail.gmail.com>
	(Paul Tan's message of "Fri, 26 Jun 2015 16:11:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272822>

Paul Tan <pyokagan@gmail.com> writes:

> OK, I'll try that out. Looks like this now:
>
> static char *read_shell_var(FILE *fp, const char *key)
> {
> ...
>     str = sq_dequote(sb.buf);
>     if (!str)
>         return NULL;

You are unlikely to get !str, but if it does, you leak sb here,
don't you?

>     return strbuf_detach(&sb, NULL);

This call is OK; if you passed the &length to detach, you're likely
to get a wrong result, though ;-)

sq_dequote() is one of the older parts of the API set and its "we
know it cannot do anything but shrink, so we'd do it in-place"
attitude, which may be vastly useful in practice, is now showing
some impedance mismatch with newer parts of the API like strbuf.

>>> +/**
>>> + * Saves state->author_name, state->author_email and state->author_date in
>>> + * `filename` as an "author script", which is the format used by git-am.sh.
>>> + */
>>> +static void write_author_script(const struct am_state *state)
>>> +{
>>> +     static const char fmt[] = "GIT_AUTHOR_NAME=%s\n"
>>> +             "GIT_AUTHOR_EMAIL=%s\n"
>>> +             "GIT_AUTHOR_DATE=%s\n";
>>> +     struct strbuf author_name = STRBUF_INIT;
>>> +     struct strbuf author_email = STRBUF_INIT;
>>> +     struct strbuf author_date = STRBUF_INIT;
>>> +
>>> +     sq_quote_buf(&author_name, state->author_name.buf);
>>> +     sq_quote_buf(&author_email, state->author_email.buf);
>>> +     sq_quote_buf(&author_date, state->author_date.buf);
>>
>> The `sq_quote_buf()` function does not call
>> strbuf_reset()`. Therefore you could just use a single strbuf to
>> construct the entire three lines and then write that out.

Yup.  "quote" appends to the output, so you could do this:

	add(&out, "GIT_AUTHOR_NAME=");
        quote(&out, state->author_name);
        add(&out, "\"\nGIT_AUTHOR_EMAIL=");
        quote(&out, state->author_email);
        ...

I am not sure if that is easier to read than what you have, though.

>> Again, if
>> you follow my suggestion to keep a "scratch pad" strbuf in am_state,
>> you could reuse that.

Don't do "scratch pad" in a structure that is passed around to
various people.  Somebody may be tempted to use the scratch pad
while he has the control, but as soon as he becomes complex enough
to require calling some helper functions, the ownership rules of the
scratch pad will become cumbersome to manage and understandable only
by the person who originally wrote the codepath.
