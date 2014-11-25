From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH] change contract between system_path and it's callers
Date: Tue, 25 Nov 2014 09:55:39 -0800
Message-ID: <xmqqbnnvtbac.fsf@gitster.dls.corp.google.com>
References: <87mw7gae8k.fsf@gmail.com>
	<1416838063-16797-1-git-send-email-kuleshovmail@gmail.com>
	<xmqqoarwwfz1.fsf@gitster.dls.corp.google.com>
	<87ppcc4b2g.fsf@gmail.com>
	<xmqqbnnwwcg0.fsf@gitster.dls.corp.google.com>
	<CANCZXo7yDJCuhKVFG3QfSSoem+KN_9VCbGerTd+5tqQuzA7dbg@mail.gmail.com>
	<CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 18:55:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtKL5-0004pt-Kg
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 18:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbaKYRzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 12:55:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750816AbaKYRzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 12:55:43 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B882F1F2D7;
	Tue, 25 Nov 2014 12:55:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CTFc5rywdh11M7TQIrHKX0r5ABI=; b=m1+0Y1
	AdT0RF766fJ2YkAt/NoJpTDNpB5vmwVe/xVkoHk2xw6ekTd7w1NuK09ji22uxS1y
	MRhaOrJo7cuHVVnyJQXAzagTFaifR87okfCjBQTNEDthyK/VtwQ7ej0Rx2JfBgpI
	MSxSkIi9c6T7EZBz8pNIpeAYc9WWcd4ri7Sq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iSdpCN2uoGGatl3+hvpHtJLD04bt511X
	aQNaFo21Od53tZ5lll/z3IxOukEZgdtoY5KZfV7k1HqX2lLJIry6bFRnPbW/OdUa
	XXyfkYLQZsGu7nM8OOO5qWLL3Pjqz4kyrDE9QqFvlTnQWg6JHrks3qzuwTDqQFgH
	3RJBP/8aa2Y=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A34B91F2D4;
	Tue, 25 Nov 2014 12:55:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EC6821F2D1;
	Tue, 25 Nov 2014 12:55:41 -0500 (EST)
In-Reply-To: <CANCZXo4C_6Zfob9VnxjGxPbsRnUioVqC10z3Hhv09_xtrx-Pog@mail.gmail.com>
	(Alexander Kuleshov's message of "Tue, 25 Nov 2014 13:04:46 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 45B8EC66-74CC-11E4-80B8-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260228>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> But if we still static const char* for git_etc_gitattributes and will
> not free it in bootstrap_attr_stack there will no memory leak, just
> tested it, so i'll remove free for it.

Leak or no leak, freeing there is wrong.  It will free the piece of
memory the next caller will obtain from the git_etc_gitattributes()
function.  In other words, the return value from that function is
owned by git_etc_gitattributes(), not by the caller.

As to "leak", in the strictest sense of the word, i.e. "do we
allocate on the heap and exit without freeing?", it _is_ leaking,
and your above "just tested it" probably means "the tool I used did
not find/report it".  But as I said, it is not something worth
bothering about [*1*].

Think of it this way.

The git_etc_gitattributes() function goes like this with your patch
(and there is no fundamental difference in the original version,
which uses "const char *" where appropriate):

         static char *git_etc_gitattributes(void)
         {
                static char *system_wide;
                if (!system_wide)
                        system_wide = system_path(ETC_GITATTRIBUTES);
                return system_wide;
         }

If you knew that the pathname for /etc/gitattributes substitute will
never be longer than 256 bytes, you may have coded the above like so
instead:

        static char system_wide[256];
        static char *git_etc_gitattributes(void)
        {
                if (!system_wide[0]) {
                        char *ret = system_path(ETC_GITATTRIBUTES);
                        if (strncpy(system_wide, ret, 256) >= 256)
                                die("ETC_GITATTRIBUTES too long ");
                }       
                return system_wide;
        }

Even though we used the memory occupied by system_wide[] and did not
clean up before exit(), nobody would complain about leaking.

The existing code is the moral equivalent of the "up to 256 bytes"
illustration, but for a string whose size is not known at compile
time.  It is using and keeping the memory until program exit.
Nobody should complain about leaking.

That is, unless (1) the held memory is expected to be very large and
(2) you can prove that after the point you decide to insert free(),
nobody will ever need that information again.


[Footnote]

*1* The leaks we care about are of this form:

    void silly_leaker(void)
    {
        printf("%s\n", system_path(ETC_GITATTRIBUTES));
    }

    where each invocation allocates memory, uses it and then loses
    the reference to it without doing anything to clean-up.  You can
    call such a function unbounded number of times and waste
    unbounded amount of memory.

    The implementation of git_etc_gitattributes() is not of that
    kind.  An invocation of it allocates, uses and keeps.  The
    second and subsequent invocation does not allocate.  When you
    call it unbounded number of times, it does not waste unbounded
    amount of memory.  It just keeps what it needs to answer the
    next caller with.

    The pattern needs to be made thread-safe, but that is a separate
    topic.
