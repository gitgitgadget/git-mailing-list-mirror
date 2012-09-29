From: Chris Webb <chris@arachsys.com>
Subject: Re: [RFC PATCH] add t3420-rebase-topology
Date: Sat, 29 Sep 2012 09:08:06 +0100
Message-ID: <20120929080805.GN2792@arachsys.com>
References: <1347949878-12578-1-git-send-email-martinvonz@gmail.com>
 <50582873.603@viscovery.net>
 <CANiSa6i+A6fkWpkPMXiBRdT48LaSfPe2yki+AmWFAKYg02p=+g@mail.gmail.com>
 <20120927122035.GL16059@arachsys.com>
 <CANiSa6hvs2253yb4s0PpaAfG=hoBK2psP896GMFWT-UjiPZDwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 10:09:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THs78-0000SW-8d
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 10:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758695Ab2I2IJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 04:09:04 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:54710 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222Ab2I2IIL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 04:08:11 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.80)
	(envelope-from <chris@arachsys.com>)
	id 1THs5o-0001cn-AM; Sat, 29 Sep 2012 09:08:09 +0100
Content-Disposition: inline
In-Reply-To: <CANiSa6hvs2253yb4s0PpaAfG=hoBK2psP896GMFWT-UjiPZDwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206644>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> For consistency, it seems like "git rebase -p --root" should always be
> a no-op, while "git rebase [-i/-m] --root" should be no-op if the
> history has no merges. Also, since "git rebase -i" tries to
> fast-forward through existing commits, it seems like "git rebase -i
> --root" should ideally not create a sentinel commit, but instead stop
> at the first commit marked for editing.
> 
> If, OTOH, --force-rebase is given, we should rewrite history from the
> first commit, which in the case of --root would mean creating a
> sentinel commit.
> 
> So, in short, I have a feeling that the sentinel commit should be
> created if and only if both --root and --force-rebase (but not --onto)
> are given.
[...]
> So I'm getting more and more convinced that the sentinel commit should
> only be created if --force-rebase was given. Let me know if I'm
> missing something.

No, that sounds fairly convincing to me. Personally, the only behaviour I
want to be able to get at without --force-rebase is for rebase -i --root to
allow the root commit to be dropped, edited or reworded, and commits to
reordered to make a different one the root, in the same way as normal
interactive rebase does for later commits.

The least intrusive implementation for rebase --root was the unconditional
sentinel, but as you say, you don't need it (and it's a bit surprising) if
the root commit on the instruction sheet is the same as the original root:
in the edit/reword case, you could just checkout the existing root and then
drop out in the normal way. You only really need the sentinel to deal with
the possibility of a conflict if the root is replaced with a different
commit.

I think I agree with you it would be better only to create the sentinel on
demand when it's required or if --force is given.

Cheers,

Chris.
