From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 12:57:32 +0100
Message-ID: <4B43292C.5060106@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de> <4B42F425.4010901@web.de> <7v1vi428w0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 12:57:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS82g-0005nX-5x
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 12:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab0AEL5i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 06:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738Ab0AEL5i
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 06:57:38 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:43916 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab0AEL5h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 06:57:37 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id ACB1314444530;
	Tue,  5 Jan 2010 12:57:35 +0100 (CET)
Received: from [80.128.61.137] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NS82X-0001Nz-00; Tue, 05 Jan 2010 12:57:33 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v1vi428w0.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/HDogcnieLttnZZvDxqM/C+sh9Ic0UfLPV5eqN
	wjXQ6+wJsnPbOgtd86/NAoy52J+JNxEy9gcGrrA90b4rXmRf5C
	pysQ68gzUGInwbUZNJug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136185>

Am 05.01.2010 10:33, schrieb Junio C Hamano:
> So it is not necessarily a bad thing if the commit checked out in the
> submodule repository is different from what the superproject records in
> its index when a commit is made in the superproject.  We allow committing
> with local changes in regular files, while we do notify the users about
> them to avoid mistakes.  We should give the same kind of notification
> about submodules, but the "local changes" need to be thought out more
> carefully than plain files in the superproject itself.  Does uncommitted
> changes in the index of submodule repository count?  Local changes in the
> work tree files?  What about untracked files that the user might have
> forgot to add?  Should they be warned?  What about the commit in the
> submodule repository being a non-descendant of the commit recorded in the
> HEAD of the superproject's tree, resulting in a non-ff change at the
> submodule level?

Committing in the superproject with any dirty state in a submodule
should always work (same as it does with local changes in regular files),
but be visible for the user (again as local changes in regular files are).
Right now we do not show enough information about a submodule to protect
the user from accidentally throwing away changes made inside it.
The only thing we show right now are the differences between submodule
commits and what the superproject has in its index and in its commits.
Missing are:

  a) modified files
     I think these have to be shown, no matter if they are checked into
     the submodules index or not (because until they are committed, they
     can't be staged in the superproject anyway).

  b) new unignored files
     IMO these files should show up too (the superproject doesn't show
     ignored files, the submodule state shouldn't do that either). But
     OTOH i don't see a possibility for loss of data when this state is
     not shown.

  c) a detached HEAD not on any local *or* remote branch
     This can be fatal when doing a reset, revert or checkout, so it
     should be shown. Alternatively when applied on a submodule, forcing
     could be disabled to let the command fail instead of throwing stuff
     away.

  d) a detached HEAD not on any remote branch
     AFAICS this is only important for a push, and could just error out
     there.

(But i don't think it is necessary to show detailed information, just
what type of states are found in the submodule)

Concerning Dscho's remarks about the performace impact: We could control
this behavior via .gitmodules too (and later have different settings
for the submodules depending on the group the user chose). So you could
turn these checks off for repos where you don't care, saving the time to
go through the whole working directory of the submodule. But i would vote
for the default to show at least case a) and maybe even c) to follow the
principle of least surprise.


> I think "clone" has a chicken-and-egg problem.  If all of your project
> participant are expected to check out all the submodules, are expected to
> make commits in all of them, and essentially have to track everything in
> sync, then "clone" can obviously do that without asking what kind of
> participant you are [*1*].  Otherwise, you need to have some mechanism
> (e.g. "group mapping" you mentioned earlier) for the user to specify "I am
> interested in these submodules" before the actual sub-clones to happen,
> but until you clone the superproject that has some description for that
> mechanism to use, and the user to see what's available, you cannot say
> what kind of participant you are.  It has to become two-step process;
> either "clone" going interactive in the middle, or you let the clone to
> happen and then "submodule init" to express that information.

Yes, we can leave it that way for now (first "clone" and then "submodule
init <the submodules you need>"). We can migrate to the "group mapping"
functionality later (which would then allow to force certain submodules
to always be populated because they appear in every group).
