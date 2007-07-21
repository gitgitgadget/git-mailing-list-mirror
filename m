From: David Kastrup <dak@gnu.org>
Subject: pointer to pointer (was: gitk problems: can't unset "idinlist(...)")
Date: Sat, 21 Jul 2007 11:32:50 +0200
Organization: Organization?!?
Message-ID: <85k5su9k59.fsf_-_@lola.goethe.zz>
References: <alpine.LFD.0.999.0707201554540.27249@woody.linux-foundation.org> <20070721050912.GB20622@coredump.intra.peff.net> <alpine.LFD.0.999.0707202226130.27249@woody.linux-foundation.org>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707202304350.2?=
	=?ISO-8859-1?Q?7249@woody.linux?= =?ISO-8859-1?Q?-foundation.=04org?=
	=?ISO-8859-1?Q?>?= <20070721061857.GB29820@coredump.intra.peff.net> <20070721062448.GA8722@coredump.intra.peff.net> <alpine.LFD.0.999.0707202335570.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 11:33:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICBKs-0000wL-Le
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 11:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759386AbXGUJdK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 05:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbXGUJdK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 05:33:10 -0400
Received: from main.gmane.org ([80.91.229.2]:37128 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759386AbXGUJdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 05:33:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICBKg-0004wr-IF
	for git@vger.kernel.org; Sat, 21 Jul 2007 11:33:02 +0200
Received: from dslb-084-061-010-231.pools.arcor-ip.net ([84.61.10.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 11:33:02 +0200
Received: from dak by dslb-084-061-010-231.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 11:33:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-010-231.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:aI+b2s4c7i0wVwT8EdWLjL0okzI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53155>

--=-=-=

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Anyway, just because this is actually something I've noticed a lot
> of people do wrong, I actually do tend to think that when you
> traverse a singly-linked list and remove entries, you should *never*
> traverse the list itself, you should only ever traverse the "pointer
> to the pointer".

When I have doubly-linked lists where there is only forward traversal
(the backlink being for convenient deletions without context), I make
the backlink a pointer to pointer.  This also means that one can
remove at the front of the list without needing to know the head
separately.

Anyway, here is some really, really ancient code of mine (file date is
of 1990 but it's older than that) which sorts linked lists stably
without extra storage and makes heavy use of pointer to pointer
traversal in both code and interface.  There is also a strictly
non-recursive variant with the same data flow (except for never making
a redundant assignment) and just one instead of two functions which
consistently beats good qsort implementations, but this old version is
quite more fun to read.

Basically, if head is the pointer to a sorted list of at least n
elements, mergesort(&head, n) will sort the first n elements and
return a pointer to that link which contains the tail of the list.  So
if you did not already 0-terminate your list, *mergesort(&head,n)=0;
will both sort and terminate your list.


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: attachment
Content-Description: Stable Mergesort on linked lists

#include "mergesrt.h"
int (*mergecompare)(void *p1, void *p2);
int mergelink;
#define getlink(adr) (*(void**)((char*)(adr)+mergelink))

static void **merge(void **head1, void **tail1, void **tail2, unsigned n1, unsigned n2)
{
	register void *p1 = *head1, *p2 = *tail1;
	for(;;) {
		if ((*mergecompare)(p1, p2) <= 0) {
			p1 = *(head1 = &getlink(*head1 = p1));
			if (--n1 == 0)
				return *head1 = p2, tail2;
		} else {
			p2 = *(head1 = &getlink(*head1 = p2));
			if (--n2 == 0)
				return *tail1 = p2, *head1 = p1, tail1;
		}
	}
}


void **mergesort(void **head, unsigned n)
{
	switch (n) {
	case 0:
		return head;
	case 1:
		return &getlink(*head);
	case 2:
		{
			register void *p1, *p2;

			p2 = getlink(p1 = *head);
			if ((*mergecompare)(p1, p2) <= 0)
				return &getlink(p2);
			getlink(p1) = getlink(*head=p2);
			return &getlink(getlink(p2) = p1);
		}
	default:
		{
			unsigned m;
			void **h2;
			n -= m = n / 2;
			h2 = mergesort(head, n);
			return merge(head,h2,mergesort(h2,m),n,m);
		}
	}
}

--=-=-=



-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum

--=-=-=--
