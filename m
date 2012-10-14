From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH 00/20] git-cvsserver: add support for cvs "-r" refs
Date: Sat, 13 Oct 2012 23:42:13 -0600
Message-ID: <1350193353-19210-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 14 07:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNH3z-0006rG-8V
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 07:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab2JNFsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 01:48:10 -0400
Received: from qmta01.emeryville.ca.mail.comcast.net ([76.96.30.16]:54894 "EHLO
	qmta01.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751984Ab2JNFsJ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Oct 2012 01:48:09 -0400
Received: from omta23.emeryville.ca.mail.comcast.net ([76.96.30.90])
	by qmta01.emeryville.ca.mail.comcast.net with comcast
	id Atmf1k0021wfjNsA1to8Hb; Sun, 14 Oct 2012 05:48:08 +0000
Received: from mmogilvi.homeip.net ([24.9.53.136])
	by omta23.emeryville.ca.mail.comcast.net with comcast
	id Atj71k00A2wKXRC8jtj7PK; Sun, 14 Oct 2012 05:43:08 +0000
Received: by mmogilvi.homeip.net (Postfix, from userid 501)
	id 20D341E9601B; Sat, 13 Oct 2012 23:43:07 -0600 (MDT)
X-Mailer: git-send-email 1.7.10.2.484.gcd07cc5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207619>

This patch series improves git-cvsserver's handling and support
of refspecs requested by the client.

Disclaimer: I don't actually intend to use any of this myself.
I suspect no one really cares about cvsserver (I don't even really
care myself).  See also below.

-----------
Features:
-----------

1. You can now switch branches with "cvs update -r REFSPEC",
   "cvs update -A", "cvs checkout -r ...", etc.  It becomes sticky for
   plain "cvs update" until reset (like standard CVS).  You can
   add/remove/commit to other branches updated this way.
      The old "cvs checkout moduleThatIsReallyABranch" technique
   still works; it becomes the main head branch from CVS's perspective.
   CVS revision number allocation is not synchronized between different
   modules checkout out in this old way.
2. You can create arbitrary diffs and patches with commands such as
   "cvs diff -r REFSPEC [-r REFSPEC]", over files, directories, or whole
   trees.  (It used to effectively be limited to individual files,
   and CVS-specific revision numbers (no tags).)
3. The REFSPECs can refer to CVS revision numbers, git commit IDs,
   git tags, git branches, or other git refspecs.  There is an escape
   mechanism you can use if your CVS client won't let you feed in
   invalid CVS tags that contain ".", "/", or similar characters.
4. No DB schema changes for now.  You can downgrade back to previous
   versions, and the only things that may break are existing sandboxes
   that were explicitly using the new features (had been set to a sticky
   branch with cvs update -r).

-----------
Limitations:
-----------

1. CVS revision numbers (other than those on the main
   branch) are not "real".  Instead, they are git commit ID's
   encoded to look like valid CVS revision numbers.  Subsequent versions
   do not have related CVS revision numbers at all.
   (Most of the code in this patch series would probably still be
   useful if someone enhances CVS revision numbers in the future.)
2. "CVS log" does not attempt to show versions on other than the "main"
   branch, even if a non-main branch is currently checked out.  It also
   doesn't show any branch or tag names.
3. Performance: When updating, it attempts to find a main-branch
   CVS revision number, or failing that, restrict itself to
   the specific git commit ID where the file most recently
   changed.  Searching for these (on an individual file
   basis) can currently be rather expensive, and probably
   doesn't scale well.  There are several possible ways it might be
   optimized, but no optimization has been done.  See comments in the
   patch.
4. I've done almost no testing, other than running both old and new
   unit tests (t9400, t9401, and t9402).
5. Testing Eclipse: I needed to make some changes to the
   details of what cvs update sends for the CVS protocol, even
   in the non-branch case.  I think I've made it closer to being
   the same as a standard CVS server (based on some captured
   conversations), but it still isn't "perfect".
   With luck, reputedly-finicky clients like Eclipse will still
   work correctly, but I haven't actually verified this.
6. Pre-existing issue: There are cases where the server will ask the
   client to replace user-modified files without saving those modifications
   off to the side first (.# files).  I haven't fixed these, but the fourth
   patch adds a comment about one such case.
7. Coding style: git-cvsserver mostly doesn't use git's main coding style.
   In fact, different parts of the file seem to use different
   coding styles.  I've made a superficial attempt to have each change
   keep relatively close to nearby coding style.  But larger chunks
   of code tend to stick to a hybrid of what seems most predominant
   in the file as a whole, and my own personally preferred style.

-----------
Disclaimer:
-----------

I don't actually intend to use any of this myself.

I started it a few years ago under the theory that a more accurate
emulation of CVS would make it easier to convince the team at $DAYJOB
to switch to git, but we eventually switched without using
git-cvsserver at all.  I've been working on this on and off (mostly
off) out of a vague sense of stubborness.

Depending on overall interest in this feature (most likely not
much) vs how many adjustments maintainers want, I might gradually get
this into a ready-to-include state (possibly weeks or months).  But
my primary goal here is just to have it available publicly
somewhere (like the mailing list) where someone who really
wants features like these can use these patches as a starting
point.  That said, perhaps some of the trivial cleanup
patches could go in now?

-------------------------------

Matthew Ogilvie (20):
  cvsserver t9400: add basic 'cvs log' test
  cvsserver: removed unused sha1Or-k mode from kopts_from_path
  cvsserver: add comments about database schema/usage
  cvsserver update: comment about how we shouldn't remove a
    user-modified file
  cvsserver: remove unused functions _headrev and gethistory
  cvsserver: clean up client request handler map comments
  cvsserver: split up long lines in req_{status,diff,log}
  cvsserver: use whole CVS rev number in-process; don't strip "1."
    prefix
  cvsserver: cvs add: do not expand directory arguments
  cvsserver status: provide real sticky info
  cvsserver: factor out git-log parsing logic
  cvsserver: cleanup extra slashes in filename arguments
  cvsserver: define a tag name character escape mechanism
  cvsserver: add misc commit lookup, file meta data, and file listing
    functions
  cvsserver: implement req_Sticky and related utilities
  cvsserver: generalize getmeta() to recognize commit refs
  cvsserver: Add version awareness to argsfromdir
  cvsserver: support -r and sticky tags for most operations
  cvsserver: add t9402 to test branch and tag refs
  cvsserver Documentation: new cvs ... -r support

 Documentation/git-cvsserver.txt |   37 +
 git-cvsserver.perl              | 2433 +++++++++++++++++++++++++++++++--------
 t/t9400-git-cvsserver-server.sh |   72 +-
 t/t9401-git-cvsserver-crlf.sh   |   35 +
 t/t9402-git-cvsserver-refs.sh   |  558 +++++++++
 5 files changed, 2624 insertions(+), 511 deletions(-)
 create mode 100755 t/t9402-git-cvsserver-refs.sh

-- 
1.7.10.2.484.gcd07cc5
