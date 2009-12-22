From: J Chapman Flack <jflack@math.purdue.edu>
Subject: Re: git's fascination with absolute paths
Date: Tue, 22 Dec 2009 12:21:27 -0500
Message-ID: <4B310017.8030009@math.purdue.edu>
References: <4B2FC17A.3010705@math.purdue.edu> <32541b130912211409j540928c0g8e944fcc05c44f82@mail.gmail.com> <7v637z6ehg.fsf@alter.siamese.dyndns.org> <7vy6kv4j2u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 22 18:22:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NN8Ql-0001rr-DH
	for gcvg-git-2@lo.gmane.org; Tue, 22 Dec 2009 18:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754224AbZLVRVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2009 12:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbZLVRVt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Dec 2009 12:21:49 -0500
Received: from mailhub128.itcs.purdue.edu ([128.210.5.128]:54948 "EHLO
	mailhub128.itcs.purdue.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754198AbZLVRVs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Dec 2009 12:21:48 -0500
Received: from math.purdue.edu (zorn.math.purdue.edu [128.210.3.177])
	by mailhub128.itcs.purdue.edu (8.14.2/8.14.2/smtp.purdue.edu) with ESMTP id nBMHLkpj030590
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 12:21:46 -0500
Received: from mailrelay.math.purdue.edu (mailrelay.math.purdue.edu [128.210.3.183])
	by math.purdue.edu (8.13.8+Sun/8.13.6/RPM-20060601-1) with SMTP id nBMHLk2E006485
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 12:21:46 -0500 (EST)
Received: From mailrelay.math.purdue.edu ([128.210.3.183]) by mailrelay.math.purdue.edu (WebShield SMTP v4.5 MR3)
	id 126150250679; Tue, 22 Dec 2009 12:21:46 -0500
Received: from hardy.math.purdue.edu [128.210.3.54]
	by mailrelay.math.purdue.edu (Alligate(TM) SMTP Gateway v3.9.7.13)
	with ESMPT id <BAF4CEDA9A173AE2.BA90C810050811DB@mailrelay.math.purdue.edu>
	for <git@vger.kernel.org>; Tue, 22 Dec 2009 12:21:27 -0500
User-Agent: Thunderbird 2.0.0.22 (X11/20090609)
In-Reply-To: <7vy6kv4j2u.fsf@alter.siamese.dyndns.org>
X-Alligate-SMTP: Whitelisted
X-Alligate-ReceivingIP: [128.210.3.183]
X-Originating-IP: 128.210.3.54
X-Destination-IP: 
X-Alligate-ID: 399399
X-Alligate-Out: IGNORED - WhiteListed From: (@*purdue.edu)
X-PMX-Version: 5.5.7.378829
X-PerlMx-Virus-Scanned: Yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135584>


Junio C Hamano wrote:
 > Clarificaiton.
 >
 > The above, like many other messages from me, was not meant as a
 > justification, but a mere explanation of the historical fact.  IOW,
 > don't get me wrong by interpreting that I am not interested in seeing
 > a solution that does not use absolute paths.

No worries - a sense of the history is exactly the kind of response
I was hoping for. :)

 > While I think the original "higher levels in the filesystems may not
 > be accessible" is a rather unusual set-up, making paths absolute and
 > relying on being able to always do so have another drawback in a
 > not-so-unusual setup.  A work tree that is shallow (say, has only one
 > t/ subdirectory and short filenames) may not be usable if it is so
 > deep in the filesystem hierarchy that the result of getcwd(3) exceeds
 > PATH_MAX.  The "hand roll

This is funny; I think in my own career I've seen applications that keep
sensitive data in subtrees restricted at the top somewhat routinely (which
might not mean "really often in absolute terms" but something more like
"whenever it made sense for the app") going back at least as far as uucp
(IIRC) ... Solaris Zones are set up that way too (when viewed from the
global zone).  By the same token, while I'd never be surprised to hear
of someone with deep hierarchies that exceed PATH_MAX, I'm not sure I've
ever actually seen it happen myself.

I don't intend that as the start of a "which case is more unusual"
comparison, I think it just illustrates the difficulty in making such
judgments of usualness, as different people's career trajectories expose
them to very different things. I'd rather spend the mental effort trying
to extract whatever general principle can be used to code robustly so the
fewest judgments of usualness need to be made. Here the general principle
(which I think you've already kind of stated yourself, so I'm not trying
to preach but just to finish the thought) is that, for various reasons,
trying to transform a relative into an absolute path is not always well
defined, can't even always be done, can have implementation-dependent
side effects and race conditions, and ought to be an operation that gets
pulled out of the arsenal only with deliberation and only for specific
paths that must be made absolute if that's the only way to satisfy some
known functional requirement of the app.

It might be tied in to the principle of least astonishment, just by
assuming that whatever path the caller, user, or admin provides is
probably the path s/he wants you to use, for any number of possible
reasons that you don't need to be able to foresee.

 >> By rewriting that part of the "root-level-discovery" code to do
 >> something like
 >>
 >>  - while test -d .git is not true:
 >>    - stat(".") to get the inum;
 >>    - chdir(".."); and
 >>    - opendir(".") and readdir() to find where we were;
 >>
 >> while going up every level, you should be able to construct the prefix
 >> without being to able to read all the way up to the filesystem root. 
  You
 >> only need to be able to read your work tree.

Yes, that's exactly what I would have suggested for the root level
discovery.  As long as you can find .git before reaching any inaccessible
ancestor, life is good.  (And if you can't it's a perfectly good reason
to give up without astonishing the user.)

It would still be better to open "." once at the beginning and
fchdir back to it, rather than trying to chdir back to the
constructed path string (an inherent race condition), just as the
Notes section in linux getcwd(3) says.

An interesting point, the chdir ../opendir/readdir algorithm you
give above is no longer necessarily what getcwd does, though it
traditionally was. These days there's often a kernel name cache
that getcwd gets at through a syscall or /proc.  You can tell,
because when I tried to use 'git init' in my situation, the error
was not from getcwd but from the later access() call done on the
full path that getcwd successfully returned.

   [there's a side issue: access(2) isn't for what a lot of people
   think it's for. It's a rather esoteric call for testing access
   by the real ids instead of the effective ones, and it's needed
   in code that (a) runs set{u,g}id AND (b) wants to confirm that
   a user-specified file is really something the user has rights to.
   Using access() routinely just to ask "can I open this" has
   a couple of problems: (1) it has a race condition and gives you
   less information than just trying the open and testing errno;
   (2) if anybody down the road does try to use your program or
   code under set{u,g}id circumstances, astonishing failures can
   result. Even for its intended purpose access() suffers from a
   race; current OSes make it fairly easy to just drop to the real
   user's IDs, try the open, and test errno, so access() is a bit
   of a dinosaur.]

Anyway, it would also be possible to make use of the modern
optimized getcwd in the root-level-discovery algorithm. If getcwd
gives a result you can just follow it backwards until you find .git,
confirming in each step that you can stat the name of the child and
the inums match (an O(1) test instead of O(directory-size) for readdir).
Just don't follow it back past the directory containing .git. The
slower fallback code is only needed for less modern systems in case
getcwd returns EACCES.  But now we're in the realm of optimization;
the traditional loop does the trick.

(well, one nice feature of the modern approach, beyond speed, is that
it only needs x on the directories up to .git and not r.  but since
I'm doubtful anything else git does would actually work without r,
that's probably moot.)

 >> Admittedly the code complexity got worse later when we added support
 >> for GIT_WORK_TREE and also GIT_CEILING_DIRECTORIES, as they
 >> fundamentally need to know where you are relative to the root of the
 >> filesystem tree and need a working getcwd(3) support

That's the kind of thing I wondered about, are there particular
features that genuinely require an absolute path?  I'm a git newbie
and I don't know what these features do, so I can't comment. (This
project was going to be my excuse for learning git, but rcs actually
suffices and I need to get it done.)

Do these features actually need to traverse the full path, or just
to know what it is?  On a system with modern getcwd that can return
the path even if it isn't traversable, could they make use of that?

-Chap
