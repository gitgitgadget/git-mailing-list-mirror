From: Nicolas Pitre <nico@cam.org>
Subject: Re: Are binary xdeltas only used if you use git-gc?
Date: Mon, 03 Nov 2008 16:42:12 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811031611060.13034@xanadu.home>
References: <f1d2d9ca0810310243r669840bbj2c5ee7183e0caaed@mail.gmail.com>
 <m37i7pggnk.fsf@localhost.localdomain>
 <f1d2d9ca0810310428o166dc075wbb43c00c1a555350@mail.gmail.com>
 <200810311726.57122.jnareb@gmail.com> <vpqej1wra1c.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0810311549570.13034@xanadu.home>
 <f1d2d9ca0811010454u203a7c88x1e09735b3fc1358f@mail.gmail.com>
 <alpine.LFD.2.00.0811010924550.13034@xanadu.home>
 <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Thanassis Tsiodras <ttsiodras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 22:43:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx7DD-00084u-Ij
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 22:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448AbYKCVmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 16:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752381AbYKCVmh
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 16:42:37 -0500
Received: from relais.videotron.ca ([24.201.245.36]:65479 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbYKCVmh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 16:42:37 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K9S0003S1MC2L00@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 03 Nov 2008 16:42:13 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <f1d2d9ca0811031235w3581f7ffnc7380b4cb488e71a@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99998>

On Mon, 3 Nov 2008, Thanassis Tsiodras wrote:

> Despair...
> 
> I just tested "git push --thin"...
> Doesn't work.
> 
> It still sends the complete object, not a tiny pack as it could (should).
> 
> But perhaps I now understand why:
> 
> I run git-gc on both the remote end and the working end (before
> changing anything,
> i.e. with both repos being in sync - "git pull" and "git push" report all OK).
> I then noticed that on the remote side, .git/objects/pack had one big pack file,
> but on the local one I have two .pack files...!
> 
> I proceeded to try (many combinations of params on) git-repack in a vain attempt
> to make my local repos also have one single .pack file (presumably, it
> should be able
> to exactly mirror the remote one, since it has the same objects inside
> it!). No way...

Please stop thinking that your repository layout has anything to do with 
what is actually transferred on a push.  It has not.

Here's a small test that you can do locally:

	mkdir repo_a
	mkdir repo_b
	cd repo_a
	git init
	seq 1000000 > data
	git add data
	git commit -m "initial commit"
	cd ../repo_b
	git init
	cd ../repo_a
	git push ../repo_b master:master

Here you should see a line that says:

	Writing objects: 100% (3/3), 2.01 MiB, done.

Therefore 2.1 MiB were transferred.  Now let's continue:

	echo "foo" >> data
	git add data
	git commit -m "second commit"
	git push ../repo_b master:master

You should get:

	Writing objects: 100% (3/3), 423 bytes, done.

And this means that you even don't need the --thin switch (which is 
wrong -- this has been broken before but that's another story) for the 
transfer to actually send only the difference and not the whole file 
again.  And note that none of those repositoryes actually contain any 
pack as everything is still loose objects.

> I'm at a loss as to why the two repos are having different "pack 
> representation" of the same objects

That's only because those objects entered each repositories in a 
different way.

> and why git-gc and git-repack fail 
> to create a single pack on my working side,

Maybe you have a .keep file in .git/objects/pack/ ?  If so delete it and 
run 'git repack -a -d'.

> but I'm guessing that this is why "git push --thin" fails to send 
> small xdeltas...

Not at all.

Please provide a complete log of your tests and maybe we could find 
something.


Nicolas
