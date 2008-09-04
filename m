From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 04 Sep 2008 12:34:19 -0700
Message-ID: <7vy7271z9g.fsf@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
 <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
 <20080904140902.GY10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 04 21:35:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbKcE-0005nH-Km
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 21:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754732AbYIDTec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 15:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754691AbYIDTec
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 15:34:32 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46476 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754554AbYIDTeb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 15:34:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 28C0E730EE;
	Thu,  4 Sep 2008 15:34:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D7CD5730E4; Thu,  4 Sep 2008 15:34:24 -0400 (EDT)
In-Reply-To: <20080904140902.GY10544@machine.or.cz> (Petr Baudis's message of
 "Thu, 4 Sep 2008 16:09:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7E3E5644-7AB8-11DD-986E-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94953>

Petr Baudis <pasky@suse.cz> writes:

> On Thu, Sep 04, 2008 at 01:31:19AM -0700, Junio C Hamano wrote:
>> To handle --author=<match> request, the code created a grep instruction
>> that tried to match a line that begins with 'author ' and <match>
>> somewhere on the same line.  "begins with 'author '" obviously needs to be
>> expressed with an regexp '^author '.
>> 
>> When the user specifies --fixed-string, this does not work at all.
>> 
>> This extends the grep machinery so that a match insn can ignore user
>> specified --fixed-string request, and uses the '( -e A --and -e B )'
>> construct from the grep machinery in order to express "has to begin with
>> '^author ', and also the same line must match the given pattern".
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Wow, this is clever solution! FWIW,

Actually, it is not clever at all.

It is a more natural solution, than what we originally had, at least from
the view of somebody who wrote our grep superstructure.  We use stock
regexp(3) library for finding individual matches, but the layer on top of
that to implement the default behaviour to --or hits together from
multiple expressions, optionally --and hits to find a line that has both
expressions, parenthesize to form groups of expressions etc. are all our
inventions.

One related thing I suspect many people haven't realized is that "git log"
can use "--all-match".

These two do different things:

	$ git log --author=Linus --grep=revision
	$ git log --all-match --author=Linus --grep=revision

The former finds commits that talk about "revision" by anybody, or commits
by Linus where he may or may not talk about "revision".  The latter finds
only commits by Linus where he talks about a word "revision" in the log
message.

I've been wondering if we want to make --all-match the default for
revision traversal family (i.e. "git log"), as I suspect it would match
people's expectations more naturally, even though it is a backward
incompatible change.  It is backward incompatible only because the
original implementation was stupid ;-).
