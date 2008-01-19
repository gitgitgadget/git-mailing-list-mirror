From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix random fast-import errors when compiled with
 NO_MMAP
Date: Fri, 18 Jan 2008 19:55:27 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801181953130.2957@woody.linux-foundation.org>
References: <20080118035700.GA3458@spearce.org> <alpine.LFD.1.00.0801172013270.2957@woody.linux-foundation.org> <20080118084201.GA14763@hashpling.org> <alpine.LFD.1.00.0801180842350.2957@woody.linux-foundation.org>
 <7vwsq6a44w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Charles Bailey <charles@hashpling.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 04:56:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JG4ok-0005Fm-0P
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 04:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763618AbYASDzv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 22:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763529AbYASDzv
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 22:55:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49659 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763378AbYASDzu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2008 22:55:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0J3tXEB022943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Jan 2008 19:55:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0J3tRFX019921;
	Fri, 18 Jan 2008 19:55:27 -0800
In-Reply-To: <7vwsq6a44w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.716 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71078>



On Fri, 18 Jan 2008, Junio C Hamano wrote:
> 
> gfi uses data in a "pack" in two quite different ways.
> 
> A new object is written to an unfinalized pack.  Such a pack
> already has "struct packed_git" allocated for it and a pointer
> to it is held in pack_data.  As far as the core part of git
> (that is, sha1_file.c) is concerned, however, this pack does not
> even exist.  It is still not part of packed_git list in
> sha1_file.c, and read_sha1_file() will not see objects in it, as
> no idx into the packfile exists yet.  gfi has a table of objects
> in this pack and uses gfi_unpack_entry() function to retrieve
> data from it.
> 
> A packfile is finalized in end_packfile().  The pack header and
> footer is recomputed, an idx file is written, and the pack is
> finally registered.  Before that time p->index_data is not even
> used for that pack (it is initialized with NULL).

Oh, ok. I did try to grep for index_data, and didn't find anything that 
looked bad, but the incestuous things that fast-import.c does just made me 
worry - but I was too lazy to really follow it all. It's one of those 
files I don't think I've ever had anything what-so-ever to do with.

> So I do not think "index_data usage" can be incorrect, as there
> won't be any index_data usage with unfinalized pack, and the
> core part of git would not even have any mmap(2) (nor open fd)
> into its idx file before it is finalized.

In that case, I think Shawn fixed it all, and we're all good, and it's not 
just hidden well enough that it "just happens" to work.

				Linus
