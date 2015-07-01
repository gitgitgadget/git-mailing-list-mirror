From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 3/4] status: give more information during rebase -i
Date: Wed, 1 Jul 2015 12:33:03 -0400
Message-ID: <CAPig+cSXzN84C4tOi5oZaK_1UJGcNXywE_-V7CyDQUMXox1Acw@mail.gmail.com>
References: <vpq7fqkz48f.fsf@anie.imag.fr>
	<1435739433-18853-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435739433-18853-3-git-send-email-Matthieu.Moy@imag.fr>
	<xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 18:33:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAKwh-0004rs-0s
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 18:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbbGAQdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 12:33:05 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33339 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbbGAQdE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 12:33:04 -0400
Received: by ykdv136 with SMTP id v136so44028097ykd.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 09:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QW1ztoNOnYWSdkqyqGaYg+bUiEd0rC5pttx21n9cflw=;
        b=SzEOyQsRfw3zymN1RgUQnRST4EmsQJcYXPJbppq8tDkPfWOvskhUNH/op9qDNzC80s
         kBbUAmEFylRasNo/WnGAMrEqdLsl4BnJfrROmif+591HbEsjG0ebSlP+8/+RFuSMi306
         7Cv9CT/c7K1mRves/szsU2f19llI75ka7KlcQi/3hZrojahMjuPr7z4mxCEwWxAlSYoF
         Cgl/ZkGjHkA6zGmAjSkzZRSkfQypOG1pIIPm5aAegvi9czMJFTfsulSlYYxGgDoskO81
         7l64E4IbFyOa97avbFldo9Kvo+BIOsQOhj1G3QcEZrK1HHYZBy5kTNXjy6QFJYAa/nex
         bqWQ==
X-Received: by 10.129.70.69 with SMTP id t66mr19456951ywa.4.1435768383912;
 Wed, 01 Jul 2015 09:33:03 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 09:33:03 -0700 (PDT)
In-Reply-To: <xmqq4mlnc0lr.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: gKNuUY5vWasnBga_2U0lguiocSM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273159>

On Wed, Jul 1, 2015 at 12:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>> +/*
>> + * Turn
>> + * pick d6a2f0303e897ec257dd0e0a39a5ccb709bc2047 some message
>> + * into
>> + * pick d6a2f03 some message
>> + */
>> +static void abbrev_sha1_in_line(struct strbuf *line)
>> +{
>> +     struct strbuf **split;
>> +     int i;
>> +
>> +     if (starts_with(line->buf, "exec ") ||
>> +         starts_with(line->buf, "x "))
>> +             return;
>> +
>> +     split = strbuf_split_max(line, ' ', 3);
>> +     if (split[0] && split[1]) {
>> +             unsigned char sha1[20];
>> +             const char *abbrev;
>> +
>> +             /*
>> +              * strbuf_split_max left a space. Trim it and re-add
>> +              * it after abbreviation.
>> +              */
>> +             strbuf_trim(split[1]);
>> +             if (!get_sha1(split[1]->buf, sha1)) {
>> +                     abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
>> +                     strbuf_reset(split[1]);
>> +                     strbuf_addf(split[1], "%s ", abbrev);
>> +             }
>
> ... else?
>
> That is, "we thought there would be a full SHA-1, but it turns out
> that there wasn't, so we keep split[1] as-is" would need to add the
> space back, no?

I was about to mention the same shortcoming, but you beat me to it.

> Perhaps be more strict and do this instead (without
> leading strbuf_trim):
>
>         if (!get_sha1_hex(split[1]->buf, sha1) &&
>             !strcmp(split[1]->buf + 40, " ") {
>                 replace split[1] with "%s " abbrev
>         }

Isn't it dangerous to assume that you can index 40 characters into
split[1]? If (for some reason), the user botched the todo line such
that the SHA1 is no longer a valid hex string, then split[1] will be
that botched string, which might be shorter than 40 characters. For
instance, if the user-edited todo line is:

    pick oops nothing

then git-rebase--interactive.sh:transform_todo_ids() will leave "oops"
as-is, since it can't unabbreviate it, and then this code will place
"oops" into split[1].
