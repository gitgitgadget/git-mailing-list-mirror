From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 09:11:17 +0100
Message-ID: <4B42F425.4010901@web.de>
References: <4B3F6742.6060402@web.de> <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de> <4B421F90.4090402@web.de> <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 09:12:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS4Wk-0002Lb-3U
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 09:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0AEIMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 03:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753945Ab0AEIMY
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 03:12:24 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:58413 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0AEIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 03:12:24 -0500
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id B134513B6A7C5;
	Tue,  5 Jan 2010 09:11:20 +0100 (CET)
Received: from [80.128.71.83] (helo=[192.168.178.26])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NS4Vc-0001Lk-00; Tue, 05 Jan 2010 09:11:20 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/pGhuzYFx6wqvVcR/bTv9Hk5JlJUanDKkRjdB1
	qNc0o7WtuwakPHUMvJ7f4hezXIbcrwtl2xhk2/B5JayT8QSmpd
	2VfhozMsbQQQ646xRxkA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136175>

Am 04.01.2010 23:29, schrieb Johannes Schindelin:
> You do remember the discussion at the Alles wird Git about the need for 
> Subversion external-like behavior, right?

Yup. But never having used svn, let alone externals, i think i just
did not get it then ;-)


> - submodules were designed with a strong emphasis on not being forced to 
>   check them out.  But Git makes it very unconvenient to actually check 
>   submodules out, let alone check them out at clone-time.  And it is 
>   outright impossible to _enforce_ a submodule to be checked out.

Absolutely. But i think the group mappings discussed by Junio and Heiko
are a good starting point to solve that problem:
http://thread.gmane.org/gmane.comp.version-control.git/130928/

This should be solvable by putting the necessary information into
.gitmodules and have git clone use it.


> - among other use cases, submodules are recommended for sharing content 
>   between two different repositories. But it is part of the design that it 
>   is _very_ easy to forget to commit, or push the changes in the submodule 
>   that are required for the integrity of the superproject.

Definitely (and if i got that right, svn externals have the same problem).

What about checking for every submodule before a push in the superproject
that its HEAD is on a remote branch? I don't think we can provide full
safety here, but we could handle the 99% case of a forgotten push in the
submodule. This could even be done with a rather simple hook (if we had a
pre-push hook that is :-).


> - that use case -- sharing content between different repositories -- is 
>   not really supported by submodules, but rather an afterthought.  This is 
>   all too obvious when you look at the restriction that the shared content 
>   must be in a single subdirectory.

I don't see that as a problem (and it's the same with svn externals, no?).

And having worked for a long time with a RCS variant which allowed
"projects" to contain an arbitrary list of files, i don't think this is
a problem (but forgetting to add new files to this list really is, so
putting everything in one directory is *much* safer IMHO).
And: almost all files were properly grouped in directories after a decade
of development even though that was not enforced by the scm at all.


> - related are the use cases where it is desired not to have a fixed 
>   submodule tip committed to the superproject, but always to update to the 
>   current, say, master (like Subversion's externals).  This use case has 
>   been wished away by the people who implemented submodules in Git.  But 
>   reality has this nasty habit of ignoring your wishes, does it not?

Having read up about svn externals in the meantime, what about something
like this:
- Add a command like "git submodule forward" (as update is already in
  use) that takes an optional -b <branchname>. It does a fetch in the
  submodule, then tries to fast forward (or rebase) to master or the
  branch given and stages this commit in the superproject. This should
  be the equivalent to doing an "svn update" in a repo with externals.
  Or am i missing something?
  (And we could avoid the detached HEAD in the fast forward case by
  really checking out the branch in the submodule)
- We could also add an option to "git submodule add" to specify the
  default branch name for forward.


> - while it might be called clever that the submodules' metadata are stored 
>   in .gitmodules in the superproject (and are therefore naturally tracked 
>   with Git), the synchronization with .git/config is performed exactly 
>   once -- when you initialize the submodule.  You are likely to miss out 
>   on _every_ change you pulled into the superproject.

Yes. This synchronization could be either obsoleted by only using
.gitmodules or automated.


> Besides, as long as there is enough reason to have out-of-Git alternative 
> solutions such as repo, submodules deserve to be 2nd-class citizens.

I think in the long run to make submodules first class citizens the
following submodule commands must be obsoleted by their regular git
parts: init (by git clone), status (by git status), update (by git
checkout), summary (already in git diff thanks to your patch) and sync
(maybe Avery's idea of only relying on .gitmodules and not copying data
int .git/config would solve this).
That would leave git submodule add, foreach and maybe a command to do
what svn update does for externals and another to manipulate things like
group membership etc..


Which reminds me of Sverre's quote from Alles Wird Git:
"Yes, it is possible. But it will be hard."
