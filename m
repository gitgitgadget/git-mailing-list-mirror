From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 12:39:13 -0700
Message-ID: <xmqqsi6sbqqm.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<20150905080325.GA25039@sigill.intra.peff.net>
	<xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 21:39:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYJJF-0004gi-J9
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 21:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbIETjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 15:39:17 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35653 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751645AbbIETjP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 15:39:15 -0400
Received: by pacfv12 with SMTP id fv12so56710126pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=eHN4isElRLTQeEPUJ3Zb0lXaU4tJaQ0f8SKsa68ZGAg=;
        b=cOQwSnTw1PfoEB5KarXx3xBoNRr6vPpyYGEvIX8mF9aCGlr7KiJVgZbJz7C88leBPX
         L9avLTi6xb6GK7qKWdnLCWHUNm/amDEkgPkJcoy8XcFkBJYiDJWrwIFRF8TALMGeryBX
         LaYT2KhF+yUL6OrTESpm6Kz8tSmEqZoZt1jAzch6JD2dBjpzeouEH6J9mgw/6c1ulEhL
         YoY6QO4SnwCi/XlFYQQaK5+xvGidzK8ozYWQZVjR+x9fWKqkln+EoExnRiuqLGaAVI9v
         Oox1JA7Oo0I7xizjjZ6ZSjGDLZIyowBeC8xct9gBfwqB2HEidPsXxaA2J3OjaJiMJI0u
         KwVw==
X-Received: by 10.67.10.101 with SMTP id dz5mr3668802pad.13.1441481954880;
        Sat, 05 Sep 2015 12:39:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id uv5sm6662956pbc.12.2015.09.05.12.39.13
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 12:39:14 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277409>

Junio C Hamano <gitster@pobox.com> writes:

> To salvage "interpret-trailers" needs a lot more, as we are
> realizing that the definition that led to its external design does
> not match the way users use footers in the real world.  This affects
> the internal data representation and the whole thing needs to be
> rethought.

Note that I am not saying that you personally did any bad job while
working on the interpret-trailers topic.  We collectively designed
its feature based on a much narrower definition of what the trailer
block is than what is used in the real world in practice, so we do
not have a good way to locate an existing entry that is not a (key,
value), no matter what the syntax to denote which is key and which
is value is, insert a new entry that is not a (key, value), or
remove an existing entry that is not a (key, value), all of which
will be necessary to mutate trailer blocks people use in the real
life.

I think a good way forward would be to go like this:

 * a helper function that starts from a flat <buf, len> (or a
   strbuf) and identifies the end of the body of the message,
   i.e. find "^---$", "^Conflicts:$", etc. and skip blank lines
   backwards.  That is what ignore_non_trailer() in commit.c does,
   and that can be shared across everybody that mutates a log
   message.

 * a helper function that takes the result of the above as a flat
   <buf, len> (or a strbuf) and identifies the beginning of a
   trailer block.  That may be just the matter of scanning backwards
   from the end of the trailer block ignore_non_trailer() identified
   for the first blank line, as I agree with Linus's "So quite
   frankly, at that point if git doesn't recognize it as a sign-off
   block, I don't think it's a big deal" in the thread.

   Not having that and not calling that function can reintroduce the
   recent "interpret-trailers corner case" bug Matthieu brought up.

With these, everybody except interpret-trailers that mutates a log
message can add a new signoff consistently.  And then, building on
these, "interpret-trailers" can be written like this:

 (1) starting from a flat <buf, len> (or a strbuf), using the above
     helpers, identify the parts of the log message that is the
     trailer block (and you will know what is before and what is
     after the trailer block).

 (2) keep the part before the trailer block and the part after the
     trailer block (this could be empty) in one strbuf each; we do
     not want to mutate these parts, and it is pointless to split
     them further into individual lines.

 (3) express the lines in the trailer block in a richer data
     structure that is easier to manipulate (i.e. reorder the lines,
     insert, delete, etc.) and work on it.

 (4) when manipulation of the trailer block is finished, reconstruct
     the resulting message by concatenating the "before trailer"
     part, "trailer" part, and "after trailer" part.

As to the exact design of "a richer data structure" and the
manipulation we may want on the trailer, I currently do not have a
strong "it should be this way" opinion yet, but after looking at
various examples Linus gave us in the discussion, my gut feelig is
that it would be best to keep the operation simple and generic,
e.g. "find a line that matches this regexp and replace it with this
line", "insert this line at the end", "delete all lines that match
this regexp", etc.
