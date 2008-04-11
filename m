From: Eric Blake <ebb9@byu.net>
Subject: backdated tag bug
Date: Fri, 11 Apr 2008 20:28:32 +0000 (UTC)
Message-ID: <loom.20080411T193913-700@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 11 22:29:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkPsR-0004Ol-3X
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 22:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759465AbYDKU2w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 16:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759431AbYDKU2w
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 16:28:52 -0400
Received: from main.gmane.org ([80.91.229.2]:34288 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759414AbYDKU2v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 16:28:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JkPrV-0004Ud-93
	for git@vger.kernel.org; Fri, 11 Apr 2008 20:28:41 +0000
Received: from eblake.csw.l-3com.com ([128.170.36.124])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:28:41 +0000
Received: from ebb9 by eblake.csw.l-3com.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 20:28:41 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 128.170.36.124 (Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727; InfoPath.1; .NET CLR 3.0.04506.30; .NET CLR 3.0.04506.648))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79293>

According to 'git tag --help', it should be possible to create a signed, back-
dated tag.  But I can't get it to work.  Am I doing something wrong, or is this 
a git bug?  Shell transcript follows:

# Done on a demo repository, although I encountered the bug on a real one.
# I plan on creating two revisions, then tagging the first v1 OLDER than
# the second at v2

$ mkdir foo
$ cd foo
$ git --version
git version 1.5.5
$ git init
Initialized empty Git repository in .git/
$ echo hi > file
$ git add file
$ git commit -m commit1
Created initial commit 617ff6a: commit1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
$ echo bye > file
$ git commit -a -m commit2
Created commit 3f226cf: commit2
 1 files changed, 1 insertions(+), 1 deletions(-)

# Create a tag right now, for comparison purposes

$ git tag -s v2 -m v2  

You need a passphrase to unlock the secret key for
user: "Eric Blake (free software programmer) <ebb9@byu.net>"
1024-bit DSA key, ID F4850180, created 2004-12-18

$ git cat-file tag v2
object 3f226cf9b3905b60310866ab7a72c744f0f1feb4
type commit
tag v2
tagger Eric Blake <ebb9@byu.net> 1207943097 -0600

v2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg

iEYEABECAAYFAkf/v7kACgkQ84KuGfSFAYA4ygCcDwGYnyWBanfQyZPInKrMluYu
m4AAnjQi/TQ+14MDtBeo3MrrpSQXoJnN
=HAcH
-----END PGP SIGNATURE-----

# Make sure I know how to get an older date

$ date '+%F %R'
2008-04-11 13:47
$ date '+%F %R' -d '-1 day'
2008-04-10 13:47

# Now, follow the advice in 'git tag --help'

$ GIT_AUTHOR_DATE=`date '+%F %R' -d '-1 day'` git tag -s v1 -m v1 HEAD^

You need a passphrase to unlock the secret key for
user: "Eric Blake (free software programmer) <ebb9@byu.net>"
1024-bit DSA key, ID F4850180, created 2004-12-18

$ git cat-file tag v1
object 617ff6a0daf5b9a32732bb79ef98f2abd3cd58de
type commit
tag v1
tagger Eric Blake <ebb9@byu.net> 1207943332 -0600

v1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg

iEYEABECAAYFAkf/wKQACgkQ84KuGfSFAYBGKACfdWzVMRgaLZImxj8IMMEDDOZr
z38An2WotiiskR+uXaIVglR6zX0mYFGD
=WEKw
-----END PGP SIGNATURE-----

# Hey wait a minute - 1207943097 is older than 1207943332.
# Which means v1 wasn't back-dated the way I asked :(
# Just to double-check with some human-readable times...

$ git tag -v v1 v2 2>&1 | grep -B1 made
v1
gpg: Signature made Fri Apr 11 13:48:52 2008 MDT using DSA key ID F4850180
--
v2
gpg: Signature made Fri Apr 11 13:44:57 2008 MDT using DSA key ID F4850180

# Oh well, I give up - 'git tag --help' lied about creating signed back-dated
# annotated tags. Since the porcelain didn't work, I'll try the plumbing.

$ git tag -d v1
Deleted tag 'v1'
$ emacs t
$ cat t
object 617ff6a0daf5b9a32732bb79ef98f2abd3cd58de
type commit
tag v1
tagger Eric Blake <ebb9@byu.net> `date +%s -d '-1 day'` -0600

v1
$ echo `git mktag < t` > .git/refs/tags/v1
$ git show v1 | head
tag v1
Tagger: Eric Blake <ebb9@byu.net>
Date:   Thu Apr 10 14:02:15 2008 -0600

v1
commit 617ff6a0daf5b9a32732bb79ef98f2abd3cd58de
Author: Eric Blake <ebb9@byu.net>
Date:   Fri Apr 11 13:40:17 2008 -0600

    commit1

# Better than nothing - I created a valid, annotated, back-dated tag.  But it
# isn't signed.  So let's try again:

$ gpg --clearsign t

You need a passphrase to unlock the secret key for
user: "Eric Blake (free software programmer) <ebb9@byu.net>"
1024-bit DSA key, ID F4850180, created 2004-12-18

$ echo `git mktag < t.asc` > .git/refs/tags/v1
error: char0: does not start with "object "
fatal: invalid tag signature file

# The plumbing doesn't like the BEGIN PGP SIGNED line, so I'll just strip it:

$ echo `tail -n+4 t.asc | git mktag` > .git/refs/tags/v1
$ git show v1 | head -n15
tag v1
Tagger: Eric Blake <ebb9@byu.net>
Date:   Thu Apr 10 14:02:15 2008 -0600

v1
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg

iEYEARECAAYFAkf/xIMACgkQ84KuGfSFAYC8egCfZAFQ5LSnUPELCjifsr1DQKrE
PCUAoIGzd6pApwZNaaHuhO6miggycF1d
=qCJn
-----END PGP SIGNATURE-----
commit 617ff6a0daf5b9a32732bb79ef98f2abd3cd58de
Author: Eric Blake <ebb9@byu.net>

# There.  That worked - a back-dated signed tag!  Or did it?

$ git tag -v v1
object 617ff6a0daf5b9a32732bb79ef98f2abd3cd58de
type commit
tag v1
tagger Eric Blake <ebb9@byu.net> 1207857735 -0600

v1
gpg: Signature made Fri Apr 11 14:05:23 2008 MDT using DSA key ID F4850180
gpg: BAD signature from "Eric Blake (free software programmer) <ebb9@byu.net>"
error: could not verify the tag 'v1'

# Shoot.  I got the signature wrong.  The help on 'git mktag --help' mentions
# that tags can be signed, but *does not say how to use gpg to get to that
# point*.  I suppose I could read the source code, but I really expected that
# the manual would tell me how.  On the other hand, I guess I can live with
# leaving the 'git mktag' documentation alone if the original 'git tag' bug
# is fixed.

# Side note - while investigating this, I found another instance where the
# ui could be improved.  Compare the difference between annotated and
# lightweight tags:

$ git tag -m v3 v3
$ git tag v4
$ git tag -v v3
object 3f226cf9b3905b60310866ab7a72c744f0f1feb4
type commit
tag v3
tagger Eric Blake <ebb9@byu.net> 1207945051 -0600

v3
gpg: no valid OpenPGP data found.
gpg: the signature could not be verified.
Please remember that the signature file (.sig or .asc)
should be the first file given on the command line.
error: could not verify the tag 'v3'

# Why'd we get all the way to gpg?  Shouldn't git be smart enough to realize
# that there is no 'BEGIN PGP SIGNATURE', and not waste the time calling gpg?

$ git tag -v v4
error: 3f226cf9b3905b60310866ab7a72c744f0f1feb4: cannot verify a non-tag object 
of type commit.
error: could not verify the tag 'v4'

# Make up your mind.  Is v4 "a non-tag object" or "tag 'v4'"?  I think it
# would be nicer if git could tell me something like:
error: tag 'v3' is not signed
error: tag 'v4' is not annotated or signed

-- 
Eric Blake
