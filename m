From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 23:37:58 +0100
Message-ID: <24A6A8D6-EED9-4E30-AE4C-125F98A7F6A3@orakel.ntnu.no>
References: <478E1FED.5010801@web.de> <alpine.LSU.1.00.0801161531030.17650@racer.site> <427BE4FD-6534-4CB2-91F8-F9014DC82B54@sb.org> <alpine.LSU.1.00.0801161629580.17650@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Mark Junker <mjscod@web.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHOG-0001fA-Hg
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbYAPXJT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbYAPXJT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:09:19 -0500
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:53194 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751384AbYAPXJS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:09:18 -0500
X-Greylist: delayed 1874 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2008 18:09:17 EST
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id E8F796411FB;
	Wed, 16 Jan 2008 23:37:59 +0100 (CET)
In-Reply-To: <alpine.LSU.1.00.0801161629580.17650@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70765>

On 16. jan.. 2008, at 17.32, Johannes Schindelin wrote:

>>> FWIW the issue is that Mac OS X decides that it knows better how to
>>> encode your filename than you could yourself.
>>
>> More like, Mac OS X has standardized on Unicode and the rest of the
>> world hasn't caught up yet. Git is the only tool I've ever heard of =
=20
>> that
>> has a problem with OS X using Unicode.
>
> No.  That's not at all the problem.  Mac OS X insists on storing =20
> _another_
> encoding of your filename.  Both are UTF-8.  Both encode the _same_
> string.  Yet they are different, bytewise.  For no good reason.
>
> Stop spreading FUD.  Git can handle Unicode just fine.  In fact, Git =
=20
> does
> not _care_ how the filename is encoded, it _respects_ the user's =20
> choice,
> not only of the encoding _type_, but the _encoding_, too.

"FUD" is a bit strong, don't you think?  HFS+ is the way it is and it =20
would be nice if Git could deal with it.

The problem is that HFS+ normalizes filenames to avoid multiple files =20
that appear to have the same name (eg "M<A WITH UMLAUT>rchen" vs =20
"Ma<UMLAUT MODIFIER>rchen", in gitweb/test).  This is sort of like =20
case sensitivity, but filenames are normalized when a file is =20
_created_.  Git, not unreasonably, expects a file to keep the name it =20
was created with.

As far as I can tell, as long as you add all your internationally =20
becharactered files to git from an HFS+ file system using a gui or =20
command-line completion, you'll be okay; trouble starts when you check =
=20
in a file with the composed form of a character, by typing the name on =
=20
the command line (I'm not sure about this one) or committing on =20
another OS.  Git will store the filename in composed form, but the =20
Mac's filesystem will decompose the filename when you check the file =20
out.

The result looks like this:

vredefort:[git]% git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	gitweb/test/M=E4rchen
nothing added to commit but untracked files present (use "git add" to =20
track)

(this is directly after checking out git.git @ v1.5.4-rc3)

There are two things to note here.  One is that Git thinks that there =20
is a new file called "gitweb/test/M=E4rchen" (decomposed) when it's =20
"really" just the same "gitweb/test/M=E4rchen" (precomposed) that's in =
=20
the repository.  The other is that git _thinks_ that the "gitweb/test/=20
M=E4rchen" (precomposed) it's expecting is still there, because the =20
filesystem, when asked for "gitweb/test/M=E4rchen" in any form will =20
return the file "gitweb/test/M=E4rchen" (decomposed).

Trying to check out the "next" branch at this point is a pain since =20
next's "M=E4rchen" would overwrite the untracked "M=E4rchen".

I can't provide links to any previous discussions about this, but =20
here's Apple's Technical Q&A on the subject:

http://developer.apple.com/qa/qa2001/qa1235.html

=46inding a sane way of allowing git to handle this behaviour is left a=
s =20
an exercise for the reader.

Eyvind Bernhardsen
