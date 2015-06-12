From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-rebase--interactive.sh: add config option for custom instruction format
Date: Fri, 12 Jun 2015 15:05:10 -0700
Message-ID: <xmqqzj44bn1l.fsf@gitster.dls.corp.google.com>
References: <1434075808-43453-1-git-send-email-rappazzo@gmail.com>
	<1434075808-43453-2-git-send-email-rappazzo@gmail.com>
	<xmqqa8w4d4sc.fsf@gitster.dls.corp.google.com>
	<CANoM8SW-N6_yJ0kgGDuGWB+RS-0d54D4FtaRbKqhsf0_fSeMdw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3X4i-0003zT-P4
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 00:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbbFLWFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 18:05:13 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35805 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbFLWFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 18:05:12 -0400
Received: by igbzc4 with SMTP id zc4so20245383igb.0
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=plnpC/UkdnKbwHny/QbLsovpf+WPJ2SPVgqHU46F4Mg=;
        b=jOZ8srX0iY3E+wesoPUBjsVounkzDK+QqeI2AR2+frHJuI4ZeuiLRPz2/Pw1wTFJz5
         7CQHmSskQp2MkYrq0fJnCsVA+7tZLpFiRzZIJcU1cj/Jbkv7CDCh48iR4N3/lWsJXiUg
         T9em8C4kIIir40b7QFBGpte/3vFmSzx0kMXdpE61a3LCAok3DbflSXXmwUer9OK6j1US
         aUP78rB5ROh2R3z7ok2ewymGco+4ykhWyN9xrm6Jukw29P/YUqEP0/rEAMyH+wkWHd6V
         WO9QpMrbIUFrXm6FIBt6MzRmYLt4z38QRIXtllq222xIY8Q+t/qaCeUlFHlqBcaC4cVI
         dD8g==
X-Received: by 10.50.28.43 with SMTP id y11mr7191934igg.8.1434146711993;
        Fri, 12 Jun 2015 15:05:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a12d:7c00:b954:bc66])
        by mx.google.com with ESMTPSA id qs10sm2026979igb.14.2015.06.12.15.05.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Jun 2015 15:05:11 -0700 (PDT)
In-Reply-To: <CANoM8SW-N6_yJ0kgGDuGWB+RS-0d54D4FtaRbKqhsf0_fSeMdw@mail.gmail.com>
	(Mike Rappazzo's message of "Fri, 12 Jun 2015 17:12:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271533>

Mike Rappazzo <rappazzo@gmail.com> writes:

> On Fri, Jun 12, 2015 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> The autosquash part somehow makes me feel uneasy, though.  The
>> feature fundamentally has to have %s as the first thing in the
>> format to work, but by making the format overridable, you are
>> potentially breaking that feature, aren't you?
>
> It only needs the '%s' for the autosquash when the todo/instruction
> list order is determined.  For this, in the rearrange_squash function,
> it will re-calculate the message:
>
> +               test -z "${format}" || message=$(git log -n 1
> --format="%s" ${sha1})
>
> Additionally, it may also rerun the log command when preparing the final list.

Yeah, I noticed that when I took a diff between v3 and v4.  I didn't
mean by "break" that you may end up reorder lines incorrectly.

But because you overwrite the $message variable you read from the
original insn sheet (which uses the custom format) and compute $rest
based on the default "%s" and store that in "$1.sq", lines in
"$1.sq" do not know anything about the custom format, do they?

And then they are injected to appropriate places in "$1.rearranged".
Moved lines in the the rearranged result would end up written in the
default "%s" format, no?

That was the part that made me uneasy.

I do not think that is a bug worth fixing, but I view it as a sign
that fundamentally the autosquash and the idea of configurable
format do not mesh well with each other.
