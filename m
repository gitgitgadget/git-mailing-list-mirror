From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Census] So who uses git?
Date: Wed, 1 Feb 2006 09:11:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602010856150.21884@g5.osdl.org>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
 <Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
 <46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
 <1138446030.9919.112.camel@evo.keithp.com> <7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
 <20060130185822.GA24487@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0601311750270.25300@iabervon.org> <7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601311623240.7301@g5.osdl.org> <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 18:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4LWc-0001tw-L2
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 18:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWBARMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWBARMG
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 12:12:06 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932446AbWBARME (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 12:12:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11HC0DZ012280
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Feb 2006 09:12:00 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11HBxgf015311;
	Wed, 1 Feb 2006 09:12:00 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15429>



On Tue, 31 Jan 2006, Junio C Hamano wrote:
> 
> Taken together with your "during a partially conflicted merge"
> example, it feels to me that the simplest safety valve would be
> to refuse "git commit paths..." if the index does not exactly
> match HEAD.  Not just mentioned paths but anywhere.

But at that point, the existing "git commit" semantics actually are the 
ones we'd use, and the only difference ends up being that we error out 
if the index doesn't match HEAD.

The problem with that is that it appears that some of the people who don't 
like the current "git commit <filename>" thing _do_ actually understand 
the index, but they want to commit just that one file. 

So at least from my understanding, I think Dscho was arguing for the new 
semantics of "git commit <file>" to _work_, but to only commit <file>, 
even if he does understand the index perfectly well, and might have done a 
"git add" or updated a file for some other reason..

Btw, one thing that _can_ be confusing is that you do

	git commit fileA

and then when you edit the commit message, you realize that you don't 
actually want to do this at all, so you exit out of the editor without 
changes (which aborts the commit). Now "git commit" will not actually have 
done the commit, but it _will_ have done the "git-update-index" on that 
file.

So next time, when you do

	git commit fileB

you'll currently commit _both_ fileA and fileB.

This is, in my opinion, the biggest argument for the suggested _new_ 
semantics: if you explicitly name a set of files, it should always do a

	# Verify current state
	parent=$(git-rev-parse --verify HEAD) || exit

	# Verify that the current index is ok in the named files
	a=$(git-diff-files --name-only --cached $parent "$@") || exit
	if [ "$a" ]; then
	   echo -e >&2 "Files are changed in the index:\n  $a"
	   exit 2
	fi

	# create the new tree object
	export GIT_INDEX_FILE=tmpfile
	newtree=$(git-read-tree $parent &&
	  git-update-index "$@" &&
	  git-write-tree) || exit

	# edit message
	... edit message ..

	# do commit
	newhead=$(git-commit-tree -p $parent < msg)
	git-update-ref HEAD $newhead $parent

or similar. That has the advantage that if we _do_ decide to break out of 
the commit, we will not have changed the current index (only the temporary 
one).

		Linus
