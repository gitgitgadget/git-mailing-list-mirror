Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8FAF1FBB0
	for <e@80x24.org>; Sat,  3 Sep 2016 02:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752804AbcICCWF (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 22:22:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50152 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751917AbcICCWE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 22:22:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5F1D3A4E6;
        Fri,  2 Sep 2016 22:22:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SiOJS69PgdAAXDzCvNGU44LdiFM=; b=tIFkvC1WcGE7TBuGsXNt
        DtcxjXZwKAxciWzuIach2r0qRmhlircNwhvAK90pPFS8kZLGcbTi9NQblpysvv+q
        udaNGa90Z/Jo3L2jhuOkgSQC00LcVHGXUK5y1zaFuxVwaGZHVm5xFIMuj6i6CKdc
        S+5vgr8U5BBgaW+1h3AJOfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=jipkAZIsDZLtK3uOiR7smp8TXFzQOLNpxg22BGMkSTt52F
        +lcgW0bQHb2M1jXdH/zSAS3GaHuiAkxkhtCOZTRlLL/wsyIV19Tfvn26Lt9ReRi6
        zu/f/A9L3NECJFwHxNwjbhMLvfdiguYy5CGiSBQT/h4w86pM4PDXtffngn0w0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA26A3A4E5;
        Fri,  2 Sep 2016 22:22:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 476993A4E4;
        Fri,  2 Sep 2016 22:22:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Robert Dailey" <rcdailey.lists@gmail.com>,
        "Git" <git@vger.kernel.org>
Subject: Re: Fixup of a fixup not working right
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>
        <55512A8927384A0790DDC7F526B09053@PhilipOakley>
Date:   Fri, 02 Sep 2016 19:22:00 -0700
Message-ID: <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 331230B8-717D-11E6-BFA7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> As I understand this it's implied by design. The issue is that the
> rebase is looking for that named commit within its current rebase
> range, and can't find it, so ignores it.
>
> There is a separate issue that all the fixup! fixup! messages are
> essentially treated as being concatenations of the original fixup!, no
> matter how many time the fiup is present.

They can be handled separately, but they come from the same "design"
that could be improved.  When the "original" is not in the range to
be rebased for whatever reason (including the most likely one, i.e.
it has already graduated to become part of the public history), the
best thing the user could do at that point may be, as you suggested
to Robert in your message, to turn the "fixup! original" that did
not make in time before "original" hit the public record into a
standalone "fix original" follow-up change, and then to squash
subsequent "fixup! fixup! original" (and other "fixup! original",
too) into that commit.  And a good direction forward may be to see
if "rebase -i" can be taught to be more helpful for the user who
wants to do that.

Perhaps a change like this to "rebase -i":

 - The search for "original" when handling "pick fixup! original",
   when it does not find "original", could turn it into "reword
   fixup! original" without changing its position in the instruction
   sequence.

 - The search for "original" when handling "pick fixup! fixup!
   original", could be (probably unconditionally) changed to look
   for "fixup! original" to amend, instead of looking for "original"
   as the current code (this is your "separate issue").  The same
   "if the commit to be amended is not found, turn it into reword"
   rule from the above applies to this one, too.

may be an improvement?
