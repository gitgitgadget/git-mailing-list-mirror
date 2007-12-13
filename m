From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 09:40:23 -0800
Message-ID: <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 18:42:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2s4c-0003EB-NI
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 18:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765555AbXLMRkj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 12:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765550AbXLMRki
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 12:40:38 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41148 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765547AbXLMRkh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 12:40:37 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C45373AE;
	Thu, 13 Dec 2007 12:40:30 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 65DC473AD;
	Thu, 13 Dec 2007 12:40:25 -0500 (EST)
In-Reply-To: <20071213093536.GC12398@artemis.madism.org> (Pierre Habouzit's
	message of "Thu, 13 Dec 2007 10:35:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68178>

Pierre Habouzit <madcoder@debian.org> writes:

> In fact we have kind of the issue for every single optional argument out
> there:
>
> $ git describe --abbrev HEAD
> error: option `abbrev' expects a numerical value
> [...]
>
>   *ouch*
>
> So I believe that with optional arguments we must change the way we do
> things, and that we _must_ enforce the argument to be sticked in that
> case.

I think "Must" is a bit too strong an expression.

	git describe --abbrev 7 HEAD
        git describe --abbrev HEAD
        git describe --abbrev=HEAD
	git describe --abbrev=7 HEAD
	git describe --abbrev

The --abbrev parser in this case could be asked with this question: "You
are on the command line.  There is a token after you.  Is it your
parameter?".

Among the above cases, the third one through the last one will get slightly
different questions.  The third and fourth ones get "You are given this
parameter and it must be yours", and the last one gets "You are on the
command line, and were not given any parameter."

The parser can do one of these things:

 * Inspect the token, if exists, and see if it is appropriate for it.

   * If not

     - if it is optional, then take the default value, and answer "I
       handled myself Ok, but that HEAD is not mine";

     - if it "must be yours" (the third case), barf.

   * If so

     - Use that given value and answer "I handled myself Ok, and that
       parameter 7 is mine";  this includes the fourth case as well.

And this does not have to be callback for common types like integers.
