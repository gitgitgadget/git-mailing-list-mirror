From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Fri, 22 Feb 2008 15:05:55 -0800
Message-ID: <7vd4qo7fsc.fsf@gitster.siamese.dyndns.org>
References: <871w7bz1ly.fsf@rho.meyering.net> <47B995CC.2000809@gmx.ch>
 <87skznhqk6.fsf@rho.meyering.net> <7vzlts9ag8.fsf@gitster.siamese.dyndns.org>
 <87ir0gx5bn.fsf@rho.meyering.net> <7vskzk99fd.fsf@gitster.siamese.dyndns.org>
 <87tzk0tzjz.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jean-Luc Herren <jlh@gmx.ch>, git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:06:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSgyj-0000OU-5g
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 00:06:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757680AbYBVXGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 18:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757755AbYBVXGP
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 18:06:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757248AbYBVXGN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 18:06:13 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F31E75F80;
	Fri, 22 Feb 2008 18:06:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3CD1B5F64; Fri, 22 Feb 2008 18:06:05 -0500 (EST)
In-Reply-To: <87tzk0tzjz.fsf@rho.meyering.net> (Jim Meyering's message of
 "Fri, 22 Feb 2008 23:08:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74768>

Jim Meyering <jim@meyering.net> writes:

> This change removes all obvious useless if-before-free tests.
> E.g., it replaces code like this:
>
>         if (some_expression)
>                 free (some_expression);
>
> with the now-equivalent:
>
>         free (some_expression);
>
> ...
>
> If you're interested in automating detection of the useless
> tests, you might like the useless-if-before-free script in gnulib:
> [it *does* detect brace-enclosed free statements, and has a --name=S
>  option to make it detect free-like functions with different names]

While I have your attention ;-)

I am not interested in automating useless "if (x) free(x)"
tests, but one thing I recently wanted but did not know a handy
tool for was to find all the calls to free() that free a pointer
to an object of a particular type.  More specifically, we seem
to allocate and free many "struct commit_list", and I wanted to
introduce a custom bulk allocator.  Allocate many of them in a
block, hand out one by one, and tell callers to hand them back
not to free() but to the allocator so that it can keep the
returned ones on a linked list and hand them back again when the
next call wanted to allocate one without actually calling
xmalloc()).  But in order to do so, missed conversion from
malloc() to the custom allocator is not fatal (just wasteful),
but forgetting to convert free() really is.

I guess sparse could be hacked to do that, but do GNU folks have
some checker like that?
