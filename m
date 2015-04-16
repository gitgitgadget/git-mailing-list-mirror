From: Andreas Mohr <andi@lisas.de>
Subject: Re: Issue: repack semi-frequently fails on Windows (msysgit) -
 suspecting file descriptor issues
Date: Thu, 16 Apr 2015 13:35:05 +0200
Message-ID: <20150416113505.GA30818@rhlx01.hs-esslingen.de>
References: <20150416100359.GA19951@rhlx01.hs-esslingen.de>
 <552F98AC.5030603@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Mohr <andi@lisas.de>, git@vger.kernel.org,
	msysGit <msysgit@googlegroups.com>
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Thu Apr 16 13:35:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yii4s-0000RY-Ca
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 13:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757157AbbDPLfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 07:35:12 -0400
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:34509 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757143AbbDPLfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 07:35:07 -0400
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 102)
	id BD4A34A782; Thu, 16 Apr 2015 13:35:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <552F98AC.5030603@virtuell-zuhause.de>
X-Priority: none
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267278>

Hi,

sorry, I had sent the prior mail prematurely (hit wrong key)
and have been busy working on the resubmission...

On Thu, Apr 16, 2015 at 01:10:36PM +0200, Thomas Braun wrote:
> Am 16.04.2015 um 12:03 schrieb Andreas Mohr:
> > Hi all,
> > 
> > over the years I've had the same phenomenon with various versions of msysgit
> > (now at 1.9.5.msysgit.0, on Windows 7 64bit), so I'm now sufficiently
> > confident of it being a long-standing, longer-term issue and thus I'm
> > reporting it now.

(I've had experience with this issue as early as 1.7.x, I believe).


> (CC'ing msysgit)
> 
> Hi Andreas,
> 
> > Since I'm doing development in a sufficiently rebase-heavy manner,
> > I seem to aggregate a lot of objects.
> > Thus, when fetching content I'm sufficiently frequently greeted with
> > a git gc run.
> > This, however, does not work fully reliably:
> > 
> >     Auto packing the repository for optimum performance. You may also
> >     run "git gc" manually. See "git help gc" for more information.
> >     Counting objects: 206527, done.
> >     Delta compression using up to 4 threads.
> >     Compressing objects: 100% (27430/27430), done.
> >     Writing objects: 100% (206527/206527), done.
> >     Total 206527 (delta 178632), reused 206527 (delta 178632)
> >     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.pack' failed. Should I try again? (y/n) n
> >     Unlink of file '.git/objects/pack/pack-ab1712db0a94b5c55538d3b4cb3660cedc264c3c.idx' failed. Should I try again? (y/n) n
> >     Checking connectivity: 206527, done.
> > 
> > A workable workaround for this recurring issue
> > (such a fetch will fail repeatedly,
> > thereby hampering my ability to update properly)
> > is to manually do a "git gc --auto"
> > prior to the fetch (which will then succeed).
> 
> I've never had this issue. The error message from unlinking the file
> means that someone is still accessing the file and thus it can not be
> deleted (due to the implicit file locking on windows).
> 
> Can you reproduce the error reliably?

It seems to be reproducible pretty reliably,
at least once git thinks it needs to repack (initiated by a fetch operation, I think),
*and* then the unlink issue successfully turned up
(which may happen perhaps every 20 fetches of a *very* rebase-heavy workflow).


Interim mail content:

I strongly suspect that git's repacking implementation
(probably unrelated to msysgit-specific deviations,
IOW, git *core* handling)
simply is buggy
in that it may keep certain file descriptors open
at least a certain time (depending on scope of implementation/objects!?)
beyond having finished its operation (rename?).
As a related note, in an unrelated application of mine
I also encountered issues on Windows
where renaming of in-use files and further use of these files/names
then failed (error code was EACCES I believe).
IOW, this seems to be an issue specific to
Windows' "special" (and sometimes quirky) filesystem handling
which probably does not turn up on many "other" platforms,
thus a historic existing implementation weakness in git's repack handling
could not be nailed down in a sufficiently easy manner.




I think I may have the order wrong, however:
Handling seems to be:
- repack needed
- counting objects
- compressing
- writing
- unlink (delete) of all prior non-repacked objects (which fails)


I have to admit that at this point in time I'm actually unsure
which higher-level operation it actually is
that gets carried out where eventually a repack *implicitly* gets triggered
(I've got a shell script here which implements clean branch updating,
where I eventually hit the problem during its daily use).


Since a standalone git gc --auto *immediately* appears to work
(after many repeated attempts of failing full-update),
this is a strong hint that (in the failure case)
it's the *PRIOR* (non-repack) operation
which has kept these objects open beyond its actual operation scope.


Suspected implementation sample code:

if (operation_needed)
{
  operation_workingset set;

  set.DoStuff();

  if (repack_needed)
  {
    repack_handler repack;

     repack.DoStuff();
  }
}

[NOTE the very prominent scope issues in this example,
which might be the exact reason for hitting such unlink failures -
simply due to having kept file descriptors open within the working set]

I have not had a look at git source though
to actually determine whether there do exist
such severe operation scope issues
that I'm strongly contemplating.

Andreas Mohr
