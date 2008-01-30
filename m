From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] prefix_path(): disallow absolute paths
Date: Tue, 29 Jan 2008 16:43:44 -0800
Message-ID: <7vhcgwkurj.fsf@gitster.siamese.dyndns.org>
References: <7vwspts9vj.fsf@gitster.siamese.dyndns.org>
	<47975FE6.4050709@viscovery.net>
	<1201463731-1963-1-git-send-email-shawn.bohrer@gmail.com>
	<alpine.LSU.1.00.0801272043040.23907@racer.site>
	<7v3asiyk2i.fsf@gitster.siamese.dyndns.org>
	<20080128003404.GA18276@lintop>
	<7vodb6wtix.fsf@gitster.siamese.dyndns.org>
	<479D805E.3000209@viscovery.net>
	<7vprvmuykw.fsf@gitster.siamese.dyndns.org>
	<479D9ADE.6010003@viscovery.net>
	<alpine.LSU.1.00.0801281210440.23907@racer.site>
	<200801292158.m0TLwA7u019321@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 01:44:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK148-00057B-St
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 01:44:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752576AbYA3AoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jan 2008 19:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbYA3AoG
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 19:44:06 -0500
Received: from rune.pobox.com ([208.210.124.79]:34290 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752334AbYA3AoF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Jan 2008 19:44:05 -0500
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 8E61618ECD1;
	Tue, 29 Jan 2008 19:44:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7135818EB5C;
	Tue, 29 Jan 2008 19:44:13 -0500 (EST)
In-Reply-To: <200801292158.m0TLwA7u019321@mi0.bluebottle.com>
	(nanako3@bluebottle.com's message of "Wed, 30 Jan 2008 06:53:48
	+0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72017>

=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93  <nanak=
o3@bluebottle.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>...
>> And not passing such ambiguous path like "fo//o" to the core
>> level but sanitizing matters.  Then core level can always do
>> memcmp() with "fo/o" to see they are talking about the same
>> path.
>
> I may be mistaken but I think "fo//o" and "fo//o/" are
> returned as two different strings "fo/o" and "fo/o/" from your
> patch. Shouldn't you clean-up the second one to "fo/o", too?

That certainly is a potentially possible sanitization, and I
actually thought about it when I did these patches.

However, I chose not to because I was not sure if some core
functions want to differentiate pathspecs "foo/" and "foo".  The
former says "I want to make sure that 'foo' is a directory, and
want to affect everything under it", the latter says "I do not
care if 'foo' is a blob or a directory, but I want to affect it
(if a blob) or everything under it (if a directory)".

In fact, stripping trailing slashes off would break this pair:

	git ls-files --error-unmatch Makefile/
	git ls-files --error-unmatch Makefile

Things like "git add Makefile/" relies on the former to fail
loudly.  So the answer is no, we do not want to clean it up.

Incidentally, I notice that in addition to the squashed patch
from yesterday, we would need to teach "error-unmatch" code that
it should trigger when get_pathspec() returns a pathspec that
has fewer number of paths than its input.

It should be a pretty straightforward patch, but I haven't
looked into fixing it.  I'm lazy and I'd rather have other
people to do the fixing for me.  Hint, hint... ;-)

By the way, please keep your lines to reasonable length by
wrapping in your e-mailed messages.
