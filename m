From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix "git log -i --grep"
Date: Sun, 24 Aug 2008 22:12:34 -0700
Message-ID: <7vmyj1isot.fsf@gitster.siamese.dyndns.org>
References: <g8jbvd$18k$1@ger.gmane.org>
 <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm>
 <20080822165047.GA3339@sigill.intra.peff.net>
 <7vzln492pc.fsf@gitster.siamese.dyndns.org>
 <20080825013837.GA17201@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 07:15:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXUQm-0005RW-Rv
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 07:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbYHYFMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 01:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbYHYFMk
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 01:12:40 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYHYFMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 01:12:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB7166E049;
	Mon, 25 Aug 2008 01:12:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 42EF96E048; Mon, 25 Aug 2008 01:12:36 -0400 (EDT)
In-Reply-To: <20080825013837.GA17201@coredump.intra.peff.net> (Jeff King's
 message of "Sun, 24 Aug 2008 21:38:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FD52EE0-7264-11DD-90C4-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93596>

Jeff King <peff@peff.net> writes:

> On Fri, Aug 22, 2008 at 02:09:35PM -0700, Junio C Hamano wrote:
>
>>     [alias]
>>         who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"
>
> I have two improvements for this, and one of them caused me to find a
> git bug, for which the fix is below. :)
>
>   1. I tried this with --no-pager, which made it obvious that this
>      should be using --pretty=tformat to append a newline.

Strict reading of POSIX suggests that you are not supposed to send an
input that has incomplete line to "sed", so tformat may be the right thing
to use for that reason as well.

However.

My sed is non POSIX in a good sense and does not have problem handing such
an input, and my use case is to say "\C-u \M-! git who Jeff <ENTER>" while
typing e-mail message, and I do _not_ want an extra newline after the
input.  That is why I use format: (not tformat:) there.

> The fix is to allocate the grep_filter member whenever we
> get _any_ grep information, be it actual filters or just
> flags. Thus checking for non-NULL revs->grep_filter is no
> longer sufficient to know that we have patterns; in
> commit_match we must actually check that the pattern list is
> not empty.

Well spotted, and thanks for the fix.

As you suggested, making the grep option structure embedded in rev_info
may not be a bad idea.  We used to keep track of the sub-options
separately while we encounter, and updated grep_filter at the end of the
loop, but the conversion to use parse-options broke it.

The only issue I still have, which I suspect your fix has made it easier
to address, is to complain if sub-options to grep like -i and -E are given
without --grep.  That's not something v1.5.6 series did, though.
