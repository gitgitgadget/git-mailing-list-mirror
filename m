From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/5] test-lib-functions: detect test_when_finished in subshell
Date: Sun, 6 Sep 2015 12:22:19 -0400
Message-ID: <CAPig+cQixsVT-5Ke2Ccedijc1HeBZ6=mbKeeN95V3zExBxSz2A@mail.gmail.com>
References: <20150905085429.GB25039@sigill.intra.peff.net>
	<cover.1441458341.git.john@keeping.me.uk>
	<59a8583f79c5ac4661f140262e01cd602286f740.1441458341.git.john@keeping.me.uk>
	<CAPig+cR+_nPFbJmOf3s90oB=Jedg1B3YgOCzSwWa8nwP8-QbeA@mail.gmail.com>
	<20150906114635.GF27660@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Sep 06 18:22:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYciI-0007r6-1Q
	for gcvg-git-2@plane.gmane.org; Sun, 06 Sep 2015 18:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbbIFQWX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2015 12:22:23 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36028 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbbIFQWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2015 12:22:21 -0400
Received: by ykcf206 with SMTP id f206so61798404ykc.3
        for <git@vger.kernel.org>; Sun, 06 Sep 2015 09:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Xwf6SXnViKNLXJ+8PI00Cqr9ERRTwFvPtyjcEpoKje8=;
        b=z4pS+nYliVBkQ/lcrs1CihVARLB54BFhwATHFfJm6XotSV3y1lV75u02lKdkgmcYFJ
         llzopuaX8/gCAdh3lz2bi7cnrh2PWH8IXno8L0IoIcxAnkoIQWKsUX3Q+L2IhvyDSmv1
         PKKbrfi2tMlLxrjZuCgf53YuCk2huh32TX6fRYnAFei0yRayYSGgFQ9Bk6mKkBp1IEY+
         2/J9CGaoZM/+gvR84/DDUIKaoXwcbEjpzN1VBybk9ol6UHrjDCwUJoeHiDSWnl2WVgDq
         msncTduZtBPYKrJtcP87wQ6VQD+frh/ohQPwZR1ZrkTEJj0mU94nptMXuhf53hLnWRnL
         Glxw==
X-Received: by 10.129.155.147 with SMTP id s141mr16205706ywg.17.1441556539987;
 Sun, 06 Sep 2015 09:22:19 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 6 Sep 2015 09:22:19 -0700 (PDT)
In-Reply-To: <20150906114635.GF27660@serenity.lan>
X-Google-Sender-Auth: JnxVwH3RcTzXzdwN_-sNRDe6644
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277428>

On Sun, Sep 6, 2015 at 7:46 AM, John Keeping <john@keeping.me.uk> wrote:
> On Sun, Sep 06, 2015 at 05:51:43AM -0400, Eric Sunshine wrote:
>> I'm not necessarily advocating this, but think it's worth mentioning
>> that an alternate solution would be to fix test_when_finished() to work
>> correctly in subshells rather than disallowing its use. This can be done
>> by having test_when_finished() collect the cleanup actions in a file
>> rather than in a shell variable.
>>
>> Pros:
>> * works in subshells
>> * portable across all shells (no Bash special-case)
>> * one less rule (restriction) for test writers to remember
>>
>> Cons:
>> * slower
>> * could interfere with tests expecting very specific 'trash' directory
>>   contents (but locating this file under .git might make it safe)
>
> Another con is that we have to worry about the working directory, and
> since we can't reliably detect if we're in a subshell every cleanup
> action probably has to be something like:
>
>         ( cd '$(pwd)' && $* )

That's an argument against allowing test_when_finished() inside
subshells, in general, isn't it? Subshell callers of
test_when_finished(), if correctly written, would already have had to
protect against that anyhow, so it's not a "con" of the idea of
collecting cleanup actions in a file.

Of course, patches 2/5 and 4/5 demonstrate that a couple of those
subshell callers did *not* correctly protect against directory (or
other) changes which would invalidate their cleanup actions, and were
thus buggy anyhow, even if the cleanup actions had been invoked.
That's a good argument in favor of disallowing test_when_finished() in
subshells, but not a "con" of the suggestion.

I'm probably arguing semantics here, thus being annoying, so I'll stop now...

> It's certainly possible but it adds another bit of complexity.
>
> Since there are only 3 out of over 13,000 tests that use this
> functionality (and it's quite easy to change them not to) I'm not sure
> it's worth supporting it.

No argument there.
