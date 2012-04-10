From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSOC Proposal draft: git-remote-svn
Date: Tue, 10 Apr 2012 18:46:22 -0500
Message-ID: <20120410234622.GB11506@burratino>
References: <11292500.AVmZFUUvNi@flobuntu>
 <2148933.pnpYo0xMAP@flomedio>
 <2487557.B8qfnaixh3@flomedio>
 <1421035.yALBSXSHGd@flomedio>
 <20120410171707.GA3869@burratino>
 <4F84B47D.1080301@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:46:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHkld-0004Wo-Rw
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 01:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759717Ab2DJXq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 19:46:28 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49187 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759705Ab2DJXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 19:46:27 -0400
Received: by iagz16 with SMTP id z16so443394iag.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a3bbygjUFTGU5sazDFPazH416Lr1NwqVFhEAERncxCw=;
        b=j9y+LEt5bd0EYGpbCXk2OlghjKL7Cx/4n+FqUMJErEgPZ0zyEINcCOwrwgB0lifUlX
         ViARebZhC2UCo1CAr5IVyMw87jayg4+UH6Sz39sXShPO1s6lvVMC5azT7Ymulx3kV4kU
         aFPpsJhHK82iLQm87ziKucpmd6u11OjUo3kXOMssZJULYLLJWQ4+UqiRnMUFkkHfYZ4M
         Vpe8uk4uHWs9lzbXmSwpKtQ/Z4npaXnQY0doOz2af57FeP0X4PYSNL0tqV5dpe88VDl/
         Vrrhmc7tjuELNqcSDNnCjMWYzIDVBKfL4F95iowNsmK5XIJ9Uqhrf500zl8fx5kwvwaL
         XvBg==
Received: by 10.50.40.228 with SMTP id a4mr408170igl.60.1334101587313;
        Tue, 10 Apr 2012 16:46:27 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id wp4sm22454877igc.3.2012.04.10.16.46.25
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 16:46:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F84B47D.1080301@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195138>

Andrew Sayers wrote:

> Just to be clear, my understanding is that this project will take SBL
> created by another program (that I'm writing) and create branches as
> specified.

If that seems like the right thing to do for the people involved
(Florian and mentor, list consensus) and if that's easy.  I'm happy as
long as the default configuration works well with sane repositories.

[...]
> On 10/04/12 18:17, Jonathan Nieder wrote:

>>    How should the importer handle Subversion copy commands that
>>    refer to other projects in this case?
>
> This is a good point.  I've just svnadmin and svnrdump, and it turns out
> svnadmin doesn't allow you to dump a subtree while svnrdump strips out
> the offending copy commands, so either way there's nothing to be done.

>From a quick test, it looks like svnrdump converts a directory copy
into the addition of its contents.  Good.

svndumpfilter produces

	svndumpfilter: E200003: Invalid copy source path '/branches/foo/subdir'

and exits with status 1 so it seems like we're ok.

[...]
>>  . tracing history past branch creation events, using the now-saved
>>    copyfrom information.
>
> I'm not sure if I understand correctly, but I think you're referring to
> this edge case:

Nope, I'm talking about the most typical and boring case there is:

	svn cp <repo>/trunk <repo>/branches/topic

When cloning <repo>, it seems reasonable to expect that the ancestry
of the trunk and branch would not be shown as disjoint linear histories,
but that the revision in which the branch was introduced would be
shown as a child of the previous revision of the trunk, like so:


	              o --- o --- o [topic]
	             /
	o --- o --- o --- o --- o --- o [trunk]

This requires paying attention to copyfrom information.

[...]
> Right now I have a script that first takes an SVN dump and produces
> gzipped JSON as output, then takes the gzipped JSON as input and
> produces an SBL file as output.  The first round will generally only
> need to be run once (and is comparable to svn-fe in speed), whereas the
> second round might need to be run an arbitrary number of times (but is
> very fast).

For what it's worth, for importing from repositories that use a
nonstandard layout I do think this "start with a quick pass to figure
the layout out" approach is a sane one.

[...]
> I'm currently focussing on bringing all the modules up to release
> quality, so that I can have something for Florian to play with in the
> near future.  This should have an interface that is mature but flexible,
> so I can change the interface to make his life easier but won't need to
> change the interface because I missed something.  After that, I'll
> concentrate on improving the quality of the SBL output.

Neat.

Thanks for some useful clarifications.
Jonathan
