From: Linus Torvalds <torvalds@osdl.org>
Subject: git-rev-list: "--bisect" flag
Date: Fri, 17 Jun 2005 23:31:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Jun 18 08:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjWkY-0004Qo-0K
	for gcvg-git@gmane.org; Sat, 18 Jun 2005 08:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVFRG3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Jun 2005 02:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVFRG3l
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jun 2005 02:29:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11420 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262099AbVFRG3e (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2005 02:29:34 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5I6TWjA019035
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Fri, 17 Jun 2005 23:29:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5I6TVA5013365
	for <git@vger.kernel.org>; Fri, 17 Jun 2005 23:29:32 -0700
To: Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Ok, I just added a feature to "git-rev-list" that I hereby nominate to be
the coolest feature ever, namely the "--bisect" flag, which basically
tries to split the list of revisions in two, and prints out just the "most
middle" commit.

The idea is that you want to do binary-search for a bug, but since the git
history isn't a nice linear thing, you don't know where the hell the
mid-point is between two commits, and even if you _do_ know where it is,
it gets even more complicated when you have 3 points (on different
branches) that are known good, and one point that is known bad.

Now, assuming you have three known-good points, and one known bad point, 
the way to get all commits in between is

	git-rev-list bad ^good1 ^good2 ^good3

and with the new flag you can now trivially get an estimate for what the 
mid-point is in this list. So you just do

	git-rev-list --bisect bad ^good1 ^good2 ^good3

and you now have the point to test. If testing shows that mid-way-point 
was bad, you just continue with that as a "new bad":

	git-rev-list --bisect new-bad ^good1 ^good2 ^good3

but if it shows that that point was still good, you instead just add it to 
the list of uninteresting commits, and do

	git-rev-list --bisect bad ^good1 ^good2 ^good3 ^new-good

instead. Every iteration you basically cut down the number of commits by 
half - you're bisecting the set, and binary-searching for the first bad 
commit.

Note that git also makes resetting to the test-point be really trivial: 
you just do

	git-read-tree -m -u <prev-point> <test-point>

where "prev-point" was your previous state (ie usually "HEAD" the first 
time, but the previous test-point otherwise), and "test-point" is the new 
point you want to test.

I haven't scripted this, but it should basically be pretty easy to add a
couple of simple scripts to make it very easy to do the binary search be
totally automated, assuming just a simple "mark test as failed/good"  
interface. Even without the scripting, it shouldn't be that hard to do
entirely by hand.

The idea being that if you notice that something doesn't work (usually in 
HEAD), but you know it used to work in the previous release, you just 
start the whole thing going with

	# set up initial state
	cat .git/HEAD > .git/BAD
	cat .git/HEAD > .git/CURRENT
	echo "^v2.6.12" > .git/GOOD

and then you just do something like:

	# iterate
	git-rev-list --bisect BAD $(cat .git/BAD) > .git/HALFWAY
	if [ ! -s .git/HALFWAY ]; then
		echo FOUND IT:
		cat .git/CURRENT
		exit 1
	fi
	git-read-tree -m -u CURRENT HALFWAY
	cat .git/HALFWAY > .git/CURRENT

	make ..


	# if good
	echo '^'$(cat .git/CURENT) >> .git/GOOD
	.. iterate ..

	# if bad
	cat .git/CURRENT > .git/BAD
	.. iterate ..

until it says "FOUND IT".

(The above is untested, but the --bisect behaviour itself I tested, and it 
seems to do the right thing).

NOTE! I'm not convinced I actually find a particularly good place to split 
at, but I think my stupid "halfway point" decision is good enough in 
practice. So it might not really be a real binary search, but I think it 
comes pretty close to it unless you have some really odd cases.

			Linus
