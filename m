From: Jeff King <peff@peff.net>
Subject: Re: Merging two projects
Date: Mon, 3 Nov 2008 23:56:44 -0500
Message-ID: <20081104045644.GC31276@coredump.intra.peff.net>
References: <216e54900811031933n346e8c68se9226e79366c3eb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Arnott <andrewarnott@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:58:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxE0I-0007I6-C9
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:58:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYKDE4r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbYKDE4r
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:56:47 -0500
Received: from peff.net ([208.65.91.99]:2338 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751052AbYKDE4q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 23:56:46 -0500
Received: (qmail 5146 invoked by uid 111); 4 Nov 2008 04:56:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 23:56:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 23:56:44 -0500
Content-Disposition: inline
In-Reply-To: <216e54900811031933n346e8c68se9226e79366c3eb6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100035>

On Mon, Nov 03, 2008 at 07:33:21PM -0800, Andrew Arnott wrote:

> I have two projects, both with histories, that I want to merge into
> just one library.  I'd like to preserve both histories, perhaps as if
> there were two branches being merged into one.  (Although each project
> has its own branches that will make the history interesting).
> 
> Is there a standard way to do this?

You have two options:

 - just merge the history as if they were two branches:

     # make a new combined repo
     mkdir merged && cd merged && git init

     # pull in each library
     for lib in lib1 lib2; do
       git fetch /path/to/$lib master:$lib
       git checkout $lib
       # do any pre-merging fixups
       mkdir $lib
       mv * $lib
       git add -u
       git add $lib
       git commit -m "move files into $lib in preparation for project merge"
     done

     # and then merge; order isn't really important
     git checkout lib1
     git merge lib2

   This method is nice because it preserves the original histories, and
   you can still merge from the original projects (if people are still
   working on them as individual projects).

   Note that this is basically what the subtree merge strategy does, so
   you could also use that. I showed all the steps here to give a sense
   of what is going on, and because you might want to do additional
   fixups besides moving files into the subtree.

 - The other alternative is rewriting the history. The advantage here
   is that the history looks as if the projects had always been part of
   the repo, so there is no big rename event. You can even annotate the
   commit messages to indicate which project is being worked on.

   The downside, of course, is that having rewritten history, merges
   with the original project become more difficult. But that is not a
   problem if you are going to throw away the original repositories.

   You can accomplish this with filter-branch:

     mkdir merged && cd merged && git init
     for lib in lib1 lib2; do
       git fetch /path/to/$lib master:$lib
       git checkout $lib
       git filter-branch -f \
         --index-filter '
             git ls-files -s |
             sed "s,\t,&'$lib'/," |
             GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
               git update-index --index-info &&
               mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' \
         --msg-filter "sed '1s/^/[$lib] /'" \
         $lib
     done

   and then merge the resulting branches as usual.

Hope that helps.

-Peff
