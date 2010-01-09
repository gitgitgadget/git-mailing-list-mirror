From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ls-files: fix overeager pathspec optimization
Date: Fri, 8 Jan 2010 16:24:21 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001081619570.7821@localhost.localdomain>
References: <4B474C73.8080100@mtu.net> <4B4751EA.8060707@drmicha.warpmail.net> <20100108162404.GA5799@coredump.intra.peff.net> <7vr5q05z74.fsf@alter.siamese.dyndns.org> <20100108164132.GA6171@coredump.intra.peff.net> <7vskag1r5o.fsf@alter.siamese.dyndns.org>
 <7v8wc8jw3k.fsf@alter.siamese.dyndns.org> <7vvdfcfjxo.fsf@alter.siamese.dyndns.org> <7veim0w68q.fsf_-_@alter.siamese.dyndns.org> <alpine.LFD.2.00.1001081520240.7821@localhost.localdomain> <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Schewe <jpschewe@mtu.net>, spearce@spearce.org,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:26:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTP9s-0006EI-8O
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 01:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754602Ab0AIA0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2010 19:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754600Ab0AIA0Q
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jan 2010 19:26:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44570 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754504Ab0AIA0P (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jan 2010 19:26:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o090OMwO013465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 Jan 2010 16:24:23 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o090OLXb023330;
	Fri, 8 Jan 2010 16:24:22 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7v3a2gnnv2.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-5.446 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136499>



On Fri, 8 Jan 2010, Junio C Hamano wrote:
> 
> Since "git add" uses the exact same codepath to find the untracked files
> that match the pathspecs, I expected the "fix" will make it complain about
> "t/gomi" being ignored.  Not so.

No. Since 't' is ignored, it won't even do a readdir() in there.

And since it didn't do a readdir() in there, it won't find any files in 
there to add to the ignored list.

And that's how the "git add" logic for "apparently ignored" files works: 
it looks at whether the list of ignored files is empty or not.

> Actually, it does start ignoring t/gomi (the index does not have t/gomi
> after the above sequence with the patch), but lack of the error message
> makes it a rather unfortunate regression---it works as specified in the
> sense that ignored paths are not added to the index unless --forced, but
> it does so without telling the user about it.

I have this memory that _used_ to have a per-filename flag in "git add" 
that checked if that particular filename component was used or not. But 
now it just looks at 'dir->ignored_nr' and 'dir->ignored[]'.

[ Digging back in history.. Yes: commit e96980ef ]

		Linus
