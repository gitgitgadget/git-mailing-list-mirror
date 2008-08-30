From: Junio C Hamano <gitster@pobox.com>
Subject: Re: setlocalversion wasn't producing git labels for bisect
Date: Sat, 30 Aug 2008 13:07:56 -0700
Message-ID: <7vbpzagtb7.fsf@gitster.siamese.dyndns.org>
References: <48B9A2C7.3080001@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Greaves <david@dgreaves.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 22:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZWkw-0001sU-Ly
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 22:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbYH3UIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Aug 2008 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbYH3UIE
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 16:08:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752834AbYH3UIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Aug 2008 16:08:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A59FB587E6;
	Sat, 30 Aug 2008 16:08:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DCEEF587E5; Sat, 30 Aug 2008 16:07:57 -0400 (EDT)
In-Reply-To: <48B9A2C7.3080001@dgreaves.com> (David Greaves's message of
 "Sat, 30 Aug 2008 20:43:03 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 592180E4-76CF-11DD-A28C-9EE598D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94414>

David Greaves <david@dgreaves.com> writes:

> Running
>   git name-rev --tags HEAD
> gives the output
>   HEAD tags/v2.6.27-rc4~44^2
>
> This isn't matched by setlocalversion regexp so it makes it harder to make deb-pkg/install/grub/reboot/remove
>
> Of course if this patch is accepted it is going to make life complicated when bisecting around it.
> Maybe git should behave as the man page suggests and have the ^X before the ~nnn? (maybe it has been fixed already)

Sorry, I don't understand what you are trying to fix here.

Your head can be reached by going 44 generations back (following the first
parent chain) from v2.6.27-rc4, which is a merge commit, and then taking
its second parent.  IOW the name-rev output you quoted represents this
history:

                                  v2.6.27-rc4
       ----o---o---o---....---o---o
          /^                  ^
         / v2.6.27-rc4~44     v2.6.27-rc4~1
        o
        ^ Your HEAD

Swapping ^X and ~nnn changes the meaning completely.  v2.6.27-rc4^2~44 is
the 44 generation ancestor of the second parent of -rc4, but v2.6.27-rc4
is *NOT* a merge and it does not have the second parent.

>   http://www.kernel.org/pub/software/scm/git/docs/v1.5.6.5/git-name-rev.html
> shows an example:
>   33db5f4d9027a10e477ccf054b2c1ab94f74c85a tags/v0.99^0~940

This says

    v0.99 is a tag, and dereference it (^0) to get to the commit that
    points at it, and then the commit in question (33db5f) is its 940th
    generation ancestor.

We used to explicitly say "it is a tag and dereference it" by adding ^0
but since Feb 2007 we stopped doing so because taking its 940th parent
can only be done to a commit, so v0.99~940 and v0.99^0~940 are equivalent.

We should fix the documentation, though.
