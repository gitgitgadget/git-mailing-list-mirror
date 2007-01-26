From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: grafts+repack+prune = history at danger
Date: Fri, 26 Jan 2007 07:55:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701260747110.25027@woody.linux-foundation.org>
References: <45B8E61E.C9C5E6C6@eudaptics.com> <7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
 <45B9B80E.E2534F97@eudaptics.com> <7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 16:56:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HATRQ-0002Ie-5g
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 16:56:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965702AbXAZP4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 10:56:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965559AbXAZP4E
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 10:56:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40028 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965702AbXAZP4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 10:56:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0QFtogP006875
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 26 Jan 2007 07:55:50 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0QFtnoC018928;
	Fri, 26 Jan 2007 07:55:49 -0800
In-Reply-To: <7vr6ti183o.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.59 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37866>



On Fri, 26 Jan 2007, Junio C Hamano wrote:
> 
> One thing you could do is to take the local-ness of grafts more
> literally and enforce it more strictly by dropping grafts while
> fetch-pack and receive-pack exchange common objects and spawn
> pack-objects to come up with objects needed to be sent.  But
> because we currently punt, we do not even do that.

One option might be:

 - add a global flag (like the current "save_commit_buffer") that commands 
   can set to specify whether they want to honor grafts or not.

   The "please_follow_grafts" flag defaults to 1.

 - "git send-pack" would explicitly set it to zero, and thus we'd always 
   send a non-grafted result.

 - "git prune" would *also* explicitly set it to zero, but would also 
   manually look at the grafts file, and mark anything that is set in the 
   grafts file as being reachable (the same way it does for index entries 
   etc).

It might also be an option to then do:

 - "git repack" should probably also set it to zero - I think we might be 
   better off packing any grafted data separately.

The alternative, of course, is to try to transfer the grafts file for 
clones and fetches, but that is likely to be a *bad* idea. It's even a 
potential security issue: grafts can literally be used to short-circuit 
some of the inherent safety in git, in that an attacker can make a graft 
that makes history *look* fine, but hide part of it (you can't "really" 
hide history, but you can make normal git operations like "git log" 
basically ignore it by judicious use of grafts).

			Linus
