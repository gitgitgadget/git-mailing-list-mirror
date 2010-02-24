From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/4] bash: improve aliased command recognition
Date: Wed, 24 Feb 2010 02:04:59 +0100
Message-ID: <20100224010459.GP4431@neumann>
References: <20100131191936.GA30466@neumann>
	<cover.1266958460.git.szeder@ira.uka.de>
	<90724961a941edd1317514dea0a1c64112dab61d.1266958460.git.szeder@ira.uka.de>
	<7v3a0rd2lz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 02:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk5ht-00051e-Ed
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 02:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754833Ab0BXBGY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 20:06:24 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:56627 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165Ab0BXBGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 20:06:23 -0500
Received: from [127.0.1.1] (p5B1308FC.dip0.t-ipconnect.de [91.19.8.252])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0Lu2H0-1NamKI0WUY-011JLr; Wed, 24 Feb 2010 02:05:01 +0100
Content-Disposition: inline
In-Reply-To: <7v3a0rd2lz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/P8Enyk9Qn6023GdrhsG7EQug0QBE9M26cDPA
 57dVMSLd2OHs1C0baH0UZZis8ypgLFXrJDdT9fCKc+CLC9frjO
 0MDcXSUBD9nH3R9Nys3YQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140886>

Hi,

On Tue, Feb 23, 2010 at 02:11:20PM -0800, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > [alias]
> >     lgm =3D "!sh -c 'GIT_NOTES_REF=3Drefs/notes/amlog git log \"$@\=
" || :' -"
> >
> > The full parsing of a shell command alias like that in the completi=
on
> > code is clearly unfeasible.  However, we can easily improve on alia=
sed
> > command recognition by eleminating stuff that is definitely not a g=
it
> > command: shell commands (anything starting with '!'), command line
> > options (anything starting with '-'), environment variables (anythi=
ng
> > with a '=3D' in it), and git itself.  This way the above alias woul=
d be
> > handled correctly, and the completion script would correctly recogn=
ize
> > "log" as the aliased git command.
>=20
> I personally do not think such a heuristic is worth the trouble (both=
 for
> writing and maintaining the completion code nor runtime overhead to
> iterate over words on the expansion).

Well, the code is already written, so ;)

Runtime overhead seems not to be an issue:

$ git config alias.shortalias log
$ git config alias.longalias \!"sh -c '$(for i in $(seq 1 100) ;do echo=
 -n "A=3D$i " ;done) git log -1'"
$ time __git_aliased_command shortalias
log

real    0m0.008s
user    0m0.004s
sys     0m0.004s
$ time __git_aliased_command longalias
log

real    0m0.017s
user    0m0.012s
sys     0m0.004s

That is, although it takes around twice as long in case of a 100+ word
long alias than with a trivial one, it is still in the hundredth of a
second range.  And I doubt that many people have that long aliases.

Maintenance might be an issue, or, erm...  well, it already is.  An
alias like "!sh -c 'git log -1'" does not work, because "'git" does
not match any of the patterns, therefore it is returned as the aliased
command.

> I vaguely recall somebody floated an idea to tell completion code tha=
t
> "you may not know what lgm is, but it takes the same set of options a=
s
> log" (either via config or a shell function---I don't recall the deta=
ils).

Shawn proposed the approach via config variables and patches 2/4 and
3/4 actually implement the shell function approach.

Personally, I prefer the shell function approach.  It needs less 'git
config' queries; actually, in this respect it is better than current
master, because there is no 'git config' query at all for the git
command case.  Furthermore, I don't really like the idea of putting
completion related stuff into git configuration files, but this is, of
course, subjective.

> I think that would be a lot more robust, efficient and easy to explai=
n
> solution to the same problem.

I agree that this heuristic is not 100% robust.  Efficiency is not an
issue, as shown above.  But I think we should also look at efficiency
and overhead at the user, too.  That is, this heuristic will work
without any action required from the user, while the other two
approaches require the user to explicitly specify the completion rules
for his non-trivial aliases.  Finally, I think it is not all that
difficult to explain:

  "The bash completion script uses some heuristics to find out the git
  command invoked by aliases.  If you have an alias for which the
  completion script does nothing or outputs garbage, then you should
  write a one-liner shell function, which ..." and here comes what you
  would need to explain anyway.


Note, that patches 1/4 and 4/4 are independent from the changes in 2/4
and 3/4, so if you are not satisfied with these heuristic changes, you
can still drop only those but not the custom completion patches.


Best,
G=E1bor

(and it's already tomorrow here, so the thoughts about completion
namespaces will have to wait)
