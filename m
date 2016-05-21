From: greened@obbligato.org (David A. Greene)
Subject: Re: Subtree split unsquashes everything
Date: Sat, 21 May 2016 18:26:35 -0500
Message-ID: <87a8jjouvo.fsf@waller.obbligato.org>
References: <CAKRjdd7Czj2iTKdwVCmz4x9fDNKCPZtLi=UjgHOsSPuYL_yLXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Joseph Musser <me@jnm2.com>
X-From: git-owner@vger.kernel.org Sun May 22 01:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4GI9-0003K7-03
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 01:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbcEUX0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2016 19:26:38 -0400
Received: from li209-253.members.linode.com ([173.255.199.253]:57872 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751600AbcEUX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2016 19:26:37 -0400
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.86)
	(envelope-from <greened@obbligato.org>)
	id 1b4GI0-0004Io-2n; Sat, 21 May 2016 18:26:36 -0500
In-Reply-To: <CAKRjdd7Czj2iTKdwVCmz4x9fDNKCPZtLi=UjgHOsSPuYL_yLXg@mail.gmail.com>
	(Joseph Musser's message of "Sat, 14 May 2016 12:53:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295251>

Joseph Musser <me@jnm2.com> writes:

> I ran `git subtree split -P=subdir/subdir/ -b newbranch` and the
> outcome seems to be perfect except that each squash merge has turned
> into a full merge, bringing along all history from the other repo. Why
> does it do this and how can I preserve my repo history, including only
> squashes from the subtree remote repo like it is today?

The only thing that --squash does on an add/merge/pull is a read-tree of
the fetched commit into a new commit in the host repository which is
then merged in to the host repository's branch.  It also annotates the
hash of the original commit in the git-subtree-split metadata.

As the split code processes commits it records parents to link up the
history to that in the subtree's original repository.  Crucially, the
git-subtree-split metadata of the commit message git-subtree creates for
squashes lists the original commit ID of the squashd commit.  That lets
git-subtree hook up split commits back to the original project history.
I believe that's why the split branch is showing the full history.  It's
baked into the split algorithm.

Presumably you split the subdirectory from the same working repository
in which you added the subtree commits in the first place.  Thus the
history of the original project is all there (it was fetched when the
subtree was added/merged).  I have not tested this, but I wonder what
would happen if you either deleted that history from the host repository
or you cloned the host repository to a new place and tried the split
there.  The original hisory wouldn't be there and git-subtree would not
have it to hook up to.

I have mentioned before that I'm working on a complete overhaul of the
split code.  Since git-subtree split it typically used to send commits
back to the original subtree repository, I never imagined that someone
would *not* want to get the original history back.  If the squash were
not reversed we would not be able to merge the history back in to the
original repository.  If keeping squashes is truly desired I will have
to think about how to do that, likely as a non-default option to split
or even an entirely different command.

                      -David
