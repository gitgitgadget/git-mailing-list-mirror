From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Thoughts on refactoring the transport (+helper) code
Date: Thu, 13 Aug 2015 12:50:33 -0400
Message-ID: <CAD0k6qRitPBaizsY7vy9FuLnwqF3nWQrmkSifvdB3z+oYqAivg@mail.gmail.com>
References: <CAD0k6qR5AgtaDX3HuE1NVHnxsrAnYFnV1TYHWJsCJoD22ABb1g@mail.gmail.com>
 <20150813164556.GA18951@LK-Perkele-VII>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:51:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPviV-00055A-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 18:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293AbbHMQuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 12:50:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38661 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbHMQuy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 12:50:54 -0400
Received: by wicja10 with SMTP id ja10so77196381wic.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 09:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=2J1sFv/EBSrod0lsgBZ6Sga69vKiADgZ0cLE3KS9vbg=;
        b=GpyJM4GpD8ZzBihAJ6J8FkfKzhdDfvFHau+s1AW5Wg7kTNAc7z7aoPN0I+T64Lgkyb
         POGhNNHIN4ibHv2Ft3nBUcMMHyI83ZDh1bdKJWtxmdSc9EFZGOkqluw3769zAAohGNs0
         qkzIVLTpzRHYjeNpj0g5d0VZklfrFvme3CSjkBc8CDAoDb6EL+YjlyiLjLECMT6fkOgD
         V4zPgv6J87gO0IXmjQfAU5UNIy7QMoKAbdIk/YXQL6ZpRqdj3nVs2SXrb+nCD3PQLzcX
         DoCeavPg3IUHKCpI/TDMv28K3mToWT6/u0XffzV8235yYXCTEf3Gnq3xtMIHN3WVV3rk
         gFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=2J1sFv/EBSrod0lsgBZ6Sga69vKiADgZ0cLE3KS9vbg=;
        b=igEWCCiUMEObLnl1s9yBEvdAKxJruaW16OB5VmhH+X5NGI7Bv/9YKd31MZ7G4fHk0J
         b3rTzgxZdR8n/fYI13r97iHqiAjyLgCr9pCiDnyFh6BFeYkv3aqkQgF/wuuIjMiIPpQ8
         DQQ8nOrpuLuY5t8JjwGA7lUmCAkqGShPYDvKohCFV/x36+8NlI7DfKNz483IT9wN6dEo
         RsBJtX4TWwh29JaL0N6gP6QAJUwxaykFmJQCorDypxnom4w8s5glo3vuDnR7aAPMmUST
         39JbwObvjp/VsdMFoEqoH7CYm29WNUa4XzvWhVnh8jp46h1F9x1VIo+ouc+Q9BTKBN8I
         N6NQ==
X-Gm-Message-State: ALoCoQkCFof1ARkysLw38fxs2kKOHy4NYLFuvNhGPu8unJX1EcuUUEBNGTV6uRolyNZ+5t76KBDp
X-Received: by 10.180.83.137 with SMTP id q9mr62570269wiy.68.1439484652774;
 Thu, 13 Aug 2015 09:50:52 -0700 (PDT)
Received: by 10.27.20.67 with HTTP; Thu, 13 Aug 2015 09:50:33 -0700 (PDT)
In-Reply-To: <20150813164556.GA18951@LK-Perkele-VII>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275862>

On Thu, Aug 13, 2015 at 12:45 PM, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:
> On Thu, Aug 13, 2015 at 11:42:50AM -0400, Dave Borowitz wrote:
>>
>> In my ideal world:
>> -smart_options would never be NULL, and would instead be called
>> "options" with a "smart" bit which is unset for dumb protocols.
>> -Command line option processing code in {fetch,clone,push}.c would set
>> fields in options (formerly known as smart_options) rather than
>> passing around string constants.
>> -TRANS_OPT_* string constants would only be used for remote helper
>> protocol option names, and no more hard-coding these names.
>> -The flags arg to the push* callbacks would go away, and callbacks
>> would respect options instead.
>> -The helper code would not send options immediately, but instead send
>> just the relevant options immediately before a particular command
>> requires them. Hopefully we could then eliminate the set_option
>> callback entirely. (Two things I ran into that complicated this: 1)
>> backfill_tags mutates just a couple of options before reusing the
>> transport, and 2) the handling of push_cas_option is very
>> special-cased.)
>
> AFAIK, here are what one can encounter with remote helpers:
>
> Some remote helpers are always smart, some are always dumb, and some
> may be smart or dumb, depending on the URL.
>
> I don't know how useful the last one is (smart or dumb depending on
> URL) is. I have never seen such remote helper (HTTP doesn't count,
> from Git PoV it is always dumb).
>
> All smart helpers take common options associated with git smart
> transport (e.g. thin, follow tags, push certs, etc..).
>
> Dumb transports may take some of these kind of of options (esp.
> smart HTTP), but it is highly dependent on the helper.
>
> Then transports can have connection-level options (e.g. HTTPS
> cert options). These can be present regardless of wheither
> transport is smart or dumb.
>
> The receive-pack / send-pack paths fall into connection-level
> options, even if those are presently in smart transport common
> options. Since those things make sense for some smart transports
> (e.g. ssh://), but not others (e.g. git://).

Yeah, thanks for summarizing some of the differences between options.
The really confusing thing when looking at the code, though, is that
the various different ways of specifying options in the code don't
actually align with those distinctions. Maybe they once did, but they
certainly don't today.

I wouldn't be opposed to splitting up git_transport_options into
different structs for connection options, smart fetch options, smart
push options, etc., rather than putting everything in one kitchen-sink
struct.

>
> -Ilari
