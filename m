From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Supplant the "while case ... break ;; esac" idiom
Date: Tue, 25 Sep 2007 08:13:52 +0200
Message-ID: <85hcljgtlr.fsf@lola.goethe.zz>
References: <853ax5mb1j.fsf@lola.goethe.zz> <85myvdktb3.fsf@lola.goethe.zz>
	<7vhcllc9bz.fsf@gitster.siamese.dyndns.org>
	<85ps08k2fj.fsf@lola.goethe.zz> <86bqbsta3g.fsf@lola.quinscape.zz>
	<7vodfr8wts.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:14:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia3gM-0003WA-8p
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754257AbXIYGN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbXIYGN6
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:13:58 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:42087 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751091AbXIYGN5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Sep 2007 02:13:57 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id BE3A927F59;
	Tue, 25 Sep 2007 08:13:55 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id A65EE28EC4E;
	Tue, 25 Sep 2007 08:13:55 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-056-073.pools.arcor-ip.net [84.61.56.73])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 764967FC4;
	Tue, 25 Sep 2007 08:13:55 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id E0D4A1C1E252; Tue, 25 Sep 2007 08:13:52 +0200 (CEST)
In-Reply-To: <7vodfr8wts.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Mon\, 24 Sep 2007 16\:31\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59093>

Junio C Hamano <gitster@pobox.com> writes:

> David Kastrup <dak@gnu.org> writes:
>
>> I am somewhat taken aback that a commit message considered offensive
>> (though I still have a problem understanding why and certainly did not
>> intend this) has been committed into master without giving me a chance
>> to amend it.
>
> Heh, that's simple.  I changed my mind ;-)
>
> When A and B test for preconditions, and C, D, and E are
> operations with error reports as their side effects, we can
> write our loop in these forms:
>
>  (1) while A && B && C && D && E || false; do :; done
>  (2) while A && B && C && D && E || break; do :; done
>  (3) while A && B; do C && D && E || break; do :; done
>  (4) while :; do A && B && C && D && E || break; done
>
> and all of them are equivalent.
>
> But obviously the only sane version is (3).

Uh, it is the only version with a syntax error.

> If your complaint were against things like (1) and (2), I would have
> completely agreed with you.  If you want "effects", you do so
> between do and done.  Although you can use break between do and done
> if you need to conditionally break out of the loop after causing
> some effect there, between while and do is where you are only
> supposed to decide if you want to break out of the loop without
> causing "effects".
>
> But what you were complaining about was different.

Basically

while A && B || break; do C && D && E || break; done

> If we were to ignore broken shells that do not return success
> from a case statement with no matching pattern, the following
> two are equivalent:
>
> 	while case "$sth" in foo) break ;; esac; do ...; done
> 	while case "$sth" in foo) false ;; esac; do ...; done
>
> Their "case" are used to decide if you want to break out of the
> loop; the former is (1) being a bit more explicit, and (2) used
> to be a bit more efficient when false was not built-in.

As a completely irrelevant side note: the autoconf documentation
mentions that "false" is more portable than "true" since calling it
returns a non-zero exit status even when it is not installed or
built-in.

> Now the latter reason is mostly historical and it is not a valid
> reason to choose the former over the latter anymore.  But that does
> not make it any more confusing than the latter to a person who knows
> what "break" means in a loop.  An explicit 'break' is still more,
> eh,... explicit ;-)
>
> But the "break" never was the issue.  Return value of "case" was.

I guess this has been a misunderstanding: for me, personally, the
break was the issue: I don't like breaking out of a condition, since
breaking for me is an action.  I just used the fact that the BSD
shells happen not to grok the constructs (and actually through a
somewhat similar confusion between condition and action) to leverage
my dislike of this construct and propose a patch.

> The reason I took your patch and proposed commit log message
> (almost) as-is was because you rewrote "case" to "test".

Uhm, ok.  It was a case of realizing "hm, this does not really look
much nicer" before I chose to switch to "test".  In fact, there is one
case statement remaining which I rewrote in the previously discussed
manner, and it did not strike me as being much prettier.  So maybe I
somewhat misjudged the core of my offended sense of aesthetics, but
the impetus of the discussion still carried into the commit message.

Alea iacta est ("The SHA-1 has been established").

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
