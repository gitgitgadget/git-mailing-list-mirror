From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix up diffcore-rename scoring
Date: Sun, 12 Mar 2006 23:09:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603122256550.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603122223160.3618@g5.osdl.org>
 <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 13 08:09:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FIhBE-0008TX-Pc
	for gcvg-git@gmane.org; Mon, 13 Mar 2006 08:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751694AbWCMHJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Mar 2006 02:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWCMHJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Mar 2006 02:09:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5073 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751536AbWCMHJQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Mar 2006 02:09:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2D79CDZ018069
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Mar 2006 23:09:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k2D79B4W030792;
	Sun, 12 Mar 2006 23:09:12 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzfusuyq.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17558>



On Sun, 12 Mar 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > The "score" calculation for diffcore-rename was totally broken.
> >
> > It scaled "score" as
> >
> > 	score = src_copied * MAX_SCORE / dst->size;
> >
> > which means that you got a 100% similarity score even if src and dest were 
> > different, if just every byte of dst was copied from src, even if source 
> > was much larger than dst (eg we had copied 85% of the bytes, but _deleted_ 
> > the remaining 15%).
> 
> Your reading of the code is correct, but that is deliberate.
> 
> >  	/* How similar are they?
> >  	 * what percentage of material in dst are from source?
> >  	 */
> 
> I wanted to say in such a case that dst was _really_ derived
> from the source.  I think using max may make more sense, but I
> need to convince myself by looking at filepairs that this change
> stops detecting as renames, and this change starts detecting as
> renames.

Just compare the result. Just eye-balling the difference between the 
rename data from 2.6.12 to 2.6.14, the fixed score actually gets better 
rename detection. It actually finds 133 renames (as opposed to 132 for the 
broken one), and the renames it finds are more sensible.

For example, the fixed version finds

	drivers/i2c/chips/lm75.h -> drivers/hwmon/lm75.h

which actually matches the other i2c/chips/ renames, while the broken one 
does

	drivers/i2c/chips/lm75.h -> drivers/media/video/rds.h

which just doesn't make any sense at all.

Now, that said, they _both_ find some pretty funky renames. I think there 
is probably some serious room for improvement, regardless (or at least 
changing the default similarity cut-off to something better ;)

		Linus
