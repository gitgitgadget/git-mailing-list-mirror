From: Petr Baudis <pasky@suse.cz>
Subject: Re: TopGit: how to deal with upstream inclusion
Date: Sun, 14 Sep 2008 23:03:16 +0200
Message-ID: <20080914210316.GJ10360@machine.or.cz>
References: <20080914203043.GA4872@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Sun Sep 14 23:04:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Keylg-0003aq-N7
	for gcvg-git-2@gmane.org; Sun, 14 Sep 2008 23:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbYINVDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2008 17:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754117AbYINVDU
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Sep 2008 17:03:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58751 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754064AbYINVDU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2008 17:03:20 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 5837C3939B3B; Sun, 14 Sep 2008 23:03:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080914203043.GA4872@lapse.rw.madduck.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95860>

  Hi,

On Sun, Sep 14, 2008 at 09:30:43PM +0100, martin f krafft wrote:
> So the Debian topgit package used to have a branch fixes/destdir to
> make the Makefile distro-friendly. TopGit 0.3 has integrated this,
> thus obsoleting the fixes/destdir branch.
> 
> I thought the way to handle this would be to simply delete the
> TopGit branch, but of course that breaks everything, e.g.:
> 
> lapse:..t/topgit|debian/locations|% tg update
> tg: fatal: some dependencies are missing: fixes/destdir
> 
> I now we had a recent discussion about how to remove branches, and
> that there's basically no way to do this. In the discussion,
> upstream inclusion was listed as one of the instances when this
> wouldn't be needed, but that refers to upstream pulling/am'ing my
> commits, not implementing the same functionality differently.

  upstream should never pull TopGit branches! They have ugly history and
contain .topdeps and .topmsg junk files. That's what tg patch and
tg export is there for. :-)

  If upstream applies the changes, the branch becomes unnecessary and
then it is ok to have some command like 'tg depend rm' to get rid of the
branch, since the *changes* aren't going away, thus we don't need to
create any "revert commits", which is the real issue with the general
'tg depend rm' command.

> How do I retire the fixes/destdir branch? Do I manually remove the
> dependency from depending branches?

  Almost. The real 'tg depend rm' (or maybe rather, 'tg depend fold' as
in "this topic branch got folded to that branch") command would be
slightly more complicated, I think, in order to ensure that no
mysterious leftovers of the retired patch are lurking in your patch
tree. Assuming

	tg depend fold RETIRED VANILLA

  (i) Take the RETIRED _base_ branch

  (ii) Merge in VANILLA

  (iii) Merge in RETIRED head branch with -s ours

  (iv) Now we have a commit that contains RETIRED topic branch, but with
the RETIRED's changes taken from VANILLA instead of RETIRED

  (v) Merge this into the base of your current branch

  (vi) Merge base to the head of your current branch, replacing RETIRED
with VANILLA (if not already there) in the .topdeps

  (vii) You do not have to add VANILLA if you depend on it recursively
and ran tg update before to get it from your dependencies

  Maybe in your case this could be even simpler but this should be the
general process. Does that sound right?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
