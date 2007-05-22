From: "Dana How" <danahow@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 01:00:06 -0700
Message-ID: <56b7f5510705220100h77e91196r1784b33772911660@mail.gmail.com>
References: <46528A48.9050903@gmail.com>
	 <7vtzu58i4c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 22 10:00:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqPI6-0003Me-3h
	for gcvg-git@gmane.org; Tue, 22 May 2007 10:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbXEVIAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 04:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755127AbXEVIAO
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 04:00:14 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:1251 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755124AbXEVIAM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 04:00:12 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1673096wra
        for <git@vger.kernel.org>; Tue, 22 May 2007 01:00:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dUE1gcV0wSVJ0KJznvZMXwau4u6L3PXB7ikXasHjNNQPwvjKQa2wHFZgQE7JM8yWg4HArVVu5CtsWO+qxSDrmVX7UnRwwAkcf9aV9O4VXXvEOOvdLVXaVH5kVlRLcah0HbI+vHG2VaVIokzpqnC2d1d2H08s9hCkWa3pP1CRjZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YX36EtO827rFJ7VuZj8RPsjGP7BG8QX39RTHoAX4cGP4PsEq58EV+BsDFIn2V8iW9Ws4Pmn9bjt2boOHN9Ikv1zOwAxLh7XxfZyK/oYoASrhpxh5MY+9fo1otJ6XVebawxRSsZUNtx573Gz2AU29jjSAdKxtsaKl+6Mte7fIAA8=
Received: by 10.78.166.7 with SMTP id o7mr1324432hue.1179820806623;
        Tue, 22 May 2007 01:00:06 -0700 (PDT)
Received: by 10.78.129.3 with HTTP; Tue, 22 May 2007 01:00:06 -0700 (PDT)
In-Reply-To: <7vtzu58i4c.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48084>

On 5/21/07, Junio C Hamano <junkio@cox.net> wrote:
> Dana How <danahow@gmail.com> writes:
> > git stores data in loose blobs or in packfiles.  The former
> > has essentially now become an exception mechanism,  to store
> > exceptionally *young* blobs.  Why not use this to store
> > exceptionally *large* blobs as well?  This allows us to
> > re-use all the "exception" machinery with only a small change.
> Well, I had an impression that mmapping a single loose object
> (and then munmapping it after done) would be more expensive than
> mmapping a whole pack and accessing that object through window,
> as long as you touch the same set of objects and the object in
> the pack is not deltified.
I agree with your comparison.  However,  if I'm processing a 100MB+
blob,  I doubt the extra open/mmap/munmap/close calls are going
to matter to me.  What I think _helped_ me was that, with the megablobs
pushed out of the pack,  git-log etc could play around inside a
"tiny" 13MB packfile very quickly.  This packfile contained all the
commits, all the trees, and all the blobs < 256KB.

> > Repacking the entire repository with a max-blob-size of 256KB
> > resulted in a single 13.1MB packfile,  as well as 2853 loose
> > objects totaling 15.4GB compressed and 100.08GB uncompressed,
> > 11 files per objects/xx directory on average.  All was created
> > in half the runtime of the previous yet with standard
> > --window=10 and --depth=50 parameters.  The data in the
> > packfile was 270MB uncompressed in 35976 blobs.  Operations
> > such as "git-log --pretty=oneline" were about 30X faster
> > on a cold cache and 2 to 3X faster otherwise.  Process sizes
> > remained reasonable.
>
> I think more reasonable comparison to figure out what is really
> going on would be to create such a pack with the same 0/0 window
> and depth (i.e. "keeping the huge objects out of the pack" would
> be the only difference with the "horrible" case).  With huge
> packs, I wouldn't be surprised if seeking to extract base object
> from a far away part of a packfile takes a lot longer than
> reading delta and applying the delta to base object that is kept
> in the in-core delta base cache.
Yes,  changing only one variable at a time would be better.
I will do that experiment.  However,  the huge pack _did_ have
0/0, and the small pack had default/default,  which I think is the
reverse of what you concluded above?,  so the experiment should
make things no better for the huge pack case.

> Also if you mean by "process size" the total VM size, not RSS, I
> think it is a wrong measure.  As long as you do not touch the
> rest of the pack, even if you mmap a huge packfile, you would
> not bring that much data actually into your main memory, would
> you?  Well, assuming that your mmap() implementation and virtual
> memory subsystem does a descent job... maybe we are spoiled by
> Linux here...
You are right that the VM number was more shocking,  but both
were too high.  But let's compare using 12GB+ of packfiles versus 13MB.
In the former case,  I'm depending on the sliding mmap windows doing
the right thing in an operating regime no one uses (which is why
Shawn was asking about my packedGitLimit settings etc), and in the
latter case, the packfile is <10% of the linux2.6 packfile but I have
to endure an extra open/mmap/munmap/close sequence when accessing
enormouse files.  The small extra cost of the latter is more attractive
to me than an unknown amount of tuning to get the former right,
and in the former case I still have to figure out how to *create*
the packfiles efficiently.

There's actually an even more extreme example from my day job.
The software team has a project whose files/revisions would be
similar to those in the linux kernel (larger commits, I'm sure).
But they have *ONE* 500MB file they check in because it takes
2 or 3 days to generate and different people use different versions of it.
I'm sure it has 50+ revisions now.  If they converted to git and included
these blobs in their packfile, that's a 25GB uncompressed increase!
*Every* git operation must wade through 10X -- 100X more packfile.
Or it could be kept in 50+ loose objects in objects/xx ,
requiring a few extra syscalls by each user to get a new version.

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
