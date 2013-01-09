From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Wed, 9 Jan 2013 09:16:17 +0100
Message-ID: <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
	<20130109072952.GC6503@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:16:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsqq5-00015f-Hl
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757328Ab3AIIQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:16:19 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:55766 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab3AIIQS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:16:18 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so356160wib.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=PESKE8VEk4wdSuej80NJt0PD3i6zOM0e/sP39Cj7mKs=;
        b=L8ogHXqGhm8ab1PoF6RfbcXEKn0j3RZa5GXrEpS5F4eJHxsjhEoNigNHWfVPzJ88T3
         UdCFm2HMjjKLoDRXZOG5/8X/BYixDAaGvZJJTXAqFVU8Q5WQyez51lQ2Z0+1u/KcscET
         KY9Ne3c54vRqktJOad0g0N+GSdMjrmCtt8S/paJBVdvLFxZAOoAAXBnOp25Y9V1MP2Sn
         nxj93P/lSo2LnGMprAMGTwy1PJuthhNqBAPhCl8DD628MsDa6/7ISQHZZr6CLLXwya8x
         PROTIf4Cyddd/v5VIxth425Rn6C6dq3WcSwSgKmXj61l2x/8VAE/FTIH3EWx2XgXX39S
         Ilmg==
X-Received: by 10.180.96.225 with SMTP id dv1mr2033895wib.0.1357719377349;
 Wed, 09 Jan 2013 00:16:17 -0800 (PST)
Received: by 10.194.139.207 with HTTP; Wed, 9 Jan 2013 00:16:17 -0800 (PST)
In-Reply-To: <20130109072952.GC6503@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213030>

Hi,

2013/1/9 Jonathan Nieder <jrnieder@gmail.com>:
> Hi,
>
> Ralf Thielow wrote:
>
>> The default of the "cleanup" option in "git commit"
>> is not configurable. Users who don't want to use the
>> default have to pass this option on every commit since
>> there's no way to configure it.
>
> Could you give an example?  I'm trying to get a sense of whether these
> habitual --cleanup= passers would use --cleanup=verbatim or
> --cleanup=strip.
>

It's actually my own usecase :). The bugtracker I'm using is able
to create relationships between issues and related commits. It
expects that a part of the commit message contains the issue number
in format "#<issueId>". So I need to use a cleanup mode different
from "default" to keep the commentary. The mode I'd use is "whitespace",
"verbatim" is also possible.

> I'm a bit worried that a setting like 'commit.cleanup = strip' would
> be likely to break scripts.  Yes, scripts using "git commit" instead
> of commit-tree while caring about detailed semantics are asking for
> trouble, but I'm worried about importers, for example, which are
> sometimes written by new git users.  Some scripts might assume that
> "git commit" preserves the entire change description from their source
> data, even when some lines happen to start by listing the ways the
> author is #1.
>

When a user uses a script/importer which expects that the "default" option
is used without setting it explicitly, and then the user changes the default,
isn't it the users fault if that would break things?

> I don't think that necessarily rules out this change, but:
>
>  1. We need more of an explanation of the purpose than "this lets
>     people type less".  What workflow does setting this option fit
>     into?
>
>  2. I would prefer to see a little thought about whether it's possible
>     to avoid silently impacting scripts.  E.g., depending on the
>     answer to (1), maybe supporting "verbatim" but not "strip" would be
>     ok?  Or alternatively, maybe a search of public code repositories
>     would reveal that new git users tend to write their importers in a
>     way that this doesn't break.
>
> As a side effect, the information gathered to answer (1) and (2) could
> have the potential to make the user-level documentation more useful,
> by adding context to the description of the configuration item.
>

I'll add a sentence of my bugtracker example to it. I think many developers
are using such a tool, so it'd makes sense.

> [...]
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -103,7 +103,7 @@ static enum {
>>       CLEANUP_NONE,
>>       CLEANUP_ALL
>>  } cleanup_mode;
>> -static char *cleanup_arg;
>> +const static char *cleanup_arg;
>
> Style nit: storage class comes first, then the type.  Otherwise the
> typename "const char *" is split up.
>

Thanks.
I'll send a new version of the patch including changes of your and
Junios comments.

Ralf
