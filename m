From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pretty.c: add %z specifier.
Date: Thu, 20 Mar 2008 22:09:27 -0700
Message-ID: <7vtzj0slx4.fsf@gitster.siamese.dyndns.org>
References: <5d46db230803201745mb736e98w4925e14b5d92d71d@mail.gmail.com>
 <7veja4u1gv.fsf@gitster.siamese.dyndns.org>
 <20080321045137.GA5563@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Govind Salinas <govind@sophiasuchtig.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcZWO-0004Vs-Ti
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 06:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbYCUFJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 01:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752683AbYCUFJn
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 01:09:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45031 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751545AbYCUFJm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 01:09:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 888AA2D12;
	Fri, 21 Mar 2008 01:09:41 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 380F42D11; Fri, 21 Mar 2008 01:09:35 -0400 (EDT)
In-Reply-To: <20080321045137.GA5563@coredump.intra.peff.net> (Jeff King's
 message of "Fri, 21 Mar 2008 00:51:37 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77715>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 20, 2008 at 09:48:16PM -0700, Junio C Hamano wrote:
>
>> > +	case 'z':		/* null */
>> > +		strbuf_addch(sb, '\0');
>> > +		return 1;
>> >  	}
>> >
>> >  	/* these depend on the commit */
>> 
>> I do not like this at all.  Why aren't we doing %XX (2 hexadecimal digits
>> for an octet)?
>
> Because %ad is already taken? :)
>
> %x* is still available, though, so maybe %x00?

Perhaps, but before I forget.

My much bigger niggle about the "--pretty=format:<>" code I have is that
the "log" machinery does not change the usual record "delimiter" to record
"terminator" when --pretty=format:<> is in effect.

The "log" family generally treats LF/NUL as record delimiter, not
terminator, and it is by a very good conscious design.  When you are
looking at the output from "git log -2", you would want to have a
delimiting LF between the first commit and the second commit, but you do
not want an extra LF after the second commit.

However, when "--pretty=format:<>" is in effect, it is inconvenient that
the machinery inserts a LF between each record but not at the end.

    $ git log -2 --pretty=format:%s

may look sane when the pager immediately returns the control to you, but
it is not really.  To view it:

    $ git log -2 --pretty=format:%s | cat

This would show that there is no LF after the final output, which is quite
bad.
