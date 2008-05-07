From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Wed, 07 May 2008 13:02:54 -0700
Message-ID: <7vabj1dgr5.fsf@gitster.siamese.dyndns.org>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
 <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>
 <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com>
 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>
 <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>
 <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>
 <alpine.DEB.1.00.0805060954470.30431@racer>
 <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
 <alpine.DEB.1.00.0805071223450.30431@racer>
 <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
 <20080507194524.GA31500@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 07 22:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtps5-0005UH-N7
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 22:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbYEGUDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755388AbYEGUDX
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 16:03:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252AbYEGUDH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 16:03:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 840DC46ED;
	Wed,  7 May 2008 16:03:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7ED8146EB; Wed,  7 May 2008 16:02:58 -0400 (EDT)
In-Reply-To: <20080507194524.GA31500@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 7 May 2008 15:45:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9B1D4CE4-1C70-11DD-8134-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81477>

Jeff King <peff@peff.net> writes:

> But more big-picture, comparing the output of the old color words and
> this implementation, there is one thing I don't like: the new one
> doesn't bring together runs of additions and deletions, which can make
> parsing text much easier. For example:
>
>   $ echo This is a complete sentence. >one
>   $ echo Here is some totally different text. >two
>
>   # with old implementation; /-.../ is red, /+.../ is green
>   $ git diff --color-words one two
>   ...
>   /-This/ /+Here/ is /-a complete sentence./+some totally different text./
>
>   # with this patch
>   $ git diff --color-words one two
>   ...
>   /-This/+Here/ is /-a/+some/ /-complete/+totally/ /-sentence./+different text./

I suspect that heavily depends on the input text.  If you drop "different"
in the example, the output becomes:

    {-This|+Here} is {-a|+some} {-complete|+totally} {-sentence.|+text.}

which is totally sensible.

You can get the output that is closer to the original by tweaking the
definition of what a token is.  You can for example define a token as "0 or
more non whitespace characters followed by 1 or more whitespace characters"
and then the internal diff would become ($ to show the end of line):

    -This $
    +Here $
     is $
    -a $
    -complete $
    -sentence.$
    +some $
    +totally $
    +different $
    +text.$

which would yield on the output:

    {-This |+Here }is {-a complete sentence.|+some totally different text.}

It's all in diff_words_tokenize(), which I kept deliberately stupid so
that people can tweak it to their liking.
