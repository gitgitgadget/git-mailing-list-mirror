From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: pack operation is thrashing my server
Date: Sun, 10 Aug 2008 20:04:44 -0700
Message-ID: <20080811030444.GC27195@spearce.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ken Pratt <ken@kenpratt.net>
X-From: git-owner@vger.kernel.org Mon Aug 11 05:06:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSNjE-0002Gr-7w
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 05:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbYHKDEq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 23:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbYHKDEp
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 23:04:45 -0400
Received: from george.spearce.org ([209.20.77.23]:54945 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753828AbYHKDEp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 23:04:45 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A0D0938375; Mon, 11 Aug 2008 03:04:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91913>

Ken Pratt <ken@kenpratt.net> wrote:
> I'm having memory issues when trying to clone a remote git repository.
> 
> The remote repository is bare, and is 180MB in size (says du), with
> 1824 objects. The remote (VPS) server is running git version 1.5.6.4
> on Arch Linux on a x86_64 Opteron with 256MB of dedicated RAM.
> 
> PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> 21782 kenpratt  20   0  444m 212m  272 D    3 83.0   0:04.98 git-pack-object

Well, clearly the server is swapping at this point.  212m resident
for this git-pack-objects process leaves no room available for
anything else.  Git is using too much memory for this system.
 
> I've tried very conservative pack settings:
> 
> [pack]
>         threads = 1
>         windowmemory = 64M
>         deltacachesize = 1M
>         deltacachelimit = 1M

Have you tried something like this?

	[core]
		packedGitWindowSize = 16m
		packedGitLimit = 64m

	[pack]
		threads = 1
		windowMemory = 64m
		deltaCacheSize = 1m

On a 64 bit system packedGitWindowSize and packedGitLimit have very
large thresholds which will cause it to mmap in the entire pack file.
You may need to try even smaller settings than these; 256m physical
memory isn't a lot when dealing with a repository 180m in size.
Especially on a 64 bit system.

-- 
Shawn.
