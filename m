From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 03:13:14 -0800
Message-ID: <7v7ijda81h.fsf@gitster.siamese.dyndns.org>
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
X-From: git-owner@vger.kernel.org Mon Dec 17 12:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Dv1-0000Ee-7B
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 12:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933723AbXLQLNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 06:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933295AbXLQLNd
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 06:13:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64540 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765553AbXLQLNc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 06:13:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1FD93AB0;
	Mon, 17 Dec 2007 06:13:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FB843AAF;
	Mon, 17 Dec 2007 06:13:20 -0500 (EST)
In-Reply-To: <20071217090749.GC7453@artemis.madism.org> (Pierre Habouzit's
	message of "Mon, 17 Dec 2007 10:07:49 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68543>

Pierre Habouzit <madcoder@debian.org> writes:

>   Okay this is kind of disgusting, and I'm absolutely not pleased with
> it (I mean I'm not pleased that parse_opt forces us to write things like
> that). This hack allows:
>
>   git tag -l -n10 <pattern>
>
> and will then attach the <pattern> to the '-l' switch,...

Heh, it turns out that we were both stupid and blind.

Look at contrib/examples/git-tag.sh again.

The original addition of "-n <count>" was suboptimal and did not allow
"git tag -l -n10 <glob>", but I would actually call that a bug of the -n
<count> implementation (it wanted to affect working of other option, so
at that point it should have restructured the loop and made parsing of
options and carrying out of actions separate steps).

The -l option tells "git tag" to work in "list tags" mode, and in that
mode, the command itself takes zero or one (we could have taken more but
we didn't) glob to limit the listing.  The <glob> is not even an option
argument to option -l, but the arguments to "git tag" command itself.

So "git-tag -l" was a bad example of an option that takes optional
option-argument, and you can see that the conversion to parse_options()
done in 396865859918e9c7bf8ce74aae137c57da134610 (Make builtin-tag.c use
parse_options.) broke it.

IOW, the fixup I posted was not a workaround but happens to be a bugfix
to the above commit that did parse_options() conversion.
