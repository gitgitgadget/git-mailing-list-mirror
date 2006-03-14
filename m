From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree -M performance regression in 'next'
Date: Tue, 14 Mar 2006 02:26:22 -0800
Message-ID: <7v1wx5l3u9.fsf@assigned-by-dhcp.cox.net>
References: <20060311172818.GB32609@c165.ib.student.liu.se>
	<7voe0bdeyr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603120858230.3618@g5.osdl.org>
	<7vk6azcv9y.fsf@assigned-by-dhcp.cox.net>
	<7vwtezw4ye.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603121700410.3618@g5.osdl.org>
	<Pine.LNX.4.64.0603121710110.3618@g5.osdl.org>
	<7vwtezt202.fsf@assigned-by-dhcp.cox.net>
	<7vveuhohve.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603131941260.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 14 11:26:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJ6jZ-0000mi-SF
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 11:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751885AbWCNK01 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 05:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752052AbWCNK01
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 05:26:27 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:7816 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751885AbWCNK00 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 05:26:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060314102308.OADH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Mar 2006 05:23:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603131941260.3618@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 13 Mar 2006 19:47:41 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17586>

Linus Torvalds <torvalds@osdl.org> writes:

> Mine is a bit less hacky than yours, I believe. It doesn't skip 
> whitespace, instead it just maintains a rolling 64-bit number, where each 
> character shifts it left by 7 and then adds in the new character value 
> (overflow in 32 bits just ignored).

That rolling register is a good idea.  The "whitespace hack" was
done to recognize certain kind of changes that commonly appear
in source code.  For example, it will still recognize content
copies after you re-indent your code, or add an "if (...) {" and
"} else { ... }" around an existing code block, or add extra
blank lines.

It is still an inadequate hack.  If you comment out a code block
by adding "#if 0" and "#endif" around it, it notices the
surviving lines, but if instead you comment out a block by
prefixing "//" in front of every line in the block, neither your
64-byte-or-EOL or my extended line algorithm would notice that
the content copy anymore.

Anyway, I did a bit of comparison and it appears that the
whitespace thing does not make much difference in practice.

> It's fast and stupid, but doesn't seem to do any worse than your old one. 

Comparing the "next" with your 64-byte-or-EOL and "extended
line" on the v2.6.12..v2.6.14 test case shows:

				64-or-EOL	extended line
renames identically detected	108		110
matched differently		2		2
finds what"next" misses		4		4
misses what "next" finds	23		21

What they find seem reasonable.  What they reject are sometimes
debatable.  For example, similarity between these two files does
not seem to be noticed by either.

        v2.6.12/drivers/media/dvb/dibusb/dvb-dibusb-firmware.c
        v2.6.14/drivers/media/dvb/dvb-usb/dvb-usb-firmware.c

The "next" algorithm gives 60% score while these two gives 45%
or so to this pair.

But they both reject these bogus "rename" the "next" algorithm
finds:

	v2.6.12/drivers/char/drm/gamma_drv.c
	v2.6.14/drivers/char/drm/via_verifier.h

("next" 51% vs 37-40% with these algorithms). 

> Anyway, I don't think something like this is really any good for rename 
> detection, but it might be good for deciding whether to do a real delta.

Either algorithm seem to have non-negligible false negative
rates but their false positive rates are reasonably low.  So we
could use these as a pre-filter and use real delta on pairs that
these quick and dirty algorithms say are too different.
