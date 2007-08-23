From: Greg KH <greg@kroah.com>
Subject: Re: stgit 0.13 import mbox problems
Date: Thu, 23 Aug 2007 09:43:22 -0700
Message-ID: <20070823164322.GC5528@kroah.com>
References: <20070823092254.GA5976@kroah.com> <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 18:44:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOFnS-0003Gh-JF
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 18:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208AbXHWQof (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755717AbXHWQof
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 12:44:35 -0400
Received: from canuck.infradead.org ([209.217.80.40]:46890 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbXHWQoe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 12:44:34 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174] helo=localhost)
	by canuck.infradead.org with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IOFnM-0007KS-HV; Thu, 23 Aug 2007 12:44:33 -0400
Content-Disposition: inline
In-Reply-To: <b0943d9e0708230319m3242f4a7yb4db1505f0d2e3@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56507>

On Thu, Aug 23, 2007 at 11:19:12AM +0100, Catalin Marinas wrote:
> On 23/08/07, Greg KH <greg@kroah.com> wrote:
> > I wanted to see if I could start using stgit instead of quilt, so I
> > tried to import my current set of kernel patches.
> >
> > After giving up on the "import a series" option,
> 
> Why?

Because it kept dieing too :)

Also, it would import these patches, which are individually in mbox
form, with the incorrect author information.  So I thought I would use
the mbox form to make sure I wasn't just doing something stupid.

> > I just created a mbox
> > of all of them using quilt and tried to import that.  Unfortunately that
> > didn't work either:
> >         $ stg import -M ~/linux/patches/mbox
> >         Checking for changes in the working directory ... done
> >         Importing patch "add-my-version-to-the-kernel" ... done
> >         Importing patch "stupid-patch-for-my-laptop-whi" ... done
> >         Importing patch "gregs-test-driver-core-sysfs-s" ... done
> >         Importing patch "detect-atomic-counter-underflo" ... done
> >         Warning: Message does not contain any diff
> >         stg import: No diff found inside the patch
> 
> Maybe I should just leave the warning and let it continue. The reason
> I added it was that "git-apply --index" fails if there is no diff.

But there was a diff.  Or it was in the file, I don't know what happened
to it :)

> In the meantime, you can try the attached patch for StGIT.
> 
> Another hint - quilt can apply patches with fuzz but GIT doesn't allow
> this by default. If a patch fails, the diff is dumped to the
> .stgit-failed.patch file so that you can apply it manually (with patch
> or git-apply) and run 'stg refresh' afterwards.

Ah, perhaps this is the problem, I'll check it out later today.  A bit
more helpful message would be appreciated, especially as I get a lot of
patches that at first apply, do not go cleanly at all.  I think there's
an override option for git to ignore fuzz somewhere, right?  Perhaps
that could be an option for stgit here?

> After an import failure, you can continue importing from the next
> patch using the 'stg import --ignore' option.

Ok, will try that, and your patch.

> > I'm using the .13 version if that matters.
> >
> > The mbox contains 177 kernel patches against Linus's current tree
> > (2.6.23-rc3-git5), and is available at:
> >         http://www.kernel.org/pub/linux/kernel/people/gregkh/misc/gregkh-stgit-import-mbox.gz
> > if anyone wants to test it out and see what I was doing wrong.
> 
> I'll give it a try.
> 
> One thing you'll notice is the speed difference as stgit has to
> generate a git commit during a push operation.

Oh yeah, I know that it would be slower, but I use git-quiltapply a lot
for sending patches to Linus, and that seems quite fast (actually a lot
faster than stgit for some reason...)

> > Oh, I do have some suggestions as to the naming of the patch from a mail
> > file, as limiting this to a small number of characters like stgit
> > currently does will not work out for a lot of my patches, but I'll wait
> > until I can actually import the thing before I look into that :)
> 
> We had the full name in the past but the algorithm cause problems with
> patches (not e-mails) that didn't have a subject line. It's probably
> better to have a config option rather than hard-coded 30 characters.
> Note that 'stg series -d' will display the full subject line.

Hm, that shows:
	$ stg series -d
	+ add-my-version-to-the-kernel   | Add my version to the kernel.
	+ stupid-patch-for-my-laptop-whi | Stupid patch for my laptop which cant get sysrq-u
	+ gregs-test-driver-core-sysfs-s | Gregs test driver core / sysfs stress test module
	> detect-atomic-counter-underflo | detect atomic counter underflows

Are those spaces really the name of the patch?

Why not just take the Subject: and mangle it to be the full name of the
patch (yeah, I can see problems if you don't have the subject).  I have
a bash script around here from a kernel developer that I use to turn
mbox files into sane file names that works great.

Ah, it's at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/scripts/rename-patch
if you want to take a look and possibly use the same type of logic.
Hm, Jean seems to have updated it, use the one at:
	http://jdelvare.pck.nerim.net/linux/rename-patch
instead, it's a bit more up to date.

> If you don't give up before importing the files :-), please let us
> know the user experience, especially related to speed as compared to
> quilt.

I really don't want to give up :)

I really do like quilt, but wanted to see how well my current workflow
could be by using stgit as I'm constantly rebasing the main kernel
version against -git snapshots and sometimes that isn't frequent enough.

thanks,

greg k-h
