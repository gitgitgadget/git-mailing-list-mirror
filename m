From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Possible to make a totally empty repository for remote access?
Date: Sat, 14 Jul 2007 04:19:41 +0200
Message-ID: <95A1FBFA-DCB7-4767-B857-89660822C6E6@wincent.com>
References: <54C69B03-C589-480E-80D3-75166DBF2D29@wincent.com> <7vtzs8lzgk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 04:20:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9XF8-00045K-Qa
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 04:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760025AbXGNCUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 13 Jul 2007 22:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbXGNCUB
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 22:20:01 -0400
Received: from wincent.com ([72.3.236.74]:46775 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757547AbXGNCUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jul 2007 22:20:00 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l6E2JvYZ009428;
	Fri, 13 Jul 2007 21:19:58 -0500
In-Reply-To: <7vtzs8lzgk.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52433>

El 14/7/2007, a las 0:18, Junio C Hamano escribi=F3:

> Note that the private working place does not have to be a clone
> of the empty one.  That actually is backwards.  Your work
> started from your private working place to the publishing one.

Thanks very much for the clarification, Junio. I didn't realize I =20
could push like that (thought it had to be from a clone); that's very =20
flexible indeed.

=46or the benefit of others who might stumble across this question in =20
the archives, the basic pattern is:

# create the bare, empty public repository on the remote server:
mkdir test.git
cd test.git
git --bare init
touch git-daemon-export-ok

# locally, create some initial content
mkdir test
cd test
git init
vi foobar # etc
git add .
git commit -s
git tag -s v0.0.1

# push initial contents
git push git.server.example.com:/pub/git/test.git master

This assumes that you have git-daemon set up to provide public read-=20
only access, and appropriate SSH accounts and configuration for those =20
who need write access, but that's all fairly well documented =20
elsewhere (ie in the git-daemon man page, and in abundant information =20
on the web about setting up SSH access with public-key auth).

To make such pushes easier in the future you can create a local =20
shortcut file, .git/remotes/shortcut (or similar), with contents like:

URL: git.server.example.com:/pub/git/test.git
Push: master

If other developers will have write access to the remote repo then =20
you can add "Pull:" statements as well so as to keep up to date (as =20
detailed in the git-push man page, and in the "Everyday GIT With 20 =20
Commands Or So" document: <http://www.kernel.org/pub/software/scm/git/=20
docs/everyday.html>), and you can synchronize multiple branches in =20
both directions by adding additional "Push:" and "Pull:" =20
declarations. With the shortcut file in place you could have written =20
the above push as:

git push shortcut

To push your initial tag you would do:

git push shortcut v.0.0.1

(Or you could have included the tag in the original push by passing =20
the --tags switch.)

One thing to note: the ".git/remotes/shortcut" file should not be =20
confused with the directories under ".git/refs/remotes".

=46inally, now that the remote repository actually has some content in =
=20
it you also have the option of just creating a fresh local clone of =20
it, and thus benefitting from the automatic set-up that "git clone" =20
does for you:

git clone git://git.server.example.com/test

The Git documentation is shockingly good; almost too good: there is =20
so much of it that sometimes it can be hard to find exactly what =20
you're looking for. For reference, the "Git core tutorial for =20
developers" was the one place which I could find which explicitly =20
talked about the missing piece of the puzzle: pushing from a private =20
repo (not a clone) to an empty public one:

<http://www.kernel.org/pub/software/scm/git/docs/core-tutorial.html>

Cheers,
Wincent
