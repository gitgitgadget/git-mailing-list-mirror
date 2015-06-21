From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 04/19] fsck: Offer a function to demote fsck errors to warnings
Date: Sun, 21 Jun 2015 10:36:05 -0700
Message-ID: <xmqqegl5j75m.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<44acafb2cf0a98e5ad75e3da24ba0e7453e6118f.1434720655.git.johannes.schindelin@gmx.de>
	<xmqqzj3v7b58.fsf@gitster.dls.corp.google.com>
	<bc06c48f005ad1c32dea2edbfa466208@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 19:36:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6jAG-0007Tn-Ja
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 19:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbbFURgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 13:36:11 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36916 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbbFURgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 13:36:09 -0400
Received: by igblr2 with SMTP id lr2so40475157igb.0
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 10:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=X/CJhrXjU2Z9MBS15+1C/oZt5uAV+Mx+rPBUMi6qUBE=;
        b=yEjTY0/Q5NPnoCyv/QernZghrwRQFPPcQfMsjcGF3um4xo/gPCieooN5qapfnQYArT
         Cau26HjYp1T6za+NC6OXG9+Yrkw18ju0jmecYX4W5PC0nyZu2Ier0Nom2z9f0plG3KZ+
         ACTEMBRsuPvGmgq3FIIwAW77cO/TCcwxJAal82g7FueBxaAwhNyvRK3TuL4zHwW5GHMr
         CA6ouw8dKE2zl007CTn+fN169+XRAh/Lrgg12nbmhLmhKESkQuuRSYAP7mIiTEbOadxH
         nR7+zRCqcbylWMmcAgycbKsUhgfctqHtFiU8RBpLAV058IIo9CiGXG4vkWTy080kz7Vh
         SY3Q==
X-Received: by 10.107.153.76 with SMTP id b73mr33719182ioe.36.1434908169144;
        Sun, 21 Jun 2015 10:36:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:990b:778:aa29:b388])
        by mx.google.com with ESMTPSA id u35sm11306454iou.7.2015.06.21.10.36.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 21 Jun 2015 10:36:06 -0700 (PDT)
In-Reply-To: <bc06c48f005ad1c32dea2edbfa466208@www.dscho.org> (Johannes
	Schindelin's message of "Sun, 21 Jun 2015 15:59:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272272>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Hmm. I really do not like that kind of thinking, i.e. having to
> duplicate, then modify data to be able to call the API, only to have
> to modify the data back afterwards, and eventually having to
> unallocate the data in all code paths. That feels just very inelegant
> to me.

You can see in our codebase that I have avoided touching end-user
strings by using a substring in place by introducing a new API
function or using an existing API function that takes <ptr, len> for
exactly that reason.  There also are cases where we are better off
if we make a copy upfront at a very high level in the callchain if
that makes the processing of that string deeper in the callchain
much simpler without customized helpers that take counted strings.

And 03/19 and this one taken together, I think it is an example of
the latter [*1*].

You not only need to invent counted string comparison in 04/19 but
also need upcasing byte-by-byte comparison in a loop in 03/19; both
of which can be made much simpler if you massaged the end-user input
"foo=error,bar=ignore" into "FOO=error,BAR=ignore" and allowed the
code to loop over it to turn ',' into NUL while parsing each
individual piece (i.e. "FOO=error").

So contrary to what you said in response to my review on 03/19, I
view this as not "adding complexity" but its total opposite.  It is
to make the code and logic much less complex by paying the price for
one copied (and massaged) string.

Having said all that, as long as the result functions correctly, I
suspect that it may not matter much either way.  As I already said,
"we can demote this error to a warning (or ignored)" is much less
useful in practice than the "we know this and that object in this
project does not pass fsck, so please do not bother checking" in my
mind, and that makes me think that this part of the series is much
less important than the skip-list thing.  Unnecessary complexity in
the code and otherwise useless helper functions may be something
that can be simplified following my advice, but that can be done as
a code clean-up, simplification and optimization by somebody else
later if they really cared.

Thanks.


[Footnote]

*1* Everything I say in my messages is what "I think", so saying "I
think" before saying what I think is redundant, but this one needs
that, because I think ;-) it is in the "taste" territory to view
each individual case and decide which one of these two opposite
approaches is more appropriate.
