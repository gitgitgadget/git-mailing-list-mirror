From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] pack-protocol.txt: Mark all LFs in push-cert as required
Date: Mon, 06 Jul 2015 09:12:39 -0700
Message-ID: <xmqqk2ud2rk8.fsf@gitster.dls.corp.google.com>
References: <1435774099-21260-1-git-send-email-dborowitz@google.com>
	<1435774099-21260-4-git-send-email-dborowitz@google.com>
	<xmqqfv578x87.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSN9=afCe3RumJPfP9JERy1w+tAYdjq01MsQnsOjdKu3A@mail.gmail.com>
	<xmqqzj3f7gde.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTDpH0H-k9h+f3X8PjXpOZ7tRzv+8wvi8HALhg9DDm4Ew@mail.gmail.com>
	<CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 18:12:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC90i-0000lm-PT
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbbGFQMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:12:44 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:36130 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbbGFQMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 12:12:42 -0400
Received: by igrv9 with SMTP id v9so157296714igr.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0n9KraQtTni4JzVXBnjRhTF+ppKhvlCjWscDBqS93tc=;
        b=o2TfP/dITWj2KPe+lFAFdKHkBlGWUO+UezAk31KwBIeeR4mzrvucPrLR7MY4ecoY9p
         tGH+5ajxy0fCXKtSzMIs8ZfvndDkR94FBMd/5YJ7CWWnA4dq0E5DfzQq8B0u9AaLUBbd
         0SpOsmV8hHxaFrHntgQUXiancsKj/o4XKEti+LL71clM63TgV5oJXuMKAeOL1FhfhQXC
         ihz2bH+Aq0/KCzz1YH7NUXaDcjgMv5+L2Rn03hhDAbq/FPltimShVuEjTSESduod1BoX
         9Sg9S6FsTRvrwzIoLQzYRDghzfyc3STxzsuiUmMvifyX6q18YHEXSs1sp9tP6lhZwG0U
         AA6w==
X-Received: by 10.50.61.234 with SMTP id t10mr70124962igr.19.1436199161990;
        Mon, 06 Jul 2015 09:12:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by smtp.gmail.com with ESMTPSA id x3sm9966051igl.2.2015.07.06.09.12.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 09:12:41 -0700 (PDT)
In-Reply-To: <CAD0k6qSJeNBX=kmo4dn-=SqHGottXT2PJfpCD=y_SKNwEMDMyA@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 6 Jul 2015 11:22:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273396>

Dave Borowitz <dborowitz@google.com> writes:

> Unfortunately, optional LFs still make the stored certs for later
> auditing and parsing a bit illegible. This is one way in which push
> certs are fundamentally different from the rest of the wire protocol,
> which is not intended to be persisted.

Hmm, I am not sure I follow.  

> The corner case I pointed out before where nonce runs into commands is
> not the only one.
>
> Consider the following cert fragment:
> 001fpushee git://localhost/repo
> 0029nonce 1433954361-bde756572d665bba81d8
>
> A naive cert storage/auditing implementation would store the raw
> payload that needs to be verified, without the pkt-line framing. In
> this case:
> pushee git://localhost/repononce 1433954361-bde756572d665bba81d8

"Without the pkt-line framing" is fine, but my understanding (or,
the intention of the original implementor) of this part of the
protocol is that "packets between the push-cert packet and the
push-cert-end packet carry the meat of the each line of the
certificate, one packet per line".

If pkt-line is allowed to omit the terminating LFs, then it follows
that the receiving ends can simply do something like what I
illustrated in $gmane/273196 (in java or whatever other
implementation platform they use) to collect packets between
"push-cert" and "push-cert-end", knowing that the packets may or may
not have terminating LF and supplying the omitted LFs themselves
when they receive the cert before verifying and storing.

So in order to reconstitute the "raw payload without pkt-line framing",
the omitted LF obviously needs to be added.  Why is that a problem?

    Side note: think of it in a different way.  The key word of the
    first paragraph above is "the meat of"; if your cert has two
    lines

    	"pushee $URL<LF>nonce 1234-5670<LF>"

    the lines in it are "pushee $URL<LF>" and "nonce 1234-5670<LF>"
    but the meat of them are "pushee $URL" and "nonce 1234-5670".

    The protocol wants to carry an array with two elements, ("pushee
    $URL", "nonce 1234-5670"), as the hypothetical cert has two
    lines.  And then "\n".join(the cert array) . "\n" would be how
    you reconstruct the original payload.

    The illustration in $gmane/273196 is slightly cheating in that
    sense.  Instead of first creating an array of plain strings
    without LF termination and joining them together later, it knows
    that we will LF-join in the end, and abuses the LF in the
    original payload that came from the sender and supplies its own
    if the sender omitted it.

It is very similar to and in the opposite of how each ref advertisement
is handled.  Until the first flush, each packet is expected to carry
the object name and the ref name.  A pkt-line framing may add
terminating LF but that obviously is not part of the ref name.

> A naive parser that wants to find the pushee would look for "pushee
> <urlish>", which would be wrong in this case. (To say nothing of the
> fact that "pushee" might actually be "-0700pushee".)
>
> The alternatives for someone writing a parser are:
> a. Store the original pkt-line framing.
> b. Write a parser in some other clever way, e.g. parsing the entire
> cert in reverse might work.
>
> Neither of these is very satisfying, and both reduce human legibility
> of the stored payload.
>
>>> > If LF is optional, then with that approach you might end up with a
>>> > section of that buffer like:
>>>
>>> I think I touched on this in my previous message.  You cannot send
>>> an empty line anywhere, and this is not limited to push-cert section
>>> of the protocol.  Strictly speaking, the wire level allows it, but I
>>> do not think the deployed client APIs easily lets you deal with it.
>>>
>>> So you must follow the "SHOULD terminate with LF" for an empty line,
>>> even when you choose to ignore the "SHOULD" in most other places.
>>>
>>> I do not think it is such a big loss, as long as it is properly
>>> documented.
