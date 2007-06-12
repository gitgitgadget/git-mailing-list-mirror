From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 12:23:20 +0200
Message-ID: <8c5c35580706120323t52b0d095v6ab6013ee2c8fdea@mail.gmail.com>
References: <20070611225918.GD4323@planck.djpig.de>
	 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
	 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
	 <200706121145.22699.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 12 12:23:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy3X6-0005tm-H0
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 12:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbXFLKXW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 06:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbXFLKXW
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 06:23:22 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:62722 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbXFLKXV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 06:23:21 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2481931wah
        for <git@vger.kernel.org>; Tue, 12 Jun 2007 03:23:20 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jn5L9IgoU5hhda6JCFx2c5MZe0dpUUBrEQJPk9QTMIx1WgnfHZ/Mfi6mrY68WNF0k1LFat8BpGNPoep9EnIrOL0rivOgQeegWdxo9bo95RpWtaQpW1tpg/OfeLvMYQsQxOj9r+C9ace8X0nBuIOO8OivuUX6Q4BRfpnT/B16DRY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bQn8/cD9U4Dfcr0guecjtY2Y1q/10bxv9Faue+AL+mJrQ2b5NKYw1rjmLrAeafCqnFqlnDT8gF6gVm+6IkrwBHYxC/PxnpYNVFaEM+sQFW/pNbpSfp9eV0oicClI7uZlPi8tj/XHB18lBN/1p8pNq2wTh6HQ0QnXtt7GelxzbMc=
Received: by 10.114.126.1 with SMTP id y1mr6545249wac.1181643800553;
        Tue, 12 Jun 2007 03:23:20 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Tue, 12 Jun 2007 03:23:20 -0700 (PDT)
In-Reply-To: <200706121145.22699.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49942>

On 6/12/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Tuesday 12 June 2007, Lars Hjemli wrote:
> > This is somewhat intentional. I want to move the submodule repos into
> > .git/submodules/$name/ (with working dir) and symlink this directory
> > when 'checking out' the submodule. This would be a simple solution for
> > the following problems:
> >   -keeping submodule modifications between checkouts
> >   -having submodules within submodules
>
> Interesting idea.
>
> How does this work
> (1) if the submodule checkout changes with the supermodule checkout?
> You still would have to store the modifications somewhere.

If you're thinking about the detached HEAD: yeah, that's a problem. My
initial plan (with later modifications) was something like this:

[path "lib1"]
  submodule=lib
  branch=stable

[path "lib2"]
  submodule=lib
  branch=bleeding

[submodule "lib"]
  url=git://example.com/lib.git

$ git-submodule init
  git-config submodule.lib.url git://example.com/lib.git

$ git-submodule update
  git-clone --bare git://example.com/lib.git .git/submodules/lib.git
  git-clone -l -s -n .git/submodules/lib.git lib1
  (cd lib1 && git-checkout $sha1)
  git-clone -l -s -n .git/submodules/lib.git lib2
  (cd lib2 && git-checkout $sha2)

git-submodule push:
  (cd lib1 && git-push origin $branch1)
  (cd lib2 && git-push origin $branch2)

I thought I could avoid 'git-submodule push' by using symlinks, but
you're right. It will not work. Back to the drawing board (again...)


> (2) on platforms which do not allow symlinks

Ok, bad idea.


>
> A workaround for problem (1) would be to create multiple checkouts of the
> same submodule if modified, e.g. in .git/submodule/$name/$sha1 .

And the $sha1 would be the sha1 found in the index? I don't think this
would work either. If two branches in the superproject checkout the
same submodule sha1, you could possibly want to keep different changes
in the submodule depending on which branch of the superproject is
checked out.

I guess the user will have to both commit and push submodule changes
before switching branches etc. But that might not be too bad, at least
for the initial submodule support.

>
> Allowing people to work like that is nice, but it should not be forced.
> It would also be nice to allow the user to specify another place where
> submodule checkouts are to be stored, e.g. when multiple supermodules
> share the same submodule.

True. Maybe submodule.<name>.repopath in .git/config? (If not
specified, default to .git/submodules/<name>.git)

--
larsh
