From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/67] strbuf: make strbuf_complete_line more generic
Date: Tue, 15 Sep 2015 18:27:49 -0700
Message-ID: <xmqqoah3tap6.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152528.GG29753@sigill.intra.peff.net>
	<CAPig+cT9piy2dGx6jbcQNyzY5kQ1XgaEB_mYNUOYBUCJ5wAc_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 03:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc1Vr-0001n2-SL
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 03:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752308AbbIPB1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 21:27:52 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33081 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbIPB1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 21:27:51 -0400
Received: by pacex6 with SMTP id ex6so192655962pac.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 18:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6gX0FTQsQNhuaWmmNivpBW+VPHt478QrAc7i/WyGskE=;
        b=IobpNM4xb5MFAJtxo4ynvZLwf+WG62gZ6u/+JUth99Zq8Nio1YkAUsVFDyxnQThBwF
         Q5Fgw8pp9/+kUplf2VBnKIm6fyroMKA+HoU2vIvxybJtdEKHXB5Gl30m4gVhV7Lahabu
         rCTyIlGnXaZx4owZgcExBTtoaqEhWxZgd6SUv4MqW4xszNYLE++raLlYfH4//vqFqk7Z
         PXoYxkn/ut7L3xJ1pxwyfzwLpf1S3+FcpwuoNCIUScE0ZV1er6jE2r3bRYxPpye4u7O2
         vDysxvtqyk+cDqscXdkgx5UcZ4irVZ0QglkIofAwtwr6iATznZyO6Mc9SNHJEy74IYX4
         PVOw==
X-Received: by 10.66.155.9 with SMTP id vs9mr53179008pab.63.1442366871194;
        Tue, 15 Sep 2015 18:27:51 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id iy1sm24304265pbb.85.2015.09.15.18.27.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Sep 2015 18:27:50 -0700 (PDT)
In-Reply-To: <CAPig+cT9piy2dGx6jbcQNyzY5kQ1XgaEB_mYNUOYBUCJ5wAc_w@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 15 Sep 2015 20:45:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277992>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +static inline void strbuf_complete(struct strbuf *sb, char term)
>> +{
>> +       if (sb->len && sb->buf[sb->len - 1] != term)
>> +               strbuf_addch(sb, term);
>> +}
>
> Hmm, so this only adds 'term' if not already present *and* if 'sb' is
> not empty, which doesn't seem to match the documentation which says
> that it "ensures" termination.
>
> But, is that reasonable behavior? Intuitively, I'd expect 'term' to be
> added when 'sb' is empty:
>
>     if (!sb->len || sb->buf[sb->len - 1] != term)
>         strbuf_addch(sb, term);
>
> strbuf_complete_line()'s existing behavior of not adding '\n' to an
> empty string may have been intentional, but actually smells like a
> bug.

I would expect two different scenarios for which this function would
be useful.

One is when dealing with a text file and want to avoid incomplete
lines at the end.  In this scenario, an empty file with zero lines
should be left as-is, instead of getting turned into a file with one
empty line.  "Leave the empty input as-is" is the behaviour the
callers want.

The other is when you are given a directory name in the strbuf, you
have a name of a file you want to be in that directory, and want to
have the full path to the file in the strbuf.  In this scenario,
what does it mean for the caller to give you an empty "directory
name"?  I think at least in our codebase, that almost always would
mean that "the path is relative to $CWD", i.e. you would want to see
the "complete" to leave the input intact and then append the
filename there.

So to these two plausible and different set of callers that would be
helped by this function, the behaviour Peff gives it would match
what the callers want better than your version.
