From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC 1/4 v2] Implement a basic remote helper for svn in C.
Date: Thu, 26 Jul 2012 10:29:51 -0700
Message-ID: <7vlii68m7k.fsf@alter.siamese.dyndns.org>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <23122876.7xH9dZiP4M@flobuntu> <20120702110741.GA3527@burratino>
 <44779150.xA3SZNmQ1h@flomedio> <20120726090842.GA4999@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRsv-0008Mw-9t
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:30:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab2GZR3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:29:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45054 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751562Ab2GZR3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2012 13:29:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC6E6879E;
	Thu, 26 Jul 2012 13:29:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sNk3fzYfPjAxde1eTwP7hSe2YTU=; b=ycAVGa
	ZUZexf90Hxq65pJ9kVL4zK05Ac3SQvMsii7TgoJClGfKVL+7tnv7it8TOEFPq/4t
	48iajHCag3fdJBnND2AvTbfj/JjF+xtmqLFg82uFTTWMRtuG0gASMFbH0tcFbC7q
	pOO6R962BbePFa3A7DSfxFY4ox1BUexDgZ5YE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Scthom86e52gXgNvO+PwbeKM/17z/XzB
	Sgp9cQ3CuiahRSz3EzlxvKVuv0zHQPW8WHMbO1OklLYw0fYvHPJz5RtikBYX3B36
	i6cxL/r0cKrSgxRHVfhSjQtrkDrEDtBYNzj3e/VI37NVgvglCh7uFb9bZr/lRLba
	bFIEyle1Dto=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9289879D;
	Thu, 26 Jul 2012 13:29:53 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B8E2879C; Thu, 26 Jul 2012
 13:29:53 -0400 (EDT)
In-Reply-To: <20120726090842.GA4999@burratino> (Jonathan Nieder's message of
 "Thu, 26 Jul 2012 04:08:42 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82A3D66A-D747-11E1-9F3F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202282>

Jonathan Nieder <jrnieder@gmail.com> writes:

> [...]
>>>> +
>>>> +enum cmd_result { SUCCESS, NOT_HANDLED, ERROR };
> [...]
>> Hm.. the enum now has SUCCESS, NOT_HANDLED, TERMINATE.
>
> Much nicer.
>
> I think this tristate return value could be avoided entirely because...
> ... it isn't needed at the moment.

I am not sure what you mean by that.

The command dispatcher loop in [Patch v2 1/16] seems to call every
possible input handler with the first line of the input and expect
them to answer "This is not for me", so NOT_HANDLED is needed.

An alternative dispatcher could be written in such a way that the
dispatcher inspects the first line and decide what to call, and in
such a scheme, you do not need NOT_HANDLED. My intuition tells me
that such an arrangement is in general a better organization.

Looking at what cmd_import() does, however, I think the approach the
patch takes might make sense for this application.  Unlike other
handlers like "capabilities" that do not want to handle anything
other than "capabilities", it wants to handle two:

 - "import" that starts an import batch;
 - "" (an empty line), but only when an import batch is in effect.

A centralized dispatcher that does not use NOT_HANDLED could be
written for such an input stream, but then the state information
(i.e. "are we in an import batch?") needs to be global, which may or
may not be desirable (I haven't thought things through on this).

In any case, if you are going to use dispatching based on
NOT_HANDLED, the result may have to be (at least) quadri-state.  In
addition to "I am done successfully, please go back and dispatch
another command" (SUCCESS), "This is not for me" (NOT_HANDLED), and
"I am done successfully, and there is no need to dispatch and
process another command further" (TERMINATE), you may want to be
able to say "This was for me, but I found an error" (ERROR).

Of course, if the dispatch loop has to be rewritten so that a
central dispatcher decides what to call, individual input handlers
do not need to say NOT_HANDLED nor TERMINATE, as the central
dispatcher should keep track of the overall state of the system, and
the usual "0 on success, negative on error" may be sufficient.

One thing I wondered was how an input "capability" (or "list")
should be handled after "import" was issued (hence batch_active
becomes true).  The dispatcher loop in the patch based on
NOT_HANDLED convention will happily call cmd_capabilities(), which
does not have any notion of the batch_active state (because it is a
function scope static inside cmd_import()), and will say "Ah, that
is mine, and let me do my thing."  If we want to diagnose such an
input stream as an error, the dispatch loop needs to become aware of
the overall state of the system _anyway_, so that may be an argument
against the NOT_HANDLED based dispatch system the patch series uses.
