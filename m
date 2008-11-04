From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 03 Nov 2008 20:18:37 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811031959070.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
 <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
 <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
 <f1d2d9ca0811031453p49390911p956149ca76b9b80d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thanassis Tsiodras <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 04 02:20:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxAaM-0000KM-IO
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 02:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbYKDBSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 20:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754202AbYKDBSo
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 20:18:44 -0500
Received: from relais.videotron.ca ([24.201.245.36]:18101 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918AbYKDBSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 20:18:44 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9S006MVBLYVFH0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Nov 2008 20:17:58 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <f1d2d9ca0811031453p49390911p956149ca76b9b80d@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100021>

On Tue, 4 Nov 2008, Thanassis Tsiodras wrote:

> RESOLVED!!!
> 
> Finally...
> What happened was actually quite reasonable, in hindsight...
> As I said in the original mail, this was what I did:
> 
> cp version7.1.tar version7.2.tar
> git add version7.2.tar
> git commit -m "same data as old, so git will use old blob"
> echo MAGICPLACE read below...
> cp /path/to/work/realNewVersion7.2.tar version7.2.tar
> git add version7.2.tar
> git commit -m "and now, commit the really new version, so git can xdelta"
> git push --thin
> 
> The problem was solved (that is, the "git push" became optimal,
> when I added a "git push" right after the MAGICPLACE mark above...
> In that way, the remote repo learned about the "dummy" commit that
> referenced the old blob... and when I did the subsequent "git push"
> at the end, the remote side could see that it already had this "dummy"
> commit to "xdelta on", and that it only needed the delta...
> 
> Originally, when I used only one "git push --thin" at the end, the remote
> side didn't have the "dummy" commit, so it probably said: "I can't
> apply a delta, give me the full object".

Oh! But of course...

In fact, the way thin packs work is to store delta against a base object 
which is not included in the pack.  Those objects which are not included 
but used as delta base are currently only the previous version of a file 
which is part of the update to be pushed/fetched.  In other words, there 
must be a previous version under the same name for this to work.  Doing 
otherwise wouldn't scale if the previous commit had thousands of files 
to test against.

But this particularity had escaped my mind somehow.

> Phew.
> 
> So it seems that if you must introduce a new file that is
> very similar to an existing one (in my case, a new version
> of software kept in an uncompressed .tar file),
> you have to do what I did above to allow for optimal "git push"es:
> that is:
> 
> 1. Create the new filename by just copying the old
>  (so the old blob is used)
> 2. commit
> 3. PUSH
> 4. copy the real new file
> 5. commit
> 6. PUSH.
> 
> If you omit the middle PUSH in step 3, neither "git push", nor "git push --thin"
> can realize that this new file can be "incrementally built" on the remote side
> (even though git-gc totally squashes it in the pack).

Right.  Those thin packs were designed for different versions of the 
same file in mind, not different files with almost the same content.  
This could possibly be improved at some point...


Nicolas
