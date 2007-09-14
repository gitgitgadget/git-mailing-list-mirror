From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] git-commit: Disallow unchanged tree in non-merge
 mode
Date: Fri, 14 Sep 2007 10:14:06 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709141002360.16478@woody.linux-foundation.org>
References: <20070905234941.GA643@nomad.office.altlinux.org>
 <20070906022539.GG18160@spearce.org> <20070906101648.GD6665@basalt.office.altlinux.org>
 <20070909044648.GH18160@spearce.org> <7vir6fjmuv.fsf@gitster.siamese.dyndns.org>
 <20070913035137.GM3099@spearce.org> <7vr6l2gxyw.fsf@gitster.siamese.dyndns.org>
 <20070914000108.GE3619@basalt.office.altlinux.org> <7vr6l2f6k1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.999.0709131850060.16478@woody.linux-foundation.org>
 <20070914024303.GH3619@basalt.office.altlinux.org>
 <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Sep 14 19:24:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWElB-0002Uu-Cj
	for gcvg-git-2@gmane.org; Fri, 14 Sep 2007 19:15:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbXINRPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2007 13:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbXINRPL
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 13:15:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59740 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751111AbXINRPJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2007 13:15:09 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHDx4m014388
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Sep 2007 10:14:00 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8EHDw5u015575;
	Fri, 14 Sep 2007 10:13:59 -0700
In-Reply-To: <alpine.LFD.0.999.0709132123570.16478@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.239 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.34__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58164>



On Thu, 13 Sep 2007, Linus Torvalds wrote:
> 
> Ok, I'm downloading those tar-balls to reproduce and hopefully see what's 
> going on, but I'm not going to be able to get at it today.

Ok, I'm seeing it, and there are serious problems in the diffcore-rename 
code.

The problems include things like actual overflow in 31 bits (a signed 
integer) from the multiplication of "num_create * num_src".

But you'll almost certainly never even get there, because you'd long since 
have given up on the O(n^2) behaviour of the "cheap tests", that aren't 
really cheap enough, if only because even just comparing the 20-byte SHA1 
hashes will basically take forever since they will always miss in the 
cache for lots of names.

So yes, we really *have* to have a rename limit, even if it's only to 
avoid the technical bug of overflowing the multiplication.

Testing this actually showed another bug too: "git diff" would actually 
never call "diff_setup_done() at all, if "diffopt.output_format" had been 
set explicitly to something. So doing a "git diff --stat" would totally 
ignore all the sanity checks (and, what caused me to find it, the 
initialization of "diffopt.rename_limit") that diff_setup_done() is 
supposed to do!

So I'm going to send out two patches - one to fix the "diff_setup_done()" 
bug, and one that replaces the default rename_limit with something saner. 
Both seem to be real bugs.

			Linus
