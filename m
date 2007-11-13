From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4/2] Fix parent rewriting in --early-output
Date: Mon, 12 Nov 2007 22:46:16 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711122238330.2786@woody.linux-foundation.org>
References: <18211.59478.188419.397886@cargo.ozlabs.ibm.com> <18217.41899.54812.227152@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0711010815320.3342@woody.linux-foundation.org> <18218.63946.772767.179841@cargo.ozlabs.ibm.com> <e5bfff550711020544h1e9a648apfd268eb549645ccc@mail.gmail.com>
 <alpine.LFD.0.999.0711020828440.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021114390.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021301200.3342@woody.linux-foundation.org> <alpine.LFD.0.999.0711021809060.3342@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711031103340.3342@woody.linux-foundation.org> <18221.14113.498416.396006@cargo.ozlabs.ibm.com> <alpine.LFD.0.999.0711032234030.15101@woody.linux-foundation.org> <alpine.LFD.0.999.0711041004220.15101@woody.linux-foundation.org>
 <alpine.LFD.0.999.0711041124050.15101@woody.linux-foundation.org> <alpine.LFD.0.9999.0711122046570.2786@woody.linux-foundation.org> <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 07:47:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrpYG-0008CK-RM
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 07:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXKMGq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 01:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXKMGq4
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 01:46:56 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41923 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbXKMGqz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 01:46:55 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD6kHfT020953
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 12 Nov 2007 22:46:18 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAD6kGwb030518;
	Mon, 12 Nov 2007 22:46:16 -0800
In-Reply-To: <7v1wauzomr.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-3.235 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64756>



On Mon, 12 Nov 2007, Junio C Hamano wrote:
> 
> This is too subtle, or I am missing something.

It's subtle. And you're probably right, I need to fix it up some more.

It works, but it works for all the wrong reasons. When thinking about it, 
you need to keep three "generations" of commits in mind. Let's call them 
"c" (commit), "p" (parent of c) and "pp" (parent of p) respectively.

What is going on is:
 - we have calculated TREECHANGE for "c".
 - that, in turn, means that we have parsed "p" (it's done by 
   add_parents_to_list() - either as part of try_to_simplify_commit(), or 
   if that code doesn't trigger, by the later loop over the parents)
 - but we haven't parsed "pp" yet.

Now, when we decide to rewrite "c", we look at whether we can change the 
parent list of c to point from "p" to "pp". But with the added check, we 
now will trigger on the fact that "pp" hasn't even been parsed yet, so we 
won't even try, and we leave the parent list alone.

But I agree, I don't think it's really stable. We could have gotten to 
"pp" through some other chain.

I think the real problem is that "TREECHANGE" has the wrong polarity. It 
should default to always being set, and then we could actively clear it 
when we do the work to say "it's the same tree". Instead, we default it to 
being the same (which triggers parent rewriting), and only later may we 
notice that it wasn't the same.

			Linus
