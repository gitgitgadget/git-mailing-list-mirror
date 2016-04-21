From: Yaroslav Halchenko <yoh@onerussian.com>
Subject: Re: 'next'ed --allow-unrelated-histories could cause lots of grief
Date: Thu, 21 Apr 2016 14:55:28 -0400
Message-ID: <20160421185528.GJ23764@onerussian.com>
References: <20160421161043.GK7907@onerussian.com>
 <xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Benjamin Poldrack <benjaminpoldrack@gmail.com>,
	Joey Hess <id@joeyh.name>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git Gurus hangout <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 20:55:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atJlK-0005zk-T5
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 20:55:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbcDUSzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 14:55:32 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:53033 "EHLO
	smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbcDUSzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 14:55:31 -0400
Received: from smtp.onerussian.com ([192.168.100.6] helo=washoe.onerussian.com)
	by smtp.onerussian.com with esmtps (TLS1.2:RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80)
	(envelope-from <yoh@onerussian.com>)
	id 1atJlA-0005G5-El; Thu, 21 Apr 2016 14:55:28 -0400
Received: from yoh by washoe.onerussian.com with local (Exim 4.84)
	(envelope-from <yoh@onerussian.com>)
	id 1atJlA-0005G0-4W; Thu, 21 Apr 2016 14:55:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn52ud6r.fsf@gitster.mtv.corp.google.com>
X-URL: http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: 192.168.100.6
X-SA-Exim-Rcpt-To: git@vger.kernel.org, benjaminpoldrack@gmail.com, id@joeyh.name, torvalds@linux-foundation.org
X-SA-Exim-Mail-From: yoh@onerussian.com
X-SA-Exim-Scanned: No (on smtp.onerussian.com); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292142>


On Thu, 21 Apr 2016, Junio C Hamano wrote:

> Yaroslav Halchenko <yoh@onerussian.com> writes:

> > I have decided to try 2.8.1.369.geae769a available from debian
> > experimental and through our (datalad) tests failing I became
> > aware of the 

> >     https://github.com/git/git/pull/158/commits/e379fdf34fee96cd205be83ff4e71699bdc32b18
> >     merge: refuse to create too cool a merge by default

> > which is planned for the next release.

> See http://thread.gmane.org/gmane.linux.kernel.gpio/15365/focus=15401
> for the backstory.

THANKS for the link!

> As this is to allow maintainers at higher levels of hierarchy not to
> have to worry about stupid mistakes happen at maintainers at lower
> levels, I'm afraid that turning this into an opt-in safety would
> defeat the point of the change in a major way.

> > ... BUT not sure if it is so
> > important as to cause a change in behavior on which some projects using
> > git through the cmdline interface might have been relying upon for
> > years!

> It is not very productive to make such an emotional statement
> without substantiating _why_ a merge that adds a new root, which was
> declared in the thread above as "crap" (in the context of the kernel
> project),

Sorry if my statement sounded too emotional ;)  I will outline some of
the use-cases below.

Meanwhile, I could argue that 'crap' in the above thread refers to the
entirety of the branch and thus more to the originating detached
root commit.  Action of creating of such a branch was also described  as
someone 'has done something TOTALLY INSANE'. And as "maintainers at
higher levels" expressed: "You actually have to *work* at making shit
like this".

I do see now the reason for introduced change of behavior clearer BUT I
would still argue that it should better be supported somehow by at least
a configuration option to not make poor mortals like yours truly
to sweat to stay compatible with multiple versions of git.

> is necessary and is a good idea in "some projects".  Maybe
> there is a valid use case that those from the kernel land didn't
> think about.

FWIW

- for git-annex (Joey was CCed from the beginning, not sure if annex
  would be affected though), it would be merging of git-annex
  branches while joining multiple annexes for the sync (e.g. by git
  annex assistant). 

- In our (datalad) case, repository is initialized with stock 'master'
  branch which carries configuration, which then used by the 'crawler'
  to initiate 'incoming' branch to contain (only) incoming data, which
  is later branched into 'incoming-processed' and later merged into
  'master', which is where such problematic merge would happen.  With
  such a workflow we can easily maintain custom changes within master,
  while automate changes to the crawled and processed data within
  those other branches being merged into master for final consumption.

  As a somewhat ugly workaround, we could probably artificially
  create an empty initial commit (forgot even how to do this magic) and
  branch-off it I guess, but I see other unit-tests failing as well, so
  I guess the situation is more chronic.

- In Debian packaging world, people often use 'debian' overlay branch
  which has no common ancestor with 'upstream' sources, but which need
  to be merged for 'in-tree' work.  I don't remember though if any of
  the tools rely on this feature (gbp iirc overlays not through the
  merge), but I know that I have used it quite a few times
  (interactively though, so yes -- could add a flag).

> > Given that git is quite 'self-healing', i.e. if someone has managed to
> > make a merge he didn't intend to, there is always a way back (e.g., as
> > simple as git reset --hard HEAD^),

> That is only true if people notice.  A mere warning would not be an
> effective prevention measure for a user who has to perform dozens of
> merges a day.

Could be argued...  Generally git's warnings is not something to be
ignored IMHO.  Do you ignore a balk of them on a daily basis?  if so --
they might better be downgraded to some kind of 'info' level msg then.

> I am personally on the fence, but right now I am on the side of
> keeping the behaviour as implemented and documented, simply because
> I haven't heard anything concrete to convince me why some people
> need to regularly do a "crap" merge (in other words, in what context
> these are not "crap" merges but ability to create them is a valuable
> part of everyday workflow).

once again -- IMHO it wasn't a 'merge' which was a crap, but the state
of the branch to be merged, and getting to that stage was non-trivial
endeavor as well ;)

Since the referenced situation happened only in 2016, I think that such
merges leading to undesired outcomes were quite a rare incident.  On the
other hand I do not have any statistic on how many of similar
merges were intensional, but I guess there could easily be thousands of
such merges intended at least in the git-annex world alone.  The point
is that it would be change in behavior require custom version-dependent
handling.

If it is more of a policy to be enforced per project, then IMHO it would
be better if disallowing such merges was a configuration option which
developers of adhering to such a policy project would configure for
their environments.

Cheers and sorry for a long post (again).
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
