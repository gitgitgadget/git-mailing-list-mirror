From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] sequencer: Expose API to cherry-picking machinery
Date: Sat, 13 Aug 2011 19:30:03 +0530
Message-ID: <CALkWK0migSRUmhPp0069O_NiRs3gQJbrU8QLdwUJ-kUYAsLz4Q@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com>
 <1313088705-32222-6-git-send-email-artagnon@gmail.com> <20110811215650.GA13839@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 13 16:00:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsElK-00008J-4g
	for gcvg-git-2@lo.gmane.org; Sat, 13 Aug 2011 16:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960Ab1HMOAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Aug 2011 10:00:25 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46455 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1HMOAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2011 10:00:24 -0400
Received: by wwf5 with SMTP id 5so3662956wwf.1
        for <git@vger.kernel.org>; Sat, 13 Aug 2011 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=oeg1DdfDmzEXwTqrAplAmP5uYcRwXh9nLHmV72PpDIE=;
        b=o+G1Px3NXZ++gCZRdOceSkAbIWrnuPLen/GMMqH1XUfslM2+UtfM4KSghdhSSVCs/A
         swX3FdqEQCwd1AGDSNwypWI/hud33LFaz52fXS3k5EBmhfFkibYafagZeUhZoOHqM5Mk
         PyBWcs5yl4ZtGaEZTJRP9RMJbbuk90Luf+ti8=
Received: by 10.216.14.41 with SMTP id c41mr1730689wec.108.1313244023143; Sat,
 13 Aug 2011 07:00:23 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Sat, 13 Aug 2011 07:00:03 -0700 (PDT)
In-Reply-To: <20110811215650.GA13839@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179278>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> --- a/sequencer.h
>> +++ b/sequencer.h
>> @@ -7,7 +7,32 @@
>> =C2=A0#define SEQ_TODO_FILE =C2=A0 =C2=A0 =C2=A0 =C2=A0"sequencer/to=
do"
>> =C2=A0#define SEQ_OPTS_FILE =C2=A0 =C2=A0 =C2=A0 =C2=A0"sequencer/op=
ts"
>>
>> +#define COMMIT_MESSAGE_INIT =C2=A0{ NULL, NULL, NULL, NULL, NULL };
>
> I don't think this should be exposed. =C2=A0The rest seems pretty san=
e,
> though I haven't read the patch carefully.

Gah, my stupidity.  What sense does it make to expose
COMMIT_MESSAGE_INIT when 'struct commit_message' itself isn't?  Moved
to sequencer.c now, thanks.

> Another thought. =C2=A0I wonder if it's possible to leave
> sequencer_parse_args() private to builtin/revert.c, making the split
> a little more logical:

Yes, I'd like this too.  However, there are two new issues:
revert_or_cherry_pick_usage and action_name.  The former has two
callsites: one in prepare_revs (in sequencer.c) and another in
parse_args (in builtin/revert.c).  Unfortunately, action_name is even
more complicated to get rid of: the information from it is used all
over the place.  Attempting to attack the problems one by one:
1. Make prepare_revs and walk_revs_populate_todo return errors to be
handled by callers.  This is a fairly small patch that can come before
the big "code moving patch".
2. Duplicate action_name in both files.  I don't think it's too
serious, and we can fix this later.

It has been enormously annoying to work with this "code moving patch":
everytime I make some changes to the earlier patches, I have to
recreate this one by hand; rebase offers no help whatsoever.  After
throwing away code based on this patch several times, I learnt my
lesson and restricted my series to avoid building on this patch.  I
consider this a very serious glitch* and I'm interested in fixing it.
Thoughts?

Thanks.

* We don't track renames, and I fully subscribe to that design.
However, that doesn't prevent us from building small helpers.

-- Ram
