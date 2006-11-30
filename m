X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: sf <sf@b-i-t.de>
Subject: Re: [RFC] Submodules in GIT
Date: Thu, 30 Nov 2006 17:05:39 +0100
Message-ID: <456F0153.5000107@b-i-t.de>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611301255.41733.andyparkins@gmail.com> <456EE3F1.5070101@b-i-t.de> <200611301449.55171.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 30 Nov 2006 16:06:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (X11/20061110)
In-Reply-To: <200611301449.55171.andyparkins@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32764>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoQ3-0004Aw-0i for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030645AbWK3QFr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967836AbWK3QFr
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:05:47 -0500
Received: from mail.medianet-world.de ([213.157.0.167]:25747 "HELO
 mail.medianet-world.de") by vger.kernel.org with SMTP id S967828AbWK3QFq
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:05:46 -0500
Received: (qmail 6385 invoked by uid 1011); 30 Nov 2006 16:05:45 -0000
Received: from sf@b-i-t.de by mail1 by uid 1003 with qmail-scanner-1.22 
 (ExcuBAtor: 1.0.2.  Clear:RC:1(213.157.15.184):SA:0(0.0/5.0):.  Processed in
 0.404396 secs); 30 Nov 2006 16:05:45 -0000
Received: from unknown (HELO IP-213157000067.dialin.heagmedianet.de)
 (213.157.15.184) by mail.medianet-world.de with SMTP; 30 Nov 2006 16:05:45
 -0000
Received: from [192.168.168.40] (groa.b-i-t.de [192.168.168.40]) by
 mail.b-i-t.de (Postfix) with ESMTP id D4235259B7; Thu, 30 Nov 2006 17:05:39
 +0100 (CET)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins wrote:
> On Thursday 2006 November 30 14:00, Stephan Feder wrote:
> 
>> Again I do not see the problem. Probably I have a much simpler picture
>> of submodules: They are just commits in the supermodule's tree.
>> Everything else follows naturally from how git currently behaves.
> 
> How are these commits any different from just having one big repository?  If 
> some of the development of the submodule is contained in the supermodule then 
> it's not a submodule anymore.

Right now you only have commits of the top directory aka the super 
project. Every subdirectory is just that: a directory (which git stores 
as trees).

Now, if you have a subdirectory that git stores as a commit, not a tree, 
you have a subproject. It is a directory with history, and because the 
commit is part of your superprject, you have access to this history.

> Why bother with all the effort to make a separation between submodule and 
> supermodule and then store the submodule commits in the supermodule.  That's 
> not supermodule/submodule git - that's just normal git.

No, it is not. Currently, there is no way to store a commit within the 
contents of another commit. You can only store trees and blobs.

> Surely the whole point of having submodule's is so that you can take the 
> submodule away.  Let me give you an example.  Let's say I have a project that 
> uses the libxcb library (some random project out in the world that uses git).  
> I've arranged it something like this:
> 
> myproject (git root)
>  |----- src
>  |----- doc
>  `----- libxcb (git root)
> 
> This works fine; with one problem.  When I make a commit in myproject, there 
> is no link into the particular snapshot of the libxcb that I used at that 
> moment.  If libxcb moves on, and makes incompatible changes, then when I 
> checkout an old version of myproject, it won't compile any more because I'll 
> need to find out which commit of libxcb I used at the time.

OK.

> Submodules will solve this problem.  In the future I'll be able to check out 
> any commit of myproject and it will automatically checkout the right commit 
> from the libxcb repository.

OK, I am still with you so far.

> Now let's say I'm working away and find a bug in 
> libxcb; I fix it, commit it.  That change had better be stored in the libxcb 
> repository, and had better make no reference to the myproject repository.  If 
> it doesn't, I'm going to have to pollute the libxcb upstream repository with 
> myproject if I want to share those fixes.

Here comes the part where we did not meet before.

Of course you do not make any reference from your subproject to your 
superproject. You do exactly what you do in git today when you work with 
different branches:

Step 1: You fix a bug in myproject's subdirectory libxcb.

Step 2: You commit to myproject. myproject now contains a new commit 
object in path libxcb. (How to do that is up to the UI but at the 
repository level the outcome should be obvious). This commit is local to 
your repository.

Step 3: You propose your changes to the libxcb upstream (it might not be 
a repository you have write access to). I use the following made up 
syntax (see man git-rev-parse):

A suffix : followed by a path, _followed by a suffix //::_ names the 
_revision_ at the given path in the tree-ish object named by the part 
before the colon.

Step 3a: Generate a patch

git diff libxcb//^..libxcb//

Step 3b: Push your changes

git push <libxcb-repository> HEAD:libxcb//:<branch in libxcb-repository>

Step 3c: Let your changes be pulled

"Hello, please pull <myproject-repository> HEAD:libxcb//:<branch in 
libxcb-repository>"

Step 4: Pull upstream version (hopefully with your changes, otherwise 
you have to merge)

git pull <libxcb-repository> <branch in libxcb-repository>::HEAD:libxcb//

See, it works.

 From what I understand you want to do the commit and push steps in one 
go. How do you want to record local (to your superproject) changes to 
the subproject?

Regards

