From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 17:47:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610211714440.3962@g5.osdl.org>
References: <45357CC3.4040507@utoronto.ca>
	<20061021191949.GA8096@coredump.intra.peff.net>
	<20061021214629.GO75501@over-yonder.net>
	<200610220025.32108.jnareb@gmail.com>
	<1161474168.9241.188.camel@localhost.localdomain>
	<8764ed1b7z.wl%cworth@cworth.org>
	<1161475645.9241.195.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 02:48:10 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbRVN-0005St-HV
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 02:47:58 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbRVN-0002jd-1B; Sun, 22 Oct 2006 01:47:57 +0100
Received: from smtp.osdl.org ([65.172.181.4])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <torvalds@osdl.org>) id 1GbRVD-0002jW-RK
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 01:47:48 +0100
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9M0lfaX019565
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 Oct 2006 17:47:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9M0leun006123;
	Sat, 21 Oct 2006 17:47:41 -0700
To: Jeff Licquia <jeff@licquia.org>
In-Reply-To: <1161475645.9241.195.camel@localhost.localdomain>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29700>



On Sat, 21 Oct 2006, Jeff Licquia wrote:
> 
> You know what?  It occurs to me that much of the problem with git
> branches vs. bzr branches might be solved when bzr gets proper tagging
> support.  Because, after all, aren't branches more like special tags in
> git?

Both branches _and_ tags in git are 100% the same thing: they're just 
shorthand for the commit name. That's _literally_ all they are. They are a 
symbolic name for a 160-bit SHA1 hash.

So yes, you can say that branches are like special tags, or that 
(unsigned) tags are like special branches. There's no real "technical" 
difference: in both cases, it's just an arbitrary name for the top commit.

However, there are some purely UI differences between tags and branches, 
which really don't affect any of the "name->SHA1" translation at all, but 
which affect how you can _use_ a tag-name vs a branch-name.

 - A branch is always a pointer to a _commit_ object.

   In contrast, a tag can point to anything. It can point to a tree (and 
   that means that you can do _diff_ between a tag and a branch, but such 
   a tree doesn't have any "history" associated with it - it's purely 
   about a certain "state", so you cannot say that it has a parent or 
   anything like that).

   A tag can also point to a single file object ("blob": pure file 
   content), which is soemthing that the git.git repository uses to point 
   to the GPG public key that Junio uses to sign things, for example.

   But perhaps more commonly, a tag can also point to a special "tag" 
   object, which is just a form of indirection that can optionally contain 
   an explanation and a digitally signed verification. When I cut a kernel 
   release, for example, my tag's don't point to the commit that is the 
   release commit, they point to a GPG-signed tag-object that in turn 
   points to the commit. 

   With those signed tags, people can verify (if they get my public key) 
   that a particular release was something I did. And due to the 
   cryptographic nature of the hash, trusting the tag object also means 
   that you can trust the commit it points to, and the whole history that 
   points to.

   So while from a _revision_lookup_ standpoint a "branch" and a "tag" do 
   100% the same thing, we put some limitations on branches: they always 
   have to point to a commit.

 - Thanks to the limitation on branches being commits, branches can be 
   "checked out" which is saying that you can make it the active working 
   tree state. You cannot "check out" a tag: you need to have a branch 
   that you check out and can do development on.  So a "tag" is considered 
   purely a stationary pointer: it cannot be committed to, and it cannot 
   participate directly in development.

   This literally has nothing to do with looking up the SHA1 name 
   associated with a tag or a branch, this is _purely_ an agreed-upon 
   convention (that is enforced by higher-level commands like "git 
   checkout"). So if you want to check out the state as of some tag, you 
   must always do it within the confines of some branch.

   So for example, you could do

	git checkout -b newbranch v2.6.18

   which uses a tag ("v2.6.18") to define where to start the branch, and 
   then creates a branch called "newbranch" and checks that out. That's 
   purely shorthand for

	git branch newbranch v2.6.18	# create 'newbranch', initialize 
					# it at v2.6.18

	git checkout newbranch		# make 'newbranch' our currently 
					#active branch

   but you are _not_ allowed to do

	git checkout v2.6.18

   because that would leave you with a situation where your "top-of-tree" 
   is a tag, and you couldn't do any development on it because you don't 
   have a branch to develop _on_.

But all of these kinds of differences between tags and branches are really 
not "core technology" and are purely about having adopted a convention. It 
is literally about just having certain "usage rules" for specific 
"symbolic namespaces".

"branch" and "tag" are just the normal namespaces git gives you and always 
has. You can have others too (and you can define your own) and those names 
will automatically be used for lookup by all the basic git tools. Git 
won't _touch_ those names in any other way, but it means that you can 
create your own tools around git that have their own rules about how the 
names are managed, and you can still use them for lookup.

For example, you could have a "svn" namespace for a project imported from 
svn, and that namespace would contain the SVN revision names for the 
project, so that you could do

	git diff svn/56..

to see the difference between "svn revision 56" and your current HEAD, 
without necessarily polluting the "real" git tag namespace.

(Which can matter, since some commands take arguments like "--tags", which 
just collects all the regular tags - so you might not want to use normal 
tags to remember your SVN revision mapping, even if it might technically 
be fine).

(The above was a totally made-up example. I don't think any of the svn 
importers actually do anything like that: but we do use a few other 
"namespaces" internally: "git bisect" puts the bisection results in the 
"bisect" namespace, and the "remotes" namespace can be used to track 
remote heads as something _different_ than a local branch - so that you 
won't check such a "remote branch" out directly by mistake)

			Linus
