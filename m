From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Fri, 31 Oct 2008 15:47:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0810311531540.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <20081031110245.GA22633@artemis.corp>
 <f1d2d9ca0810310416n1e9f3700if49951a05cae9a37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Thanassis Tsiodras <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 20:49:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvzzm-000423-Ca
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 20:49:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751883AbYJaTsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 15:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbYJaTsH
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 15:48:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47267 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751284AbYJaTsF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 15:48:05 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9M00ERCCAWH1T0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 31 Oct 2008 15:47:20 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <f1d2d9ca0810310416n1e9f3700if49951a05cae9a37@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99627>

On Fri, 31 Oct 2008, Thanassis Tsiodras wrote:

> Actually, after using git-gc, git-repack isn't really needed...
> git-gc identifies that the two files are very similar and re-deltifies
> (see the du -s -k outputs in the original mail, after git-gc we have
> in fact lower usage than the first commit).

git-gc does call git-repack already.  In fact, git-gc is only a 
convenience wrapper for a couple maintenance commands.

> My question is basically...
> (a) why doesn't git detect this during commit and needs a git-gc

Because we want commit operations to be fast. One of many usage 
scenarios for git is to apply a large amount of patches in one go, 
meaning many commits per second.  The gc operation is potentially long, 
can be done unfrequently and deferred any time, like when you don't have 
to wait for it.

> (b) whether after git-gc I would have seen the massive difference
> during a subsequent git-push or not

No.  A push does create a pack with best size reduction already, whether 
or not your local or remote repositories are already packed.  The only 
advantage for having your local repository packed is in the time 
required to create that same pack to be pushed.

As mentioned already, you should consider the --thin switch if you are 
pushing over a slow link.  If the remote repository already has 
necessary objects then all the pushed pack will contain is all deltas.

The reason why --thin is not activated by default is because most people 
do pulls from a central server and only few people do pushes to such a 
server, and while thin packs do reduce the transmission size they do 
create slightly bigger packs on the receiving end which is best avoided 
on a busy server.


Nicolas
