From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 10:15:55 -0800
Message-ID: <7vmydstoys.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de>
 <87ljtdk9b3.fsf@iki.fi> <200901142059.09005.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901142258250.3586@pacific.mpi-cbg.de>
 <8763khtbfc.fsf@iki.fi>
 <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 15 19:17:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNWmd-0008Hh-4W
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 19:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756193AbZAOSQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 13:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755017AbZAOSQI
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 13:16:08 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37755 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712AbZAOSQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 13:16:07 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7E90390A18;
	Thu, 15 Jan 2009 13:16:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 23FA390A15; Thu,
 15 Jan 2009 13:15:56 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901151337080.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Thu, 15 Jan 2009 13:41:37 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 91C69268-E330-11DD-9101-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105861>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> BTW this gets even worse when you compare the following:
>
> bbb aaa
> ccc aaa
>
> --color-words=a+ will show
>
> ccc aaa

Naive question.  What is the expected output?

The user defines that "a", "aa", "aaa",... are words and everything else
is the background that the words float on, and asks --color-words to color
code where the words differ.  The way to show them is to have the words in
red (if it comes from preimage) or in green (if it comes from postimage) on
top of some background.

In this case, there is no difference in words, and the only difference is
the background.  Should we still see any output?  Shouldn't it behave more
like "diff -w" that suppresses lines that differ only in whitespace?

I didn't see the semantics of color-words documented in the original
either, and I think it should be described in a way humans would
understand (in other words, "here is what we do internally, splitting
words into lines, running diff between them and coalescing the result in
this and that way, and whatever happens to be output is what you get" is
not the semantics that is explained in a way humans would understand).

The above "The way to show them is to have the words in red (if it comes
from preimage) or in green (if it comes from postimage) on top of some
background." was my attempt to describe an easier half of the semantics,
but I am not sure what definition of "some background" the current draft
code is designed around; I think the original's definition was "we discard
the background from either preimage or postimage and insert whitespace
outselves between the words we output; the only exception is the
end-of-line that appears in the postimage which we try to keep" or
something like that, but that is not written in the documentation either.

How should the background computed to draw the result on?  If a
corresponding background portion appear in both the preimage and the
postimage, we use the one from the postimage?  That justifies why bbb is
not shown but ccc is, when you compare these two:

  bbb aaa
  ccc aa

What happens if a portion of background is only in the preimage?
E.g. when these two are compared:

  bbb aaa bb aa b
  ccc aaa cc

what should happen?  We would want to say "aa" was removed by showing it
in red, but on what background should it be displayed?  cc <red>aa</red>
b?
