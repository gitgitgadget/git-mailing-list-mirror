From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick with symlinks fails horribly
Date: Thu, 11 Mar 2010 21:49:23 -0800
Message-ID: <7vljdyt7h8.fsf@alter.siamese.dyndns.org>
References: <c6c947f61003081728u48292de4x6f2c26e1ea9c1756@mail.gmail.com>
 <201003110557.11268.chriscool@tuxfamily.org>
 <c6c947f61003110416l40a85b6fg7ede2403a8f6961b@mail.gmail.com>
 <201003120448.22821.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Gladysh <agladysh@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 12 06:49:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Npxki-0008La-IM
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 06:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192Ab0CLFtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 00:49:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37319 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab0CLFtc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 00:49:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0182AA1356;
	Fri, 12 Mar 2010 00:49:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+mAWTV8gN5ARYUHJG7byS4QnFak=; b=G1j0NV
	Tli+kOBb5ie7ZVT0GKwzkGVJJ3oeoYG4TZl+7xwaUWQKmglQN3n/H8pQYv3o+2Xl
	9zmf8BZi3jHH3a/WZ8GG+9+tQMHfLyNbMfImY2bXLXeiA+1AEav+5TRJC8Ayi6Pi
	mqa6Dn+Lqz79XVbedVwSH4QuSNZzjQq0f3R/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JvLysOeOUuXvPogXgCIooJ5WEUeEjQsq
	4dvpDvj+GiuZV8IiE9+zu2PE8fanpPks3p6rqY5bxFF4mxmHAOwnlo6VPwQm1E+J
	iPoEsTUdgJ0hvlIwZHu6T6/bwaHqgzKR/w9z3L2biw7/QfQqdBlU4ssfcDOSUesY
	VTrr5iRXSq0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF447A1355;
	Fri, 12 Mar 2010 00:49:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDF18A1354; Fri, 12 Mar
 2010 00:49:24 -0500 (EST)
In-Reply-To: <201003120448.22821.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri\, 12 Mar 2010 04\:48\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05F53E7C-2D9B-11DF-9454-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142017>

Christian Couder <chriscool@tuxfamily.org> writes:

> Anyway when looking at t/t6035-merge-dir-to-symlink.sh, we can see that
> there are still 2 broken tests:
>
> $ ./t6035-merge-dir-to-symlink.sh
> ...
> *   ok 5: do not lose a/b-2/c/d in merge (resolve)
> *   still broken 6: do not lose a/b-2/c/d in merge (recursive)
> *   ok 7: setup a merge where dir a/b-2 changed to symlink
> *   ok 8: merge should not have conflicts (resolve)
> *   still broken 9: merge should not have conflicts (recursive)
> * still have 2 known breakage(s)
> * passed all remaining 7 test(s)
>
> So it looks like breakages in this area are known, though perhaps not your 
> particular breakage.

The above shows that resolve passes the same tests that recursive fails,
which means that the breakage is likely to be in recursive, and not in
unpack-trees, as you seemt to have guessed earlier.  If cherry-pick were
still a shell script, we could easily test that conjecture by letting you
try running it using resolve instead of recursive, but things like that
has got a lot harder to do these days since many things were rewritten in
C (sigh).

It might not be a bad idea to teach a hidden primarily-for-debugging
option to "cherry-pick" to let it use resolve instead of recursive for
cases like this.
