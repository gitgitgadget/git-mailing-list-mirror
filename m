From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Two ideas for improving git's user interface
Date: Wed, 1 Feb 2006 17:44:49 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602011732560.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
 <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
 <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
 <87lkwupsbr.wl%cworth@cworth.org> <Pine.LNX.4.64.0602011656130.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 02:45:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4TWw-00039z-03
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 02:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423048AbWBBBo7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 20:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423050AbWBBBo7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 20:44:59 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19373 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423048AbWBBBo6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 20:44:58 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k121ioDZ006978
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 17:44:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k121in7q028169;
	Wed, 1 Feb 2006 17:44:49 -0800
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <Pine.LNX.4.64.0602011656130.21884@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15477>



On Wed, 1 Feb 2006, Linus Torvalds wrote:
> 
> And notice how I commit the _merge_ without actually committing my dirty 
> state in the tree - and whether the files involved in my standard dirty 
> changes ("Makefile") are part of the state that the merge changed or not 
> is _totally_ irrelevant.

If you get the feeling that merging is special, then to some degree, yes, 
you'd be right.

Merging (especially with conflicts) is the _one_ operation where you 
absolutely have to know about the index. If you don't know about how the 
index works, you can get the conflict resolution right kind of by 
accident, simply because the default workflow of

	.. edit conflict to look ok ..
	git commit file/with/conflict

actually happens to do exactly the right thing (very much on purpose, 
btw), but the fact is, to actually figure out more complicated conflicts 
and to _understand_ what happens, you absolutely need to be aware of the 
index. Not being aware of it just isn't an option for any serious git 
user.

(Btw, I think this is where cogito falls down. Cogito tries to hide the 
index file, but I don't think you really _can_ hide the index file and 
also do merges well at the same time. Anybody who has non-trivial merges 
should use raw git - not just because the "recursive" strategy just works 
better, but exactly because of the index file issue).

So when you work with a merge, the index file content really in a very 
real way _is_ the merge. Yes, the index file is also technically how git 
actually does all the merging complexity, but in this case, there also is 
no "diff" to the parent, and the number of changed files may be in the 
hundreds, yet "git diff" should be basically empty when you finally commit 
your merge.

I say "basically empty", because as I've explained, at least I personally 
have had dirty state in my tree at the time I commit a merge - on _top_ of 
(and independently of) the state that I actually commit.

So to recap:

 - you really do have to be aware of the index file at some point. Trying 
   to hide it entirely is a huge mistake.

 - real git power users _will_ use their awareness of the index file when 
   they commit. You will too, some day. Maybe it's only for merges, but I 
   wouldn't be surprised if somebody at some point wants to take advantage 
   of it even for "normal" working conditions (ie use "git-update-index" 
   to "freeze" a certain state for committing, and then editing the file 
   and _not_ committing those edits)

So making "-a" the default would be just a horrid horrid mistake. You can 
only hide the index so far - don't even try to hide it more.

			Linus
