From: Junio C Hamano <junkio@cox.net>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sun, 12 Feb 2006 19:36:41 -0800
Message-ID: <7v4q3453qu.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>
	<7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>
	<1139685031.4183.31.camel@evo.keithp.com> <43EEAEF3.7040202@op5.se>
	<1139717510.4183.34.camel@evo.keithp.com>
	<46a038f90602121806jfcaac41tb98b8b4cd4c07c23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>, Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Feb 13 04:36:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8UWB-00048g-Dv
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 04:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbWBMDgo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 22:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbWBMDgo
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 22:36:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2535 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751564AbWBMDgn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 22:36:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060213033512.GKW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 22:35:12 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90602121806jfcaac41tb98b8b4cd4c07c23@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 13 Feb 2006 15:06:42 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16040>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> +1... there should be an easy-to-compute threshold trigger to say --
> hey, let's quit being smart and send this client the packs we got and
> get it over with. Or perhaps a client flag so large projects can
> recommend that uses do their initial clone with --gimme-all-packs?

What upload-pack does boils down to:

    * find out the latest of what client has and what client asked.

    * run "rev-list --objects ^client ours" to make a list of
      objects client needs.  The actual command line has multiple
      "clients" to exclude what is unneeded to be sent, and
      multiple "ours" to include refs asked.  When you are doing
      a full clone, ^client is empty and ours is essentially
      --all.

    * feed that output to "pack-objects --stdout" and send out
      the result.

If you run this command:

	$ git-rev-list --objects --all |
          git-pack-objects --stdout >/dev/null 

It would say some things.  The phases of operations are:

	Generating pack...
	Counting objects XXXX...
        Done counting XXXX objects.
        Packing XXXXX objects.....

Phase (1).  Between the time it says "Generating pack..." upto
"Done counting XXXX objects.", the time is spent by rev-list to
list up all the objects to be sent out.

Phase (2). After that, it tries to make decision what object to
delta against what other object, while twenty or so dots are
printed after "Packing XXXXX objects." (see #git irc log a
couple of days ago; Linus describes how pack building works).

Phase (3). After the dot stops, the program becomes silent.
That is where it actually does delta compression and writeout.

You would notice that quite a lot of time is spent in all
phases.

There is an internal hook to create full repository pack inside
upload-pack (which is what runs on the other end when you run
fetch-pack or clone-pack), but it works slightly differently
from what you are suggesting, in that it still tries to do the
"correct" thing.  It still runs "rev-list --objects --all", so
"dangling objects" are never sent out.

We could cheat in all phases to speed things up, at the expense
of ending up sending excess objects.  So let's pretend we
decided to treat everything in .git/objects/packs/pack-* (and
the ones found in alternates as well) have interesting objects
for the cloner.

(1) This part unfortunately cannot be totally eliminated.  By
    assume all packs are interesting, we could use the object
    names from the pack index, which is a lot cheaper than
    rev-list object traversal.  We still need to run rev-list
    --objects --all --unpacked to pick up loose objects we would
    not be able to tell by looking at the pack index to cover
    the rest.

    This however needs to be done in conjunction with the second
    phase change.  pack-objects depends on the hint rev-list
    --objects output gives it to group the blobs and trees with
    the same pathnames together, and that greatly affects the
    packing efficiency.  Unfortunately pack index does not have
    that information -- it does not know type, nor pathnames.
    Type is relatively cheap to obtain but pathnames for blob
    objects are inherently unavailable.

(2) This part can be mostly eliminated for already packed
    objects, because we have already decided to cheat by sending
    everything, so we can just reuse how objects are deltified
    in existing packs.  It still needs to be done for loose
    objects we collected to fill the gap in (1).

(3) This also can be sped up by reusing what are already in
    packs.  Pack index records starting (but not end) offset of
    each object in the pack, so we can sort by offset to find
    out which part of the existing pack corresponds to what
    object, to reorder the objects in the final pack.  This
    needs to be done somewhat carefully to preserve the locality
    of objects (again, see #git log).  The deltifying and
    compressing for loose objects cannot be avoided.

    While we are writing things out in (3), we need to keep
    track of running SHA1 sum of what we write out so that we
    can fill out the correct checksum at the end, but I am
    guessing that is relatively cheap compared to the
    deltification and compression cost we are currently paying
    in this phase.

NB. In the #git log, Linus made it sound like I am clueless
about how pack is generated, but if you check commit 9d5ab96,
the "recency of delta is inherited from base", one of the tricks
that have a big performance impact, was done by me ;-).
