From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 12:07:30 -0700
Message-ID: <xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915153637.GO29753@sigill.intra.peff.net>
	<CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
	<20150916094814.GB13966@sigill.intra.peff.net>
	<xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
	<20150916185256.GA2654@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:07:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcI3M-0000SU-LF
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbbIPTHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:07:32 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36234 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452AbbIPTHc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:07:32 -0400
Received: by padhk3 with SMTP id hk3so216732389pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=SBxStQZr1GMn12YuCWMxCnqM2tLIPl3CwbyR6Zs+pYM=;
        b=ODHbl7vGpexN7FEds3MhCSpUe9jsukwdf8hlPSw3D5Pcroacb0r0y+l+/Mx8heBOZ/
         YjiasgiNx21AuKjqL72tCi2BzapzRFYxQsy8kn3/mBvNqqnjiNTJiOo0xiJWFTKP7/Pp
         ifeWYIvkpAmTgJifQ8f/XPFyP1A2ise7neTc/xDtw/Hkll1fbQ5TPR7qN6LRP080s9lI
         f3afvQBFy/wAf+sbQwqnGQprTEkeBKaI/hmjGfbPT0ycw5ftaOTjqMN2cYBf3QLYNGDc
         tURDoNxNnVjtHLS2fCMChQnmgzBASPRLuJ3/Ow5bgVtBrqMWmZ+IzOr4jRtHqzSvhnwJ
         5AWQ==
X-Received: by 10.66.142.202 with SMTP id ry10mr39503783pab.86.1442430451603;
        Wed, 16 Sep 2015 12:07:31 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id bc1sm29220653pbb.66.2015.09.16.12.07.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 12:07:30 -0700 (PDT)
In-Reply-To: <20150916185256.GA2654@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 14:52:57 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278049>

Jeff King <peff@peff.net> writes:

> On Wed, Sep 16, 2015 at 11:24:27AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Tue, Sep 15, 2015 at 11:19:21PM -0400, Eric Sunshine wrote:
>> >
>> >> >                 strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
>> >> > -               sprintf(ownbuf[stage], "%o", ce->ce_mode);
>> >> > +               xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
>> >> 
>> >> Interesting. I wonder if there are any (old/broken) compilers which
>> >> would barf on this. If we care, perhaps sizeof(ownbuf[0]) instead?
>> >
>> > Good point. I've changed it to sizeof(ownbuf[0]).
>> 
>> Panda brain is lost here.  What's the difference, other than that we
>> will now appear to be measuring the size of the thing at index 0
>> while using that size to stuff data into a different location?  All
>> elements of the array are of the same size so there wouldn't be any
>> difference either way, no?
>
> Correct. The original is sane and gcc does the right thing. The question
> is whether some compiler would complain that "stage" is not a constant
> in the sizeof() expression. I don't know if any compiler would do so,
> but it is easy enough to be conservative.

Wouldn't such a compiler also complain if you did this, though?

	int *pointer_to_int;
        size_t sz = sizeof(*pointer_to_int);

You (as a complier) do not know exactly where ownbuf[stage] is,
because "stage" is unknown to you.  In the same way, you do not know
exactly where *pointer_to_int is.  But of course, what the sizeof()
operator is being asked is the size of the thing, which does not
depend on where the thing is.  If you (as a compiler) does not know
that and complain to ownbuf[stage], wouldn't you complain to the
pointer dereference, too?

A more important reason I am reluctant to see this:

	xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);

is that it looks strange in the same way as this

	memcpy(ownbuf[stage], src, sizeof(ownbuf[0]));

looks strange.  "We use the size of one thing to stuff into another".

That will make future readers wonder "Is this a typo, and if it is,
which index is a mistake I can fix?" and may lead to an unnecessary
confusion.  I do not want to see a correctly written

	xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);

turned into

	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", ...);

out of such a confusion.
