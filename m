From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Sat, 14 Apr 2012 22:35:59 +0100
Message-ID: <4F89EDBF.9050906@pileofstuff.org>
References: <11292500.AVmZFUUvNi@flobuntu> <2104868.dCxFQtJHdU@flomedio> <4F875785.6040103@pileofstuff.org> <1472353.TRfidGPc01@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 23:36:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJAdh-0006lQ-Ui
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 23:36:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756127Ab2DNVgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 17:36:07 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:55751 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755896Ab2DNVgG (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 17:36:06 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120414213602.SDRE21612.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 14 Apr 2012 22:36:02 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120414213602.XMVZ13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 14 Apr 2012 22:36:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
In-Reply-To: <1472353.TRfidGPc01@flomedio>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=Hd5Tmzg1rDkA:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=T9477rCp4CzQ3W-Uo2UA:9 a=S-AvjOgz5bdpNCurc04A:7 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195517>

On a slightly different topic, here's the only branching edge case I
know of that will affect you.  I agree with Jonathan that you should
focus on the standard layout for now, but I think it's worth having the
trickier cases in your head when you're planning things out.

Imagine a team does this:


# Slight misunderstanding of the standard layout at first:

mkdir trunk/project1 trunk/project2
svn add trunk
svn ci -m "Initial revsion" # r1

# Time passes, commits are made, people get smarter.
# In revision 1000, the team decides to put the structure right:

svn rm trunk
svn ci -m "Removed incorrect directory name" # r1000

mkdir trunk
touch trunk/MOVED_TO_PROJECT_TRUNK
svn ci -m "Added signpost file for future reference" # r1001

mkdir project1 project2
svn cp -r 999 trunk/project1 project1/trunk
svn cp -r 999 trunk/project2 project2/trunk
svn ci -m "Recreated projects with correct directory names" # r1002


This would be represented in SBL something like:

In r1, create branch "trunk/project1"
In r1, create branch "trunk/project2"

# We would prefer just to deactivate these...
In r1000, deactivate "trunk/project1"
In r1000, deactivate "trunk/project2"

# ... but we have to delete them,
# because git doesn't support recursive branch names:
In r1001, delete branch "trunk/project1"
In r1001, delete branch "trunk/project2"
In r1001, create branch "trunk"

# We deleted the branches, so how do we get the commit to fork from?
In r1002, create branch "project1/trunk" from "trunk/project1" r999
In r1002, create branch "project2/trunk" from "trunk/project2" r999


If you look in your ".git/refs/heads/" directory, you'll see git
branches are stored as files on disk.  So if you have a branch
"trunk/project1", you can't create a branch called "trunk" unless you
delete the directory called "trunk" first.  This unfortunate limitation
of an otherwise neat solution means you can't reliably use git branches
when retrieving older revisions.

Other people will be able to tell you if there's any interest in
removing this limitation, but even if there is, users will occasionally
change their mind after asking for a branch to be deleted, and be
surprised if SVN lets them but git doesn't.

One solution you could look at would be storing dead branches in a JSON
file somewhere.  If you go down that route, remember that `git gc` will
try to garbage collect the commits once the branches have been dead for
long enough.

	- Andrew
