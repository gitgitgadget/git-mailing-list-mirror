From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Linus' sha1 is much faster!
Date: Mon, 17 Aug 2009 09:22:56 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908170852320.3162@localhost.localdomain>
References: <4A85F270.20703@draigBrady.com> <87eirbef3c.fsf@master.homenet>  <4A88B80D.40804@draigBrady.com> <8763cmemsa.fsf@master.homenet> <f488382f0908170844h649126efxb27f87d7b319961b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Giuseppe Scrivano <gscrivano@gnu.org>,
	=?ISO-8859-15?Q?P=E1draig_Brady?= <P@draigbrady.com>,
	Bug-coreutils@gnu.org, Git Mailing List <git@vger.kernel.org>
To: Steven Noonan <steven@uplinklabs.net>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:23:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4zK-0006Zq-Ug
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbZHQQXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZHQQXF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:23:05 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57231 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753104AbZHQQXF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:23:05 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7HGMuXh021982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Aug 2009 09:22:57 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n7HGMuDg021303;
	Mon, 17 Aug 2009 09:22:56 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <f488382f0908170844h649126efxb27f87d7b319961b@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126217>



On Mon, 17 Aug 2009, Steven Noonan wrote:
> 
> Interesting. I compared Linus' implementation to the public domain one
> by Steve Reid[1]

You _really_ need to talk about what kind of environment you have.

There are three major issues:
 - Netburst vs non-netburst
 - 32-bit vs 64-bit
 - compiler version

Steve Reid's code looks great, but the way it is coded, gcc makes a mess 
of it, which is exactly what my SHA1 tries to avoid.

[ In contrast, gcc does very well on just about _any_ straightforward 
  unrolled SHA1 C code if the target architecture is something like PPC or 
  ia64 that has enough registers to keep it all in registers.

  I haven't really tested other compilers - a less aggressive compiler 
  would actually do _better_ on SHA1, because the problem with gcc is that 
  it turns the whole temporary 16-entry word array into register accesses, 
  and tries to do register allocation on that _array_.

  That is wonderful for the above-mentioned PPC and IA64, but it makes gcc 
  create totally crazy code when there aren't enough registers, and then 
  gcc starts spilling randomly (ie it starts spilling a-e etc). This is 
  why the compiler and version matters so much. ]

> (average of 5 runs)
> Linus' sha1: 283MB/s
> Steve Reid's sha1: 305MB/s

So I get very different results:

	#             TIME[s] SPEED[MB/s]
	Reid            2.742       222.6
	linus           1.464         417

this is Intel Nehalem, but compiled for 32-bit mode (which is the more 
challenging one because x86-32 only has 7 general-purpose registers), and 
with gcc-4.4.0.

			Linus
