From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Fix the rename detection limit checking
Date: Fri, 14 Sep 2007 11:44:04 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141132250.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141014130.16478@woody.linux-foundation.org>
 <alpine.LFD.0.999.0709141017450.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 20:47:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWGBb-0004LF-8C
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 20:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbXINSqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 14:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754535AbXINSqP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 14:46:15 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38076 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753770AbXINSqN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 14:46:13 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EIhxZQ018007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 11:44:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EIhuBa019022;
	Fri, 14 Sep 2007 11:43:59 -0700
In-Reply-To: <alpine.LFD.0.999.0709141017450.16478@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58179>



On Fri, 14 Sep 2007, Linus Torvalds wrote:
>
> ... and we also make sure that we don't overflow when doing the matrix 
> size calculation.

Side note: by "make sure", I don't really mean a total guarantee.

We could be even more careful here. In particular:

 - we later do end up allocating the matrix with 

	sizeof(*mx) * num_create * num_src

   and I didn't actually fix the overflow that is possible due to the
   "sizeof(*mx)" multiplication.

 - even after we've checked that not *both* of the source and destination 
   counts are larger than the rename_limit, we could still overflow the 
   multiplication in just the limit check.

.. but with the rename_limit being set to 100, in practice neither of 
these are really even close to realistic (ie you'd need to have less than 
100 new files, and deleted over twenty million files to overflow, or vice 
versa).

So with a rename_limit of 100, it's all good (I'm pretty sure you'd have 
*other* issues long before you'd hit the integer overflows on renames ;)

But if somebody sets the rename_limit to something bigger, it gets 
increasingly easier to screw it up.

If somebody wants to be *really* careful, they'd need to do something like

	unsigned long max;

	/* This isn't going to overflow, since we limited 'rename_limit' */
	max = rename_limit * rename_limit;

	/*
	 * But we should also check that multiplying by "sizeof(*mx)" 
	 * won't make it overlof either..
	 */
	while ((sizeof(*mx) * max) / sizeof(*mx) != max)
		max >>= 1;

	/*
	 * And then avoid multiplying "rename_dst_nr" and "rename_src_nr"
	 * together by turning it into a division instead
	 */
	if (max / rename_dst_nr > rename_src_nr)
		goto cleanup;

but the patch I sent out was the "obvious" first one that at least avoided 
the overflow for the triggerable case that Dmitry had, and as per above 
likely in all reasonable cases...

			Linus
