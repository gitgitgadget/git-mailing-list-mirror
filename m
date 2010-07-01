From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Why is "git tag --contains" so slow?
Date: Wed, 30 Jun 2010 17:58:54 -0700
Message-ID: <20100701005854.GO2337@spearce.org>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 01 02:59:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OU87O-0000WQ-RB
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 02:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab0GAA7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jun 2010 20:59:00 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32983 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0GAA7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jun 2010 20:59:00 -0400
Received: by pzk26 with SMTP id 26so29273pzk.19
        for <git@vger.kernel.org>; Wed, 30 Jun 2010 17:58:56 -0700 (PDT)
Received: by 10.142.134.13 with SMTP id h13mr6111221wfd.48.1277945936073;
        Wed, 30 Jun 2010 17:58:56 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x19sm2541253wfd.22.2010.06.30.17.58.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Jun 2010 17:58:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1OU82h-0001xY-3b@closure.thunk.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150003>

Theodore Ts'o <tytso@mit.edu> wrote:
> 
> I'm trying to write a script that can determine the first kernel release
> (i.e., a tag of that matchs v2.6.*) that contains a particular commit.
> 
> I can do this using "git tag --contains <commit-id>", but it's quite
> slow.  It takes something like 8-9 seconds.  (8.5 seconds of user time,
> 8.6 times of wall clock, to be precise).
> 
> I can get the information much faster using "gitk -1 <commit-id>", which
> finishes painting the screen in under 2 seconds, but that throws up a
> GUI and then a human has to pull the information out using their eyes.
> (Yeah, or I could figure out where in the 11,631 lines of Tcl script the
> "preceeds" line is calculated, but I figured I'd ask here first.)
> 
> Is there a better way of calculating what I want from the command line
> using the built-in native git tools?  And if so, why is git tag
> --contains apparently 4 times slower than gitk at performing this task?

gitk keeps a cache of this stuff in .git/gitk.cache.  I'll bet its
pulling from cache here, which is why it snaps so fast.

Without the cache is expensive, which is what 'git tag --contains'
is doing.  The code walks back from each tag tracing along the commit
parent pointers, keeping track of the nearest tag name that can reach
any given commit.  When it finds your commit, it stops and outputs.

Since this stuff can't change unless the refs change, yes, it can be
cached easily.  But nobody has done caching for this in Git itself,
only in Tcl for gitk.  :-\

-- 
Shawn.
