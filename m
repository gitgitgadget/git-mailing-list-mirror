From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 11 Jan 2007 14:28:21 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111424400.3594@woody.osdl.org>
References: <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
 <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
 <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
 <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
 <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org> <7vfyah48j2.fsf@assigned-by-dhcp.cox.net>
 <20070111221053.GD6058@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 23:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H58PO-0006Vc-OM
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 23:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932670AbXAKW22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 17:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbXAKW22
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 17:28:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39480 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932651AbXAKW21 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 17:28:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BMSMWi008014
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 14:28:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BMSLDv005066;
	Thu, 11 Jan 2007 14:28:22 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20070111221053.GD6058@steel.home>
X-Spam-Status: No, hits=-2.663 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.170 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36627>



On Thu, 11 Jan 2007, Alex Riesen wrote:
> 
> It must have been large leak, as I really have seen the memory usage
> dropping down significantly.

I really think it was about 6MB (or whatever your index file size was) per 
every single resolved file. I think merge-recursive used to flush the 
index file every time it resolved something, and every flush would 
basically leak the whole buffer used to write the index.

Anyway, 40-50 sec on a fairly weak laptop for a 44k-file merge sounds like 
git doesn't have to be totally embarrassed. I'm not saying we shouldn't be 
able to do it faster, but it's at least _possible_ that a lot of the time 
spent is now spent doing real work (ie maybe you actually have a fair 
amount of file-level merging? Maybe it's 40-50 sec because there's some 
amount of real IO going on, and a fair amount of real work done too?)

			Linus
