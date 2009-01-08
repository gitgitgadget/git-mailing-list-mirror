From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 8 Jan 2009 12:22:22 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901081216060.3283@localhost.localdomain>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>  <1231314099.8870.415.camel@starfruit>  <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>  <1231368935.8870.584.camel@starfruit>  <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
  <1231374514.8870.621.camel@starfruit>  <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>  <20090108030115.GF10790@spearce.org>  <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>  <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
  <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain> <1231438552.8870.645.camel@starfruit>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	=?ISO-8859-15?Q?Jan_Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:31:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL1RH-000194-Tj
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 21:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbZAHUXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 15:23:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753205AbZAHUXr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 15:23:47 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41739 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751845AbZAHUXr (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Jan 2009 15:23:47 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08KMOmP029321
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Jan 2009 12:22:25 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n08KMMDO003562;
	Thu, 8 Jan 2009 12:22:22 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231438552.8870.645.camel@starfruit>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.449 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104958>



On Thu, 8 Jan 2009, R. Tyler Ballance wrote:
> > 
> > Tyler - does this make the corruption errors go away, and be replaced by 
> > hard failures with "out of memory" reporting?
> 
> Yeah, looks like it:

Well, I was hoping that you'd have a confirmation from your own huge repo, 
but I do suspect it's all the same thing, so I guess this counts as 
confirmation too.

> > This patch is potentially pretty noisy, on purpose. I didn't remove the 
> > reporting from places that already do so - some of them have stricter 
> > errors than this.
> 
> I'm assuming this patch is going to be reworked, if so, I'll back it out
> of our internal 1.6.1 build and anxiously await The Real Deal(tm)

Oh, it shouldn't be any noisier under _normal_ load - it's more that 
certain real corruption cases will now report the error twice. That said, 
the new errors should actually be more informative than the old ones, so 
even that isn't necessarily all bad.

Junio - I think we should apply this, and likely to the stable branch too. 
Add the re-trying the inflateInit() after shrinking pack windows on top of 
it.

			Linus
