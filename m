From: tytso@mit.edu
Subject: Re: Why is "git tag --contains" so slow?
Date: Sat, 3 Jul 2010 20:55:43 -0400
Message-ID: <20100704005543.GB6384@thunk.org>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 04 02:55:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVDUw-0001gj-NH
	for gcvg-git-2@lo.gmane.org; Sun, 04 Jul 2010 02:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756415Ab0GDAzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 20:55:49 -0400
Received: from THUNK.ORG ([69.25.196.29]:43673 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755879Ab0GDAzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 20:55:49 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1OVDUm-0003ut-D1; Sat, 03 Jul 2010 20:55:44 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.71)
	(envelope-from <tytso@thunk.org>)
	id 1OVDUl-0000Su-Mi; Sat, 03 Jul 2010 20:55:43 -0400
Content-Disposition: inline
In-Reply-To: <20100703080618.GA10483@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150215>

On Sat, Jul 03, 2010 at 04:06:19AM -0400, Jeff King wrote:
> 
> I noticed that my improved time for "git tag --contains" was similar to
> the total time for "git rev-list --all >/dev/null". Can you try timing
> that? My suspicion is that it is going to be about 2.9 seconds for you.

I'm at home, so getting access to my work machine is a bit of a pain,
so I replicated the experiment at home.

% time /tmp/git.1.7.2-rc1 tag --contains 307ae18 | wc -l
13

real	0m13.706s
user	0m13.542s
sys	0m0.150s

% time /tmp/git.patch.1 tag --contains 307ae18 | wc -l
13

real	0m2.869s
user	0m2.703s
sys	0m0.163s

% time /tmp/git.patch.1 rev-list --all  > /dev/null

real   0m3.074s
user   0m2.920s
sys    0m0.147s


> Try the patch below, which adds a date cutoff similar to the one used in
> name-rev. It's much faster in my tests:

Yep, much faster indeed:

% time /tmp/git.patch.2 tag --contains 307ae18 | wc -l
13

real	0m0.054s
user	0m0.030s
sys	0m0.023s

> The obvious downside is that it stops looking down a path in the face of
> extreme clock skew. We could perhaps allow a "--contains=thorough" to
> spend a little more time to achieve a better answer (i.e., ignore the
> cutoff date).

Yep, it does blow up in the face of the extreme clock skew in some of
the ext4 commits in the Linux kernel tree.  (Sorry about that; mea
culpa, I didn't realize at the time this was a problem, and it was my
workflow using the guilt program which happened to introduce them.)

In any case, because of the ext4 commits, I can show a test case which
doesn't work well with your date cutoff patch:

#!/bin/sh

for i in $(git log --reverse --oneline v2.6.32..v2.6.35-rc3 fs/ext4 fs/jbd2 |
      	       awk '{print $1}')
do
    echo -n "$i "
    /tmp/git.patch.2 tag --contains $i | head -1
done

You won't see any problems after v2.6.34; I fixed my workflow once I
was told it was causing git problems.

If you replace this with the unpatched git, or with git with your
first patch, it will be of course much slower, but it will print out
all of the tags that would be expected given a topographical
examination of the commit graph.  Whether this is a bug in git or a bug
that I introduced into the Linux kernel git tree is of course an open
question.  However, if we do want to allow git operations to work
quickly --- and I agree this is a good thing; the speedups that this
can allow are quite significant --- maybe we should teach "git commit"
to either print a warning or outright refuse to introduce clock skews
in the first place.

(Or maybe we have git config options that can enable or disable
optimizations that depend on the lack of clock skews; but I could
understand people not wanting to maintian the extra code paths.)

	   	      	      	 	  - Ted
