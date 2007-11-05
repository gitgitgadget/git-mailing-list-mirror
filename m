From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/2] Enhance --early-output format
Date: Mon, 5 Nov 2007 12:47:31 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711051233270.15101@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0710280943090.30120@woody.linux-foundation.org>
 <18217.41899.54812.227152@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org>
 <18218.63946.772767.179841@cargo.ozlabs.ibm.com>
 <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org>
 <18221.14113.498416.396006@cargo.ozlabs.ibm.com>
 <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org>
 <7vsl3kphjp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 21:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip8rt-0006y6-EW
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbXKEUsH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 15:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbXKEUsG
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 15:48:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37574 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752045AbXKEUsF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 15:48:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5KlWdh027866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Nov 2007 12:47:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5KlVGH019004;
	Mon, 5 Nov 2007 12:47:32 -0800
In-Reply-To: <7vsl3kphjp.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.237 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63549>



On Mon, 5 Nov 2007, Junio C Hamano wrote:
>
> > +		if (rev->prune_fn && rev->dense && !(flags & TREECHANGE)) {
> > +			if (commit->parents && !commit->parents->next)
> > +				continue;
> > +		}
> 
> When looking at:
> 
> 	if (A && B && C) {
>         	if (D && E)
>                 	continue;
> 	}
> 
> an uninitiated might say "Huh?  Why use nested 'if'?", but to
> somebody who knows how revision traversal works, the above split
> is a more logical way to test this condition.  Maybe one liner
> comment is in order?

I'd almost prefer not to.

If people feel the code is subtle enough that a comment is in order to 
explain *what* something does, I would rather introduce helper functions 
than add comments. I'm not a big believer in comments in the middle of 
code to explain the code, but I *am* a big believer in trying to make the 
code easy to read without them.

(I don't dislike comments per se, but I'd *much* rather have the comments 
explain what is going on at a higher level. Comments that talk about the 
details of the code itself is likely bogus).

So we could add a commit to say what is going on ("ignore commits that 
have only one parent and didn't change the tree"), but I'd not want to 
explain why that particular layout of code.

That said, I've often found the "TREECHANGE" bit annoying. The fact that 
we always have to test it together with testing "rev->prune_fn" and often 
also the "rev->dense" flag is just annoying. I'd almost like to just 
always set the bit if "rev->prune_fn" isn't set. Alternatively, the code 
could be rewritten to just have a few inline helper functions, and it 
could perhaps be written as

	if (!(flags & TREECHANGE) && revs->dense && single_parent(commit))
		continue;

I dunno. I have no really *strong* opinions, although I suspect that 
anybody who looks at that particular piece of code had better understand 
these issues well enough anyway that it doesn't much matter..

> As you noted, this is more like "Partial output" now.
> How about painting the bikeshed pink by saying:
> 
> 	Partial output: 20
>         Partial output: 70
>         Final output: 70000

I'm fine with it. The reason I did it the way I did was that this way I 
didn't need to change "gitk" - I could just use Pauls original patch 
as-is, since that code didn't care *what* came after the "Final output", 
and didn't care how many times it showed up.

			Linus
