From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/2] merge-trees script for Linus git
Date: Sat, 16 Apr 2005 01:12:12 -0700
Message-ID: <7vis2ncf8j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
	<7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
	<20050415062807.GA29841@64m.dyndns.org>
	<7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
	<7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
	<7vmzrzhkd3.fsf@assigned-by-dhcp.cox.net>
	<7vfyxrhfsw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vmzrzfwe4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504151755590.7211@ppc970.osdl.org>
	<7v7jj3fjky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504152152580.7211@ppc970.osdl.org>
	<P
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 10:09:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMiMP-00086M-Ph
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 10:09:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDPIM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 04:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVDPIM2
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 04:12:28 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:32687 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261192AbVDPIMO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 04:12:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050416081212.TRAK13819.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Apr 2005 04:12:12 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Damn, my cunning plan is some good stuff. 

I really like this a lot.  It is *so* *simple*, clear, flexible
and an example of elegance.  This is one of the things I would
happily say "Sheeeeeeeeeeeeeesh!  Why didn't *I* think of *THAT*
first!!!" to.

LT> NOTE NOTE NOTE! I could make "read-tree" do some of these nontrivial 
LT> merges, but I ended up deciding that only the "matches in all three 
LT> states" thing collapses by default.

 * Understood and agreed.

LT> Damn, I'm good.

 * Agreed ;-). Wholeheartedly.

So what's next?  Certainly I'd immediately drop (and I would
imagine you would as well) both C or Perl version of
merge-tree(s).

The userland merge policies need ways to extract the stage
information and manipulate them.  Am I correct to say that you
mean by "ls-files -l" the extracting part?

LT> I should make "ls-files" have a "-l" format, which shows the
LT> index and the mode for each file too.

You probably meant "ls-tree".  You used the word "mode" but it
already shows the mode so I take it to mean "stage".  Perhaps
something like this?

$ ls-tree -l -r 49c200191ba2e3cd61978672a59c90e392f54b8b
100644	blob	fe2a4177a760fd110e78788734f167bd633be8de	COPYING
100644	blob	b39b4ea37586693dd707d1d0750a9b580350ec50:1	man/frotz.6
100644	blob	b39b4ea37586693dd707d1d0750a9b580350ec50:2	man/frotz.6
100664	blob	eeed997e557fb079f38961354473113ca0d0b115:3	man/frotz.6
 ...

The above example shows that COPYING has merged successfully,
and O and A have the same contents and B has something different
at man/frotz.6.

Assuming that you would be working on that, I'd like to take the
dircache manipulation part.  Let's think about the minimally
necessary set of operations:

 * The merge policy decides to take one of the existing stage.

   In this case we need a way to register a known mode/sha1 at a
   path.  We already have this as "update-cache --cacheinfo".
   We just need to make sure that when "update-cache" puts
   things at stage 0 it clears other stages as well.

 * The merge policy comes up with a desired blob somewhere on
   the filesystem (perhaps by running an external merge
   program).  It wants to register it as the result of the
   merge.

   We could do this today by first storing the "desired blob"
   in a temporary file somewhere in the path the dircache
   controls, "update-cache --add" the temporary file, ls-tree to
   find its mode/sha1, "update-cache --remove" the temporary
   file and finally "update-cache --cacheinfo" the mode/sha1.
   This is workable but clumsy.  How about:

   $ update-cache --graft [--add] desired-blob path

   to say "I want to register mode/sha1 from desired-blob, which
   may not be of verify_path() satisfying name, at path in the
   dircache"?

 * The merge policy decides to delete the path.

   We could do this today by first stashing away the file at the
   path if it exists, "update-cache --remove" it, and restore
   if necessary.  This is again workable but clumsy.  How about:

   $ update-cache --force-remove path

   to mean "I want to remove the path from dircache even though
   it may exist in my working tree"?

So it all boils down to update-cache.  The new things to be
introduced are:

 * An explicit update-cache always removes stage 1/2/3 entries
   associated with the named path.

 * update-cache --graft

 * update-cache --force-remove

Am I on the right track?

You might want to go even lower level by letting them say
something like:

 * update-cache --register-stage mode sha1 stage path

   Registers the mode/sha1 at stage for path.  Does not look at
   the working tree.  stage is [0-3]
 
 * update-cache --delete-stage stage-list path

   Removes the entry at named stages for path.  Does not look at
   the working tree.  stage-list is either [0-3](,[0-3])+ or
   bitmask (i.e. (1 << stage-number) ORed together).  The former
   would probably be easier to work with by scripts

 * write-blob path

   Hashes and registers the file at path (regardless of what
   verify_path() says) and writes the resulting blob's mode/sha1
   to the standard output.

If you take this lower-level approach, an explicit update-cache
would not clear stage1/2/3.

My preference is the former, not so low-level, interface.
Guidance?

