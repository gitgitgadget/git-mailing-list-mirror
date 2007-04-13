From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Fri, 13 Apr 2007 08:23:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704130816310.28042@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz> 
 <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
 <56b7f5510704121132g3961060amb394978bb49093e6@mail.gmail.com>
 <Pine.LNX.4.64.0704121203290.4061@woody.linux-foundation.org>
 <461F46B5.2020007@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dana How <danahow@gmail.com>,
	David Lang <david.lang@digitalinsight.com>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Rogan Dawes <lists@dawes.za.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 17:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcNdP-0000b6-Q2
	for gcvg-git@gmane.org; Fri, 13 Apr 2007 17:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbXDMPYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Apr 2007 11:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754044AbXDMPYU
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Apr 2007 11:24:20 -0400
Received: from smtp.osdl.org ([65.172.181.24]:37199 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754038AbXDMPYT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2007 11:24:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3DFNxIs022755
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 13 Apr 2007 08:23:59 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3DFNvxc002796;
	Fri, 13 Apr 2007 08:23:58 -0700
In-Reply-To: <461F46B5.2020007@dawes.za.net>
X-Spam-Status: No, hits=-0.957 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44412>



On Fri, 13 Apr 2007, Rogan Dawes wrote:
> 
> Would it not make sense for a hosting environment to say, if you are using
> alternates, or shared object directories, then you need to include *all* the
> refs in *all* the projects if you ever do an fsck?

Yes. And it shouldn't be hard to add support to do it. It's just not been 
done.

A lot of git programs already take refs on stdin, but fsck just doesn't do 
it (it can do it from the command line, but you'd run out of command line 
space very quickly).

More natural would be to just list all the git repos by git repo pathname 
(and there, usually the command line probably *is* long enough), but 
somebody would just have to do it. It's probably not very much code: just 
iterate over each repo both when adding refs and when actually doing the 
fsck itself.

> I'm not sure how well git will scale in this case, although it just should be
> a matter of how well git scales to dealing with a single project with tens of
> thousands of refs/tags/etc. The only problem might be in passing all those
> refs/tags to fsck in one go. STDIN, I guess?

For a real shared object directory, passing the refs to stdin (and 
teaching fsck about a "--stdin" flag) would be consistent with what we do 
for many other commands, so yes, that would work.

However, fsck actually tends to want not just the refs, but actually 
things like the index files and reflog files too, because those add other 
reachability info, which is why it's probably more natural to just give 
fsck the list of related repositories and let it figure them out.

That's also what you'd want to do for "alternates", since now there is no 
longer a single object directory either, but multiple separate (but 
related) ones.

Somebody would just have to write the code.. The basic rules are really 
all in "git/builtin-fsck.c": cmd_fsck(). Hint hint.

			Linus
