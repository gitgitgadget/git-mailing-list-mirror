From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: sharing object packs
Date: Thu, 19 Jun 2008 05:01:30 -0400
Message-ID: <20080619090129.GJ11793@spearce.org>
References: <20080618195726.GA20440@kernoel.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: marc.zonzon+git@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 19 11:02:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9G2H-0001DT-UI
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 11:02:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYFSJBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 05:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751709AbYFSJBf
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 05:01:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42866 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbYFSJBd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 05:01:33 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9G1J-0007Qh-CZ; Thu, 19 Jun 2008 05:01:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0D39B20FBAE; Thu, 19 Jun 2008 05:01:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080618195726.GA20440@kernoel.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85461>

marc.zonzon+git@gmail.com wrote:
> I have a big bare repository 'main.git' and many small git repositories sub1, sub2, ... subn.
>
> All repositories lie in the same file file system, and each subx
> repository track and fetch main.git in a remote branch.
>
> I would like to avoid duplicating main.git objects
...
> - Using an objects/info/alternates with the path of main.git object repository.
> It work well too, but I import objects from main.git inside subx,
> and they don't have the same life time than those in main.git. So
> they can, disapear during a git-prune-packed or gc. (The same
> problem we have with: git clone --share)

This is the approach you want to use.  The risk is that you do
not allow objects to be added to main.git to later be deleted from
main.git.  This means main.git cannot rewind/reset/delete a branch.

If that is not acceptable perhaps you could instead create 3 tiers:

	main.git ---
	            \
	            shared.git
	            /
	subx.git ---  

Have main.git and subx.git both use shared.git as an alternate
(place path of shared.git/objects in their objects/info/alternates).
You can still allow subx.git to fetch main.git.

Push only stable commits to shared.git that will never be
rewind/reset/deleted.  Once something enters shared.git it should
never be deleted.  This way shared objects will not be removed by
git-prune or git-gc.  Every so often push newer stable branches from
main.git to shared.git, once they cannot be rewind/reset/deleted.

Repack main.git and subx.git using `git gc` as that includes the
-l flag to `git repack`.  Any objects which are now available from
shared.git will not be included in main.git or subx.git, so their
usage will shrink after shared.git is updated.


If you also configure gc.packrefs to never in shared.git and
symlink shared.git/refs into main.git/refs/shared and also into
subx.git/refs/shared and do this configuration on both server and
client systems you can have everyone transfer only the minimal
objects necessary.

I use basically that arrangement at day-job to avoid 7 copies of
roughly 150 MB of shared history across 8 repositories.  This
reduces the amount of data the OS needs to store in buffer cache
by nearly 1050 MB and thus makes things run rather quickly.  (Yes,
many operations hit all 8 repositories in rather rapid succession,
its a submodule sort of arrangement.)

-- 
Shawn.
