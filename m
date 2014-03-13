From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] install_branch_config: simplify verbose messages logic
Date: Thu, 13 Mar 2014 16:35:31 -0400
Message-ID: <CAPig+cQU5__EPA2C3QvCPAT4od3Ux8kCgq-2H8nCddGdNqaG0A@mail.gmail.com>
References: <1394584412-7735-1-git-send-email-pawlo@aleg.pl>
	<CAPig+cTmdF06PrWboJFNFEGKLCa=3rmGrcPusSsYZxdtfSEewA@mail.gmail.com>
	<xmqqr466hrru.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?UTF-8?Q?Pawe=C5=82_Wawruch?= <pawlo@aleg.pl>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 21:35:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOCLp-0005B2-9t
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 21:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754994AbaCMUfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 16:35:33 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:57055 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbaCMUfc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 16:35:32 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so4158862ykt.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CBejCyNs/lcBFU/QxWaDrGjTPDeLD4ZXVgpWs4+lWXo=;
        b=pfgaA2NM+R6P/5nvS/FNX28qgekP/+T6C2VVpZLwByRx76xtcka6BC0OzaqpoifXSB
         CpaxoXloLcTxyu+KK5sPEbGb8sSGAjf4ZgzXztD64dpVx/b7038+rdd8L/71sVXViIUs
         gffIJ0vehOGDYoTn5fEUSBD/V5nl72kEawurLv1p7e+w7OiF2mdWSQsITv84RBwQDdiR
         AFABicDqU32Dx11kF+6UC0mSXnmmoh5IMfSX20fND19DEIACnKCIyzntBTGx6UYW0Pq+
         AUmUKhjhyiPVCsNpPoG6WfSZ5JA6p95RFhDkL2QaA8ihlVDRWCEaDGQA2S/JCq4OsQh8
         o3wg==
X-Received: by 10.236.17.195 with SMTP id j43mr4934894yhj.121.1394742931863;
 Thu, 13 Mar 2014 13:35:31 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Thu, 13 Mar 2014 13:35:31 -0700 (PDT)
In-Reply-To: <xmqqr466hrru.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: GdGw7NwnzS0av3AwL8FEC3ZwOF8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244050>

On Thu, Mar 13, 2014 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Shouldn't this logic [to decide what the printf arguments should
>> be] also be encoded in the table?
>> ...
>> The same argument also applies to computation of the 'name' variable
>> above. It too can be pushed into the the table.
>
> Because the "printf argument" logic does not have to be in the
> table, the same argument does not apply to the 'name' thing.
>
> After looking at the v5 patch, I do not think an extra two-element
> array to switch between remote vs shortname is making it any easier
> to read.  I would have to say that personally I find that
>
>         const char *name[] = {remote, shortname};
>         ... long swath of code ...
>         printf_ln(... name[!remote_is_branch] ...);
>
> is a lot harder to read than:
>
>         printf_ln(... remote_is_branch ? shortname : branch ...);

Indeed, that's a step backward, and is not what was asked. Merely
pushing data into tables does not make the logic table-driven
(emphasis on *driven*). The GSoC microproject did not demand a
table-driven approach, but instead asked students if such an approach
would make sense. A more table-driven approach might look something
like this:

    struct M { const char *s; const char **a1; const char **a2; }
    message[][2][2] = {{{
        { "Branch %s set ... %s ... %s", &shortname, &origin },
        ...
    }},{{
        { "Branch %s set ... %s", &remote, NULL },
        ...
    }}};

    const struct M *m = message[!remote_is_branch][!origin][!rebasing];
    printf_ln(m->s, local, *m->a1, *m->a2);

Whether this approach is more clear than the original code is a matter
for debate [1], however, it's obvious from the table which arguments
belong with each message, and the printf_ln() invocation does not
require any logic. When moving only messages into a table, they become
disconnected from their arguments which makes reasoning about them a
bit more difficult. The original code does not have this problem, nor
does a table-driven approach.

[1]: While ungainly, the original code may not be sufficiently bad to
warrant the extra complications of a table. A simple refactoring, such
as [2], can make the code a bit easier to read without adding
complexity.

[2]: http://thread.gmane.org/gmane.comp.version-control.git/243704
