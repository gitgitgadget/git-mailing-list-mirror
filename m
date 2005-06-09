From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
 internally
Date: Thu, 9 Jun 2005 10:37:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506091033300.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
 <7vis0o30sc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
 <7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net> <7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org> <7v7jh3phkk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 19:34:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgQt4-0001az-1Y
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 19:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVFIRgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbVFIRgM
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 13:36:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262420AbVFIRf5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 13:35:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j59HZejA021218
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 9 Jun 2005 10:35:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j59HZdi2012677;
	Thu, 9 Jun 2005 10:35:40 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7jh3phkk.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0.001 required=5 tests=REMOVE_IN_QUOTES
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 9 Jun 2005, Junio C Hamano wrote:
> 
> I need to regurgitate other points you raised, but one immediate
> comment on the "lost remove" case.  The current two-way code has
> the same brokenness in that it does not unlink removed files
> under "-u".  We either need the "list of files to be removed",
> or we need to make two-way abort if we see these "remove" cases.

Yes, you're right.

Ho humm. I'll think about it. There's no "next" pointer in a struct 
cache-struct, and because we use the on-disk layout (good or bad, I dunno, 
but it does remove the need for copying megabytes of data for some cases) 
we can't just add one. So to generate a list of "deleted" files we'd have 
to make a separate array or something.

Not hard, but it's a bit ugly. I don't see any alternative, though, unless
we really do end up using the same "leave it in the different stages and
force people to run git-merge-cache on the result" thing that the
three-way merge does.

The fact that the three-way merge _might_ also like to remove the entries,
and that the two-way merge already handles the addition of new files, does
kind of argue that we should do it. For symmetry witht he "file add" case, 
if nothing else.

			Linus
