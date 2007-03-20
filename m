From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Avoid unnecessary strlen() calls
Date: Mon, 19 Mar 2007 21:31:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703192116020.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703151747110.3816@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703162257560.18328@xanadu.home>
 <Pine.LNX.4.64.0703171044550.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171232180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171242180.4964@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171420420.4964@woody.linux-foundation.org>
 <118833cc0703171814n4e56ab9fwfaaea81c903ae235@mail.gmail.com>
 <Pine.LNX.4.64.0703171822280.4964@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172136440.18328@xanadu.home>
 <Pine.LNX.4.64.0703171854270.6730@woody.linux-foundation.org>
 <alpine.LFD.0.83.0703172200060.18328@xanadu.home>
 <Pine.LNX.4.64.0703171911120.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703171949190.6730@woody.linux-foundation.org>
 <7v8xdunavr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703180848580.6730@woody.linux-foundation.org>
 <7v3b40d2os.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 05:32:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTW1C-0004aj-EA
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 05:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933984AbXCTEcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Mar 2007 00:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933985AbXCTEcP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Mar 2007 00:32:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:45633 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933984AbXCTEcO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2007 00:32:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2K4VwcD022216
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 21:31:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2K4VvXq025639;
	Mon, 19 Mar 2007 20:31:57 -0800
In-Reply-To: <7v3b40d2os.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.977 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42702>



On Mon, 19 Mar 2007, Junio C Hamano wrote:
> 
> With this stupidity-removal patch, it gets down to 7.80user from
> 8.72user (comparable number of minor faults) for blaming
> block/ll_rw_blk.c (without tglx grafts)

Yeah, this one works for me too. Even more than for you. For me, 

	git blame --incremental -C HEAD block/ll_rw_blk.c

takes 6.71s (best of ten) normally, and 4.85 (best of ten again) with your 
patch and Nico's one-liner. In fact, that's a much bigger improvement than 
I would have expected from the profile, but it may be that you just cut 
the data cache footprint down a lot, and thus made other things more 
efficient.

(I just double-checked. Nico's one-liner does help, but not nearly as 
radically as it did for Nico. The "best of ten" with *just* Nico's 
one-liner is 6.22 for me - better than before, but the combination of 
Nico's patch and yours is much more dramatic).

Btw, Dscho's slightly more invasive patch seems to *just* edge out Nico's 
one-liner for me, with best-of-ten being 6.17s.

The winner is your patch *with* Dscho's slightly more invasive one: 4.69s.

But the difference between the numbers of Dscho's bigger patch and Nico's 
one-liner really are totally in the noise. Dscho *just* wins the 
best-of-ten both with and without your patch, but in both cases it's 
*way* in the noise. For example, while 4.69s was the best for your+Dscho 
in my testing, the full series was

	0:05.69
	0:04.69
	0:04.82
	0:04.97
	0:04.85
	0:05.88
	0:04.77
	0:04.69
	0:05.12
	0:04.98

so the variability was big enough that I wouldn't say that 0.1s is really 
all that meaningful even for "best of ten". I didn't try to make the 
machine totally quiescent, I've got xmms playing in the background etc..

But these kinds of things will definitely vary from machine to machine. 
It's all good, though.

			Linus
