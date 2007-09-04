From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 01:50:21 -0400
Message-ID: <9e4733910709032250r1198379cmafd4e14fd330513b@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
	 <7vmyw3835y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:50:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISRJL-0002cT-6V
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbXIDFur (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbXIDFur
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:50:47 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:19794 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbXIDFuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:50:46 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1092473rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 22:50:46 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=emhllYXTvPRo5lfkLBaDZqdakG8D3fv0oHVmmMU5gmDsi7NdGx22KblgisxPmVMGEnDw40luemsQ5oHN6Ic83PaN6RKt2wTmPaLse1PNZKi+SUb4sjtPi7AHDLYUm6WAtAJopLffrAgLL0jZsHPnvHMvDlNjYkur/wTOLvX5TNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NagTt7jKBEpeFUaHdJaKqRQ5nqqG/x/3XIsmS6cSt+R1DFsTYUIyyFrJKnEHn+/dPri8nqamV1JTEcn2o+0P+Mij6nJbdDz1HMDfZSz6z7QvrrF3+q7GKM/kMELdxgj1vEEGgzY/wctEUziqhefEwdt52+5koM4wqY5LcgERsLU=
Received: by 10.141.15.19 with SMTP id s19mr2258646rvi.1188885021292;
        Mon, 03 Sep 2007 22:50:21 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Mon, 3 Sep 2007 22:50:21 -0700 (PDT)
In-Reply-To: <7vmyw3835y.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57525>

On 9/4/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> >> Yes.  For performance reasons, since a simple commit would kill you in any
> >> reasonably sized repo.
> >
> > That's not an obvious conclusion. A new commit is just a series of
> > edits to the previous commit. Start with the previous commit, edit it,
> > delta it and store it. Storing of the file objects is the same. Why
> > isn't this scheme fast than the current one?
>
> I think you seem to be forgetting about tree comparison.
>
> With a large project that has a reasonable directory structure
> (i.e. not insanely narrow), a commit touches isolated subparts
> of the whole tree.  Think of an architecture specific patch to
> the Linux kernel touching only include/asm-i386 and arch/i386
> directories.
>
> Being able to cull an entire subdirectory (e.g. drivers/ which
> has 5700 files underneath) by only looking at the tree SHA-1 of
> the containing tree is a _HUGE_ win.

In my scheme you have all of the SHAs for the commit in RAM because
the are contained in the commit and you have the commit in RAM. It
take microseconds to compare these two lists in RAM.

The current scheme is doing disk accesses to get those tree nodes so
of course it is a win to cull the 5700 files.

>
> And this is not just about two tree comparison.  When you say:
>
>         git log v2.6.20 -- arch/i386/
>
> what you are seeing is a simplified history that consists of
> commits that touch only these paths.  How would we determine if
> a commit touch these paths efficiently?  By comparing the "i386"
> entry in tree objects for $commit^:arch and $commit:arch.  You
> do not have to look inside arch/i386/ trees to see if any of the
> 330 files in it is different.  You just check a single SHA-1
> pair.

It's more than just comparing a SHA, you have to do disk accesses to
retrieve the SHA.

I'm proposing that we only really need commit and file objects. I also
mentioned that if you think of the file objects as a table you could
use triggers to build cached indexes. To get performance back to the
current level we may want to construct some of these indexes. We need
to explore the scheme more before we can figure out the best cached
indexes to build.

Right now we only have a single index type, the tree nodes. And it's a
permanent part of the storage not cached. A hierarchical index is not
very useful of indexing non file name attributes.

-- 
Jon Smirl
jonsmirl@gmail.com
