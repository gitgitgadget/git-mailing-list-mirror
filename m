From: Nix <nix@esperi.org.uk>
Subject: Handling very large numbers of symbolic references?
Date: Tue, 25 Jul 2006 20:29:46 +0100
Message-ID: <87psfteb4l.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Jul 25 21:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G5SbJ-0002Ro-MW
	for gcvg-git@gmane.org; Tue, 25 Jul 2006 21:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWGYT3t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Jul 2006 15:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGYT3t
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Jul 2006 15:29:49 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:41999 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S964838AbWGYT3t
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jul 2006 15:29:49 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id k6PJTk2U028559
	for <git@vger.kernel.org>; Tue, 25 Jul 2006 20:29:47 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id k6PJTkqd029464;
	Tue, 25 Jul 2006 20:29:46 +0100
To: git@vger.kernel.org
X-Emacs: the road to Hell is paved with extensibility.
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24183>

I'm about to start writing my first git porcelain (to try to convert my
workplace from the world's oldest and cruftiest version control system
to something not based on the bastard offspring of SCCS and VMS's CMS,
with less power than either) and have run into a problem that I'm not
sure how to solve.

The biggest problem with git for totally naive users is that they get
scared by the sha1 IDs used as version numbers (assuming the index is
porcelained away: but that would confuse them, not scare them). They're
not pronounceable, not memorable, and so on. So the porcelain I'm
whipping up conceals them in large part by using instead bug IDs, as the
workflow of the place I'm doing this for is driven entirely by Bugzilla
bug numbers.

I'm taking a leaf from the `git for the ignorant' document and arranging
that every fix that fixes some Bugzilla bug is on a branch named after
that bug, e.g. #2243, #10155, whatever. (I'm going to have to go further
than that and track dependency relationships between bugs, i.e. `if you
merge bug #1404's branch, you must merge #1306's and #1505's as well'. I
could do that by adding a new bug-dependency object, respected by a
wrapper around git-merge, but I'm not sure how kosher it is to add new
types of objects only used by porcelain. Hell, I'm not even sure if it's
possible yet.)

However, this causes a potential problem. There are tens of thousands of
these bugs, and the .git/refs/heads directory gets *enormous* and thus
the system gets terribly terribly slow (crappy old Solaris filesystem
syndrome).

It seems to me there are two ways to fix this:

 - restructure .git/refs/* in a similar way to .git/objects, i.e. as a
   one- or two-level tree.

 - the vast majority of these bugs are closed. They still need to be got
   at now and again for branch merges, but they could be got out of
   .refs/heads at delete_branch time, and pushed into a tree consisting
   entirely of deleted branches, which would in turn be pointed at from
   some new place under .refs; perhaps .refs/heads/heavy (by analogy to
   non-lightweight tags). The problem here is that whenever we delete
   a tag, we'll leak that tree (at least we will if it's in a pack), and
   that leakage really could add up in the end.

   (Deleting branches corresponding to closed bugs is good for other
   reasons: e.g., it cleans up gitweb output. But certain tools *will*
   need to get at those closed bug branches: I'm inclined to say that
   all of them will sooner or later, because the users aren't going to
   tolerate being told that they can't do anything to a closed
   bug. Except for adding code to it: we can reasonably declare the
   addition of commits to those branches over. Of course once we have
   the sha1 id, it's all academic, really.)

I'm not sure which way is preferable. Suggestions? Is the entire idea
lunatic?


And, in case this hasn't been said enough: thank you for git, it's the
nicest version control system I've used in years, and the way it's
structured encourages everyone to play :)

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
