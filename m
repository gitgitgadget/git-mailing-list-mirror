From: Sam Vilain <sam@vilain.net>
Subject: Re: n-heads and patch dependency chains
Date: Wed, 05 Apr 2006 18:34:29 +1200
Message-ID: <443364F5.2040504@vilain.net>
References: <4430D352.4010707@vilain.net>	<7vsloucuxk.fsf@assigned-by-dhcp.cox.net>	<4431B60E.3030008@vilain.net> <7vhd596ua0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 08:35:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FR1bV-00032v-9p
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 08:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWDEGeq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 02:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbWDEGeq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 02:34:46 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:19346 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S1751112AbWDEGeq
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 02:34:46 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id 85A745A70; Wed,  5 Apr 2006 18:34:42 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id 9C3E04D36;
	Wed,  5 Apr 2006 18:34:33 +1200 (NZST)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd596ua0.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.1.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18418>

Junio C Hamano wrote:

>A "bind commit" proposal was made to support subprojects living
>in their own subdirectories.  The picture to describe the commit
>ancestry chain would be almost the same as the above picture,
>except that it did not uncap and recap, but would have built its
>own ancestry chain.
>  
>

I had considered that this would make directory subprojects possible,
but didn't want to draw attention to it.

Actually I'm now of the thinking that the problem is that we are using
'parent' for two things;

1. the merge bases for this merge, if a merge
(or the base for this change for a patch)

2. the historical precedent(s) for this commit.

In the single line of history case these are always the same. For an
actual merge they are also the same. However, when you are superceding a
merge with a newer merge, or mucking with history they are different.

So, I think all we need to make this all work smashingly well is to have
a new field called "prior" or perhaps "previous".

As well as being mostly backwards compatible and supporting grouping
your commits into topics in a single checkout, this would also have the
side effect of:

- directly supporting stgit / pg style patchset evolution, without
needing to use seperate branches for each release of your patchset. This
would not replace the need for stgit etc to wind the head - while
revising a patchset you really don't want the system to record
intermediate changes, just the ones you want to publish

- supporting tree subprojects (as it is a more specific use case)

- rewriting history! Without losing the old commits. Unless you wanted
to - say, for archiving old commits by rebasing the whole project off a
new revision.

It also does not suffer from the 'problem' in Andreas' "dual head
commit" approach that one commit will thenceforth be known by two commit
IDs.

>It had two different kinds of commit relationships: parenthood
>and directory structure binding.  The component subprojects
>lived in their own subdirectories (so if you are maintaining an
>embedded Linux along with matching toolchain, you would have linux/
>subdirectory that has the kernel hierarchy, gcc/, libc/, ...),
>and commit objects had "bind commit-sha1 subdirectory-name"
>lines to express how the components are bundled together.  A
>commit object would have looked like this:
>
>	tree fc9957b0052df6a8248420395bc9febd66194252
>        parent 052df6a8248420395bc9febd66194252fc9957b0
>        bind f6a8248420395bc9febd66194252fc9957b0052d linux/
>        bind 20395bc9febd66194252fc9957b0052df6a82484 gcc/
>	author A U Thor <author@example.com> 1144111304 -0700
>
>The "parent" line is the commit ancestry as usual, and each
>"bind" line names a commit object of component project and where
>in the directory hierarchy the tree for that commit object would
>be checked out.  The "tree" line records the result of grafting
>the subprojects together.  So, for example, ls-tree -d fc9957
>linux in the above example would have shown the tree object
>f6a824^{tree}.
>  
>

While the approach I outlined supports this in a way, it is subtly
different.

Firstly, the above approach makes it a hard requirement that the
independent series of commits are in seperate paths, you mention a fix
for this -

>The structure forbid you from binding two separate projects at
>the same directory in order to enforce clean separation of
>subprojects, but if you allow multiple commits to be bound at
>the root level, that could be used as a hydra cap.
>  
>

- but this means you are not storing the 'merged' tree in the commit,
which I think is a mistake. While we've been talking mostly about
dealing with managing changes simple enough to merge plainly for
simplicity of operations, this would *force* it to be so because you
need to allow anyone to check it out.

On the other hand - these bind commits enables tracking a sub-project in
a sub-directory whilst retaining the same commit IDs, to make tracking
easier.

Even this works using "prior", too - though you'd have to use surrogate
commits that link to the sub-project commit and wrapper tree object.

How does that sound?

Sam.
