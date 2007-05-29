From: mkoegler@auto.tuwien.ac.at (Martin Koegler)
Subject: Re: [PATCH] gitweb: handle non UTF-8 text
Date: Tue, 29 May 2007 23:55:36 +0200
Message-ID: <20070529215536.GA13250@auto.tuwien.ac.at>
References: <1180385254576-git-send-email-mkoegler@auto.tuwien.ac.at> <20070528232139.GU4489@pasky.or.cz> <200705291121.12119.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Martin Langhoff <martin@catalyst.net.nz>,
	Martyn Smith <martyn@catalyst.net.nz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 23:56:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht9fp-00060r-Ib
	for gcvg-git@gmane.org; Tue, 29 May 2007 23:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbXE2Vzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 29 May 2007 17:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbXE2Vzm
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 17:55:42 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:45368 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbXE2Vzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 17:55:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id E4D217CE53F5;
	Tue, 29 May 2007 23:55:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K6HjjkaAX72Z; Tue, 29 May 2007 23:55:36 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 37F327CE7560; Tue, 29 May 2007 23:55:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200705291121.12119.jnareb@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48711>

On Tue, May 29, 2007 at 11:21:11AM +0200, Jakub Narebski wrote:
> On Tue, 29 May 2007, Petr Baudis wrote:
> > On Mon, May 28, 2007 at 10:47:34PM CEST, Martin Koegler wrote:
>=20
> >> gitweb assumes, that everything is in UTF-8. If a text contains in=
valid
> >> UTF-8 character sequences, the text must be in a different encodin=
g.
>=20
> But it doesn't tell us _what_ is the encoding. For commit messages,
> with reasonable new git, we have 'encoding' header if git known that
> commit message was not in utf-8.
>=20
> By the way, I winder why we don't have such header for tag objects
> (i18n.tagEncoding ;-)...

Why do I need to set i18n.commitEncoding on a normal Linux systems?  We
have a locale, which contains this information. With this, its more
likely, that the commits can be read correctly later, if somebody
forget to set "i18n.commitEncoding" in a repository.

> >> This patch interprets such a text as latin1.
>=20
> Meaning that it tries to recode text from latin1 (iso-8859-1) to utf-=
8
> (not changing gitweb output encoding, which is utf-8).
>=20
> It would be much better, and much easier at least for commit message
> to add --encoding=3Dutf-8 to git-rev-list / git-log invocation.

It does not help for old commits, where the encoding was not specified
correctly. If my research is correct, the encoding handling was
introduced at the end of 2006 and released this february.

> >> Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> >> ---
> >> For correct UTF-8, the patch does not change anything.
> >>=20
> >> If commit/blob/... is not in UTF-8, it displays the text
> >> with a very high probability correct.=20
>=20
> It is commit (with its 'encoding' header, and `--encoding' option
> we can use instead of doing it in gitweb, provided that git was
> compiled with iconv support), tag (similar to commit, but IIRC
> without 'encoding' header, and `--encoding' option), blob (with
> no place to store encoding) and pathname in tree (which can be
> different from blob encoding).
>=20
> And I doubt very much about this "very high probability to be
> correct".

=46or normal text, this should be true:

We can divide ISO-8859-1 into some groups:
a) 0x00-0x7f: shared with UTF-8
b) 0x80-0xBF: continuation characters in UTF-8 (0x80-0x9F are control c=
haracters/unused)
c) 0xC0-0xDF: start of a two byte UTF-8 character
d) 0xE0-0xEF: start of a tree byte UTF-8 character
e) 0xF0-0xFF: start of other longer UTF-8 sequences

To misinterpret a ISO-8859-1 text as UTF-8, each character of class
c/d/e must be followed by the correct number of character of class b.

Character of class b are "special character", characters of class
c/d/e are mostly special letters. As "special character" are normally n=
ot part
of a word (at least in German),  any occurence of c/d/e at the begin
or the in the middle of the word will therefore result in a invalid UTF=
-8
sequence. Only a occurence of c/d/e at the end of an word, which is
followed by the correct number occurences of class b result in a correc=
t UTF-8
sequence.

In german, the commonly used character of c/d/e are: =C3=84=C3=96=C3=9C=
=C3=A4=C3=B6=C3=BC=C3=9F
The uppercase =C3=84=C3=96=C3=9C appear ony at the beginning of a word =
=3D> invalid combination.

Other combinations:
* =C3=A4=C3=B6=C3=BC followed by two "special characters"  (I don't kno=
w, where such a combination could occur).
* =C3=9F followed by one "special character" (I regard this as the most=
 likly misinterpretation).

I can not speak for other languages. If you doubt, please look at an
character table (eg. http://en.wikipedia.org/wiki/ISO-8859-1#ISO-8859-1=
)
and think about the possibiltiy of UTF-8 compatible combinations in you=
r languague.

As gitweb is processing a line of text at once, one UTF-8 compatible
combinations has no effect, if any other non UTF-8 combatible
character sequence occurs.

> >> As git itself is not aware of any encoding, I know no better
> >> possibility to handle non UTF-8 text in gitweb.
> >=20
> > I don't think this is a reasonable approach; I actually dispute the=
 high
> > probability - in western Europe it's obvious to assume latin1, but =
does
> > majority of users using non-ascii characters come from there? Or ra=
ther
> > from central Europe (like me, Petr Baudi=C5=A1? ;-))? Somewhere els=
e?
>=20
> I also don't think that hardcoding latin1 (iso-8859-1) as default
> alternate encoding is a good idea. I don't think using iso-8859-1
> (outside us-ascii) is _nowadays_ that common. On the other hand I thi=
nk
> that not all users of koi8r, eucjp or iso-2022-jp converted (and can
> convert) to utf-8; latin1 users can.

UTF-8 is not the universal, dropin solution for ISO-8859-1. It has some=
 drawbacks:
- Some operations are slower, eg.
$$ hexdump -C s
00000000  78 0a 78 0a 78 0a 78 0a  78 0a 78 0a 78 0a 78 0a  |x.x.x.x.x.=
x.x.x.|
*
01000000
$ grep --version
grep (GNU grep) 2.5.1
$LANG=3Den_US.ISO-8859-15 time grep "[a]" s
Command exited with non-zero status 1
0.38user 0.05system 0:00.46elapsed 93%CPU (0avgtext+0avgdata 0maxreside=
nt)k
0inputs+0outputs (0major+219minor)pagefaults 0swaps
$ LANG=3Den_US.UTF-8 time grep "[a]" s
Command exited with non-zero status 1
10.86user 0.31system 0:14.29elapsed 78%CPU (0avgtext+0avgdata 0maxresid=
ent)k
0inputs+0outputs (0major+17151minor)pagefaults 0swaps
- Anything using string length/character position is more complicated.

=46or some problems, UTF-16 might be a simpler solution.

But I agree, that there should be the possibilty to choose a the
fallback encoding.

> And using latin1 (other encoding) _only_ when there is an invalid utf=
-8
> sequence is not a good idea either; I think that that there are some
> latin1 sequences outside us-ascii which are valid utf-8 sequences. Th=
at
> kind of magic is wrong, wrong, wrong...

Please tell me a better alternative. The non UTF-8 will be in the histo=
ry
(in blobs/trees/commits/..) forever, where it can not be changed.

I need a solution for this. I can use this patch on my system, but I
would like to see support other encodings in upstream gitweb.

> > If we do something like this, we should do it properly and look at
> > configured i18n.commitEncoding for the project. (But as config look=
up
> > may be expensive, probably do it only when we need it.)
>=20
> I think it would be best to make it into %feature, overridable
> or not (which would look at i18n.commitEncoding instead of at
> gitweb.commitEncoding, but still a feature).

I would use i18n.commitEncoding only as last fallback. In a project
more different encodings could be used and the guessing logic may need
additional parameter, so I would create a own set of config parameters
for this.

> About config lookup: we can either "borrow" config reading code in Pe=
rl
> from git-cvsserver, perhaps via putting it into Git.pm. Or we can
> implement at last core git support for dumping whole config in
> unambiguous machine parseable output: "git config --dump", e.g.
>   key <LF> value <NUL>
> or
>   key <NUL>
> (the second for "boolean" variables without set value).

If we use a new file (in the gitweb config format), the whole thing
will be faster and less complicated.

mfg Martin K=C3=B6gler
