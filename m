From: Marc Singer <elf@buici.com>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Fri, 8 Jul 2005 17:40:47 -0700
Message-ID: <20050709004047.GA27080@buici.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 09 03:23:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dr43n-0007ff-1C
	for gcvg-git@gmane.org; Sat, 09 Jul 2005 03:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVGIBXD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 21:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263022AbVGIAlx
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 20:41:53 -0400
Received: from florence.buici.com ([206.124.142.26]:13546 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263031AbVGIAks
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 20:40:48 -0400
Received: (qmail 27097 invoked by uid 1000); 9 Jul 2005 00:40:47 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2005 at 05:17:08PM -0700, Junio C Hamano wrote:
> >>>>> "MS" == Marc Singer <elf@buici.com> writes:
> 
> MS> In working through a usage example on my way to producing bonafide
> MS> patches, I've found that commit is complaining.  Here's what I've done.
> 
> MS>   o Fetched and built cogito-0.12
> MS>   o Fetched (rsync) Linus' tree
> MS>   o Created a working directory, linux-2.6
> MS>   o linked .git in the working directory to the .git directory fetched
> MS>     from the net.
> 
> This is slightly different from the BCP.  A recommended way is:
> 
>  $ mkdir linux-2.6
>  $ cd linux-2.6
>  $ git-init-db
>  $ rsync linux-2.6.git/ from kernel.org into .git/

Does this preclude symlinking .git?  I'd like to keep one .git which
is mirrored from the net and allow for more than one working
directory.

> Although your commit problem does not have to do with this.
> 
> MS>   o # git checkout -f v2.6.11
> MS>   o # cat ../old-patch-file | patch -p1
> 
> GITified Linux kernel repository starts at v2.6.12-rc2, so
> from anything older you cannot create a commit off of it
> (easily).

Trouble is that 2.6.12 breaks some things and I need to continue to
build patches from 2.6.11 for the time being.  Once I get familiar,
I'll patch the tree to build properly for my targets with later
revisions.

> MS> Then, according to Jeff's instructions, I have to perform
> MS> get-update-cache with the name of each file I changed.  Is that really
> MS> the way?
> 
> MS>   o # git-update-cache LIST_OF_CHANGED_FILES
> 
> That is correct.  Also remember to say:
> 
>     git-update-cache --add LIST_OF_ADDED_FILES
>     git-update-cache --remove LIST_OF_REMOVED_FILES

His text is a little overly-brief on this, but I got the gist.

> Notice the use of git-apply --index instead of patch -p1 in the
> above example?  If you use git-apply --index, you do not have to
> do the above steps yourself.

Notice it...where?  I gather that git-apply is a better way to apply
patches?

> MS>    fatal: 5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c is not a valid 'commit' object
> 
> That is a tag to the v2.6.11 tree, which is not a valid commit,
> so you cannot make a commit off of it.

So what does this mean?  Can I only produce commits from the master?
Is this a peculiarity of the v2.6.11 tag?

> Linus, I think git-checkout-script should not store a tag to non
> commit in HEAD.  If that did not happen, and if the repo was
> created without ref/heads/master (the usual case), then he
> _could_ have done something like this:
> 
>  $ git checkout -f v2.6.11 ;# fixed one
>  warning: v2.6.11 is not a commit -- not updating your HEAD
>  $ git commit ;# to have his own baseline at v2.6.11
>  $ git-apply --index --stat --summary --apply <../old-patch-file
>  $ : do the usual tests
>  $ git commit ;# create a commit based on the baseline v2.6.11

That sounds like what I'm looking for.  Can I do this by hand somehow?

As an ARM developer, I need to be able to cleanly track kernel
development revisions and produce patches that are easy to merge.  The
cycle is something like this:

  o Update kernel tree.
  o Fix the build.
  o Produce a patch to send upstream.
  o Apply work-in-progress patches
  o Fix the build.
  o Publish new patches against updated kernel tree

The trickiest part has been bringing the works-in-progress forward
without spending lots of time babysitting the SCM tools.
