From: Christian Couder <christian.couder@gmail.com>
Subject: Re: More builtin git-am issues..
Date: Mon, 7 Sep 2015 21:27:09 +0200
Message-ID: <CAP8UFD1AoSsP303NEMLf39o-RHEwRMt-GvUv-87kCGtpA56Piw@mail.gmail.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<20150905080325.GA25039@sigill.intra.peff.net>
	<xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com>
	<xmqqsi6sbqqm.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 21:27:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ24b-00041e-LC
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 21:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbbIGT1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 15:27:12 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:34153 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878AbbIGT1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 15:27:11 -0400
Received: by laeb10 with SMTP id b10so57135896lae.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gs5RhhpPHBCNQ3CVhUdci8FTL15VxvIbvvZEvsmkrwM=;
        b=nGtlsoyajJi31KzB1PegKZXHM1dgpKXuNo1PgM+uVxzH9gAI5FUYcrHFjDFcTdbQiE
         ff4nGPvKofmBzdS1ja0DSIChWk14HM6+TOzk9FmsfR6YeGYfchkKNV4cPDrnhev4OGDv
         rEO933itokk48ZxDeCS3/5mhVUXYwXaP9CWlAlc5jiXjiz4/YdmM6ijm8DGfv3djEmdI
         gDmBMVNfm2EVZPpp80WQe4Y8WzhfqoWcRetWhSDnGiKE/EMT/6ssSUHY1KxFy9KpJJGF
         0fr0e69BIR+TYIZsmdmK5u+hoJ+e8w47rg7THj8gWXtdxIurB8gsSRRbaeUQi5oYSnTN
         b21A==
X-Received: by 10.112.168.100 with SMTP id zv4mr18340515lbb.117.1441654029457;
 Mon, 07 Sep 2015 12:27:09 -0700 (PDT)
Received: by 10.25.135.7 with HTTP; Mon, 7 Sep 2015 12:27:09 -0700 (PDT)
In-Reply-To: <xmqqsi6sbqqm.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277474>

On Sat, Sep 5, 2015 at 9:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> To salvage "interpret-trailers" needs a lot more, as we are
>> realizing that the definition that led to its external design does
>> not match the way users use footers in the real world.  This affects
>> the internal data representation and the whole thing needs to be
>> rethought.
>
> Note that I am not saying that you personally did any bad job while
> working on the interpret-trailers topic.  We collectively designed
> its feature based on a much narrower definition of what the trailer
> block is than what is used in the real world in practice, so we do
> not have a good way to locate an existing entry that is not a (key,
> value), no matter what the syntax to denote which is key and which
> is value is, insert a new entry that is not a (key, value), or
> remove an existing entry that is not a (key, value), all of which
> will be necessary to mutate trailer blocks people use in the real
> life.
>
> I think a good way forward would be to go like this:
>
>  * a helper function that starts from a flat <buf, len> (or a
>    strbuf) and identifies the end of the body of the message,
>    i.e. find "^---$", "^Conflicts:$", etc. and skip blank lines
>    backwards.  That is what ignore_non_trailer() in commit.c does,
>    and that can be shared across everybody that mutates a log
>    message.
>
>  * a helper function that takes the result of the above as a flat
>    <buf, len> (or a strbuf) and identifies the beginning of a
>    trailer block.  That may be just the matter of scanning backwards
>    from the end of the trailer block ignore_non_trailer() identified
>    for the first blank line, as I agree with Linus's "So quite
>    frankly, at that point if git doesn't recognize it as a sign-off
>    block, I don't think it's a big deal" in the thread.
>
>    Not having that and not calling that function can reintroduce the
>    recent "interpret-trailers corner case" bug Matthieu brought up.
>
> With these, everybody except interpret-trailers that mutates a log
> message can add a new signoff consistently.  And then, building on
> these, "interpret-trailers" can be written like this:
>
>  (1) starting from a flat <buf, len> (or a strbuf), using the above
>      helpers, identify the parts of the log message that is the
>      trailer block (and you will know what is before and what is
>      after the trailer block).
>
>  (2) keep the part before the trailer block and the part after the
>      trailer block (this could be empty) in one strbuf each; we do
>      not want to mutate these parts, and it is pointless to split
>      them further into individual lines.
>
>  (3) express the lines in the trailer block in a richer data
>      structure that is easier to manipulate (i.e. reorder the lines,
>      insert, delete, etc.) and work on it.
>
>  (4) when manipulation of the trailer block is finished, reconstruct
>      the resulting message by concatenating the "before trailer"
>      part, "trailer" part, and "after trailer" part.
>
> As to the exact design of "a richer data structure" and the
> manipulation we may want on the trailer, I currently do not have a
> strong "it should be this way" opinion yet, but after looking at
> various examples Linus gave us in the discussion, my gut feelig is
> that it would be best to keep the operation simple and generic,
> e.g. "find a line that matches this regexp and replace it with this
> line", "insert this line at the end", "delete all lines that match
> this regexp", etc.

I will see what I can do about this.

Thanks,
Christian.
