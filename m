From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 7 Jul 2009 12:17:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907071142330.3210@localhost.localdomain>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 21:18:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOGB5-0006bM-Km
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 21:18:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754209AbZGGTSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jul 2009 15:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZGGTSA
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 15:18:00 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43109 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751740AbZGGTR7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jul 2009 15:17:59 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n67JHkVb009856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Jul 2009 12:17:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n67JHk0p007813;
	Tue, 7 Jul 2009 12:17:46 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122860>



On Mon, 6 Jul 2009, Junio C Hamano wrote:
>=20
> * lt/read-directory (Fri May 15 12:01:29 2009 -0700) 3 commits
>  - Add initial support for pathname conversion to UTF-8
>  - read_directory(): infrastructure for pathname character set
>    conversion
>  - Add 'fill_directory()' helper function for directory traversal
>=20
> Before adding the real "conversion", this needs a few real fixups, I
> think.  For example there is one hardcoded array that is used without
> bounds check.

Hmm. I'm not sure what array you're talking about (the newpath/newbase=20
ones? We do protect against PATH_MAX, it's just that we protect against=
 it=20
in the "previous iteration").

The bigger issue, though, is that I spent half a day looking more at th=
is=20
series last Thursday, and I've got some improvements, but getting "all =
the=20
way" turns out to be really quite painful.

Why?

We have a _lot_ of code that does "lstat()" on pathnames, and it all=20
basically uses the internal git representation of the pathname. In=20
particular, we do this a lot for index lookups, but it's true in other=20
cases too (example: things like tree merging, where we check whether a=20
file exists in the working tree).

To test this all out, I actually fleshed out the patches to the point=20
where I could do

	[core]
		PathEncoding =3D Latin1

and actually have the working tree use Latin1 encoding, and convert=20
internally in git to UTF-8, and have a working "git add ."

However, "git add ." was just about the only thing that I made do the=20
right thing. Even doing a simple "git diff" afterwards would then show =
the=20
file as deleted, because the UTF-8 version of the file (that the index=20
contained) didn't exist in the filesystem. I fixed that with a hack, bu=
t=20
it basically turns out to be pretty damn ugly, and there's a _lot_ of=20
those places.

So, the question is, "What now?"

There's a few alternatives:

(a) don't do any of this crap at all. What git does right now works fai=
rly
    well for most people. Instead, perhaps worry about just the crazy=20
    case-insensitive filesystems, which are a totally separate issue.

    End result: git will always have problems with the crazy NFD format
    that OS X uses. Mixing git archives across OS X and other saner
    operating systems (and in this context, Windows really does count a=
s
    "saner" - it really is OS X that is braindamaged!) will be painful =
if
    you have odd characters in your working tree.

    This is the simplest approach, of course. The case-insensitivity is=
=20
    still not trivial, but we could work on it, and it really is a=20
    different problem (and has none of the "if you look the file up wit=
h a=20
    converted name, you cannot see it" issues that the Latin1<->UTF8=20
    example had).

(b) Forget about the general case (like Latin1) that needs two-way=20
    conversion. Just worry about OS X being crazy, and do the NFD->NFC=20
    translation, which only needs to be done one way (because OS X will
    still accept and recognize NFC characters, so the "converted" path =
is=20
    still seen as valid by 'lstat()' and friends).

    This is very much just a special case of handling filesystems that =
are=20
    UTF-8, but are confused about what "equivalent" and "identical" mea=
ns,=20
    and where the filesystem designer was a moron on some seriously cra=
zy=20
    drugs, and thought that equivalence means identity, and thought tha=
t=20
    NFD is a sane form to expose.

    This is a much simpler case than the general approach. I don't have=
 OS=20
    X to test with, though, and so far it hasn't appeared that any OS X=
=20
    people really care about to actually implement it. So I can fix up =
my=20
    series to a certain point, but will never be able to really do the=20
    final testing and tuning. At least with the full "treat filesystem =
as=20
    Latin1 encoding", I could _test_ it.

(c) Try to bite the bullet. I can do this, but it really is going to be=
 a=20
    _very_ invasive patch-series, and it will probably involve some nas=
ty=20
    changes to the index format (for performance, we'll likely have to=20
    change the index to have _both_ the "git filename", and the=20
    "filesystem filename" in it).

    This was what I wanted to do, and it's what you'd need to do if you=
 do=20
    things like Latin1 filesystem trees or ones where pathnames are don=
e=20
    with shift-JIS encoding or if we want to actually use the (crazy)=20
    native Windows UCS filesystem accessors or whatever.

    But I have to admit that after looking at the pain, I'm not at all=20
    convinced it's worth it. Do we ever want to say "git supports=20
    filesystems with shift-JIS encoding"? Do people really care deeply=20
    enough about non-utf filesystems that they'd be willing to live wit=
h a=20
    _lot_ of pretty nasty complexity, and some real performance overhea=
d?

I have to say, even with plain UTF-8, git isn't really a pleasure to us=
e.=20
While I did my Latin1 test, I used filenames like "=E5=E4=F6" (the thre=
e extra=20
=46innish/Swedish characters), and if you do this

	mkdir test-repo
	cd test-repo
	git init
	echo testfile > =E5=E4=F6
	git add .
	git ls-files

the end result is not actually really usable. We quote it to a binary=20
mess, rather than showing "=E5=E4=F6". Our pathname quoting is trying t=
o be=20
safe, which is good, but it does mean that right now, odd characters=20
aren't very friendly even _if_ you are using a sane filesystem, and all=
=20
plain NFC utf-8.

So right now, my personal opinion is:

 - let's just face the fact that the only sane filename representation =
is=20
   NFC UTF-8. Show filenames as UTF-8 when possible, rather than quotin=
g=20
   them.

 - Do case (b) above: add support for converting NFD -> NFC at readdir(=
)=20
   time, so that OS X people can use UTF-8 sanely.=20

 - add a "binary encoding" mode to filesystems that actually use Latin1=
,=20
   just so that if people use Latin1 or Shift-JIS filesystem encodings,=
 we=20
   promise that we'll never munge those kinds of names.=20

 - Maybe we'd make the "binary encoding" (which is effectively existing=
=20
   git behavior) be the default on non-OSX platforms.

but that's just my gut feel from trying to weigh the costs of trying to=
 do=20
something more involved against the costs of OS X support and just lett=
ing=20
crazy encodings exist in their own little worlds. So a development grou=
p=20
that uses Shift-JIS (or Latin1) would be able to work internally with g=
it=20
that way, but would not be able to sanely work with the world at large=20
that uses UTF-8.

		Linus
