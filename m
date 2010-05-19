From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: ok to delete tmp_pack file(s)? also, backing up a git repository
Date: Wed, 19 May 2010 19:56:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005191935400.12758@xanadu.home>
References: <loom.20100520T010426-277@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Adam Monsen <haircut@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 20 01:56:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEt86-0000uq-A5
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 01:56:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0ESX4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 May 2010 19:56:45 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46643 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0ESX4o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 May 2010 19:56:44 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L2O00GL6YIJA410@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 May 2010 19:56:43 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <loom.20100520T010426-277@post.gmane.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147354>

On Wed, 19 May 2010, Adam Monsen wrote:

> I backup my remote git repositories on sf.net using "rsync -a REMOTE
> LOCAL". I chose rsync instead of clone --mirror/fetch because I wanted
> hook scripts, "description", and "config" backed up.
> 
> I got the following error from my backup cron job:
> 
>         rsync: send_files failed to open
>         "/mifos/head/objects/pack/tmp_pack_IcK2CZ" (in gitroot):
>         Permission denied (13)
> 
> So, fine, I can't reach that file. Looks like a temp file--I think I did
> a CTRL-C during a push, so maybe that's what caused it to be left
> around. A few questions:
> 
>      1. Should I just ignore "objects/pack/tmp_pack_*" file in my rsync
>         backup?

Yes.

>      2. Should I shell into sf.net and run "git gc" on the repository?
>         or "git repack"? or something else?

The command which removes stall tmp files after a grace period is 'git 
prune'.  This is normally run amongst other things by 'git gc'.

>      3. Is rsync a bad idea? For instance, is the backup useful even if
>         rsync was running while someone was doing a "git push" into the
>         repository being backed up?

If you want your rsync backup to be fine, you need to follow some 
ordering.  You need to copy the refs first (.git/packed-refs and 
.git/refs/), then the loose objects (.git/objects/??/*), and then all 
the rest.  If files are copied in a different order while some write 
operations are performed on the source repository then you may end up 
with an incoherent repository.

>      4. Anyone have different rsync options to recommend for optimal
>         backup of a git repository?

The optimal backup of a git repo is performed by git itself.  Due to 
repacking, the pack files are likely to change over time which will 
completely defeat rsync's ability to transfer only differences to a file 
when updating your backup.  Git will always transfer the minimum of 
information to replicate a repository's _content_ even if the actual 
repository files aren't identical on both ends, plus you get some SHA1 
validation of the transferred data for free.  But if your repository is 
quiet and you don't mind the extra transfer size then rsync should work 
just fine.

> Thank you!
> -Adam
> 
> PS - git rocks... our benefits since migrating from svn are numerous:
> * remote folks (UK, India, Africa, etc.) are quite happy with the speed
> increase
> * branching and merging just works
> * examining logs/forensics is much easier and faster
> * lots more, but I gotta grab me some lunch
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
