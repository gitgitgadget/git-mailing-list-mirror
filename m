From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Tue, 23 May 2006 05:59:00 -0400
Message-ID: <BAYC1-PASMTP07A0CAD58FB1CE30882F19AE9B0@CEZ.ICE>
References: <4471CF23.1070807@gmx.de>
	<7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP1164FE2A24B4D1B4C0A607AE9A0@CEZ.ICE>
	<Pine.LNX.4.64.0605221646540.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, BjEngelmann@gmx.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 12:05:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiTl7-0001Z0-Fk
	for gcvg-git@gmane.org; Tue, 23 May 2006 12:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWEWKE6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 06:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWEWKE6
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 06:04:58 -0400
Received: from bayc1-pasmtp07.bayc1.hotmail.com ([65.54.191.167]:45674 "EHLO
	BAYC1-PASMTP07.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S932163AbWEWKE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 06:04:58 -0400
X-Originating-IP: [69.156.138.66]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.138.66]) by BAYC1-PASMTP07.BAYC1.HOTMAIL.COM over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Tue, 23 May 2006 03:08:16 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 4D34D644C04;
	Tue, 23 May 2006 06:04:56 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Message-Id: <20060523055900.0dd845fd.seanlkml@sympatico.ca>
In-Reply-To: <Pine.LNX.4.64.0605221646540.3697@g5.osdl.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.15; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 23 May 2006 10:08:16.0390 (UTC) FILETIME=[CF1CEA60:01C67E50]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 22 May 2006 17:02:41 -0700 (PDT)
Linus Torvalds <torvalds@osdl.org> wrote:

> That said, I think that what you actually want to do may be totally 
> different.
> 
> If _each_ commit has some extra information associated with it, you don't 
> want to create a tag that points to the commit, you more likely want to 
> create an object that is indexed by the commit ID rather than the other 
> way around.
> 
> IOW, I _think_ that what you described would be that if you have the 
> commit ID, you want to find the data based on that ID. No?

Correct.  But even though there isn't currently an efficient way to do
the reverse lookup, many of the visual tools do it.  So for instance, if
you embed some metadata in the name of a tag, it will actually be nicely
shown to you associated with the proper commit in qgit/gitk/gitweb.  So
you _can_ abuse tags and get modest results.  And of course the low level
tools let you do..  git name-rev --tags to lookup the meta data as well.
So you can do  git log | git name-rev --tags --stdin  and see which tags
are associated with each commit.

I'm not arguing that this makes tags well designed for the these types
of things, just that there is no other option built in to the low level
git that comes as close.

> And that you can do quite easily, while _also_ using git to distribute the 
> extra per-commit meta-data. Just create a separate branch that has the 
> data indexed by commit ID. That could be as simple as having one file per 
> commit (using, perhaps, a similar directory layout as the .git/objects/ 
> directory itself), and then you could do something like
> 
> 	# Get the SHA1 of the named commit
> 	commit=$(git-rev-parse --verify "$cmitname"^0)
> 
> 	# turn it into a filename (slash between two first chars and the rest)
> 	filename=$(echo $commit | sed 's:^\(..\)\(.*\):\1/\2:')
> 
> 	# look it up in the "annotations" branch
> 	git cat-file blob "annotations:$filename"
> 
> which gets the data from the "annotations" branch, indexed by the SHA1 
> name.
> 
> Now, everybody can track your "annotations" branch using git, and get your 
> per-commit annotations for the main branch.
> 
> See?

Sure, makes a lot of sense.  Although the one file per commit thing doesn't
scale well.  It's already a problem when trying to use a lot of tags for
instance.

More than the technical details of the implementation though, i'm trying to
make a case that git would do well to codify something like the above and
provide a _standard_ method of associating meta data with commits.  This
would allow all the tools to start displaying meta data etc and have a
defined way to efficiently query and manipulate it. 

Sean
