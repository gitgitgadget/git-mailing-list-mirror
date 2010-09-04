From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 01:23:54 -0400
Message-ID: <AANLkTikVf=X8cLP9s6W9VGOt0EHE4J5MYsBpgKYhrAri@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
 <AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
 <AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
 <4C7FC3DC.3060907@gmail.com> <AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
 <alpine.LFD.2.00.1009021249510.19366@xanadu.home> <AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
 <alpine.LFD.2.00.1009021624170.19366@xanadu.home> <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
 <7voccezr7m.fsf@alter.siamese.dyndns.org> <20100903183120.GA4887@thunk.org>
 <alpine.LFD.2.00.1009031522590.19366@xanadu.home> <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 04 07:24:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrlEl-00084J-Bw
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 07:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145Ab0IDFYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 01:24:19 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42684 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab0IDFYS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 01:24:18 -0400
Received: by ewy23 with SMTP id 23so1567669ewy.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 22:24:16 -0700 (PDT)
Received: by 10.213.31.79 with SMTP id x15mr74608ebc.60.1283577854500; Fri, 03
 Sep 2010 22:24:14 -0700 (PDT)
Received: by 10.14.13.193 with HTTP; Fri, 3 Sep 2010 22:23:54 -0700 (PDT)
In-Reply-To: <04755B03-EE1D-48FA-8894-33AA8E2661C0@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155304>

Ted,

I think your "canonical pack" idea has value, but I'd be inclined to
try to optimize more for the "common case" of developing on a fast
local network with many local checkouts, where you occasionally
push/fetch external sources via a slow link.

Specifically, let's look at the very reasonable scenario of a
developer working over a slow DSL or dialup connection.  He's probably
got many copies of various GIT repositories cloned all over the place
(hey, disk is cheap!), but right now he just wants a fresh clean copy
of somebody else's new tree with whatever its 3 feature branches are.
Furthermore, he's probably even got 80% of the commit objects from
that tree archived in his last clone from linux-next.

In theory he could very carefully arrange his repositories with
judicious use of alternate object directories.  From personal
experience, though, such arrangements are *VERY* prone to accidentally
purging wanted objects; unless you *never* ever delete a branch in the
"reference" repository.

So I think the real problem to solve would be:  Given a collection of
local computers each with many local repositories, what is the best
way to optimize a clone of a "new" remote repository (over a slow
link) by copying most of the data from other local repositories
accessible via a fast link?

The goal would be to design a P2P protocol capable of rapidly and
efficiently building distributed searchable indexes of ordered commits
that identify which peer(s) contain that each commit.

When you attempt to perform a "git fetch --peer" from a repository, it
would quickly connect to a few of the metadata index nodes in the P2P
network and use them to negotiate "have"s with the upstream server.
The client would then sequentially perform the local "fetch"
operations necessary to obtain all the objects it used to minimize the
commit range with the server.  Once all of those "fetch" operations
completed, it could proceed to fetch objects from the server normally.

Some amount of design and benchmarking would need to be done in order
to figure out the most efficient indexing algorithm for finding a
minimal set of "have"s of potentially thousands of refs, many with
independent root commits.  For example if the index was grouped
according to "root commit" (of which there may be more than one), you
*should* be able to quickly ask the server about a small list of root
commits and then only continue asking about commits whose roots are
all known to the server.

The actual P2P software would probably involve 2 different daemon
processes.  The first would communicate with each other and with the
repositories, maintaining the ref and commit indexes.  These daemons
would advertise themselves with Avahi, or alternatively in an
enterprise environment they would be managed by your sysadmins and be
automatically discovered using DNS-SD.  Clients looking to perform a
P2P fetch would first ask these.

The second daemon would be a modified git-daemon that connects to the
advertised "index" daemons and advertises its own refs and commit
lists, as well as its IP address and port.

My apologies if there are any blatant typos or thinkos, it's a bit
later here than I would normally be writing about technical topics.

Cheers,
Kyle Moffett
