From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] parseopt: introduce OPT_RECURSE to specify shared
 options
Date: Mon, 5 Nov 2007 08:15:31 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711050755340.15101@woody.linux-foundation.org>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <Pine.LNX.4.64.0711051230020.4362@racer.site> <Pine.LNX.4.64.0711051237420.4362@racer.site>
 <Pine.LNX.4.64.0711051315300.4362@racer.site>
 <Pine.LNX.4.64.0711051340490.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 17:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip4df-0000Jg-8B
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 17:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863AbXKEQRI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 11:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752759AbXKEQRI
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 11:17:08 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45665 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752096AbXKEQRG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2007 11:17:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5GFWda010175
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Nov 2007 08:15:33 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lA5GFVeP008372;
	Mon, 5 Nov 2007 08:15:32 -0800
In-Reply-To: <Pine.LNX.4.64.0711051340490.4362@racer.site>
X-Spam-Status: No, hits=-3.236 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63523>



On Mon, 5 Nov 2007, Johannes Schindelin wrote:
> 
> After kicking this around a bit more on IRC, we had another idea.  Instead 
> of introducing OPT_RECURSE(), do something like OPT__QUIET(), only this 
> time in diff.h: ....

I think the preprocessor approach would tend to be simpler, which is an 
advantage. But whichever approach is chosen, I think one important issue 
is to make sure that options that *hide* other options are correctly 
handled in the help printout..

We have a few cases where a "recursive" option is hidden. For example, the 
option "-n" can mean different things in different contexts: in 
git-format-patch, for example, the "-n" is handled *before* calling 
setup_revisions() and allt he normal revision flags, which means that the 
format-patch -specific meaning of "-n" overrides the normal "revision" 
meaning. 

I suspect that in this kind of situation, it's actually easier to have a 
single linear array of options, because the option parser can just walk 
back and check "oh, I already saw this short option, so I should not 
output it as documentation because this version of it is hidden by the 
earlier one". 

But that's an implementation issue. The same certainly *can* be done with 
a recursive setup, just passing a linked list of what the earlier levels 
were (which is what we do in other places). And it's not like the 
recursion is going to be very deep or complex.

		Linus
