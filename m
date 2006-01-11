From: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: RFC: Subprojects
Date: Wed, 11 Jan 2006 20:43:43 +0100
Message-ID: <43C55FEF.2090108@hogyros.de>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de> <43C537C9.4090206@hogyros.de> <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98CF4E7E29B83834C4B42BB8"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 20:46:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwltE-0004Rf-BG
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 20:44:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWAKTn5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 14:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWAKTn5
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 14:43:57 -0500
Received: from kleinhenz.com ([213.239.205.196]:50892 "EHLO kleinhenz.com")
	by vger.kernel.org with ESMTP id S964797AbWAKTn4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2006 14:43:56 -0500
Received: from [192.168.115.35] (p5499772B.dip.t-dialin.net [84.153.119.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Simon Richter", Issuer "Kleinhenz Elektronik CA" (verified OK))
	by kleinhenz.com (Postfix) with ESMTP id 26A194A8045;
	Wed, 11 Jan 2006 20:43:51 +0100 (CET)
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
X-Enigmail-Version: 0.93.0.0
OpenPGP: url=http://www.hogyros.de/simon.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14505>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98CF4E7E29B83834C4B42BB8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Linus Torvalds wrote:

> Turning a _snapshot_ of a subproject into a subdirectory is easy: you can 
> literally just create a subdirectory, copy it there, and it will re-use 
> all the objects that the subproject uses (ie the top-level project will 
> have a "tree" entry that just points to the same tree entry as the 
> top-level commit in the sub-project).

Exactly. My proposal is to allow the tree object to point to the 
toplevel commit object directly, thus importing the entire project[1].

> However, while that works as a way to import snapshots, it doesn't work in 
> any other way. It allows you to share objects with the "real project", and 
> it's space-efficient etc, but there's no shared history, and you cannot 
> merge back-and-forth, which is probably what you really want to do.

Well, the history cannot be really shared, as turning subtrees to 
projects and vice versa is a valid use case (and in fact something I do 
pretty often in my projects, as various "helper" classes evolve into 
"utility" libraries). Since the subproject needs to be self-contained, 
the history before it became a separate project will be difficult to 
represent, to say the least.

> Quite frankly, you really probably want more of a "git-aware symlink" kind 
> of thing. I'd really hesitate (in fact, I'd object) to re-use the existing 
> "tree" type for it, but you're not the only one to have asked for 
> subproject support, so this is clearly not a odd request.

[...]

> What we _could_ do is for you to first do a commit in the "independent" 
> subproject (it really would be a totally independent git repository in all 
> ways: you could continue to merge it with other subprojects of the same 
> type), and then you could commit a new pointer to that subproject in the 
> master project. 

Exactly. The questions I posed in the last paragraph of the initial 
mail, rewritten for clarity, would be
  - "should cg-commit automatically create a commit in the master 
project when a change in the subproject is committed?", and
  - "should cg-commit automatically commit all changes to subprojects 
when a path that has been listed on the command line contains a 
subproject?".

There are three cases, basically:

  - change to subproject, part of a larger set of changes, not ready for 
prime time: A commit in the subproject, master left alone (obviously, 
the directory would show as "modified".
  - change to subproject, fixing a bug that affects the master project. 
You'd expect these to happen often, as I could fix stuff that the master 
doesn't care about in another tree. In this case, you'd want a new 
commit to happen in the master as well, for everyone to enjoy.
  - change to subproject and master that need to go in sync, like 
renaming a configure option. Obviously, this can also happen after an 
update of the subproject, so creating a new commit on the master after 
an update is bad, but normal behaviour for update would be to merge and 
create a commit instantly if there were no conflicts.

> The two would really be fundamentally independent: they'd be two different 
> git projects, one would just have a strange kind of "symlink" to the 
> other, which would include a name and the top commit SHA1 of the other 
> project.

Well, that would be exactly what the tree contains. One could do an 
additional level of indirection with another object that just points to 
an sha1 (because its name is given by the tree referencing it).

Having such an object would mainly have the advantage of being extensible.

> I'd suggest adding a new kind of object ("gitlink") which has some 
> well-specified format (20-byte SHA1 + ASCII C string "name" - the name 
> translation to external repository would be done in the .git/config file 
> of the "outer" project).

Well, most people would likely not care about the external repository of 
the subproject, as they can get all the objects from the master project. 
I'm not even sure the subproject needs an "origin" branch by default, as 
you can push changes to the master project's maintainers who would then 
eventually push them on to the subproject's maintainers (in fact I 
believe it's vital to be able to keep changes to the subproject in the 
master project so development can go on while the subproject maintainers 
review the changes.

> Then a special file mode to indicate that in the 
> "struct tree", and support for "git-update-cache" to understand how such 
> an object is really tied into the "<pathname>/.git/HEAD" file rather than 
> the rest of the directory contents.

That sounds pretty simple actually.

> Then a "git fetch" would have to be taught to recursively fetch the other 
> subproject when the "gitlink" changes.

I think that would be mostly implicit if we were to use a direct 
tree->commit reference, but can be implemented trivially even for the 
link objects.


> It should be doable: somebody could try to implement a rough first draft 
> (maybe not very seamless at first).

Indeed. I just wanted to have rough use cases thrown at me before I even 
think of implementing something like it.

    Simon

[1] There is a slight problem with that approach: When you cherry-pick 
changes into a subproject (like I did today with the asm-arm/uaccess.h 
constness fix), the subproject will have a separate branch whose head is 
known to the outer project only. When the subproject gets merged with 
its origin later, that branch is no longer needed, and it makes a lot of 
sense to have the master project reference origin again. This means that 
if you look at the history of the inner project from the POV of the 
outer, the new commit is no longer a descendant of the old, but in fact 
it may be a good idea to attempt a fast-forward merge nevertheless as 
going through the common ancestor is very likely to cause conflicts 
here, and those conflicts have already been resolved, or you wouldn't be 
seeing an updated subproject link (i.e. you just want to preserve local 
changes and stuff committed on top of the old reference).

--------------enig98CF4E7E29B83834C4B42BB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iQCVAwUBQ8Vf8lYr4CN7gCINAQIglQP9EGknkhgLZ567wF7Fsvz7ZYWVBKLXALCu
nurv3pig0WV/p+W5wkKj7bnVAzrF1x36kpD6DbNScCJzMMaFsHeHYurzEX59orvK
Ed+WYA0K5Z3jy1wIfmCmegz8Nu9eKU0wX+R2sz6dVAkEtaP6cfluN7NlQmoNsof5
lpvC6EHbgdE=
=4Vj4
-----END PGP SIGNATURE-----

--------------enig98CF4E7E29B83834C4B42BB8--
