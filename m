From: tony.luck@intel.com
Subject: Re: trying to figure out this git thing - some questions
Date: Thu, 14 Apr 2005 16:52:13 -0700
Message-ID: <200504142352.j3ENqDB06021@unix-os.sc.intel.com>
References: <68b6a2bc05041412025f1cb7c9@mail.gmail.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 01:49:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DME4w-0000Sq-RL
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVDNXwW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261662AbVDNXwW
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:52:22 -0400
Received: from fmr23.intel.com ([143.183.121.15]:48094 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261660AbVDNXwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:52:15 -0400
Received: from scsfmr100.sc.intel.com (scsfmr100.sc.intel.com [10.3.253.9])
	by scsfmr003.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id j3ENqD66021306;
	Thu, 14 Apr 2005 23:52:13 GMT
Received: from unix-os.sc.intel.com (unix-os.sc.intel.com [172.25.110.7])
	by scsfmr100.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with ESMTP id j3ENrXJI010553;
	Thu, 14 Apr 2005 23:53:33 GMT
Received: from localhost (localhost [[UNIX: localhost]])
	by unix-os.sc.intel.com (8.11.6/8.11.2) id j3ENqDB06021;
	Thu, 14 Apr 2005 16:52:13 -0700
In-Reply-To: <68b6a2bc05041412025f1cb7c9@mail.gmail.com>
To: Ehud Shabtai <eshabtai.lkml@gmail.com>
X-Scanned-By: MIMEDefang 2.44
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>I'm trying to understand how it works and I'll appreciate if someone could help.

>1. git uses object abstraction for the different types and so
>everything is in one directory (objects). From what I've seen in the
>implementation, the different kind of objects are not of the same type
>(there aren't any operations which work on two different types) and
>thus in each step when an object is used its type is verified.
>What's the benefit of having them all in the same tree? An alternative
>would be to separate the different object types into different
>directories which trivially allows getting a list of all commits, or
>trees or blobs.

If all the commits were in ".git/objects/commits/xx/xxxxx", etc. then every
time git opened a file the kernel would have one extra level of directory
to walk to get to the file ... so opens would be fractionally slower. There
is no normal-use upside to this overhead.  While it would be easier to find
all the blobs if they were kept separate from the trees and commits, there
isn't any time that we'd ever want to scan through just the blobs.  Git never
goes searching through a directory opening files to see what they are
(exception: fsck-cache does scan all objects).

>2. A commit can have more than one parent. Can anyone draw an example
>of such a case? When do we get a commit graph which is not linear?

When a merge happens.  E.g. I take a snapshot of Linus' tree when a file
is at version 1.2.  We both make a couple of changes before I ask him to
pull from my tree:

	1.1 -> 1.2 -> 1.3 -> 1.4 -> 1.5
                \                  /
                1.2.1 -> 1.2.2 ---/

The changeset to create 1.5 has two parents ... the changeset that Linus made
to create 1.4, and the changeset that I made to create 1.2.2

>3. How does git handle binary files? I guess it doesn't really care if
>it's binary or text, but how would the diff and merge scripts handle
>them?

Yes, git doesn't care.  Diff is somewhat smart about noticing that its
input files aren't text:

	$ diff /bin/cat /bin/ls
	Binary files /bin/cat and /bin/ls differ

But in general this will be an issue for the SCM layer if there are binary
files checked into the tree.

-Tony
