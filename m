From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] builtin: add git-check-mailmap command
Date: Thu, 11 Jul 2013 23:28:09 -0400
Message-ID: <CAPig+cQvnKSxZ5M6zW_r6Y9xwZ0Ch99JDq4SccYXCRof9svsOg@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-2-git-send-email-sunshine@sunshineco.com>
	<7vli5crk8l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 05:28:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxU1o-00053b-6Z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 05:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756543Ab3GLD2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 23:28:12 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:49968 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756505Ab3GLD2L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 23:28:11 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so7229420lab.25
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=fHCXJ/IDIDF6eZ2vwTv24QG4Pt8MfqcqyGcR3/td7lo=;
        b=EyWmJam3SscQ3jt1YLBzAdpPiJFoun6QTTFOoPdh2WmEyTVVtJs28GEMs6ZFu3VGIX
         Dmqxhk/2pMSNJAlWBskFQQM86HnfxQWRa8J8N46NklLcmjeotSkEDZh59CK6lCtfgEDu
         WcRFlt7U6yCUqgKJhPX2tnhtTZBcohXNMct7wNXHotZ5T0lEn65P3EafX1zlgAcfriAE
         r95jkYkRqjWOen1uQGAG7xKiav7JQ/TJAiryMeWaaomHg+Q5IvoM1YgrjOei+Q/nqT3/
         pQgn3NyG406mz4FtnYg4bx9s4sjHDe1J9pe0m9t0JeNnnPX+z4ViaAkgFm+E4c1YRglD
         WvFg==
X-Received: by 10.152.4.65 with SMTP id i1mr18568965lai.21.1373599689175; Thu,
 11 Jul 2013 20:28:09 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 20:28:09 -0700 (PDT)
In-Reply-To: <7vli5crk8l.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: N4CttY6KpB_-D07Pw3VxPPPVLF8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230158>

On Thu, Jul 11, 2013 at 3:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> +DESCRIPTION
>> +-----------
>> +
>> +For each ``Name $$<email@address>$$'' or ``$$<email@address>$$'' provided on
>> +the command-line or standard input (when using `--stdin`), prints a line with
>> +the canonical contact information for that person according to the 'mailmap'
>> +(see "Mapping Authors" below). If no mapping exists for the person, echoes the
>> +provided contact information.
>
> OK.  The last part needed a reading and a half for me to realize the
> "echoes the provided contact information" is the same thing as "the
> "input string is printed as-is", especially because "contact
> information" is not defined anywhere in the previous part of the
> DESCRIPTION section, though.  I might be worth starting the
> paragraph with:
>
>         For each contact information (either in the form of ``Name
>         <user@host>'' or ...)
>
> in order to clarify that the two forms of input is what you call
> "contact information".

Is this easier to read?

    For each ``Name $$<user@host>$$'' or ``$$<user@host>$$'' from the
    command-line or standard input (when using `--stdin`), print a line
    showing either the canonical name and email address (see "Mapping
    Authors" below), or the input ``Name $$<user@host>$$'' or
    ``$$<user@host>$$'' if there is no mapping for that person.

>> diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
>> new file mode 100644
>> index 0000000..c36a61c
>> --- /dev/null
>> +++ b/builtin/check-mailmap.c
>> @@ -0,0 +1,69 @@
>> +#include "builtin.h"
>> +#include "mailmap.h"
>> +#include "parse-options.h"
>> +#include "string-list.h"
>> +
>> +static int use_stdin;
>> +static int null_out;
>
> Is there a reason why the variable name should not match that of the
> corresponding variables in check-ignore and check-attr, which you
> copied the bulk of the code from?
>
> If there isn't, use "null_term_line" like they do.

In check-attr, null_term_line indicates that _input_ lines are
null-terminated. In check-ignore, null_term_lines is overloaded (and
perhaps abused) to mean that both _input_ and _output_ lines are
null-terminated. In check-mailmap, -z affects only _output_ lines. A
reader of the code can easily be misled into thinking that the
variable controls the same function in all three programs, hence
null_out was chosen to make it clear that it applies only to output. A
lesser reason is that, in the future, someone might add an option to
null terminate input lines (distinct from output), and null_in would
be a reasonable name for that variable.

Other than the above reasoning, I don't feel strongly about it and can
revert the name if you prefer.

>> +static void check_mailmap(struct string_list *mailmap, const char *contact)
>> +{
>> +     const char *name, *mail;
>> +     size_t namelen, maillen;
>> +     struct ident_split ident;
>> +     char term = null_out ? '\0' : '\n';
>
> Is there a reason why the variable name "term" should not match that
> of the corresponding variables in check-ignore and check-attr, which
> you copied the bulk of the code from?
>
> If there isn't, use "line_termination" like they do.

No strong justification. As with 'buf' vs. 'buffer',
'line_termination' required more reading effort without conveying any
more information than 'term'.

>> +     if (split_ident_line(&ident, contact, strlen(contact)))
>> +             die(_("unable to parse contact: %s"), contact);
>> +
>> +     name = ident.name_begin;
>> +     namelen = ident.name_end - ident.name_begin;
>> +     mail = ident.mail_begin;
>> +     maillen = ident.mail_end - ident.mail_begin;
>> +
>> +     map_user(mailmap, &mail, &maillen, &name, &namelen);
>> +
>> +     if (namelen)
>> +             printf("%.*s ", (int)namelen, name);
>> +     printf("<%.*s>%c", (int)maillen, mail, term);
>> +}
>> +
>> +int cmd_check_mailmap(int argc, const char **argv, const char *prefix)
>> +{
>> +     int i;
>> +     struct string_list mailmap = STRING_LIST_INIT_NODUP;
>> +
>> +     git_config(git_default_config, NULL);
>> +     argc = parse_options(argc, argv, prefix, check_mailmap_options,
>> +             check_mailmap_usage, 0);
>
> It is a bit distracting that the second line that is not indented
> enough.  Either (1) with enough HT and with minimum number of SP,
> align "argc" and "check_mailmap_usage", or (2) with minimum number
> of HT and no SP, push "check_mailmap_usage" to the right of opening
> parenthesis of "(argc".  Our code tend to prefer (1).

Okay.
