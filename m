From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [RFD] diff-tree -c (not --cc) in diff-raw format?
Date: Sat, 4 Feb 2006 07:18:35 +0100
Message-ID: <e5bfff550602032218s72f91151tb8f6fcda373c2a28@mail.gmail.com>
References: <7vfyn0asdd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 07:18:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5Gky-0003e6-QA
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 07:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946314AbWBDGSg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 01:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946315AbWBDGSg
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 01:18:36 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:34607 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1946314AbWBDGSf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Feb 2006 01:18:35 -0500
Received: by wproxy.gmail.com with SMTP id 68so1437205wra
        for <git@vger.kernel.org>; Fri, 03 Feb 2006 22:18:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mgkTbCpB2WwKITUbOuJFfy7E/TA70Ht+yuYHgFmZnvq9/e6U6oUaoPtWL1Pj4DAG/+PBL1G7LGM7W8DyFZn12B6bUTYUlL3V7noAuL/a243n07UMSpxtlayypdTChx2D/oY0irFTWjYhjPLTAeMhLVu99y5C/h2zHWWpa/6iYVk=
Received: by 10.65.210.17 with SMTP id m17mr1305614qbq;
        Fri, 03 Feb 2006 22:18:35 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Fri, 3 Feb 2006 22:18:35 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyn0asdd.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15572>

On 2/4/06, Junio C Hamano <junkio@cox.net> wrote:
> The second paragraph from this log caught my attention:
>
>     commit cb80775b530a8a340a7f9e4fecc8feaaac13777c
>     Author: Marco Costalba <mcostalba@gmail.com>
>     Date:   Sun Jan 29 12:27:34 2006 +0100
>
>         Use git-diff-tree -c (combined) option to retrieve merge's
>         file list
>
>         Change un-interesting files pruning algorithm to use native
>         git-diff-tree -c option when showing merge files in files
>         list box.
>
> The current diff-tree -c is rather expensive way to do this.  I
> made both -c and --cc to always produce patches, but this
> suggests at least qgit would benefit if I allow -c in diff-raw
> format.  Essentially, you are interested in paths that the
> results do not match _any_ of the parents.
>

Yes. that would be great!

If you look at the patch you see I actually run something like this

         git-diff-tree -c <sha> | grep "diff --combined"

to get the 'interesting' file list.

> So instead of 70 lines output from
>
>         $ git-diff-tree -m -r --abbrev v1.0.0
>
> I could give you:
>
>         $ git-diff-tree -c -m -r --abbrev v1.0.0
>         c2f3bf071ee90b01f2d629921bb04c4f798f02fa
>         :100644 100644 92cfee4... e9bf860... M  Makefile
>         :100644 100644 d36904c... 4fa6c16... M  debian/changelog
>         c2f3bf071ee90b01f2d629921bb04c4f798f02fa
>         :100644 100644 50392ff... e9bf860... M  Makefile
>         :100644 100644 376f0fa... 4fa6c16... M  debian/changelog
>
> or even:
>
>         $ git-diff-tree -c -m -r --name-only v1.0.0
>         c2f3bf071ee90b01f2d629921bb04c4f798f02fa
>         Makefile
>         debian/changelog
>
> I am not so sure which one is more useful, though.  What do you
> think?
>

The first one without --abbrev option

 git-diff-tree -c -m -r c2f3bf071ee90b01f2d629921bb04c4f798f02fa

So to recycle my common diff-tree parsing code. Peraphs better, if possible,
I would suggest to treat -c option as all the other options, so to be possible
to use something like

git-diff-tree -c -r c2f3bf071ee90b01f2d629921bb04c4f798f02fa
git-diff-tree -c -r --name-only v1.0.0
git-diff-tree -c -r --abbrev v1.0.0
git-diff-tree -c -r c2f3bf071ee90b01f2d629921bb04c4f798f02fa  foo.c

and so on....

As you see -c _could_ imply -m

The current -c behaviour _could_ be obtained with

git-diff-tree -c -r -p <sha>

I didn't check the combined code to see if what I suggest is easy/possible.

> I should keep track of qgit repository more often but I haven't
> been doing so because the site used to be almost unpullable over
> http (it seems to work just fine these days so it is not an
> excuse for me anymore) and I do not read C++ too well (bad
> excuse perhaps but still an excuse for me).
>
>

No problem, I do not read C++ too well too. ;-)

Marco
