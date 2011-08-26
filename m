From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] revision: keep track of the end-user input from the
 command line
Date: Thu, 25 Aug 2011 19:21:08 -0700
Message-ID: <7vy5yggbfv.fsf@alter.siamese.dyndns.org>
References: <20110824213205.GI45292@book.hvoigt.net>
 <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> <7vbovdgf73.fsf_-_@alter.siamese.dyndns.org> <CAGdFq_he-skXpEy903RSY2ravDXo1eVCN19RzJeHXQCT__HTmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brad King <brad.king@kitware.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 04:21:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qwm2n-0007I9-TE
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 04:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab1HZCVM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 22:21:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38312 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866Ab1HZCVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 22:21:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF5D553CF;
	Thu, 25 Aug 2011 22:21:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gMy6BbIwykRY4zIVeWOLVvb8uE8=; b=SB5yOZ
	pXlHxOSwaIQJD6Hf4bnwFwt03fPDvveBHWjWg/rb9Dj4a4T15K0/f12CQPsyVdNT
	4w1AY8hRrNFTI7WW05EHZWARKa7R7MUOMjYgUG7hZarXpYv81+cFtX4Gygn6Q0uc
	EJxSX/jnxD0qDwLf/PHzmmA1uMes1iRJ0OEi8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmTdnYwEhB7b0mc5V9fpv31/f51ypFqp
	tUuDo6cpn/F80FPM2AQeVdB8jh3oyKQRDTzAGchvYa6GAEOyJEPEDanM4MF47af2
	xin2lC50dtleVdHy79QpMz09xRMgL/3m01uT3Vt56zOGahIqYmJs6Z7IsZhscPJX
	lEpRHUJ6XZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D60EA53CE;
	Thu, 25 Aug 2011 22:21:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3967353CD; Thu, 25 Aug 2011
 22:21:10 -0400 (EDT)
In-Reply-To: <CAGdFq_he-skXpEy903RSY2ravDXo1eVCN19RzJeHXQCT__HTmA@mail.gmail.com> (Sverre
 Rabbelier's message of "Thu, 25 Aug 2011 18:08:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 10074FF8-CF8A-11E0-BF36-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180145>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>> Prepare a separate array to keep track of what syntactic element was used
>> to cause each object to appear in the pending array from the command line,
>> and populate it as setup_revisions() parses the command line.
>
> Thank you! I was really dreading looking into this myself, so I'm very
> glad that you could find the time to look into it yourself.

I debated long and hard if I should instead fatten object array entry and
shove this information there without adding a new structure, which would
have resulted in something very similar to what you had, so you should
take some credit for the code, and also credit for a large part of the
motivation (the second paragraph in the log is entirely your use case).

We might end up unifying this command line information array and the
pending object array after reviewing what other future callers would want
from this new information, but at least by doing it this way I can rest
assured that no existing code that is unaware of the mechanism would get
any unintended side effects in the earlier rounds.

>> @@ -835,6 +853,7 @@ static void handle_one_reflog_commit(unsigned char *sha1, void *cb_data)
>>                struct object *o = parse_object(sha1);
>>                if (o) {
>>                        o->flags |= cb->all_flags;
>> +                       /* ??? CMDLINEFLAGS ??? */
>>                        add_pending_object(cb->all_revs, o, "");
>>                }
>>                else if (!cb->warned_bad_reflog) {
>
> What is happening here?

We could have add_rev_cmdline() call there if we really wanted to, but I
decided not to do so for two reasons:

(1) with "rev-list -g HEAD", the user is not explicitly mentioning all
    objects in the reflog of the HEAD---it might still make sense to mark
    HEAD as explicitly mentioned as positive, but the code to do so will
    not sit here anyway; and more importantly,

(2) I was appalled by how broken the design and the implementation of
    walking the reflog was (it shoves _all_ the objects in the entire
    history recorded in the reflog to the pending queue before letting the
    caller do an iota of work). It is against the general design of Git,
    and the design of the revision walk machinery in particular that tries
    very hard to be incremental. It goes against a good software design
    taste.

For the latter reason, I think in the longer term we should correct the
implementation to walk the reflog to keep an iterator (a structure that
holds an open file descriptor to a reflog file, and perhaps a little bit
of buffer) in struct rev_info, and teach get_revisions() to lazily read
from there, reading the file backward. Once that happens, this callback
from for_each_reflog_ent() will go away, so I didn't bother.
