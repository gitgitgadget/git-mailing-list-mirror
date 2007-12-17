From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-tag: fix fallouts from recent parsopt restriction.
Date: Mon, 17 Dec 2007 11:52:29 -0800
Message-ID: <7vy7bt6qv6.fsf@gitster.siamese.dyndns.org>
References: <20071213055226.GA3636@coredump.intra.peff.net>
	<20071213090604.GA12398@artemis.madism.org>
	<20071213091055.GA5674@coredump.intra.peff.net>
	<20071213093536.GC12398@artemis.madism.org>
	<20071213102636.GD12398@artemis.madism.org>
	<7vd4t5eq52.fsf@gitster.siamese.dyndns.org>
	<20071217090749.GC7453@artemis.madism.org>
	<7vir2xa8z7.fsf@gitster.siamese.dyndns.org>
	<20071217105834.GG7453@artemis.madism.org>
	<7v1w9la7o8.fsf@gitster.siamese.dyndns.org>
	<20071217123307.GK7453@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4M1n-0001Bd-Ag
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 20:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935817AbXLQTwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 14:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765238AbXLQTwn
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 14:52:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935840AbXLQTwl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 14:52:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 17AC53E59;
	Mon, 17 Dec 2007 14:52:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D9033E58;
	Mon, 17 Dec 2007 14:52:31 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68606>

Pierre Habouzit <madcoder@debian.org> writes:

> After having written this mail 4 time already, I came up with an idea I
> kind of like: like find, we could make {} be a placeholder for the
> "default" argument. For example:
>
>   $ git foo --abbrev {} 10
>   $ git log -M {} 1
>   ...
>
> {} would have the same semantics as your --long-opt-default. It tells the
> option parser that "no there isn't anything to grok for that command thank you
> very much". Of course if for some reason you really want to pass "{}" to the
> command, the stuck form holds:
>
>   $ git foo --long-opt={}
>   $ git foo -o{}
>
> What do you think ?

1. {} means a completely different thing to find ("place the real value
   here"); there is no similarity.  I would strongly oppose to it.  If
   you want to invoke opt with default but still want to pass "{}" as an
   argument unrelated to that opt, you would do "--opt={} {}".  That's
   double ugly.

2. For a long option with optional option-argument, --abbrev-default (or
   in the other order, --default-abbrev) to mark "there is no option
   argument, do not do your context sensitive parsing" and using an
   explicit '=' (e.g. --abbrev=<value>) to mark "this is the argument,
   do not do your context sensitive parsing" is much more readable.

3. There are only handful options with optional option-argument that
   does not have long format.  I think it is reasonable to require
   "stuck argument" to them.  For most of the short options that take
   optional option-argument, traditionally we did not allow them to be
   spelled as separate words, so there is no regression to introduce
   such a behaviour.  -B/-M/-C options to diff family would be handled
   sanely this way.

   Another possibility, which I do not like very much, is to add long
   format to them, if only for paranoid scripters who want rename
   detection with the default threshold and cannot say "diff -M $foo".
   They can say "diff --detect-rename-default $foo" instead ("-M" is a
   bad example here, as giving a single path never makes sense for -M so
   $foo cannot be a file whose name is e.g. "20", and default number of
   abbreviated commit object name is longer than 2 which means it would
   make it longer than "percentage" form of threshold).

So in short, for an option that takes optional option-argument:

   - if it is given as "--<long-name>-default", there is no optional
     argument, period.

   - if it is given as "--long-name" but there is no next word, there is
     no optional argument, either.

   - if it is given as "--long-name=value", that "value" is the
     argument.  Barf if it does not validate.

   - if it is given as "--long-name", and there is a next word, see if
     that is plausible as its argument.  Get it and signal the caller
     you consumed it, if it is.  Ignore it and signal the caller you
     didn't, if it isn't.

   - if it is given as "-svalue", that "value" is the argument.  Barf if
     it does not validate.

   - if it is given as "-s", and there is a next word, and if the option
     has long format counterpart as well, then see if the next word is
     plausible as its argument.  Get it and signal the caller you
     consumed it, if it is.  Ignore it and signal the caller you didn't,
     if it isn't.

   - if it is given as "-s" but the previous rule did not trigger, there
     is no optional argument.
