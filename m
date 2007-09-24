From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Mon, 24 Sep 2007 16:31:27 -0700
Message-ID: <7vodfr8wts.fsf@gitster.siamese.dyndns.org>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<7vhcllc9bz.fsf@gitster.siamese.dyndns.org>
	<85ps08k2fj.fsf@lola.goethe.zz> <86bqbsta3g.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Sep 25 01:31:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZxOu-0003s2-Fu
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 01:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758257AbXIXXbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 19:31:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758173AbXIXXbd
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 19:31:33 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:32862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbXIXXbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 19:31:33 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 24C741394D1;
	Mon, 24 Sep 2007 19:31:51 -0400 (EDT)
In-Reply-To: <86bqbsta3g.fsf@lola.quinscape.zz> (David Kastrup's message of
	"Mon, 24 Sep 2007 16:24:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59079>

David Kastrup <dak@gnu.org> writes:

> I am somewhat taken aback that a commit message considered offensive
> (though I still have a problem understanding why and certainly did not
> intend this) has been committed into master without giving me a chance
> to amend it.

Heh, that's simple.  I changed my mind ;-)

When A and B test for preconditions, and C, D, and E are
operations with error reports as their side effects, we can
write our loop in these forms:

 (1) while A && B && C && D && E || false; do :; done
 (2) while A && B && C && D && E || break; do :; done
 (3) while A && B; do C && D && E || break; do :; done
 (4) while :; do A && B && C && D && E || break; done

and all of them are equivalent.

But obviously the only sane version is (3).

If your complaint were against things like (1) and (2), I would
have completely agreed with you.  If you want "effects", you do
so between do and done.  Although you can use break between do
and done if you need to conditionally break out of the loop
after causing some effect there, between while and do is where
you are only supposed to decide if you want to break out of the
loop without causing "effects".

But what you were complaining about was different.

If we were to ignore broken shells that do not return success
from a case statement with no matching pattern, the following
two are equivalent:

	while case "$sth" in foo) break ;; esac; do ...; done
	while case "$sth" in foo) false ;; esac; do ...; done

Their "case" are used to decide if you want to break out of the
loop; the former is (1) being a bit more explicit, and (2) used
to be a bit more efficient when false was not built-in.

Now the latter reason is mostly historical and it is not a valid
reason to choose the former over the latter anymore.  But that
does not make it any more confusing than the latter to a person
who knows what "break" means in a loop.  An explicit 'break' is
still more, eh,... explicit ;-)

But the "break" never was the issue.  Return value of "case"
was.

The reason I took your patch and proposed commit log message
(almost) as-is was because you rewrote "case" to "test".  That
IS an improvement, especially in the presense of a shell in the
field that does not implement case statement correctly, and you
talk about that in the later part of the commit log message.

The only "offending" part was "I consider...ugly", which is your
opinion but I think you as the patch author deserve to express
that.  I do not think it would not have helped the FreeBSD shell
a bit if you removed that "ugliness" by merely replacing "break"
with "false", so I think the comment was not just offending but
irrelevant, though.

All the rest of your commit message is correct.  The spec of
"case" might not be obvious to everybody that it ought to return
success when no pattern matched.  And I found your wording to
fold the bug decription of some BSD shells there amusing ;-)
