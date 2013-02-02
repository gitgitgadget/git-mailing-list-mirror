From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Sat, 2 Feb 2013 02:07:49 -0800
Message-ID: <CAJo=hJvPz_EYFGzb8LLdW77T2MhcOqnUBtroLMWKkEWWKSTchQ@mail.gmail.com>
References: <20130126224011.GA20675@sigill.intra.peff.net> <7vlibfxhit.fsf@alter.siamese.dyndns.org>
 <20130129082939.GB6396@sigill.intra.peff.net> <7vwquwrng6.fsf@alter.siamese.dyndns.org>
 <20130129211932.GA17377@sigill.intra.peff.net> <CAJo=hJuGw8x=VrjWhvZhzakuhWrCWr2FRuEsNt5gQNC=6PPuVw@mail.gmail.com>
 <20130201091431.GC30644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 02 11:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1a1U-0000X7-IM
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 11:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab3BBKIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2013 05:08:15 -0500
Received: from mail-ia0-f172.google.com ([209.85.210.172]:53420 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab3BBKIN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2013 05:08:13 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so6479733iag.31
        for <git@vger.kernel.org>; Sat, 02 Feb 2013 02:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=rFXDxd0CGN8RXQz8Vhri9EmCot3tArzOk85901EhJKs=;
        b=AVpzKh72sTgdHr7jErH9lL39KK+TSL1IGtJ5c1Kb7tDOy6ybi+SDUw6w589I797Vrx
         v/F6c7BSp58HI9oE05/SuSImQY90YcscY02E38d/0l6exItrw2ejVqG/SYI+yNhwqhQN
         10nD53CseKBKVtCmLB2U4NyWzEMabCTm9Pqp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=rFXDxd0CGN8RXQz8Vhri9EmCot3tArzOk85901EhJKs=;
        b=HliqGHYRmXJNi9HWvcDgxtt+OryXzBhKCxpRJcb4qmds1Yd5jn6wM/u6gkvY6s6pWb
         TUDxODorX/DSoJQ8CENv34wS385vRHs7tjcNV0vKXR9f2ml1JCA/VL1NW/EYJKkcAyW4
         njFBtdRUcVQL6tMnquhE7XMhJikWER/REcoyusjDxeISFevNJFmZ9cavEQMjzV0vCff8
         6dQcnBTI/+W6uWoKKvuB5XaMsc9izDmgtBGirApavouh9UaqeTEx8Fhf7JclTKZSziKV
         ObEJKKBhz7sTBpNkn0atEsOKKQVYylVdYski3nxa2X2ORJlJOhHPQv25XHuJjEjocvj3
         IoBQ==
X-Received: by 10.50.189.163 with SMTP id gj3mr1073300igc.14.1359799693125;
 Sat, 02 Feb 2013 02:08:13 -0800 (PST)
Received: by 10.64.170.100 with HTTP; Sat, 2 Feb 2013 02:07:49 -0800 (PST)
In-Reply-To: <20130201091431.GC30644@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmXz3ICXL5b0plUoJcwih1RxcJD8r+kFn+gRIUoKr68eaVZHuySlXA5XyLTHFE8WxtGSBkb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215288>

On Fri, Feb 1, 2013 at 1:14 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Jan 31, 2013 at 08:47:37AM -0800, Shawn O. Pearce wrote:
>
>> >>  - System resource cost we incur by having to keep 50 file
>> >>    descriptors open and maintaining 50 mmap windows will reduce by
>> >>    50 fold.
>> >
>> > I wonder how measurable that is (and if it matters on Linux versus less
>> > efficient platforms).
>>
>> It does matter. We know it has a negative impact on JGit even on Linux
>> for example. You don't want 300 packs in a repository. 50 might be
>> tolerable. 300 is not.
>
> I'd love to see numbers if you have them. It's not that I don't believe
> it is slower, but knowing _how much_ is important when thinking about
> what kind of performance increase we are looking to get (which in turn
> impacts how much effort to put into the repacking).

Never done a formal experiment. Just working from memory where 4 years
and 3 desks ago I got called because one of our Git servers was
struggling to keep up with user git fetch commands. Turns out the
repository had O(200) pack files. git gc that normally took only about
5 minutes took a hellva lot longer, like an hour or more.

The problem happened because the server was saving every push to a
pack and never exploding incoming packs to loose objects. This meant
the thin packs from the wire got delta bases appended to them.
pack-objects was looking at O(50) different alternatives for most
objects when trying to decide which one it should copy into the output
pack... for either a fetch/clone client, or the gc I was trying to run
to fix the repository.
