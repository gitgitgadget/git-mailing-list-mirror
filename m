From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] reset: Libify reset_index_file and print_new_head_line
Date: Sat, 11 Jun 2011 11:37:52 +0530
Message-ID: <BANLkTi=UbGer-zbbviM_DM5JwzSE1LXy2A@mail.gmail.com>
References: <1307546728-11202-1-git-send-email-artagnon@gmail.com> <20110610103532.GA32119@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 11 08:08:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVHN6-0006dP-4z
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 08:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667Ab1FKGIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Jun 2011 02:08:14 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42592 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab1FKGIN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Jun 2011 02:08:13 -0400
Received: by wwa36 with SMTP id 36so3384263wwa.1
        for <git@vger.kernel.org>; Fri, 10 Jun 2011 23:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=FjQuJE+aCSj1DnyeTDNWNQZGLWkpr/OTJtfJROqu6GA=;
        b=G9q85n5i/m02F1NUtPT4yBxNkK/XJtUuxjw+XBd1BCAfyivuySFEB5ZUGIb3yP83dN
         j8lNJbYgq6UBSdbiDijw2m7PogduUs3ewW96lHLyLaNDDc+/iSSGYSTe8jI1Tzap0BCM
         Mw67/hUg1T+osVVBhuuVvuE/eyP9YfgSvwmaw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=UC+dPFnySXm9+OAEoomjjslTHAPamwjHxuQPZjvRlFrCLCdqBmOjSjFkEzQuES8jpB
         mwz2EpZj92OEihNVb7Yw0m6qv5NSaA0bw5TP0MbqCi1e4vYIB+Md2OLTzNdm0yJuVV8Q
         RbLI2s1mnO5IzsuWXZHJiCr2aYBaRpIkY5QbU=
Received: by 10.216.201.163 with SMTP id b35mr2803838weo.80.1307772492147;
 Fri, 10 Jun 2011 23:08:12 -0700 (PDT)
Received: by 10.216.1.20 with HTTP; Fri, 10 Jun 2011 23:07:52 -0700 (PDT)
In-Reply-To: <20110610103532.GA32119@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175636>

Hi Jonathan,

Jonathan Nieder writes:
> It should be easier to review this one with a caller in mind to give
> an indication about whether the API is right. =C2=A0More generally, t=
he
> excitement of patches exposing new library code comes when you can se=
e
> the header with a pleasant API, ideally followed by an example or two
> to see how it plays out in practice. =C2=A0See "git log --grep=3DAPI =
junio/pu"
> for a few recent examples of this.

Yes, I know. Unfortunately, I don't have those callers ready -- most
of that work is in the form of RFC patches in the sequencer series. I
wanted to post this in the same spirit as Junio's rerere series (which
I initiated, but messed up quite badly).

>> --- /dev/null
>> +++ b/reset.c
>> @@ -0,0 +1,81 @@
>> +#include "builtin.h"
>> +#include "refs.h"
>> +#include "diff.h"
>> +#include "diffcore.h"
>> +#include "tree.h"
>> +#include "branch.h"
>> +#include "tree.h"
>> +#include "unpack-trees.h"
>> +#include "reset.h"
>
> Are these all needed? =C2=A0E.g., where is diffcore used?

Pruned, thanks.

>> --- /dev/null
>> +++ b/reset.h
>> @@ -0,0 +1,11 @@
>> +#ifndef RESET_H
>> +#define RESET_H
>> +
>> +#include "commit.h"
>
> We can avoid unnecessarily rebuilding (if COMPUTE_HEADER_DEPENDENCIES
> is set) for callers that do not use commit.h when commit.h changes by
> just declaring
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct commit;

Thanks for the tip.

>> +enum reset_type { MIXED, SOFT, HARD, MERGE, KEEP, NONE };
>
> The names of these identifiers (especially KEEP, MERGE, and NONE)
> would have a good chance to colliding with other uses after being
> exposed into a global namespace like this, no?
>
> Maybe RESET_MIXED, RESET_SOFT, etc could avoid this while still not
> being too verbose.

I should have got this right the first time. Anyway, fixed now.

>> +int reset_index_file(const unsigned char *sha1, int reset_type, int=
 quiet);
>> +void print_new_head_line(struct commit *commit);
>
> Warning: trivia ahead.
>
> For some odd reason I still remember a patch from Stefan Beyer:
> http://thread.gmane.org/gmane.comp.version-control.git/92023
> which was probably too invasive to apply but made the whole codebase
> oddly more pleasant when I tried it. =C2=A0It simply added "extern" a=
t the
> start of function prototypes in header files that lacked it.

Good tip. We can atleast use "extern" for the new functions that we
write to avoid massive code churns.

Your review has been very helpful, as always. Thanks.

-- Ram
