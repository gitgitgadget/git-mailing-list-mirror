From: Johan Herland <johan@herland.net>
Subject: [RFC] Referring to a submodule state recorded in a supermodule from within the submodule
Date: Wed, 5 Nov 2008 18:24:28 +0100
Message-ID: <200811051824.28374.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 05 18:38:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmKV-0003gu-3X
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbYKERgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 12:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753622AbYKERgv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:36:51 -0500
Received: from sam.opera.com ([213.236.208.81]:49255 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421AbYKERgv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 12:36:51 -0500
X-Greylist: delayed 734 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Nov 2008 12:36:50 EST
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id mA5HOSXa005982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Wed, 5 Nov 2008 17:24:34 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100163>

Hi,

I have a stand-alone project, "foo", that I work on myself. The "foo" 
project is included as a submodule in two other projects, "bar" 
and "baz", that I don't have any direct affiliation with.

Semi-regularly, I like to keep tabs on bar and baz, to see what versions 
of foo they are using, what changes they have made to foo, and if there 
are things I could pick up from them, or maybe even things they could 
learn from eachother.

Doing this currently is quite tedious:
1. Clone/Fetch bar and initialize/update its foo submodule
2. Clone/Fetch baz and initialize/update its foo submodule
3. Set up remotes bar_foo and baz_foo in my main foo repo,
   pointing to bar/foo and baz/foo, respectively. Fetch.
4. Create tags bar_foo_current and baz_foo_current pointing
   to the foo SHA1 sum recorded in baz and baz, respectively.
5. Start comparing bar_foo_current and baz_foo_current to
   eachother, and to my own master branch.


Now, bring this into a larger company setting. There are many (~100) 
different foo-type projects owned by (~50) different developers. These 
projects are included as submodules by several (~20) different 
bar/baz-type projects. In addition, each bar/baz-type project has 
multiple (~3) branches using various versions of the foo-type 
submodules.

Finally, throw in questions like "What are the differences in submodule 
FOO between branch X of BAR, and branch Y of BAZ?", for random values 
of FOO, X, BAR, Y, and BAZ. It is apparent that the above approach just 
doesn't cut it.

Ironically, these questions are fairly easily answered by our current 
CVS setup (which applies the supermodule tags/branches to the entire 
source tree (including submodules)):
1. cd FOO
2. cvs diff -r BAR_X -r BAZ_Y

What I'd like, is some way to refer to the state of a repo as specified 
by the appropriate submodule blob in a superproject commit. Ideally 
this should be done remotely as well, so that I don't have to clone the 
entire superproject just to get at the appropriate submodule blob.


Crude Proposal:

Define a new "git submodule" subcommand that takes three arguments:
   <superURL> <tree-ish> <submoduleName>
The command does the following steps:
1. Locate git repo at <superURL>
2. Resolve <tree-ish> to the tree object within the git repo in #1
3. Locate .gitmodules within the tree object in #2
4. Lookup <submoduleName> in .gitmodules to find its path and URL
5. Locate the submodule blob from the path in #4 within the tree from #2
6. Record the object name (SHA1) stored in the submodule blob from #4
7. Fetch the object name (#7) from the submodule repo (its URL was
   found in #4) into the local git repo
8. Store a reference to the fetched object


Given the above command, the tedious steps described at the top can be 
reduced to the following (which is reasonably close to the equivalent 
CVS commands):
1. git submodule magic-command url/to/bar master foo
2. git submodule magic-command url/to/baz master foo
3. Start comparing the fetched refs to eachother, and
   to my own master branch.

If this sounds reasonable, I'd be happy to start coding the above 
proposal.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
