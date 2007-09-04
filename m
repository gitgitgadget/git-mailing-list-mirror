From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 17:54:00 -0400
Message-ID: <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>
	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>
	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>
	 <20070904212507.GA24434@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:54:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISgLg-0004FP-QZ
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbXIDVyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXIDVyD
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:54:03 -0400
Received: from rv-out-0910.google.com ([209.85.198.189]:59748 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbXIDVyB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:54:01 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1280714rvb
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 14:54:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ys1i66Uzb0CVj7xWadWvPUk5RcMoAZx1ouv+ZU7UpZDw7+XpbGUe6QGNPNqjPOBgGX7ghTFU4LfCxd7hZWs1OYORJ/tjuJ/4X7zDYG+247JpXSoKYIheTHA914WMWcXhapfMVns1TzS7n6IDNXBRWQYPHyDJxLZoY0uTnLn9iA8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PSV4nyJy1GMoSmvtXh/6bvyWIbiJWMp3+SNp/O1nCP/fq23dODAEMhUQxZ7ytomWXkHcZCZ4Hp5lB6eGbXhel/Ad4siV6rSywrho8e/4UDMUnXAULcnvBf7G/tLjkWaYKLdrW1OHiDax7z3839CZRxFfEf4Bs1Bfy+XH0IkO38Y=
Received: by 10.141.211.13 with SMTP id n13mr2489102rvq.1188942840429;
        Tue, 04 Sep 2007 14:54:00 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 14:54:00 -0700 (PDT)
In-Reply-To: <20070904212507.GA24434@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57652>

On 9/4/07, Theodore Tso <tytso@mit.edu> wrote:
> On Tue, Sep 04, 2007 at 01:44:47PM -0400, Jon Smirl wrote:
> > The current data store design is not very flexible. Databases solved
> > the flexibility problem long ago. I'm just wondering if we should
> > steal some good ideas out of the database world and apply them to git.
> > Ten years from now we may have 100GB git databases and really wish we
> > had more flexible ways of querying them.
>
> Databases solved the flexibility problem, at the cost of performance.
> And if you use full normalized form in your database scheme, it costs
> you even more in performance, because of all of the joins that you
> need in order get the information you need to do, you know, useful
> work as opposed to database wanking.
>
> If you take a look at the really big databases with super high
> performance requirements, say like those used to managed airline
> tickets/reservation/fares, you will find that they are not normalized,
> and they are not relational; they can't afford to be.  And if you take
> a look at some of git competition that use relational databases to
> store their SCM data, and take a look at how loooooong they they take
> to do even basic operations, I would say that the onus is on you to
> prove that normalization is actually a win in terms of real (not
> theoretical) advantages, and that it doesn't cause performance to go
> into the toilet.
>
> I think the fundamental disconnect here is that no one is buying your
> claim that just because the data design is "more flexible" that this
> is automatically a good thing in and of itself, and we should even for
> a moment, "put performance aside".

It is very easy to get bogged down in performance arguments on
database design when the correct answer is that there are always lots
of different ways to achieve the same goal. I wanted to defer debating
performance until we closely looked at the relationships between the
data at an abstract level.

Since git hasn't stored all of the fields in the object table (the
path is encoded in the index) we are never going to be able to build
an alternative way of indexing the object table. Not being able to
build alternative indexes is likely to cause problems when the
database starts getting really big. Without an index every query that
can't use the path name index is reduced to doing full table scans.

A few things that could benefit from alternative indexing, blame,
full-text search, automating the Maintainers file, etc.

I'm just asking if we really want to make full table scans the only
possible way to implement these types of queries. If the answer is no,
then let's first explore how to fix things at an abstract level before
diving into the performance arguments.

An obvious parallel from the file system world is the locate database
and how it is forced to continuously rescan the file system and store
full path names.


>
> I also don't think that attempting to force git's data structures into
> database terms makes sense; it is much closer to an filesystem using
> an object based store --- and very few people except for folks like
> Hans Resiers believes that Filesystems and Database should be
> unified....
>
>                                                 - Ted
>


-- 
Jon Smirl
jonsmirl@gmail.com
