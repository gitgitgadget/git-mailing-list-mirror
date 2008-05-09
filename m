From: Chris Frey <cdfrey@foursquare.net>
Subject: [PATCH] Updating documentation to match Brandon Casey's proposed git-repack patch.
Date: Fri, 9 May 2008 19:09:50 -0400
Message-ID: <20080509230950.GA2733@foursquare.net>
References: <48237344.6070405@nrlssc.navy.mil> <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home> <7vwsm39kft.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 10 01:11:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JubkY-0005hI-Dx
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 01:11:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760166AbYEIXKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 19:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756268AbYEIXKv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 19:10:51 -0400
Received: from nic.NetDirect.CA ([216.16.235.2]:60632 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760177AbYEIXKo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 19:10:44 -0400
X-Originating-Ip: 216.16.235.2
Received: from localhost (rubicon.netdirect.ca [216.16.235.2])
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id m49N9oxD015365;
	Fri, 9 May 2008 19:09:53 -0400
Content-Disposition: inline
In-Reply-To: <7vwsm39kft.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.4.1i
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (not cached, score=-16.8, required 5,
	autolearn=not spam, ALL_TRUSTED -1.80, BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: <cdfrey@netdirect.ca>
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81633>

On Fri, May 09, 2008 at 03:33:41PM -0700, Junio C Hamano wrote:
> I think the true motivation behind --keep-unreachable is not about the
> shared object store (aka "alternates") but about races between gc and
> push (or fetch).  Before push (or fetch) finishes and updates refs, the
> new objects they create would be dangling _and_ the objects these dangling
> objects refer to may be packed but unreferenced.  Repacking unreferenced
> packed objects was a way to avoid losing them.

This is what the log history seems to indicate:

	git log -p --grep=keep-unreach

So pack-objects --keep-unreachable was implemented in order to add repack -A,
which now doesn't need --keep-unreachable, and can become obsolete.

Which is just as well, since --keep-unreachable never made it to the
man pages. :-)

If I understand things correctly, there is no user-friendly way to add
loose, unreachable objects to a pack.  This whole architecture was just
to prevent a repack from silently deleting things.

If this is right, the patch below updates the docs.

- Chris


>From 443b1201d54f0b7197d18779ce934823e9897b36 Mon Sep 17 00:00:00 2001
From: Chris Frey <cdfrey@foursquare.net>
Date: Fri, 9 May 2008 19:08:26 -0400
Subject: [PATCH] Updating documentation to match Brandon Casey's proposed git-repack patch.

This patch clarifies the git-prune man page, documenting that it only
prunes unpacked objects.  git-repack is documented according to
the new git-repack -A behaviour, which does not depend on
git-pack-objects --keep-unreachable anymore.

Signed-off-by: Chris Frey <cdfrey@foursquare.net>
---
 Documentation/git-prune.txt  |    5 ++++-
 Documentation/git-repack.txt |   14 +++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index f92bb8c..3178bc4 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -18,12 +18,15 @@ git-prune. See the section "NOTES", below.
 
 This runs `git-fsck --unreachable` using all the refs
 available in `$GIT_DIR/refs`, optionally with additional set of
-objects specified on the command line, and prunes all
+objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
 running `git prune-packed`.
 
+Note that unreachable, packed objects will remain.  If this is
+not desired, see linkgit:git-repack[1].
+
 OPTIONS
 -------
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 3d95749..906d3c7 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -8,7 +8,7 @@ git-repack - Pack unpacked objects in a repository
 
 SYNOPSIS
 --------
-'git-repack' [-a] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
+'git-repack' [-a] [-A] [-d] [-f] [-l] [-n] [-q] [--window=N] [--depth=N]
 
 DESCRIPTION
 -----------
@@ -37,6 +37,18 @@ OPTIONS
 	leaves behind, but `git fsck --full` shows as
 	dangling.
 
+-A::
+	Same as `-a`, but any unreachable objects in a previous
+	pack become loose, unpacked objects, instead of being
+	left in the old pack.  Unreachable objects are never
+	intentionally added to a pack, even when repacking.
+	When used with '-d', this option
+	prevents unreachable objects from being immediately
+	deleted by way of being left in the old pack and then
+	removed.  Instead, the loose unreachable objects
+	will be pruned according to normal expiry rules
+	with the next linkgit:git-gc[1].
+
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
-- 
1.5.4.4
