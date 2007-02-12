From: Rogan Dawes <discard@dawes.za.net>
Subject: Re: restriction of pulls
Date: Mon, 12 Feb 2007 15:58:46 +0200
Message-ID: <45D07296.7070804@dawes.za.net>
References: <200702091149.12462.duelli@melosgmbh.de> <Pine.LNX.4.63.0702091554160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45CC941E.9030808@dawes.za.net> <Pine.LNX.4.63.0702101533060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Rogan Dawes <lists@dawes.za.net>,
	Christoph Duelli <duelli@melosgmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 12 15:00:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGbjO-0001M6-Ur
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 15:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbXBLOAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 09:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbXBLOAb
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 09:00:31 -0500
Received: from sumo.dreamhost.com ([66.33.216.29]:50737 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964921AbXBLOAb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 09:00:31 -0500
Received: from spunkymail-a20.g.dreamhost.com (sd-green-bigip-145.dreamhost.com [208.97.132.145])
	by sumo.dreamhost.com (Postfix) with ESMTP id DA4BE1879D7
	for <git@vger.kernel.org>; Mon, 12 Feb 2007 06:00:25 -0800 (PST)
Received: from [192.168.201.100] (dsl-146-24-208.telkomadsl.co.za [165.146.24.208])
	by spunkymail-a20.g.dreamhost.com (Postfix) with ESMTP id 4AD72FE75F;
	Mon, 12 Feb 2007 05:58:57 -0800 (PST)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <Pine.LNX.4.63.0702101533060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39401>

Johannes Schindelin wrote:
> Hi,
> 
> On Fri, 9 Feb 2007, Rogan Dawes wrote:
> 
>> Johannes Schindelin wrote:
>>> On Fri, 9 Feb 2007, Christoph Duelli wrote:
>>>
>>>> Is it possible to restrict a chechout, clone or a later pull to some 
>>>> subdirectory of a repository?
>>> No. In git, a revision really is a revision, and not a group of file 
>>> revisions.
>> I thought about how this might be implemented, although I'm not entirely 
>> sure how efficient this will be.
> 
> There are basically three ways I can think of:
> 
> - rewrite the commit objects on the fly. You might want to avoid the use 
> of the pack protocol here (i.e. use HTTP or FTP transport).
> 
> - try to teach git a way to ignore certain missing objects and 
> directories. This might be involved, but you could extend upload-pack 
> easily with a new extension for that.
> 
> (my favourite:)
> - use git-split to create a new branch, which only contains doc/. Do work 
> only on that branch, and merge into mainline from time to time.
> 
> If you don't need the history, you don't need to git-split the branch.
> 
> You only need to make sure that the newly created branch is _not_ branched 
> off of mainline, since the next merge would _delete_ all files outside of 
> doc/ (merge would see that the files exist in mainline, and existed in the 
> common ancestor, too, so would think that the files were deleted in the 
> doc branch).
> 
> Ciao,
> Dscho
> 

Your third option sounds quite clever, apart from the problem of 
attributing a commit and a commit message to someone, when the actual 
commit doesn't match what they actually did :-(

As well as wondering what happens when they check out a few more files. 
Do we rewrite those commits as well? What happens if the user has made 
some commits already? What happens if they have already sent those 
upstream? etc.

I think the best solution is ultimately to make git able to cope with 
certain missing objects.

I started writing this in response to another message, but it will do 
fine here, too:

The description I give here will likely horrify people in terms of 
communications inefficiency, but I'm sure that can be improved.

Scenario:

A user sees a documentation bug in a git-managed project, and decides 
that she wants to do something about it. Since she is not on the fastest 
of connections, she'd like to reduce the checkout to a reasonable 
minimum, while still working with the git tools.

Viewing the repo layout using gitweb, she sees that all the 
documentation is stored in the docs/ directory from the root.

So, she creates a local repo to work in:

$ git init-db

She configures her local repo to reference the source one:

(Hypothetical syntax)
$ git clone --reference http://example.com/project.git \
     http://example.com/project.git

Since the reference and repo are the same (and non-local), git doesn't 
actually download anything, other than the current heads (and maybe tags).

She then does a partial checkout of the master branch, but only the 
docs/ directory:

$ git checkout -p master docs/

The -p flag indicates that this is a partial checkout of master. Git 
records that the current HEAD is "master", checks out the docs/ 
directory, and removes any other files in the working directory (that it 
knew about from the existing index, if any - I'm not suggesting that it 
should arbitrarily delete files!)

The checkout process goes as follows: Resolve the <treeish> that HEAD 
points to, and retrieve it from the upstream repo if it does not exist 
locally. Continue requesting only the necessary tree and blob objects to 
satisfy the requested checkout. i.e. From the first tree, identify the 
docs/ directory. Then request only that tree object. Continue to 
download tree and blob objects until the entire docs/ directory can be 
created in the working directory.

This will likely require a new index file format, that simply stores the 
hashes of objects (blobs or trees) that have not been checked out, as 
well as the current file's stat information.

Now create a "negative index" (pindex?) that has details about the other 
files and directories that were not checked out. Obviously, this does 
not need to recurse into directories that were not checked out. Simply 
having the hash of the parent directory in the pindex is sufficient 
information to reconstruct a new index. (This might require a new index 
format that does not include all known files, but simply stores the hash 
of the unchecked-out tree or blob.)

Then creating a new commit would require creating the necessary blobs 
for changed files, new tree objects for trees that change, and a commit 
object.

As far as I can tell, that could then be pushed/pulled/merged using the 
existing tools, without any problems.

Rogan
