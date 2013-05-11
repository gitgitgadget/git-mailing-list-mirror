From: Thomas Rast <trast@inf.ethz.ch>
Subject: [ANN] git-tbdiff: topic branch diff
Date: Sat, 11 May 2013 17:35:46 +0200
Message-ID: <87ip2pfs19.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 11 17:36:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbBq2-0007Jj-4a
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 17:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155Ab3EKPfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 11:35:53 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:44547 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab3EKPfw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 11:35:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sat, 11 May
 2013 17:35:39 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (213.221.117.227) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Sat, 11 May 2013 17:35:49 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [213.221.117.227]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223974>

Hi,

Spawned by discussion here at git-merge, I created a script that diffs
the state of branches.

You can grab it from

  https://github.com/trast/tbdiff.git

The usage is

  git tbdiff A..B C..D

Make sure to pass two ranges; it doesn't check that at all, and just
hands it off to format-patch, so that a lone commit 'foo' means
'foo..HEAD' in the usual format-patch semantics.

It does not use a longest-common subsequence approach like all other
diffs, since the commits on the branch could have been reordered.
Unlike in code, where only special cases of reorderings do not change
the meaning[1], these reorderings frequently do not change the semantics
of the series.

I tried an approach that goes looking for a minimum cost bipartite
matching, where the cost is given by the interdiff between the commits.
This seems to be working nicely; for example, between v2 and v3 of the
fc/remote-hg topic[2] it shows (in glorious color that cannot be
represented here):

  $ git tbdiff origin/master~2..fc/remote-hg-2  origin/master..fc/remote-hg-3
   1:  95bb1c2 =  1:  832f6a6 remote-hg: trivial test cleanups
   2:  ebff16c =  2:  1512332 remote-hg: make sure fake bookmarks are updated
  --: -------- >  3:  1584d8b remote-hg: fix bad state issue
   3:  8db4546 =  4:  0d6054b remote-hg: redirect buggy mercurial output
  --: -------- >  5:  ff9def9 remote-hg: fix bad file paths
   5:  2406703 =  6:  f467a2d remote-hg: refactor export
   6:  e3018d1 =  7:  70e4855 remote-hg: fix for files with spaces
   7:  a35adfb =  8:  7af557e remote-hg: update remote bookmarks
  --: -------- >  9:  99fe20c remote-hg: document location of stored hg repository
   8:  4ec2382 = 10:  d360d7c remote-hg: add missing config variable in doc
   9:  1c94a96 = 11:  0c51226 remote-hg: trivial cleanups
   4:  fd646af = 12:  e9f3e36 remote-hg: update tags globally
  10:  dc097ea = 13:  1ed339d remote-hg: properly report errors on bookmark pushes
  12:  d8a548c = 14:  f887082 remote-hg: split bookmark handling
  --: -------- > 15:  a9ac462 remote-hg: add basic author tests
  --: -------- > 16:  c68bed9 remote-hg: add simple mail test
  --: -------- > 17:  a350abe remote-hg: add 'insecure' option
  11:  0870eb6 ! 18:  66e283d remote-hg: push to the appropriate branch
      @@ -11,7 +11,7 @@
        
       +    # Check if the ref is supposed to be a named branch
       +    if ref.startswith('refs/heads/branches/'):
      -+        extra['branch'] = ref.rpartition('/')[2]
      ++        extra['branch'] = ref.replace('refs/heads/branches/', '')
       +
            if mode == 'hg':
                i = data.find('\n--HG--\n')

  13:  a583fa6 < --: -------- remote-hg: force remote push
  --: -------- > 19:  ff4571d remote-hg: show more proper errors
  --: -------- > 20:  34b0b77 remote-hg: force remote push

So you can clearly see that commit old-4 moved to position 12, commit 3
is new, etc.  The failure to match up old-13 with new-20 is not a bug;
the two are so different that the heuristics split it into a
creation/deletion.

Another use-case is when Junio picked up a series that you submitted.
Comparing Peff's jk/packed-refs-race on github with what was actually
merged into git.git shows

  $ git tbdiff origin/next..peff/jk/packed-refs-race origin/next..7c95033
  1:  eb4f175 ! 1:  ed485e2 resolve_ref: close race condition for packed refs
      @@ -25,6 +25,9 @@
       resolve_ref_unsafe. In the situation described above, we may
       still be depending on a cached view of the packed-refs file;
       that race will be dealt with in a future patch.
      +
      +Signed-off-by: Jeff King <peff@peff.net>
      +Signed-off-by: Junio C Hamano <gitster@pobox.com>
       diff --git a/refs.c b/refs.c
       --- a/refs.c
       +++ b/refs.c

  2:  d9d9e0f ! 2:  40aba32 add a stat_validity struct
      @@ -13,6 +13,9 @@
       reuse the logic about which stat entries to trust for a
       particular platform, but hides the complexity behind two
       simple functions: check and update.
      +
      +Signed-off-by: Jeff King <peff@peff.net>
      +Signed-off-by: Junio C Hamano <gitster@pobox.com>
       diff --git a/cache.h b/cache.h
       --- a/cache.h
       +++ b/cache.h

  3:  4e566d4 ! 3:  7c95033 for_each_ref: load all loose refs before packed refs
      @@ -40,6 +40,17 @@
       from that tip (the same thing can happen if "repack -ad" is
       used, as it simply drops unreachable objects that are
       packed).
      +
      +This patch solves it by loading all of the loose refs for
      +our traversal into our in-memory cache, and then refreshing
      +the packed-refs cache. Because a pack-refs writer will
      +always put the new packed-refs file into place before
      +starting the prune, we know that any loose refs we fail to
      +see will either truly be missing, or will have already been
      +put in the packed-refs file by the time we refresh.
      +
      +Signed-off-by: Jeff King <peff@peff.net>
      +Signed-off-by: Junio C Hamano <gitster@pobox.com>
       diff --git a/refs.c b/refs.c
       --- a/refs.c
       +++ b/refs.c
      @@ -80,7 +91,7 @@
       +	/*
       +	 * We must make sure that all loose refs are read before accessing the
       +	 * packed-refs file; this avoids a race condition in which loose refs
      -+	 * iare migrated to the packed-refs file by a simultaneous process, but
      ++	 * are migrated to the packed-refs file by a simultaneous process, but
       +	 * our in-memory view is from before the migration. get_packed_refs()
       +	 * takes care of making sure our view is up to date with what is on
       +	 * disk.

  4:  9937a33 ! 4:  b6be74d get_packed_refs: reload packed-refs file when it changes
      @@ -53,6 +53,9 @@
       appear in their executed order to process A, by the time A
       sees the missing loose ref, the new packed-refs file must be
       in place.
      +
      +Signed-off-by: Jeff King <peff@peff.net>
      +Signed-off-by: Junio C Hamano <gitster@pobox.com>
       diff --git a/refs.c b/refs.c
       --- a/refs.c
       +++ b/refs.c


In this case the matching up is trivial, but you can see that it clearly
shows the added Signoffs and edited parts of message and patch.

Have fun, and let me know if it breaks!

- Thomas


[1]  in imperative languages anyway

[2]  One part of that series, anyway.  The different versions make a
really good use-case for this tool.  I pushed four versions of that
series to git://github.com/trast/git.git as fc/remote-hg-[1234] so you
can experiment with git-tbdiff.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
