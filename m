From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 02:53:00 -0800
Message-ID: <7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
	<7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
	<20071217090749.GC7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 11:54:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Dby-0002Sj-IO
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 11:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbXLQKxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 05:53:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934633AbXLQKxP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 05:53:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63913 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763452AbXLQKxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 05:53:13 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4541D35A8;
	Mon, 17 Dec 2007 05:53:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 99A2535A7;
	Mon, 17 Dec 2007 05:53:02 -0500 (EST)
In-Reply-To: <20071217090749.GC7453@artemis.madism.org> (Pierre Habouzit's
	message of "Mon, 17 Dec 2007 10:07:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68535>

Pierre Habouzit <madcoder@debian.org> writes:

>   Okay this is kind of disgusting, and I'm absolutely not pleased with
> it (I mean I'm not pleased that parse_opt forces us to write things like
> that).
> ...
> I'll try to think harder about what we can do about it. Though for now,
> we will have to go for it for a while.

This is just a quick idea before I go back to sleep, but your earlier
comment on "--no-<an-option-that-is-not-even-boolean>" made me realize
that the alternative I was suggesting earlier would actually work much
nicer, if you introduce "--<an-option-that-take-optional-arg>-default"
magic.

Then, normal users who know what the value of $foo is (iow, not scripts)
can say:

	git cmd --abbrev 10
        git cmd --abbrev HEAD
        git cmd --abbrev=10 HEAD

and scripts that want to have $foo to be treated as rev, even when it
consists entirely of digits, can say:

	git cmd --abbrev-default $foo

to disambiguate (i.e.  like "--no-" magic, "-default" is a magic, and it
tells the parser that "there is no option-argument given to this").

To make sure $foo is treated as the precision, the script can say:

	git cmd --abbrev=$foo

If the script wants DWIM just like human users want, it can do:

	git cmd --abbrev $foo

There of course is a little details called coding, but I think this is
probably the most user friendly to the users and the scripts alike.  It
certainly is nicer than what the current parse_options() does, and/or
the git-tag workaround does.
