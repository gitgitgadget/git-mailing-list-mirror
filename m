From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Mon, 11 Jan 2016 15:51:53 +0000
Message-ID: <20160111155153.GE3397@logi.codethink.co.uk>
References: <20160107165417.GB3397@logi.codethink.co.uk>
 <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
 <xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 16:52:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIelJ-0008Rq-HJ
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 16:52:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760254AbcAKPwA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 10:52:00 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43175 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758503AbcAKPv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 10:51:59 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id DDD6E4621BE;
	Mon, 11 Jan 2016 15:51:57 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iyEYtkY1y0A; Mon, 11 Jan 2016 15:51:55 +0000 (GMT)
Received: from logi.codethink.co.uk (unknown [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id B2A09461F40;
	Mon, 11 Jan 2016 15:51:55 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283659>

On Fri, Jan 08, 2016 at 01:37:02PM -0800, Junio C Hamano wrote:

Thanks for the write-up.
I knew most of how the protocol worked, but not all,
and I appreciate the write-up of how the extension could work.

If I have time I can see if I can implement this protocol extension myself.

<snip>
> While that consistency principle must hold everywhere in our system,
> it does not mean a client cannot ask a server to do something whose
> result it has to trust, at least to some degree, because there is
> fundamentally no way to independenty verify the result.

So there'll be a greater level of trust required in the transport protocol,
so you wouldn't necessarily want to allow this protocol over git:// or http://.

<snip>
> So if you want to do this, a new protocol extension needs to allow
> your updated sender (upload-pack) and receiver (fetch-pack) to work
> more like this:
> 
>  * The sender would advertise "I support that extension", while
>    giving the usual "here are my refs and its current values".
> 
>  * The receiver would say "I want to use that extension", and to
>    each of its "want" (which usually consists of "want" followed by
>    an object name and nothing else), it optionally adds names of the
>    objects it wants to verify ancestry relationship with.
> 
>    E.g. if you have O at the tip of the master branch and P at the
>    tip of the maint branch, the sender has N at both of these two
>    branches, and if you are updating your master and maint with
>    their master and maint, you would say something like "want N O P"
>    to tell the sender that you want history leading to N, and you
>    want to see if N is a descendant of O and if N is a descendant of
>    P.
> 
>  * The receiver and the sender then does the usual "have"/"ack"
>    exchange, which does not have to change any behaviour with this
>    extension.
> 
>  * Finally, when the sender sends out the resulting packfile, it
>    also has to tell the receiver which of the object pairs the
>    receiver asked it to check the ancestry relationship violate the
>    fast-forward rule.  In the earlier example of fast-forwarding O
>    and P with N, where the receiver asked "want N O P", the receiver
>    asked to check object pairs <N, O> and <N, P>.  If P fast-forwards
>    to N but O does not, then the sender would tell the receiver the
>    fact that "O does not fast forward to N".

So this would be another step after the receiver communicates "done",
but before the pack file itself gets sent,
so the sender can determine that it doesn't need to tell the reciever
the relationship between two commits,
since it knows you can work it out yourself?

Otherwise if it can probably communicate the relationships before the have list
is sent, and extend the shallow-update part of the protocol instead, which
might be simpler.

> With such an extension, your updated receiver can receive the
> necessary objects to update your history to "N", but notice that it
> would result in non-ff update to update master (that used to be O)
> with the new commit N.

Code-wise, does the following make sense?

1.  Add a field to `struct ref` to flag a "trusted fast-forward".
2.  Change `find_common()` in `fetch-pack.c`
    and `receive_needs()` in `upload-pack.c`
    to communicate the relationships we're interested in as above,
    and set the "trusted fast-forward" flag.
3.  Change `update_local_ref()` in `builtin/fetch.c`
    to check `ref->trusted_fast_forward || in_merge_bases(current, updated)`.
