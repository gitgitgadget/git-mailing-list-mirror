From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] daemon whitelist handling (Re: git pull aborts in 50% of cases)
Date: Sat, 03 Dec 2005 13:19:47 -0800
Message-ID: <7vslt9vpxo.fsf@assigned-by-dhcp.cox.net>
References: <20051202190412.GA10757@mipter.zuzino.mipt.ru>
	<43909963.60901@zytor.com>
	<20051202211250.GA11384@mipter.zuzino.mipt.ru>
	<4390B64E.20601@zytor.com>
	<Pine.LNX.4.63.0512030316520.19086@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vu0dq29wg.fsf@assigned-by-dhcp.cox.net> <43911D9E.5030803@zytor.com>
	<7vpsoezf6y.fsf@assigned-by-dhcp.cox.net>
	<7vzmnivuz8.fsf_-_@assigned-by-dhcp.cox.net>
	<4391F4DD.2060002@zytor.com>
	<Pine.LNX.4.64.0512031156070.3099@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 22:21:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EienT-0000d3-5Q
	for gcvg-git@gmane.org; Sat, 03 Dec 2005 22:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLCVTw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Dec 2005 16:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbVLCVTw
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Dec 2005 16:19:52 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:1722 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932072AbVLCVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2005 16:19:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051203211814.TYK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 3 Dec 2005 16:18:14 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <Pine.LNX.4.64.0512031156070.3099@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 3 Dec 2005 11:56:37 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13168>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 3 Dec 2005, H. Peter Anvin wrote:
>> 
>> At the very least, if you insist on using getcwd() names, you should
>> pre-canonicalize the whitelist, too.
>
> That would probably solve the problem and sounds like the right 
> user-friendly solution.

I agree with you that limiting with names exposed to the
end-user is the right approach and we should avoid having
administrators to use getcwd() names.  So in that sense, I think
the patch I sent earlier is going in the right direction.

To cope with the "oops" symlink problem, we could introduce
"--strict-symlink" flag to daemon that does these things:

 - enter_repo() returns three things: "~alice/foo.git/.git",
   "/home/alice/foo.git/.git", and "/home/alice"; the first is
   what remote requested with DWIM, the second is where it
   chdir()ed, and the third is what it expanded the
   user-relative base to.  None of them uses getcwd().  When
   user-relative path is not involved, the first two are the
   same, and the last one is undefined (and not used).

 - daemon checks the whitelist with the first one, and if the
   path is not allowed, the processing stops there with failure.
   Without --strict-symlink, this is the only test done with
   whitelist.  This means the whitelist should have /pub/scm and
   ~alice, not /mnt/disk47/slice31/scm nor /home2/alice.

   With --strict-symlink, it uses the latter two with the
   whitelist entry it matched, to determine where to start
   further "strict symlink check".  The part that matched the
   whitelist is OK and the rest is checked [*1*]:

   - If "~alice" was whitelisted, it knows ~alice expanded to
     /home/alice, and starts checking from /home/alice/foo.git
     and then checks /home/alice/foo.git/.git.

   - If "~alice/foo.git" was whitelisted, it knows it expands to
     /home/alice/foo.git, and checks /home/alice/foo.git/.git.

   - If a whitelist entry "/pub/scm" was matched against a
     request "/pub/scm/git/git.git", it checks /pub/scm/git and
     /pub/scm/git.git

   The strict symlink check tries to readlink() each of what are
   to be checked by the above logic, and rejects if it was found
   to be a symlink that starts with a "/" (i.e. absolute
   pathname) or anything that has undesiable aliasing effect;
   "belts and suspender paranoia" in daemon.c::avoid_alias(),
   which is stricter than needed but is safe is a good starting
   point, but we may want to allow things that do not step
   outside the prefix we matched.

However, I am not ready to do all of the above, not just yet.

Since I wanted to do another maintenance update this weekend,
I'd throw in the last-night's patch in the master so that at
least 0.99.9l works with /pub whitelist, knowing the "oops"
symlink issue is still to be solved.  That way we can keep the
users' configuration the same when later we introduce all of the
above.

Thoughts?

[Footnote]

*1* If we later introduce "/pub/scm/**/*.git", we allow symlinks
in the first directories without glob patterns, i.e. "/pub/scm",
so this is somewhat future-proof.
