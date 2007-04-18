From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Add keyword unexpansion support to convert.c
Date: Tue, 17 Apr 2007 18:19:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704171800290.5473@woody.linux-foundation.org>
References: <200704171041.46176.andyparkins@gmail.com>
 <Pine.LNX.4.64.0704170829500.5473@woody.linux-foundation.org>
 <46250175.4020300@dawes.za.net> <Pine.LNX.4.64.0704171121090.5473@woody.linux-foundation.org>
 <20070417235649.GE31488@curie-int.orbis-terrarum.net>
 <7vps62lfbw.fsf@assigned-by-dhcp.cox.net> <20070418002658.GA18683@fieldses.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	Rogan Dawes <lists@dawes.za.net>,
	Andy Parkins <andyparkins@gmail.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 03:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdypr-0004cz-Ur
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 03:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbXDRBTs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 21:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030650AbXDRBTs
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 21:19:48 -0400
Received: from smtp.osdl.org ([65.172.181.24]:43218 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753554AbXDRBTr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 21:19:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3I1JZYC025155
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 18:19:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3I1JYiG012950;
	Tue, 17 Apr 2007 18:19:34 -0700
In-Reply-To: <20070418002658.GA18683@fieldses.org>
X-Spam-Status: No, hits=-0.964 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44849>



On Tue, 17 Apr 2007, J. Bruce Fields wrote:
> 
> I've occasionally wondered before whether git could offer any help in
> the case where, say, somebody hands me a file, I know it's based on
> src/widget/widget.c from somewhere in v0.5..v0.7, and I'd like a guess
> at the most likely candidates.

It's actually fairly easy to do.

Get the git hash of the blob: use "git hash-object" to do so (although 
you can do it without git too, see later), then just do

	git whatchanged v0.5..v0.7 -- src/widget/widget.c

and just look for the hash. If it's an exact match, you'd find it there, 
and it will tell you when it changed.

If it's *not* an exact match, you have to come up with some "measure of 
minimality" for the thing (the size of the diff might be a good one), and 
you can do

	git rev-list --no-merges --full-history v0.5..v0.7 -- src/widget/widget.c > rev-list

which will get you a full set of commits that changed that file. Then you 
can just do something like

	best_commit=none
	best=1000000
	while read commit
	do 
		git cat-file blob "$commit:src/widget/widget.c" > tmpfile
		lines=$(diff reference-file tmpfile | wc -l)
		if [ "$lines" -lt "$best" ]
		then
			echo Best so far: $commit $lines
			best=$lines
		fi
	done < rev-list

and you're done!

(Yeah, I'm sure that script could be improved, but it's probably really 
not that bad even as-is! The initial "git rev-list" will have done all 
the heavy lifting, and picked out the commits that matter)

> I haven't wondered that often enough that I'd consider it worth
> embedding the blob SHA1 in every checked-out file, though!

It really doesn't pay.

Besides, if you actually have the file, you can trivially get the SHA1 
_without_ embedding it into the file. Just do

	(echo -e -n "blob <size>\0" ; cat file) | sha1sum

where "size" is just the size in bytes of the file.

So embedding the SHA1 doesn't actually buy you anything: every blob BY 
DEFINITION has their SHA1 embedded into them.

In fact, embedding the SHA1 (or doing any other modifications) just makes 
it harder to do this, since then you have to filter it out again.

		Linus
