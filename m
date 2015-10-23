From: Kevin Daudt <me@ikke.info>
Subject: Re: git-cherry doesn't detect a "copied" commit
Date: Fri, 23 Oct 2015 12:57:56 +0200
Message-ID: <20151023105756.GB12622@ikke.info>
References: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 12:58:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zpa2t-0006Rv-0F
	for gcvg-git-2@plane.gmane.org; Fri, 23 Oct 2015 12:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbbJWK57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2015 06:57:59 -0400
Received: from ikke.info ([178.21.113.177]:58034 "EHLO vps892.directvps.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbbJWK56 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2015 06:57:58 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1001)
	id F14944400AE; Fri, 23 Oct 2015 12:57:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAC9WiBhM4edBFCYx35xZJB79AZWo49mkO-Pxnb1q4aLDmBufWQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280090>

On Tue, Oct 20, 2015 at 06:32:12PM +0200, Francis Moreau wrote:
> Hi,
> 
> I'm seeing something odd with git-cherry: it doesn't seem to detect
> that a commit has been cherry-picked from master branch.
> 
> This happens with the systemd git repository (from github) so it
> should be fairly simple to reproduce.
> 
> What I did:
> 
> $ git --version
> git version 2.6.0
> $ git checkout -b foo v210
> $ git cherry-pick -x 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
> $ git branch --contains 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f
> master
> $ git cherry master HEAD
> + fef60bf34d1b372bea1db2515a8d936386dfc523
> 
> so git-cherry tells me that the cherry-picked commit has not
> equivalent in master, which is no the case.
> 
> What am I missing ?
> 

Let's see:

  $ git show | git patch-id 
  50c9f9548e1fd25401ff9540c82c1d5f9723c3d5 b4c86d2965aaf0736e4ab30be1d1a08931009a08

  $ git show 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f | git patch-id
  a5cfbb542882bd9cbe192b43026354d1f2741673 9ea28c55a2488e6cd4a44ac5786f12b71ad5bc9f

Git patch-id calculates the hash over the diff, and, when gives in this
case two hashes, first the patch-id and the second the commit hash.

The patch-ids are different, explaining why git cherry does not see them
as equivalent. If I take a diff of the diff, I notice something:

   diff --git a/src/udev/udevadm-settle.c b/src/udev/udevadm-settle.c
  -index 927ea2a..65fc35f 100644
  +index b026155..ea9b078 100644
   --- a/src/udev/udevadm-settle.c
   +++ b/src/udev/udevadm-settle.c
   @@ -41,42 +41,28 @@
  @@ -1094,7 +1094,7 @@
                            exit(EXIT_SUCCESS);
   @@ -102,44 +85,13 @@ static int adm_settle(struct udev *udev, int argc, char *argv[])
                    default:
  -                         assert_not_reached("Unknown argument");
  +                         assert_not_reached("Unkown argument");
                    }
   +        }

If you look at the lines with assert_not_reached, it seems there is a
difference in the context of both diffs, causing the diffs to be
different.

Hope this helps, Kevin
