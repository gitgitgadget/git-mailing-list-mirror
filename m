From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 12:27:47 -0400
Message-ID: <20060829162747.GA21729@spearce.org>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 18:29:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI6RP-0002F0-5P
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 18:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbWH2Q1v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 Aug 2006 12:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWH2Q1v
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 12:27:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:15824 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965059AbWH2Q1u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Aug 2006 12:27:50 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GI6RC-0002op-AJ; Tue, 29 Aug 2006 12:27:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 343D620FB7F; Tue, 29 Aug 2006 12:27:47 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <ed1kn3$c3r$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26208>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
>=20
> > From a data locality perspective putting the base object before
> > or after the delta shouldn't matter, as either way the delta
> > is useless without the base. =A0So placing the base immediately
> > before the delta should perform just as well as placing it after.
> > Either way the OS should have the base in cache by the time the
> > delta is being accessed.
>=20
> _Should_ perform? Have you got any measurements of speed of creating =
"base
> before delta" pack, and reading objects from this kind of pack?

No, not yet.  It just seemed odd to me that the base was put behind
the delta which then forces unpack-objects to hold a delta in memory
until it finds the corresponding base later in the stream when it
could have been just as simple to require the base appear before
the delta.  I wondered what the rationale was for the additional
complexity in unpack-objects.

Nicolas' reply pointed out that the current arrangement of base
after delta may actually offer improved performance due to the
OS performing read-ahead when you seek to the delta.  But he also
pointed out this base after delta situtation should be rather rare
as we try to delta older objects against newer objects and we try to
place newer objects at the front of the pack, so it likely shouldn't
matter that much.


I just instrumented builtin-pack-objects.c to count how many times
we put the delta before the base and then repacked a current Git
repo with `git repack -a -d -f`.  28167 objects, 19170 deltas. 6003
deltas appeared before their base objects.  So 31% of the time.
That's certainly not the common case but it does occur with some
frequency.  However resorting the output of verify-pack -v by offset
and visually looking at the entries you can clearly see it doesn't
happen very often early in the pack. Most of the objects in the
front of the pack are undeltafied commits.

This particular Git repository has 6723 commits and 905 trees that
weren't deltafied.  That's a total of 4 MiB of uncompressed data,
most of which appears at the front of the pack.  Only 68 commits
were deltas but 8067 trees were made into deltas.  The compressed
commits seemed to occupy the first 2 MiB of the pack file; that's
25% of the 8 MiB pack.  A commit-specific pack local dictionary
could be interesting here as it might some pack space.


I'm going to shutup now and not say anything further on the subject
unless I've got some hard results indicating a different organization
is better or worse than what we have right now.

--=20
Shawn.
