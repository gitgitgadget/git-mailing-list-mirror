From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git-fast-import
Date: Sun, 6 Aug 2006 00:09:22 -0400
Message-ID: <9e4733910608052109v5d4d348ci6aa986cc04939116@mail.gmail.com>
References: <9e4733910608051951g42bc4a5dv560c12e0a9add163@mail.gmail.com>
	 <20060806034009.GE20565@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 06 06:09:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Zx9-0002m5-Kl
	for gcvg-git@gmane.org; Sun, 06 Aug 2006 06:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbWHFEJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Aug 2006 00:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWHFEJY
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Aug 2006 00:09:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:28614 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751261AbWHFEJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Aug 2006 00:09:23 -0400
Received: by nf-out-0910.google.com with SMTP id p46so71575nfa
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 21:09:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fUiawcQpJyOIvrb0XyNar1j1DGwmz/I+D/+w6OxuRrilA8qkV9C7rjFcY+fDZ7NeS3O1BrRIBJCj+tjvKvl5anqLOTVkItIq2/jVKeZI9GscCBAv7d7kJPxZNv1aoW9IMEcLfSxirJDg+wnHxqucpZplkSPpgbpG4owP8MK0Gdo=
Received: by 10.78.136.7 with SMTP id j7mr2023117hud;
        Sat, 05 Aug 2006 21:09:22 -0700 (PDT)
Received: by 10.78.148.9 with HTTP; Sat, 5 Aug 2006 21:09:22 -0700 (PDT)
To: "Shawn Pearce" <spearce@spearce.org>
In-Reply-To: <20060806034009.GE20565@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24961>

On 8/5/06, Shawn Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > git-fast-import works great. I parsed and built my pack file in
> > 1:45hr. That's way better than 24hr. I am still IO bound but that
> > seems to be an issue with not being able to read ahead 150K small
> > files. CPU utilization averages about 50%.
>
> Excellent.  Now if only the damn RCS files were in a more suitable
> format.  :-)
>
> > I didn't bother reading the sha ids back from fast-import, instead I
> > computed them in the python code. Python has a C library function for
> > sha1. That decouple the processes from each other. They would run in
> > parallel on SMP.
>
> At least you are IO bound and not CPU bound.  But it is silly for the
> importer in Python to be computing the SHA1 IDs and for fast-import
> to also be computing them.  Would it help if fast-import allowed
> you to feed in a tag string which it dumps to an output file listing
> SHA1 and the tag?  Then you can feed that data file back into your
> tree/commit processing for revision handling.

I am IO bound, there is plenty of CPU and I am on a 2.8Ghz single processor.
The sha1 is getting stored into an internal Python structure. The
structures then get sliced and diced a thousand ways to compute the
change sets.

The real goal of this is to use the cvs2svn code for change set
detection. Look at how much work these guys have put into it making it
work on the various messed up CVS repositories.
http://git.catalyst.net.nz/gitweb?p=cvs2svn.git;a=shortlog;h=a9167614a7acec27e122ccf948d1602ffe5a0c4b

cvs2svn is the only tool that read and built change sets for Moz CVS
on the first try.

> > My pack file is 980MB compared to 680MB from other attempts. I am
> > still missing entries for the trees and commits.
>
> The delta selection ain't the best.  It may be the case that prior
> attempts were combining files to get better delta chains vs. staying

My suspicion is that prior attempts weren't capturing all of the
revisions. I know cvsps (the 680MB repo) was throwing away branches
that it didn't understand. I don't think anyone got parsecvs to run to
completion. MozCVS has 1,500 branches.

> all in one file.  It may be the case that the branches are causing
> the delta chains to not be ideal.  I guess I expected slightly
> better but not that much; earlier attempts were around 700 MB so
> I thought maybe you'd be in the 800 MB ballpark.  Under 1 GB is
> still good though as it means its feasible to fit the damn thing
> into memory on almost any system, which makes it pretty repackable
> with the standard packing code.

I am still missing all of the commits and trees. Don't know how much
they will add yet.

> Its possible that you are also seeing duplicates in the pack;
> I actually wouldn't be surprised if at least 100 MB of that was
> duplicates where the author(s) reverted a file revision to an exact
> prior revision, such that the SHA1 IDs were the same.  fast-import
> (as I have previously said) is stupid and will write the content
> out twice rather than "reuse" the existing entry.
>
> Tonight I'll try to improve fast-import.c to include index
> generation, and at the same time perform duplicate removal.
> That should get you over the GPF in index-pack.c, may reduce disk
> usage a little for the new pack, and save you from having to perform
> a third pass on the new pack.

Sounds like a good plan.

-- 
Jon Smirl
jonsmirl@gmail.com
