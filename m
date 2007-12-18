From: "Dana How" <danahow@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Tue, 18 Dec 2007 14:08:33 -0800
Message-ID: <56b7f5510712181408g4aee55d2j2a7f0f13bf90323d@mail.gmail.com>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	 <20071218204623.GC2875@steel.home>
	 <200712182224.28152.jnareb@gmail.com>
	 <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	danahow@gmail.com
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:09:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kcu-0006XM-Le
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:09:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226AbXLRWIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXLRWIj
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:08:39 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:32097 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226AbXLRWIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:08:37 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1473886nfb.21
        for <git@vger.kernel.org>; Tue, 18 Dec 2007 14:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=nmAlU2KIsBhHuqWxp4D+ull6QOpiJLx9qjFIpf+cmPw=;
        b=sFsK5dDRsDReDFTeayWvZ8Qurheyc6Xrac7MIQBHd0+v/ycYKCwjOklLyE9KZK6OJDU06Mlne5B+mi4nNSxo92zfyCayHpJ1U8GF+U2kdUdP7yXSkME9W37kZEY791W6OTj3dWXUyi0j32MIlTnY2FBsCFKHePOdhsHVdnfFnRA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WdDEbVCkLbvWQ3FfBvhZZ3zDyiqYmsgswb2pOoToikX/XvQ39tGq8rMXBe3ONrKNeAtXU6HBGWYB+EscWOHNOvea90yQ4h+rbZ7BMjb7anEAMB/8QvGmrYmjN1h3KwTncjgQkxEnsp+rf4DQa5hrA/1ADaCW1d83RoQ2Ju8NY0s=
Received: by 10.78.160.4 with SMTP id i4mr7286216hue.35.1198015714057;
        Tue, 18 Dec 2007 14:08:34 -0800 (PST)
Received: by 10.78.130.1 with HTTP; Tue, 18 Dec 2007 14:08:33 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712181347140.21557@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68829>

On Dec 18, 2007 1:53 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, 18 Dec 2007, Jakub Narebski wrote:
> >
> > What cwd? <path> in <tree-ish>:<path> syntax is "relative" to <tree-ish>.
> > IMHO "<tree-ish>:<path>" should be considered (and is considered) as
> > one object: current working directory doesn't matter at all there,
> > contrary to "<tree-ish> -- <pathspec>" where it is natural that <pathspec>
> > is relative to current working directory.
>
> Indeed.
>
> The <treeish>:<path> syntax *is* relative, but it's relative to the exact
> *treeish* that is given. It has nothing what-so-ever to do with the
> current working directory, since the user has explicitly given an exact
> tree object, and trying to fake that out would be actively wrong.

I think the solution is to use the cwd only when the tree-ish refers
to a commit.
If it refers explicitly to a tree (or to a tree through a tag w/o
going through a commit)
then you don't make any modification.

When it *does* refer to a commit,  then for commit:relpath you prefix
relpath with the suffix of the cwd which is an extension beyond the root
of the working tree.

At the time I thought this through submodules didn't exist.
Clearly that case needs to be thought through as well.

> That said, I can kind of understand the wish for something like this, and
> I suspect that we could make the "commit->tree" translation take the
> current path into account. In other words, maybe we should have something
> like this:
>
>         /*
>          * This sequence currently works
>          */
>         [torvalds@woody git]$ git rev-parse HEAD
>         f9c5a80cdf2265f2df7712fad9f1fb7ef68b4768
>
>         [torvalds@woody git]$ git rev-parse HEAD^{tree}
>         051fb0c0dff4371f97f8ad9407f9f1fd335b1682
>
>         [torvalds@woody git]$ git rev-parse HEAD^{tree}:t
>         49d8bcd7a2df5c17193b1d002c4a8489d4fa990c
>
>         /*
>          * .. but this would be new
>          */
>         [torvalds@woody git]$ cd t
>         [torvalds@woody t]$ git rev-parse HEAD^{tree}
>         49d8bcd7a2df5c17193b1d002c4a8489d4fa990c
>
> where the magic is *not* done by any "SHA1 path lookup" at all, but is
> simply done by the commit->tree lookup. At least at that point it would
> make logical sense (although it would probably be quite painful to
> implement).

I must be missing something.  The old patch I submitted did this.
Its defect was that it did NOT make the cwd insertion conditional
on whether the tree-ish involved a commit or not (a test which also
_seems_ doable,  but I don't think I finished it & sent it in).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
