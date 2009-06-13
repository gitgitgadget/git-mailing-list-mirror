From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH QGit RFC] Fix "Save patch..." on a commit range
Date: Sat, 13 Jun 2009 12:11:38 +0200
Message-ID: <200906131211.39361.markus.heidelberg@web.de>
References: <1244849357-31166-1-git-send-email-markus.heidelberg@web.de> <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 12:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFQDC-00039F-DU
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 12:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756121AbZFMKLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 06:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752162AbZFMKLg
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 06:11:36 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:43524 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967AbZFMKLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 06:11:36 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id B89FF1032E1A8;
	Sat, 13 Jun 2009 12:11:37 +0200 (CEST)
Received: from [89.59.112.3] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1MFQD3-000397-00; Sat, 13 Jun 2009 12:11:37 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <e5bfff550906130013j3a9802cen48ac5828a2357bf1@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18Y3H7g1agE/OeyiU7tujxLski+uZ3G8uWiWEt5
	3BUPNC0Kp2dSU79WKoX6yH6AuLcYwDGw6Kr9BF9scE/yeVVJwM
	PiGC9qh7VwHqLf97KvZg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121490>

Marco Costalba, 13.06.2009:
> On Sat, Jun 13, 2009 at 00:29, Markus
> Heidelberg<markus.heidelberg@web.de> wrote:
> > Creating a patch series didn't work, because the SHA1 list was
> > interpreted in the wrong order.
> >
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> 
> I think they are generated in apply order as should be.
> 
> As example, from git repo we have the following revisions:
> 
> GIT 1.6.3
> t4029: use sh instead of bash
> t4200: convert sed expression which operates on non-text file to perl
> t4200: remove two unnecessary lines
> 
> Now if I select the 4 revisions and use "Save patch..." I have
> 
> 0001-t4200-remove-two-unnecessary-lines.patch
> 0002-t4200-convert-sed-expression-which-operates-on-non.patch
> 0003-t4029-use-sh-instead-of-bash.patch
> 0004-GIT-1.6.3.patch
> 
> That is correct because if I go to apply the patches I have to apply
> in the reverse cronological order, from the oldest to the newest.

Sorry, I didn't describe the problem proper. The problem was not about
the order of the created patches - it's that I can't create multiple
patches at all.

If I only select 1 revision and use "Save patch..." I get
0001-xyz.patch, which is correct.

But if I select 2 or more revisions, I don't get any patch file.

For example, with the following DAG:

    A---B---C---D---E

If I select B to D and use "Save patch...", Qgit creates the following
command:

    git format-patch -o /home/markus D^..B

but D^..B obviously is empty.

My patch now changes it, so that this command is produced:

    git format-patch -o /home/markus B^..D

which generates 3 patches.


OK, that was the state from yesterday. While testing a bit more, I can
notice some really strange behavior:

I managed to get the following shaList in Git::formatPatch(): D, B, C
which led to this revision range in the command: C^..D
which produced 2 patches.

After several tests it seems as if the revisions C and D are always the
first and last of the shaList variable, if they are included in the
selection. Selecting only the first and last revision with
Ctrl+LeftMouse instead of all including the ones in between with
Shift+LeftMouse works.

Hmm, I will look some more into it...

Markus
