From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: using git on flash media
Date: Wed, 19 Apr 2006 17:23:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604191651110.3701@g5.osdl.org>
References: <20060419233125.89318.qmail@web86912.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 02:23:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWMx1-00043I-Nq
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 02:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWDTAXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 20:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWDTAXN
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 20:23:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751156AbWDTAXM (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Apr 2006 20:23:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3K0NAtH018086
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 19 Apr 2006 17:23:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3K0N9dE009457;
	Wed, 19 Apr 2006 17:23:10 -0700
To: David Tweed <tweed314@yahoo.co.uk>
In-Reply-To: <20060419233125.89318.qmail@web86912.mail.ukl.yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18953>



On Thu, 20 Apr 2006, David Tweed wrote:
>
> What I'm basically checking is that it doesn't, I dunno, rewrite files 
> so frequently that on a modern flash drive it would wear out the entire 
> drive unreasonably quickly.

The largely write-once nature of git should mean that the only files that 
get rewritten a lot are
 - the directories get rewritten to, since git creates new objects at a 
   reasonable pace
 - the branch references get rewritten.

In general, I'd say that git probably does less writing than most other 
SCM's are likely to do.

That said, when you say "modern flash drive", I really suspect you 
shouldn't care deeply any more. Modern flash devices can be rewritten a 
lot more than old ones could (by an order of magnitude or more), and they 
almost always have wear levelling in hw, making it even less of an issue 
(but if they don't, your biggest issue will be that you should use a 
filesystem that does it for you).

That said, if you want to be safe, I think flash memory card vendors 
guarantee only up to 10,000 write cycles (and it used to be much less). 

That's _complete_ rewrites, though, which is more than just a single 
sector write. They tend to guarantee 100,000 single-sector re-writes (ie 
more like the "directory update" things when you create a new object).

And assuming you'd count one commit as one "total rewrite" (which sounds 
unlikely - but it's certainly more than one sector - I don't know what 
they consider a total rewrite when they make up their numbers), that 
implies that to be really safe, you shouldn't do more than 10,000 commits 
before you replace your flash. Quite frankly, I suspect that's _way_ more 
conservative than you should be, but hey, since you asked..

10,000 commits is actually a fair number. The kernel has gotten 25,000 in 
a year, but the kernel is a pretty active and large project. I suspect 
that 10,000 commits is quite a lot of years for most projects.

One rule: NEVER mount your flash with the "sync" option, and use "noatime" 
to avoid unnecessary inode access time updates (that's especially true for 
git, where archive atimes aren't interesting, but it's usually a good idea 
for flash in general). Otherwise you'll get normal accesses ending up 
doign "writes" too and writes will do a lot more of them, and the above 
"one commit = one rewrite" rule-of-thumb is suddenly not at all 
conservative.

Btw, backups are still good. Flash or no flash, and whether you're very 
conservative in your flash usage or not.

		Linus
